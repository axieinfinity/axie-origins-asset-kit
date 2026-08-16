import { useEffect, useRef } from 'react'
import type { LibraryItem } from '../catalog'

type Props = {
  item: LibraryItem
  className?: string
  playKey?: number
  still?: boolean
  loop?: boolean
}

export function VideoPreview({ item, className, playKey = 0, still = false, loop = true }: Props) {
  const videoRef = useRef<HTMLVideoElement>(null)
  const video = item.video

  useEffect(() => {
    const el = videoRef.current
    if (!el || still || !video) return
    el.currentTime = 0
    const play = el.play()
    if (play && typeof play.catch === 'function') play.catch(() => {})
  }, [playKey, video?.url, still, loop])

  if (!video) return <div className={`preview-mount ${className || ''}`} />

  if (still) {
    const src = video.poster || video.url
    return (
      <div className={`preview-mount video-preview is-still ${className || ''}`}>
        {src ? <img src={src} alt={item.title} /> : null}
      </div>
    )
  }

  return (
    <div className={`preview-mount video-preview ${className || ''}`}>
      {video.poster ? <img className="poster-back" src={video.poster} alt="" /> : null}
      <video
        ref={videoRef}
        key={`${video.url}:${playKey}`}
        poster={video.poster}
        autoPlay
        muted
        loop={loop}
        playsInline
        preload="auto"
      >
        {video.webm ? <source src={video.webm} type="video/webm" /> : null}
        <source src={video.url} type={video.url.endsWith('.webm') ? 'video/webm' : 'video/mp4'} />
      </video>
    </div>
  )
}
