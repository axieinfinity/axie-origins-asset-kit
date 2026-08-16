#!/usr/bin/env node
import { existsSync, readdirSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs'
import { cpus } from 'node:os'
import { dirname, join } from 'node:path'
import { spawn } from 'node:child_process'
import { fileURLToPath } from 'node:url'

const here = dirname(fileURLToPath(import.meta.url))
const dest = join(here, '../public/previews/video')
const framesRoot = join(dest, 'frames')
const jobs = Math.max(4, (cpus().length || 8) - 2)

function ffmpegBin() {
  for (const candidate of ['/opt/homebrew/bin/ffmpeg', '/usr/local/bin/ffmpeg']) {
    if (existsSync(candidate)) return candidate
  }
  return 'ffmpeg'
}

function readJson(path) {
  return JSON.parse(readFileSync(path, 'utf8'))
}

function run(bin, args) {
  return new Promise((resolve, reject) => {
    const child = spawn(bin, args, { stdio: ['ignore', 'pipe', 'pipe'] })
    let err = ''
    child.stderr.on('data', (chunk) => {
      err += chunk.toString()
    })
    child.on('close', (code) => {
      if (code === 0) resolve()
      else reject(new Error((err.split('\n').slice(-8).join('\n') || 'exit ' + code).trim()))
    })
  })
}

async function pool(items, limit, worker) {
  const pending = new Set()
  const results = []
  for (const item of items) {
    const task = Promise.resolve()
      .then(() => worker(item))
      .then((value) => ({ ok: true, item, value }))
      .catch((error) => ({ ok: false, item, error }))
      .finally(() => pending.delete(task))
    pending.add(task)
    results.push(task)
    if (pending.size >= limit) await Promise.race(pending)
  }
  return Promise.all(results)
}

async function encodeOne(id, ff) {
  const frameDir = join(framesRoot, id)
  const metaPath = join(frameDir, 'meta.json')
  if (!existsSync(metaPath)) throw new Error('missing frames')
  const meta = readJson(metaPath)
  const fps = String(meta.fps || 30)
  const pattern = join(frameDir, '%04d.png')
  if (!existsSync(join(frameDir, '0000.png'))) throw new Error('no 0000.png')
  const mp4 = join(dest, `${id}.mp4`)
  const webm = join(dest, `${id}.webm`)
  const jpg = join(dest, `${id}.jpg`)
  await run(ff, [
    '-y',
    '-framerate',
    fps,
    '-i',
    pattern,
    '-c:v',
    'libx264',
    '-pix_fmt',
    'yuv420p',
    '-profile:v',
    'high',
    '-crf',
    '18',
    '-movflags',
    '+faststart',
    '-an',
    mp4,
  ])
  if (existsSync(join(dest, `${id}.png`))) {
    await run(ff, ['-y', '-i', join(dest, `${id}.png`), '-q:v', '3', jpg]).catch(() => {})
  }
  if (!existsSync(jpg)) {
    const mid = String(Math.floor((meta.frames || 2) / 2)).padStart(4, '0')
    const src = existsSync(join(frameDir, `${mid}.png`)) ? join(frameDir, `${mid}.png`) : join(frameDir, '0000.png')
    await run(ff, ['-y', '-i', src, '-q:v', '3', jpg])
  }
  await run(ff, [
    '-y',
    '-framerate',
    fps,
    '-i',
    pattern,
    '-c:v',
    'libvpx-vp9',
    '-b:v',
    '0',
    '-crf',
    '33',
    '-row-mt',
    '1',
    '-an',
    webm,
  ]).catch(() => {})
  return { id, frames: meta.frames, duration: meta.duration, lit: meta.lit }
}

async function main() {
  mkdirSync(dest, { recursive: true })
  if (!existsSync(framesRoot)) {
    console.error('No frame sequences at', framesRoot)
    process.exit(1)
  }
  const ff = ffmpegBin()
  const ids = readdirSync(framesRoot).filter((name) => existsSync(join(framesRoot, name, 'meta.json')))
  console.log(`Encoding ${ids.length} clips with ${jobs} workers via ${ff}`)
  const results = await pool(ids, jobs, (id) => encodeOne(id, ff))
  const ok = results.filter((row) => row.ok)
  const failed = results.filter((row) => !row.ok)
  const index = {
    count: ok.length,
    fps: 30,
    width: 960,
    height: 540,
    items: ok.map((row) => row.item),
    failed: failed.map((row) => ({ id: row.item, error: String(row.error?.message || row.error) })),
  }
  writeFileSync(join(dest, 'index.json'), JSON.stringify(index, null, 2))
  console.log(`Encoded ${ok.length}/${ids.length}`)
  if (failed.length) {
    for (const row of failed) console.error('FAIL', row.item, row.error?.message || row.error)
    process.exit(2)
  }
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
