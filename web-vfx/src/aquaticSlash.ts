import { BLEND_MODES, Rectangle, Sprite, Texture } from 'pixi.js'
import { atlasUrl, frameAt, type ClipEvent, type VfxClip } from './clip'

export type Point = { x: number; y: number }

export type PlayHandle = {
  stop: () => void
}

function loadImage(url: string) {
  return new Promise<HTMLImageElement>((resolve, reject) => {
    const img = new Image()
    img.onload = () => resolve(img)
    img.onerror = () => reject(new Error(`Failed to load ${url}`))
    img.src = url
  })
}

export type Anchors = { attacker: Point; defender: Point; fieldWidth: number }

export function mapCaptureToField(clip: VfxClip, anchors: Anchors) {
  const { attacker, defender, fieldWidth } = anchors
  const cdx = clip.captureDefender.x - clip.captureAttacker.x
  const jdx = defender.x - attacker.x
  const captureSpan = Math.abs(cdx) > 8 ? Math.abs(cdx) : 390
  const spanScale = Math.abs(jdx) > 8 ? Math.abs(jdx) / captureSpan : 0.6
  const fitScale = fieldWidth > 0 ? (fieldWidth * 0.55) / clip.atlas.frameW : spanScale
  const scale = Math.min(Math.max(0.22, spanScale), Math.max(0.22, fitScale))
  const flip = Math.sign(jdx || 1) !== Math.sign(cdx || -1)
  return { scale, flip, defender }
}

export function cropPointToField(clip: VfxClip, map: ReturnType<typeof mapCaptureToField>, px: number, py: number) {
  const dx = px - clip.anchor.x
  const dy = py - clip.anchor.y
  const sx = map.flip ? -map.scale : map.scale
  return {
    x: map.defender.x + dx * sx,
    y: map.defender.y + dy * map.scale,
  }
}

export class AdditiveAtlas {
  readonly image: HTMLImageElement
  readonly clip: VfxClip
  readonly textures: Texture[] = []

  constructor(clip: VfxClip, image: HTMLImageElement, base: Texture) {
    this.clip = clip
    this.image = image
    const { cols, frameW, frameH } = clip.atlas
    for (let i = 0; i < clip.frames; i++) {
      const col = i % cols
      const row = Math.floor(i / cols)
      this.textures.push(new Texture(base.baseTexture, new Rectangle(col * frameW, row * frameH, frameW, frameH)))
    }
  }

  static async load(clip: VfxClip) {
    const url = atlasUrl(clip)
    const image = await loadImage(url)
    const base = Texture.from(image)
    return new AdditiveAtlas(clip, image, base)
  }

  drawCanvas(
    ctx: CanvasRenderingContext2D,
    index: number,
    x: number,
    y: number,
    scaleX: number,
    scaleY: number,
    originX: number,
    originY: number,
  ) {
    const { cols, frameW, frameH } = this.clip.atlas
    const col = index % cols
    const row = Math.floor(index / cols)
    ctx.save()
    ctx.translate(x, y)
    ctx.scale(scaleX, scaleY)
    ctx.drawImage(
      this.image,
      col * frameW,
      row * frameH,
      frameW,
      frameH,
      -originX,
      -originY,
      frameW,
      frameH,
    )
    ctx.restore()
  }
}

export function playOnCanvas(
  atlas: AdditiveAtlas,
  ctx: CanvasRenderingContext2D,
  getAnchors: () => Anchors,
  opts: {
    loop?: boolean
    ticker?: { add: (fn: () => void) => void; remove: (fn: () => void) => void }
    onEvent?: (evt: ClipEvent & { time: number }) => void
    onFrame?: (index: number, time: number) => void
    onDone?: () => void
  } = {},
): PlayHandle {
  const clip = atlas.clip
  const origin = clip.anchor
  let raf = 0
  let stopped = false
  const started = performance.now()
  const fired = new Set<string>()
  let cycle = 0

  const tick = () => {
    if (stopped) return
    const elapsed = (performance.now() - started) / 1000
    const nextCycle = opts.loop ? Math.floor(elapsed / Math.max(0.05, clip.duration)) : 0
    if (nextCycle !== cycle) {
      fired.clear()
      cycle = nextCycle
    }
    const t = opts.loop ? elapsed % clip.duration : Math.min(clip.duration, elapsed)
    const index = frameAt(clip, t)
    const transform = ctx.getTransform()
    ctx.setTransform(1, 0, 0, 1, 0, 0)
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height)
    ctx.setTransform(transform)
    const map = mapCaptureToField(clip, getAnchors())
    const pos = cropPointToField(clip, map, origin.x, origin.y)
    atlas.drawCanvas(ctx, index, pos.x, pos.y, map.flip ? -map.scale : map.scale, map.scale, origin.x, origin.y)
    opts.onFrame?.(index, t)
    for (const evt of clip.events) {
      const key = `${evt.function}:${evt.time}`
      if (t + 1 / clip.fps >= evt.time && !fired.has(key)) {
        fired.add(key)
        opts.onEvent?.({ ...evt, time: evt.time })
      }
    }
    if (!opts.loop && elapsed >= clip.duration) {
      opts.onDone?.()
      stopTicker()
      return
    }
    if (!opts.ticker) raf = requestAnimationFrame(tick)
  }
  const stopTicker = () => {
    if (opts.ticker) opts.ticker.remove(tick)
    else cancelAnimationFrame(raf)
  }
  if (opts.ticker) opts.ticker.add(tick)
  else tick()
  return {
    stop() {
      stopped = true
      stopTicker()
      const transform = ctx.getTransform()
      ctx.setTransform(1, 0, 0, 1, 0, 0)
      ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height)
      ctx.setTransform(transform)
    },
  }
}

export function playOnPixi(
  atlas: AdditiveAtlas,
  parent: { addChild: (s: Sprite) => unknown; removeChild: (s: Sprite) => unknown },
  getAnchors: () => Anchors,
  opts: {
    loop?: boolean
    ticker: { add: (fn: () => void) => void; remove: (fn: () => void) => void }
    onEvent?: (evt: ClipEvent & { time: number }) => void
    onDone?: () => void
  },
): PlayHandle {
  const clip = atlas.clip
  const sprite = new Sprite(atlas.textures[0])
  sprite.anchor.set(clip.anchor.x / clip.atlas.frameW, clip.anchor.y / clip.atlas.frameH)
  sprite.blendMode = BLEND_MODES.ADD
  parent.addChild(sprite)

  let stopped = false
  const started = performance.now()
  const fired = new Set<string>()
  let cycle = 0
  const tick = () => {
    if (stopped) return
    const elapsed = (performance.now() - started) / 1000
    const nextCycle = opts.loop ? Math.floor(elapsed / clip.duration) : 0
    if (nextCycle !== cycle) {
      fired.clear()
      cycle = nextCycle
    }
    const t = opts.loop ? elapsed % clip.duration : Math.min(clip.duration, elapsed)
    const map = mapCaptureToField(clip, getAnchors())
    const pos = cropPointToField(clip, map, clip.anchor.x, clip.anchor.y)
    sprite.scale.set(map.flip ? -map.scale : map.scale, map.scale)
    sprite.position.set(pos.x, pos.y)
    sprite.texture = atlas.textures[frameAt(clip, t)]
    for (const evt of clip.events) {
      const key = `${evt.function}:${evt.time}`
      if (t + 1 / clip.fps >= evt.time && !fired.has(key)) {
        fired.add(key)
        opts.onEvent?.({ ...evt, time: evt.time })
      }
    }
    if (!opts.loop && elapsed >= clip.duration) {
      opts.ticker.remove(tick)
      parent.removeChild(sprite)
      sprite.destroy()
      opts.onDone?.()
    }
  }
  opts.ticker.add(tick)
  return {
    stop() {
      stopped = true
      opts.ticker.remove(tick)
      parent.removeChild(sprite)
      if (!sprite.destroyed) sprite.destroy()
    },
  }
}

export function playCssSprite(
  img: HTMLImageElement,
  atlas: AdditiveAtlas,
  getAnchors: () => Anchors,
  opts: {
    loop?: boolean
    onEvent?: (evt: ClipEvent & { time: number }) => void
    onDone?: () => void
  } = {},
): PlayHandle {
  const clip = atlas.clip
  img.hidden = false
  img.src = atlas.image.src
  img.style.position = 'absolute'
  img.style.pointerEvents = 'none'
  img.style.mixBlendMode = 'plus-lighter'
  img.style.transformOrigin = '0 0'
  img.style.objectFit = 'fill'
  const origin = clip.anchor

  let raf = 0
  let stopped = false
  const started = performance.now()
  const fired = new Set<string>()
  let cycle = 0
  const tick = () => {
    if (stopped) return
    const elapsed = (performance.now() - started) / 1000
    const nextCycle = opts.loop ? Math.floor(elapsed / clip.duration) : 0
    if (nextCycle !== cycle) {
      fired.clear()
      cycle = nextCycle
    }
    const t = opts.loop ? elapsed % clip.duration : Math.min(clip.duration, elapsed)
    const index = frameAt(clip, t)
    const map = mapCaptureToField(clip, getAnchors())
    const pos = cropPointToField(clip, map, origin.x, origin.y)
    const sx = map.flip ? -map.scale : map.scale
    const w = clip.atlas.frameW * map.scale
    const h = clip.atlas.frameH * map.scale
    img.style.width = `${clip.atlas.cols * w}px`
    img.style.height = `${clip.atlas.rows * h}px`
    img.style.left = `${pos.x}px`
    img.style.top = `${pos.y}px`
    img.style.clipPath = `inset(0 ${(clip.atlas.cols - 1) * w}px ${(clip.atlas.rows - 1) * h}px 0)`
    const col = index % clip.atlas.cols
    const row = Math.floor(index / clip.atlas.cols)
    img.style.transform = `scale(${sx}, ${map.scale}) translate(${-origin.x - col * clip.atlas.frameW}px, ${-origin.y - row * clip.atlas.frameH}px)`
    for (const evt of clip.events) {
      const key = `${evt.function}:${evt.time}`
      if (t + 1 / clip.fps >= evt.time && !fired.has(key)) {
        fired.add(key)
        opts.onEvent?.({ ...evt, time: evt.time })
      }
    }
    if (!opts.loop && elapsed >= clip.duration) {
      img.hidden = true
      opts.onDone?.()
      return
    }
    raf = requestAnimationFrame(tick)
  }
  raf = requestAnimationFrame(tick)
  return {
    stop() {
      stopped = true
      cancelAnimationFrame(raf)
      img.hidden = true
    },
  }
}
