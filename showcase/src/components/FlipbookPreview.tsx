import { useEffect, useRef, useState } from 'react'
import type { LibraryItem } from '../catalog'

type Props = {
  item: LibraryItem
  className?: string
  speed?: number
  playKey?: number
  still?: boolean
}

function peakFrame(image: HTMLImageElement, book: NonNullable<LibraryItem['flipbook']>) {
  const fw = image.width / book.cols
  const fh = image.height / book.rows
  const probe = document.createElement('canvas')
  probe.width = Math.max(1, Math.round(fw))
  probe.height = Math.max(1, Math.round(fh))
  const ctx = probe.getContext('2d', { willReadFrequently: true })
  if (!ctx) return { index: 0, score: 0 }
  let best = 0
  let bestScore = -1
  const limit = Math.min(book.frames, book.cols * book.rows)
  for (let i = 0; i < limit; i++) {
    const sx = (i % book.cols) * fw
    const sy = Math.floor(i / book.cols) * fh
    ctx.clearRect(0, 0, probe.width, probe.height)
    ctx.drawImage(image, sx, sy, fw, fh, 0, 0, probe.width, probe.height)
    const data = ctx.getImageData(0, 0, probe.width, probe.height).data
    let score = 0
    for (let p = 0; p < data.length; p += 16) {
      const r = data[p]
      const g = data[p + 1]
      const b = data[p + 2]
      const a = data[p + 3]
      if (a < 8) continue
      const spread = Math.abs(r - g) + Math.abs(g - b) + Math.abs(r - b)
      if (spread < 12 && r < 110) continue
      score += a + spread * 2
    }
    if (score > bestScore) {
      bestScore = score
      best = i
    }
  }
  return { index: best, score: Math.max(0, bestScore) }
}

export function FlipbookPreview({ item, className, speed = 1, playKey = 0, still = false }: Props) {
  const canvasRef = useRef<HTMLCanvasElement>(null)
  const hostRef = useRef<HTMLDivElement>(null)
  const book = item.flipbook
  const [empty, setEmpty] = useState(false)

  useEffect(() => {
    const canvas = canvasRef.current
    const host = hostRef.current
    if (!canvas || !host || !book) return
    const ctx = canvas.getContext('2d')
    if (!ctx) return
    let frame = 0
    let raf = 0
    let running = true
    let visible = true
    let start = 0
    let peak = 0
    setEmpty(false)
    const image = new Image()
    const io = new IntersectionObserver(([entry]) => {
      visible = entry.isIntersecting
    }, { rootMargin: '80px' })
    io.observe(host)
    const resize = () => {
      const w = Math.max(1, host.clientWidth)
      const h = Math.max(1, host.clientHeight)
      if (canvas.width !== w || canvas.height !== h) {
        canvas.width = w
        canvas.height = h
      }
    }
    resize()
    const ro = new ResizeObserver(resize)
    ro.observe(host)

    const draw = (index: number) => {
      const fw = image.width / book.cols
      const fh = image.height / book.rows
      const sx = (index % book.cols) * fw
      const sy = Math.floor(index / book.cols) * fh
      ctx.setTransform(1, 0, 0, 1, 0, 0)
      ctx.globalCompositeOperation = 'source-over'
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      const scale = Math.min(canvas.width / fw, canvas.height / fh) * 0.92
      const dw = fw * scale
      const dh = fh * scale
      ctx.imageSmoothingEnabled = true
      ctx.drawImage(image, sx, sy, fw, fh, (canvas.width - dw) / 2, (canvas.height - dh) / 2, dw, dh)
      const painted = ctx.getImageData(0, 0, canvas.width, canvas.height)
      const px = painted.data
      for (let p = 0; p < px.length; p += 4) {
        const r = px[p]
        const g = px[p + 1]
        const b = px[p + 2]
        if (Math.abs(r - g) < 10 && Math.abs(g - b) < 10 && r > 55 && r < 120) {
          px[p + 3] = 0
        }
      }
      let visiblePx = 0
      for (let p = 3; p < px.length; p += 4) if (px[p] > 8) visiblePx += 1
      if (visiblePx < 80 && index !== peak) {
        draw(peak)
        return
      }
      ctx.putImageData(painted, 0, 0)
    }

    image.onload = () => {
      const picked = peakFrame(image, book)
      peak = picked.index
      if (picked.score < 80) {
        setEmpty(true)
        return
      }
      setEmpty(false)
      if (still) {
        draw(peak)
        return
      }
      const tick = (now: number) => {
        if (!running) return
        if (!start) start = now
        if (visible) {
          const elapsed = ((now - start) / 1000) * speed
          const index = (peak + Math.floor(elapsed * book.fps)) % book.frames
          if (index !== frame || frame === 0) {
            frame = index
            draw(index)
          }
        }
        raf = requestAnimationFrame(tick)
      }
      raf = requestAnimationFrame(tick)
    }
    image.src = `${book.url}?v=${playKey}`
    return () => {
      running = false
      cancelAnimationFrame(raf)
      io.disconnect()
      ro.disconnect()
    }
  }, [book?.url, book?.cols, book?.rows, book?.frames, book?.fps, speed, playKey, still])

  if (empty && item.src) {
    return (
      <div className={`preview-mount icon-preview ${className || ''}`}>
        <img src={item.src} alt={item.title} />
      </div>
    )
  }

  return (
    <div ref={hostRef} className={`preview-mount flipbook-preview ${className || ''}`}>
      <canvas ref={canvasRef} className="preview-canvas" />
    </div>
  )
}
