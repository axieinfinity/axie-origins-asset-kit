import { Application } from 'pixi.js'
import { Spine } from 'pixi-spine'
import { TextureAtlas } from '@pixi-spine/base'
import { AtlasAttachmentLoader, SkeletonBinary, SkeletonJson } from '@pixi-spine/runtime-3.8'
import { useEffect, useRef, useState } from 'react'
import type { LibraryItem } from '../catalog'
import { loadTexture } from '../vfx'

type Props = {
  item: LibraryItem
  className?: string
  clip?: string
  loop?: boolean
  playKey?: number
  compact?: boolean
}

const MAX_COMPACT = 16
let compactLive = 0

async function loadSpine(item: LibraryItem) {
  if (!item.spineAtlas || !item.spineSkel || !item.spineBase) throw new Error('Missing spine paths')
  const atlasText = await fetch(item.spineAtlas).then((r) => {
    if (!r.ok) throw new Error('atlas')
    return r.text()
  })
  const pages = [...atlasText.matchAll(/^\S+\.(png|jpg|jpeg)$/gim)].map((match) => match[0])
  const textures: Record<string, Awaited<ReturnType<typeof loadTexture>>> = {}
  await Promise.all(
    pages.map(async (page) => {
      const texture = await loadTexture(`${item.spineBase}${page}`)
      textures[page] = texture
      textures[page.replace(/\.[^.]+$/, '')] = texture
    }),
  )
  const atlas = await new Promise<TextureAtlas>((resolve, reject) => {
    const parsed = new TextureAtlas(
      atlasText,
      (pageName, done) => {
        const texture = textures[pageName] || textures[pageName.replace(/\.[^.]+$/, '')]
        if (!texture) {
          done(null as never)
          reject(new Error(`Missing atlas page ${pageName}`))
          return
        }
        done(texture.baseTexture)
      },
      (result) => {
        if (!result) reject(new Error('Failed to parse spine atlas'))
        else resolve(result)
      },
    )
    void parsed
  })
  const loader = new AtlasAttachmentLoader(atlas)
  const isJson = item.format === 'json' || item.spineSkel.endsWith('.json')
  if (isJson) {
    const data = await fetch(item.spineSkel).then((r) => r.json())
    const parser = new SkeletonJson(loader)
    parser.scale = 1
    return new Spine(parser.readSkeletonData(data))
  }
  const buffer = await fetch(item.spineSkel).then((r) => r.arrayBuffer())
  const parser = new SkeletonBinary(loader)
  parser.scale = 1
  return new Spine(parser.readSkeletonData(new Uint8Array(buffer)))
}

export function SpinePreview({ item, className, clip, loop = true, playKey = 0, compact = false }: Props) {
  const hostRef = useRef<HTMLDivElement>(null)
  const [ready, setReady] = useState(false)
  const [failed, setFailed] = useState(false)
  const [error, setError] = useState('')
  const [visible, setVisible] = useState(!compact)

  useEffect(() => {
    const host = hostRef.current
    if (!host || !compact) return
    const io = new IntersectionObserver(([entry]) => setVisible(entry.isIntersecting), { rootMargin: '80px' })
    io.observe(host)
    return () => io.disconnect()
  }, [compact, item.id])

  useEffect(() => {
    const host = hostRef.current
    if (!host || !visible) return
    let cancelled = false
    let app: Application | null = null
    let tookSlot = false
    setReady(false)
    setFailed(false)
    setError('')
    void (async () => {
      try {
        if (compact) {
          while (compactLive >= MAX_COMPACT) {
            await new Promise((resolve) => setTimeout(resolve, 80))
            if (cancelled) return
          }
          compactLive += 1
          tookSlot = true
        }
        for (let i = 0; i < 40 && (host.clientWidth < 8 || host.clientHeight < 8); i += 1) {
          await new Promise((resolve) => requestAnimationFrame(resolve))
          if (cancelled) return
        }
        if (host.clientWidth < 8 || host.clientHeight < 8) throw new Error('preview host has no size')
        const spine = await loadSpine(item)
        if (cancelled) return
        const common = {
          width: host.clientWidth,
          height: host.clientHeight,
          backgroundAlpha: 0,
          antialias: true,
          resolution: Math.min(2, window.devicePixelRatio || 1),
          autoDensity: true,
        }
        try {
          app = new Application(common)
        } catch {
          app = new Application({ ...common, forceCanvas: true })
        }
        const view = app.view as HTMLCanvasElement
        view.style.width = '100%'
        view.style.height = '100%'
        host.appendChild(view)
        const names = spine.spineData.animations?.map((anim) => anim.name) || []
        const preferred =
          clip && names.includes(clip)
            ? clip
            : names.find((name) => name === 'action/idle/normal') ||
              names.find((name) => /idle|loop|victory|flag/i.test(name)) ||
              names[0]
        if (preferred) spine.state.setAnimation(0, preferred, loop)
        app.stage.addChild(spine as never)
        const layout = () => {
          const w = app!.screen.width
          const h = app!.screen.height
          spine.position.set(w / 2, h * (compact ? 0.96 : 0.9))
          const bounds = spine.getLocalBounds()
          const fit = compact ? 0.88 : 0.84
          const cap = compact ? 1.4 : 0.82
          const scale = Math.min((w * fit) / Math.max(1, bounds.width), (h * fit) / Math.max(1, bounds.height), cap)
          spine.scale.set(scale)
        }
        layout()
        app.renderer.on('resize', layout)
        setReady(true)
      } catch (err) {
        console.error('Spine load failed', item.id, err)
        if (!cancelled) {
          setFailed(true)
          setError(err instanceof Error ? err.message : 'Spine failed')
        }
      }
    })()
    return () => {
      cancelled = true
      if (tookSlot) compactLive = Math.max(0, compactLive - 1)
      app?.destroy(true, { children: true })
    }
  }, [visible, item.id, item.spineSkel, clip, loop, playKey, compact])

  return (
    <div className={`preview-mount spine-preview ${className || ''}`}>
      <div ref={hostRef} className="preview-canvas" />
      {visible && !ready && !failed ? <div className="preview-loading">Loading</div> : null}
      {failed && item.src ? (
        <img className="spine-still" src={item.src} alt={item.title} />
      ) : failed ? (
        <div className="preview-fallback">{item.title}</div>
      ) : null}
    </div>
  )
}
