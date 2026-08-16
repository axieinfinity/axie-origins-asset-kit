import { Loader, Size } from '@axieinfinity/dango'
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
}

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

export function SpinePreview({ item, className, clip, loop = true, playKey = 0 }: Props) {
  const hostRef = useRef<HTMLDivElement>(null)
  const [ready, setReady] = useState(false)
  const [failed, setFailed] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    const host = hostRef.current
    if (!host) return
    let cancelled = false
    let app: Application | null = null
    setReady(false)
    setFailed(false)
    setError('')
    void (async () => {
      try {
        const spine = await loadSpine(item)
        if (cancelled) return
        app = new Application({
          resizeTo: host,
          backgroundAlpha: 0,
          antialias: true,
          resolution: Math.min(2, window.devicePixelRatio || 1),
          autoDensity: true,
        })
        host.appendChild(app.view as HTMLCanvasElement)
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
          spine.position.set(w / 2, h * 0.88)
          const bounds = spine.getLocalBounds()
          const scale = Math.min((w * 0.82) / Math.max(1, bounds.width), (h * 0.82) / Math.max(1, bounds.height), 0.7)
          spine.scale.set(scale)
        }
        layout()
        app.renderer.on('resize', layout)
        setReady(true)
      } catch (err) {
        console.error('Spine load failed', item.id, err)
        if (!cancelled) {
          setError(err instanceof Error ? err.message : String(err))
          setFailed(true)
        }
      }
    })()
    return () => {
      cancelled = true
      app?.destroy(true, { children: true })
    }
  }, [item.id, item.spineSkel, clip, loop, playKey])

  return (
    <div className={`preview-mount ${className || ''}`}>
      <div ref={hostRef} className="preview-canvas" />
      {!ready && !failed ? (
        <div className="preview-loading">
          <Loader.Circle size={Size.Small} />
        </div>
      ) : null}
      {failed ? (
        <div className="preview-fallback">
          {item.src || item.plateUrl ? <img src={item.src || item.plateUrl} alt={item.title} /> : item.title}
          {error && !error.includes('auto-detect') ? <small>{error}</small> : null}
        </div>
      ) : null}
    </div>
  )
}
