#!/usr/bin/env node
/** Copy catalog-referenced /kit/* files into showcase/public/kit for production. */
import { copyFileSync, existsSync, mkdirSync, readFileSync, statSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const here = dirname(fileURLToPath(import.meta.url))
const kitRoot = join(here, '../../Assets/OriginsKit')
const destRoot = join(here, '../public/kit')
const catalog = JSON.parse(readFileSync(join(here, '../public/catalog.json'), 'utf8'))

const paths = new Set()
const walk = (value) => {
  if (typeof value === 'string' && value.startsWith('/kit/')) paths.add(value.slice(5))
  else if (Array.isArray(value)) value.forEach(walk)
  else if (value && typeof value === 'object') Object.values(value).forEach(walk)
}
walk(catalog)

let copied = 0
let missing = 0
for (const rel of [...paths].sort()) {
  const src = join(kitRoot, rel)
  const dest = join(destRoot, rel)
  if (!existsSync(src) || !statSync(src).isFile()) {
    missing += 1
    continue
  }
  mkdirSync(dirname(dest), { recursive: true })
  copyFileSync(src, dest)
  copied += 1
}
console.log(`staged kit files ${copied} (missing ${missing}) into public/kit`)
