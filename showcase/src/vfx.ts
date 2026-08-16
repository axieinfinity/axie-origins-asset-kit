import { Texture } from 'pixi.js'

const textureCache = new Map<string, Promise<Texture>>()

export function loadTexture(url: string) {
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
