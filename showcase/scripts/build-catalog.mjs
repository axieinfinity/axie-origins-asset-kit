#!/usr/bin/env node
import { copyFileSync, existsSync, mkdirSync, readdirSync, readFileSync, statSync, writeFileSync } from 'node:fs'
import path, { basename, dirname, extname, join, relative } from 'node:path'
import { fileURLToPath } from 'node:url'

const here = dirname(fileURLToPath(import.meta.url))
const kitRoot = join(here, '../..')
const assets = join(kitRoot, 'Assets/OriginsKit')
const flipSrc = '/Users/jaatster/Work/Projects/Axie Origins Client/origins-battle-mixer-pack/vfx/flipbooks'
const publicDir = join(here, '../public')
const flipDest = join(publicDir, 'previews/vfx')
const outFile = join(publicDir, 'catalog.json')

const CLASSES = ['aquatic', 'beast', 'bird', 'bug', 'plant', 'reptile', 'mech', 'dawn', 'dusk']

function readJson(path) {
  return JSON.parse(readFileSync(path, 'utf8'))
}

function walk(dir, pred, acc = []) {
  if (!existsSync(dir)) return acc
  for (const name of readdirSync(dir)) {
    const path = join(dir, name)
    const stat = statSync(path)
    if (stat.isDirectory()) walk(path, pred, acc)
    else if (pred(name, path)) acc.push(path)
  }
  return acc
}

function kitUrl(abs) {
  return `/kit/${relative(assets, abs).split('\\').join('/')}`
}

function copyFlipbooks() {
  mkdirSync(flipDest, { recursive: true })
  if (!existsSync(flipSrc)) {
    console.log('flipbook source missing; using showcase/public/previews/vfx')
    return existsSync(flipDest) ? readdirSync(flipDest) : []
  }
  const copied = []
  for (const name of readdirSync(flipSrc)) {
    if (name.includes('smash 1')) continue
    if (!name.endsWith('.png') && !name.endsWith('.json')) continue
    copyFileSync(join(flipSrc, name), join(flipDest, name))
    copied.push(name)
  }
  return copied
}

function flipbookFor(id) {
  const jsonPath = join(flipDest, `${id}.json`)
  const pngPath = join(flipDest, `${id}.png`)
  if (!existsSync(jsonPath) || !existsSync(pngPath)) return null
  const meta = readJson(jsonPath)
  return {
    url: `/previews/vfx/${id}.png`,
    cols: meta.cols,
    rows: meta.rows,
    frames: meta.frames,
    fps: meta.fps || 24,
    duration: meta.duration || 1,
  }
}

function spineFor(folder, slug) {
  const atlas = join(folder, `${slug}.atlas`)
  const skel = join(folder, `${slug}.skel`)
  const json = join(folder, `${slug}.json`)
  const png = join(folder, `${slug}.png`)
  if (!existsSync(atlas) || !existsSync(png)) return null
  const skelPath = existsSync(skel) ? skel : existsSync(json) ? json : null
  if (!skelPath) return null
  return {
    spineAtlas: kitUrl(atlas),
    spineSkel: kitUrl(skelPath),
    spineBase: `/kit/${relative(assets, folder).split('\\').join('/')}/`,
    plateUrl: kitUrl(png),
    format: skelPath.endsWith('.json') ? 'json' : 'skel',
  }
}

function titleize(id) {
  return id.replace(/[_-]+/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase())
}

function main() {
  copyFlipbooks()
  const items = []

  const activation = readJson(join(assets, 'Catalogs/activation.json'))
  const skillVfx = readJson(join(assets, 'Catalogs/skill-vfx.json'))
  const mixer = readJson(join(assets, 'Catalogs/mixer-animations.json'))
  const pve = readJson(join(assets, 'Catalogs/pve-chimeras.json'))
  const pveCards = readJson(join(assets, 'Catalogs/pve-cards.json'))
  const pveIntents = readJson(join(assets, 'Catalogs/pve-intents.json'))
  const pveStarters = readJson(join(assets, 'Catalogs/pve-starters.json'))

  const byVfx = new Map()
  for (const row of skillVfx.items || []) {
    const id = row.vfxId
    if (!id) continue
    const bucket = byVfx.get(id) || { cards: [], abilityIds: [], attackAnimation: row.attackAnimation, hitAnimation: row.hitAnimation, isRanged: row.isRanged }
    bucket.cards.push(...(row.cardNames || []))
    bucket.abilityIds.push(row.abilityId)
    byVfx.set(id, bucket)
  }

  for (const clip of activation.items || []) {
    const id = clip.id
    const kind = clip.kind === 'buff' ? 'buff' : 'skill'
    const className = CLASSES.find((c) => id.startsWith(`${c}_`))
    const style = className ? id.slice(className.length + 1) : id
    const map = byVfx.get(id) || { cards: [], abilityIds: [] }
    const book = flipbookFor(id)
    const attack = clip.events?.find((e) => e.function === 'OnAttack')
    const hit = clip.events?.find((e) => e.function === 'OnHit')
    items.push({
      id: `${kind}:${id}`,
      kind,
      name: id,
      title: titleize(id),
      tags: [kind, className, style].filter(Boolean),
      family: className || kind,
      preview: book ? 'flipbook' : 'texture',
      className,
      style,
      vfxId: id,
      attackAnimation: attack?.string || map.attackAnimation,
      hitAnimation: hit?.string || map.hitAnimation,
      isRanged: Boolean(clip.events?.some((e) => e.function === 'OnThrow') || map.isRanged),
      duration: clip.duration || book?.duration || 1,
      events: clip.events || [],
      cards: [...new Set(map.cards)],
      abilityIds: map.abilityIds,
      unityPath: `Assets/OriginsKit/Prefabs/${kind === 'buff' ? 'Buffs' : 'Skills'}/${id}.prefab`,
      clipPath: `Assets/OriginsKit/Animations/${id}.anim`,
      sfxUrl: existsSync(join(assets, `Audio/${id}_attack.wav`))
        ? `/kit/Audio/${id}_attack.wav`
        : existsSync(join(assets, `Audio/${id.replace('_apply', '')}.wav`))
          ? `/kit/Audio/${id.replace('_apply', '')}.wav`
          : existsSync(join(assets, `Audio/${id}.wav`))
            ? `/kit/Audio/${id}.wav`
            : null,
      flipbook: book,
      usage:
        kind === 'skill'
          ? `Spawn Prefabs/Skills/${id} with SkillPlayer at scale 54. OnAttack plays the attacker mixer clip; OnHit plays the defender hit.`
          : `Loop Prefabs/Buffs/${id} on the fighter. Buffs skip OnAttack / OnThrow / OnHit.`,
    })
  }

  for (const row of mixer.items || []) {
    items.push({
      id: `animation:${row.name}`,
      kind: 'animation',
      name: row.name,
      title: row.name.split('/').slice(-1)[0],
      tags: ['animation', row.usedInOriginsBattle ? 'origins-battle' : 'mixer'],
      family: row.name.split('/')[0],
      preview: 'spine',
      animation: row.name,
      duration: 1,
      usage: row.usage || mixer.battleUsage?.[row.name] || 'Mixer Spine clip name. Play on a mixer Axie or a starter Spine.',
      unityPath: 'Assets/OriginsKit/Catalogs/mixer-animations.json',
      actor: 'starter:1',
      usedInOriginsBattle: row.usedInOriginsBattle,
    })
  }

  for (const rec of pve.extractedSkeletons || []) {
    const folder = join(assets, 'PvE/Chimeras', rec.id)
    const spine = spineFor(folder, rec.id)
    const portrait = join(assets, 'PvE/Avatars/portraits', `${rec.id}.png`)
    items.push({
      id: `chimera:${rec.id}`,
      kind: 'chimera',
      name: rec.id,
      title: titleize(rec.id),
      tags: ['chimera', 'pve'],
      family: 'chimera',
      preview: 'spine',
      duration: 1,
      clips: rec.unityClips || [],
      animation: (rec.unityClips || []).find((n) => n.includes('idle/normal')) || rec.unityClips?.[0],
      src: existsSync(portrait) ? kitUrl(portrait) : spine?.plateUrl,
      plateUrl: spine?.plateUrl,
      ...spine,
      unityPath: `Assets/OriginsKit/PvE/Chimeras/${rec.id}/`,
      usage: 'Spine 3.8 enemy body. Play action/idle/normal, then attack clips. Skills use Prefabs/Skills via pve-cards.json.',
    })
  }

  for (const rec of pveStarters.extractedSkeletons || []) {
    const folder = join(assets, 'PvE/Starters', rec.id)
    const spine = spineFor(folder, rec.id)
    items.push({
      id: `starter:${rec.id}`,
      kind: 'starter',
      name: rec.id,
      title: `${rec.displayName || rec.id}${rec.bodyStage ? ' (awakened)' : ''}`,
      tags: ['starter', rec.bodyStage ? 'awakened' : 'base'],
      family: String(rec.axieId || rec.id),
      preview: 'spine',
      duration: 1,
      clips: rec.unityClips || [],
      animation: 'action/idle/normal',
      src: spine?.plateUrl,
      plateUrl: spine?.plateUrl,
      ...spine,
      unityPath: `Assets/OriginsKit/PvE/Starters/${rec.id}/`,
      usage: 'Official starter Axie Spine. Same mixer clip names as NFT Axies. Use as a playable PvE roster body.',
    })
  }

  for (const file of walk(join(assets, 'PvE/Cards'), (n) => n.endsWith('.png'))) {
    const name = basename(file, '.png')
    const chimeraCard = relative(join(assets, 'PvE/Cards/Chimeras'), file).startsWith('..') === false
    items.push({
      id: `card:${name}`,
      kind: 'card',
      name,
      title: titleize(name.replace(/-0\d-00$/, '')),
      tags: [chimeraCard ? 'chimera-card' : 'tool-card'],
      family: chimeraCard ? 'chimera-card' : 'tool-card',
      preview: 'texture',
      src: kitUrl(file),
      plateUrl: kitUrl(file),
      duration: 0,
      unityPath: `Assets/OriginsKit/PvE/Cards/${chimeraCard ? 'Chimeras' : 'Tools'}/${name}.png`,
      usage: chimeraCard ? 'Enemy card art for a chimera ability variant.' : 'Tool / chimera ability card face. Match to abilityId in pve-cards.json.',
    })
  }

  for (const file of walk(join(assets, 'PvE/Intents'), (n) => n.endsWith('.png'))) {
    const name = basename(file, '.png')
    items.push({
      id: `intent:${name}`,
      kind: 'intent',
      name,
      title: name,
      tags: ['intent'],
      family: 'intent',
      preview: 'icon',
      src: kitUrl(file),
      duration: 0,
      unityPath: `Assets/OriginsKit/PvE/Intents/${name}.png`,
      usage: `Enemy intent icon. Origins loads intent/${name}.png on the HP bar.`,
    })
  }

  const bgRoots = [
    join(assets, 'PvE/Backgrounds/story'),
    join(assets, 'PvE/Backgrounds/events'),
    join(assets, 'PvE/Backgrounds/class'),
  ]
  for (const root of bgRoots) {
    if (!existsSync(root)) continue
    const group = basename(root)
    if (group === 'class') {
      for (const file of walk(root, (n) => /\.(png|jpg|jpeg)$/i.test(n) && !n.startsWith('sactx-'))) {
        const name = basename(file)
        items.push({
          id: `arena:class:${name}`,
          kind: 'arena',
          name,
          title: titleize(basename(file, extname(file))),
          tags: ['arena', 'class'],
          family: 'class',
          preview: 'texture',
          src: kitUrl(file),
          duration: 0,
          unityPath: `Assets/OriginsKit/PvE/Backgrounds/class/${name}`,
          usage: 'Class / mode backdrop painting.',
        })
      }
      continue
    }
    for (const slug of readdirSync(root)) {
      const folder = join(root, slug)
      if (!statSync(folder).isDirectory()) continue
      const files = walk(folder, (n, p) => /\.(png|jpg)$/i.test(n) && !n.startsWith('sactx-') && !p.includes(`${path.sep}layers${path.sep}`))
      const preferred =
        files.find((f) => /_bg|BG|Ground|s23_bg_b|Valentine_PVP_back/i.test(basename(f))) || files[0]
      if (!preferred) continue
      items.push({
        id: `arena:${group}:${slug}`,
        kind: 'arena',
        name: slug,
        title: titleize(slug),
        tags: ['arena', group],
        family: group,
        preview: 'texture',
        src: kitUrl(preferred),
        layers: files.map(kitUrl),
        duration: 0,
        unityPath: `Assets/OriginsKit/PvE/Backgrounds/${group}/${slug}/`,
        usage: group === 'story' ? 'Adventure battle layers. Stack BG behind, FRONT/FOG/CLOUD on top.' : 'Seasonal / ranked battle arena.',
      })
    }
  }

  for (const file of walk(join(assets, 'PvE/Music'), (n) => n.endsWith('.wav') || n.endsWith('.mp3'))) {
    const name = basename(file, extname(file))
    items.push({
      id: `music:${name}`,
      kind: 'music',
      name,
      title: titleize(name),
      tags: ['music'],
      family: 'music',
      preview: 'audio',
      audioUrl: kitUrl(file),
      sfxUrl: kitUrl(file),
      duration: 0,
      unityPath: `Assets/OriginsKit/PvE/Music/${basename(file)}`,
      usage: 'Loop behind a fight. Nodes pick music/pve_1, music/boss, or a seasonal track.',
    })
  }

  for (const file of walk(join(assets, 'Audio'), (n) => n.endsWith('.wav'))) {
    const name = basename(file, '.wav')
    items.push({
      id: `sfx:${name}`,
      kind: 'sfx',
      name,
      title: titleize(name),
      tags: ['sfx'],
      family: CLASSES.find((c) => name.startsWith(`${c}_`)) || 'buff',
      className: CLASSES.find((c) => name.startsWith(`${c}_`)),
      preview: 'audio',
      audioUrl: kitUrl(file),
      sfxUrl: kitUrl(file),
      duration: 0,
      unityPath: `Assets/OriginsKit/Audio/${name}.wav`,
      usage: 'Play on the matching SkillPlayer event: {vfx}_attack, {vfx}_fly, {vfx}_hit, or buff name.',
    })
  }

  for (const file of walk(join(assets, 'Textures/StatusIcons'), (n) => n.endsWith('.png'))) {
    const name = basename(file, '.png')
    items.push({
      id: `status:${name}`,
      kind: 'status',
      name,
      title: titleize(name),
      tags: ['status'],
      family: name.startsWith('chimera_') ? 'chimera-passive' : name.startsWith('debuff_') ? 'debuff' : name.startsWith('buff_') ? 'buff' : 'status',
      preview: 'icon',
      src: kitUrl(file),
      duration: 0,
      unityPath: `Assets/OriginsKit/Textures/StatusIcons/${name}.png`,
      usage: 'Status / chimera-passive icon for HP bars and tooltips.',
    })
  }

  for (const slug of readdirSync(join(assets, 'Summoners'))) {
    const folder = join(assets, 'Summoners', slug)
    if (!statSync(folder).isDirectory()) continue
    const files = readdirSync(folder)
    const atlas = files.find((f) => f.endsWith('.atlas'))
    const skel = files.find((f) => f.endsWith('.skel'))
    const png = files.find((f) => f.endsWith('.png'))
    if (!atlas || !skel || !png) continue
    const id = slug
    items.push({
      id: `summoner:${id}`,
      kind: 'summoner',
      name: id,
      title: titleize(id),
      tags: ['summoner'],
      family: 'summoner',
      preview: 'spine',
      spineAtlas: kitUrl(join(folder, atlas)),
      spineSkel: kitUrl(join(folder, skel)),
      spineBase: `/kit/Summoners/${slug}/`,
      plateUrl: kitUrl(join(folder, png)),
      src: kitUrl(join(folder, png)),
      format: 'skel',
      duration: 1,
      unityPath: `Assets/OriginsKit/Summoners/${slug}/`,
      usage: 'Summoner Spine 3.8. Play with the Spine runtime, not the Axie mixer.',
    })
  }

  for (const slug of ['victory', 'defeated', 'draw', 'flag_pvp']) {
    const folder = join(assets, 'BattleUI', slug)
    if (!existsSync(folder)) continue
    const files = readdirSync(folder)
    const atlas = files.find((f) => f.includes('.atlas'))
    const skel = files.find((f) => f.endsWith('.bytes') || f.endsWith('.skel'))
    const png = files.find((f) => f.endsWith('.png'))
    if (!atlas || !skel || !png) continue
    items.push({
      id: `ui:${slug}`,
      kind: 'ui',
      name: slug,
      title: titleize(slug),
      tags: ['battle-ui'],
      family: 'battle-ui',
      preview: 'spine',
      spineAtlas: kitUrl(join(folder, atlas)),
      spineSkel: kitUrl(join(folder, skel)),
      spineBase: `/kit/BattleUI/${slug}/`,
      plateUrl: kitUrl(join(folder, png)),
      src: kitUrl(join(folder, png)),
      format: skel.endsWith('.bytes') || skel.endsWith('.skel') ? 'skel' : 'json',
      duration: 1,
      unityPath: `Assets/OriginsKit/BattleUI/${slug}/`,
      usage: 'End-of-battle Spine (win / lose / draw / flag).',
    })
  }

  for (const file of walk(join(assets, 'PvE/UI'), (n) => n.endsWith('.png')).slice(0, 200)) {
    const rel = relative(join(assets, 'PvE/UI'), file)
    const name = basename(file, '.png')
    items.push({
      id: `hud:${rel}`,
      kind: 'hud',
      name,
      title: titleize(name),
      tags: ['hud', rel.split('/')[0]],
      family: rel.split('/')[0],
      preview: 'icon',
      src: kitUrl(file),
      duration: 0,
      unityPath: `Assets/OriginsKit/PvE/UI/${rel}`,
      usage: 'PvE / in-battle HUD art. No client scripts — use as sprites.',
    })
  }

  const catalog = {
    generatedAt: new Date().toISOString(),
    count: items.length,
    chimeraCards: pveCards.chimeraAbilities || [],
    intents: pveIntents.intents || [],
    items,
  }
  mkdirSync(dirname(outFile), { recursive: true })
  writeFileSync(outFile, JSON.stringify(catalog))
  const counts = {}
  for (const item of items) counts[item.kind] = (counts[item.kind] || 0) + 1
  console.log('catalog', catalog.count, counts)
}

main()
