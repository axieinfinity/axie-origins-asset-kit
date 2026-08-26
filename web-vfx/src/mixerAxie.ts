import { Buffer } from 'buffer'
import { Texture } from 'pixi.js'
import { Spine, TextureAtlas } from 'pixi-spine'
import { AtlasAttachmentLoader, SkeletonJson } from '@pixi-spine/runtime-3.8'
import {
  getAxieColorPartShift,
  getAxieSpineFromGenes,
  getVariantAttachmentPath,
  initAxieMixer,
} from '@axieinfinity/mixer'

import GenesData from '@axieinfinity/mixer/dist/data/axie-2d-v3-stuff-genes.json'
import SamplesData from '@axieinfinity/mixer/dist/data/axie-2d-v3-stuff-samples.json'
import VariantsData from '@axieinfinity/mixer/dist/data/axie-2d-v3-stuff-variant.json'
import AnimationsData from '@axieinfinity/mixer/dist/data/axie-2d-v3-stuff-animations.json'

;(globalThis as unknown as { Buffer: typeof Buffer }).Buffer = Buffer

const AXIE_IMAGES_URL = 'https://axiecdn.axieinfinity.com/mixer-stuffs/v6/'

export const SAMPLE_GENES = {
  p1: '0x180000000000010001c1a050821000000001000c086043040001000c086044080001000c106083040001000c286143040001000c0861830c0003000c08604306',
  p2: '0x20000000000001000000e0a08310000000010010200104080001000008810302000100080881830a000100001081400400030010288102040001001010a0430a',
}

export const IDLE = 'action/idle/normal'

const textureCache = new Map<string, Promise<Texture>>()

function loadTexture(url: string) {
  const hit = textureCache.get(url)
  if (hit) return hit
  const pending = new Promise<Texture>((resolve, reject) => {
    const img = new Image()
    img.crossOrigin = 'anonymous'
    img.onload = () => resolve(Texture.from(img))
    img.onerror = () => reject(new Error(`Failed to load ${url}`))
    img.src = url
  })
  textureCache.set(url, pending)
  return pending
}

let mixerReady = false

export function bootMixer() {
  if (mixerReady) return
  initAxieMixer(GenesData, SamplesData, VariantsData, AnimationsData)
  mixerReady = true
}

export const FALLBACK_MELEE = [
  'attack/melee/normal-attack',
  'attack/melee/horn-gore',
  'attack/melee/mouth-bite',
  'attack/melee/shrimp',
  'attack/melee/tail-smash',
  'attack/melee/tail-thrash',
  'attack/melee/tail-roll',
]

export const FALLBACK_HIT = [
  'defense/hit-by-normal',
  'defense/hit-by-normal-crit',
  'defense/hit-by-normal-dramatic',
  'defense/hit-by-ranged-attack',
  'defense/hit-with-shield',
]

export function fallbacksFor(name: string) {
  if (!name) return [IDLE]
  if (name.includes('melee')) return [name, ...FALLBACK_MELEE]
  if (name.includes('ranged') || name.includes('cast')) return [name, 'attack/ranged/cast-fly', ...FALLBACK_MELEE]
  if (name.includes('defense') || name.includes('hit')) return [name, ...FALLBACK_HIT]
  if (name.includes('buff') || name.includes('debuff')) return [name, 'battle/get-buff', 'battle/get-debuff', IDLE]
  return [name, IDLE]
}

export function hasAnimation(spine: Spine, name: string) {
  const data = spine.spineData
  if (!data) return false
  if (typeof data.findAnimation === 'function') return !!data.findAnimation(name)
  return (data.animations || []).some((a) => a.name === name)
}

export function playAnim(spine: Spine, names: string | string[], loop = false, track = 0) {
  const list = Array.isArray(names) ? names : [names]
  const name = list.find((n) => hasAnimation(spine, n))
  if (!name || !spine.state) return null
  return spine.state.setAnimation(track, name, loop)
}

function collectTextures(skeletonData: any, variant: string) {
  const resources: { key: string; url: string }[] = []
  const skins = skeletonData?.skins || []
  const partColorShift = getAxieColorPartShift(variant)
  for (const skin of skins) {
    const attachments = skin.attachments || {}
    for (const slotName of Object.keys(attachments)) {
      const slotAttachments = attachments[slotName] || {}
      for (const attachmentName of Object.keys(slotAttachments)) {
        const attachment = slotAttachments[attachmentName]
        const path = attachment?.path || attachment?.name || attachmentName
        if (!path || typeof path !== 'string') continue
        const variantPath = getVariantAttachmentPath(slotName, path, variant, partColorShift)
        resources.push({ key: path, url: `${AXIE_IMAGES_URL}${variantPath}` })
      }
    }
  }
  return resources
}

const spineCache = new Map<string, ConstructorParameters<typeof Spine>[0]>()

export async function createAxieSpine(genes: string) {
  bootMixer()
  const hit = spineCache.get(genes)
  if (hit) {
    const spine = new Spine(hit)
    playAnim(spine, IDLE, true)
    return spine
  }

  const result = getAxieSpineFromGenes(genes, new Map(), false)
  if (result.error || !result.skeletonDataAsset) {
    throw new Error(result.error || 'Mixer failed to build Axie')
  }

  const needed = collectTextures(result.skeletonDataAsset, result.variant)
  const textures: Record<string, Texture> = {}
  await Promise.all(
    needed.map(async ({ key, url }) => {
      if (textures[key]) return
      try {
        const texture = await Promise.race([
          loadTexture(url),
          new Promise<never>((_, reject) => setTimeout(() => reject(new Error('timeout')), 8000)),
        ])
        textures[key] = texture
        textures[key.replace(/\./g, '/')] = texture
        const file = url.split('/mixer-stuffs/v6/')[1] || url
        textures[file] = texture
        textures[file.replace(/\.png$/, '')] = texture
        textures[url] = texture
      } catch {
        /* missing part textures are skipped */
      }
    }),
  )

  const atlas = new TextureAtlas()
  atlas.addTextureHash(textures as never, false)
  const parser = new SkeletonJson(new AtlasAttachmentLoader(atlas))
  parser.scale = 1
  const spineData = parser.readSkeletonData(result.skeletonDataAsset)
  spineCache.set(genes, spineData)
  const spine = new Spine(spineData)
  playAnim(spine, IDLE, true)
  return spine
}
