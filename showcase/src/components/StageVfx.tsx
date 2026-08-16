import { useEffect, useRef } from 'react'
import type { LibraryItem } from '../catalog'

type Props = {
  item: LibraryItem
  playKey?: number
  loop?: boolean
  className?: string
}

export function StageVfx({ item, playKey = 0, loop = true, className }: Props) {
  const videoRef = useRef<HTMLVideoElement>(null)
  const canvasRef = useRef<HTMLCanvasElement>(null)
  const video = item.video

  useEffect(() => {
    const el = videoRef.current
    const canvas = canvasRef.current
    if (!el || !canvas || !video) return
    const ctx = canvas.getContext('2d', { willReadFrequently: true })
    if (!ctx) return
    let raf = 0
    let running = true

    const punchImage = (source: CanvasImageSource, w: number, h: number) => {
      if (canvas.width !== w || canvas.height !== h) {
        canvas.width = w
        canvas.height = h
      }
      ctx.drawImage(source, 0, 0, w, h)
      const frame = ctx.getImageData(0, 0, w, h)
      const data = frame.data
      for (let i = 0; i < data.length; i += 4) {
        const r = data[i]
        const g = data[i + 1]
        const b = data[i + 2]
        if (r < 28 && g < 30 && b < 36) {
          data[i + 3] = 0
        } else {
          const floor = Math.min(r, g, b)
          if (floor < 48) data[i + 3] = Math.min(data[i + 3], Math.round((floor / 48) * 255))
        }
      }
      ctx.putImageData(frame, 0, 0)
    }

    if (video.poster) {
      const poster = new Image()
      poster.onload = () => punchImage(poster, poster.naturalWidth || 960, poster.naturalHeight || 540)
      poster.src = video.poster
    }

    const punch = () => {
      if (!running) return
      if (el.readyState >= 2) {
        punchImage(el, el.videoWidth || 960, el.videoHeight || 540)
      }
      raf = requestAnimationFrame(punch)
    }

    const start = () => {
      el.currentTime = 0
      const play = el.play()
      if (play && typeof play.catch === 'function') play.catch(() => {})
      raf = requestAnimationFrame(punch)
    }

    el.addEventListener('loadeddata', start)
    if (el.readyState >= 2) start()
    return () => {
      running = false
      cancelAnimationFrame(raf)
      el.removeEventListener('loadeddata', start)
    }
  }, [video?.url, playKey, loop])

  if (!video) return <div className={`preview-mount ${className || ''}`} />

  return (
    <div className={`preview-mount stage-vfx ${className || ''}`}>
      <video
        ref={videoRef}
        key={`${video.url}:${playKey}`}
        muted
        loop={loop}
        playsInline
        preload="auto"
        hidden
      >
        {video.webm ? <source src={video.webm} type="video/webm" /> : null}
        <source src={video.url} type="video/mp4" />
      </video>
      <canvas ref={canvasRef} />
    </div>
  )
}
