import { useEffect, useRef } from 'react'
import type { LibraryItem } from '../catalog'

type Props = {
  item: LibraryItem
  className?: string
  speed?: number
  playKey?: number
}

export function FlipbookPreview({ item, className, speed = 1, playKey = 0 }: Props) {
  const canvasRef = useRef<HTMLCanvasElement>(null)
  const hostRef = useRef<HTMLDivElement>(null)
  const book = item.flipbook

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
    const image = new Image()
    const io = new IntersectionObserver(([entry]) => {
      visible = entry.isIntersecting
    }, { rootMargin: '80px' })
    io.observe(host)
    const resize = () => {
      canvas.width = host.clientWidth
      canvas.height = host.clientHeight
    }
    resize()
    const ro = new ResizeObserver(resize)
    ro.observe(host)
    image.onload = () => {
      const fw = image.width / book.cols
      const fh = image.height / book.rows
      const tick = () => {
        if (!running) return
        if (visible) {
          const step = Math.max(1, 60 / (book.fps * speed))
          const index = Math.floor(frame / step) % book.frames
          const sx = (index % book.cols) * fw
          const sy = Math.floor(index / book.cols) * fh
          ctx.clearRect(0, 0, canvas.width, canvas.height)
          ctx.globalCompositeOperation = 'lighter'
          const scale = Math.min(canvas.width / fw, canvas.height / fh)
          const dw = fw * scale
          const dh = fh * scale
          ctx.drawImage(image, sx, sy, fw, fh, (canvas.width - dw) / 2, (canvas.height - dh) / 2, dw, dh)
          frame += 1
        }
        raf = requestAnimationFrame(tick)
      }
      tick()
    }
    image.src = book.url
    return () => {
      running = false
      cancelAnimationFrame(raf)
      io.disconnect()
      ro.disconnect()
    }
  }, [book?.url, book?.cols, book?.rows, book?.frames, book?.fps, speed, playKey])

  return (
    <div ref={hostRef} className={`preview-mount flipbook-preview ${className || ''}`}>
      <canvas ref={canvasRef} className="preview-canvas" />
    </div>
  )
}
