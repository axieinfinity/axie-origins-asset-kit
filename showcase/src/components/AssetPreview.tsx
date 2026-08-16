import { PlayIcon } from '@axieinfinity/dango-icons'
import type { LibraryItem } from '../catalog'
import { FlipbookPreview } from './FlipbookPreview'
import { SpinePreview } from './SpinePreview'
import { VideoPreview } from './VideoPreview'

type Props = {
  item?: LibraryItem | null
  mode: 'player' | 'mini'
  loop?: boolean
  speed?: number
  playKey?: number
  clip?: string
  className?: string
}

export function AssetPreview({ item, mode, loop, speed, playKey, clip, className }: Props) {
  if (!item) return <div className={`preview-mount ${className || ''}`} />

  if (item.video && (item.kind === 'skill' || item.kind === 'buff')) {
    return (
      <VideoPreview
        item={item}
        className={className}
        playKey={playKey}
        still={mode === 'mini'}
        loop={loop !== false}
      />
    )
  }

  if (item.flipbook && (item.kind === 'skill' || item.kind === 'buff')) {
    if (item.kind === 'buff' && item.src && mode === 'mini') {
      return (
        <div className={`preview-mount icon-preview ${className || ''}`}>
          <img src={item.src} alt={item.title} />
        </div>
      )
    }
    return (
      <FlipbookPreview
        item={item}
        className={className}
        speed={mode === 'mini' ? 1 : speed}
        playKey={playKey}
        still={mode === 'mini'}
      />
    )
  }

  if (item.preview === 'spine' && item.spineSkel && mode === 'player') {
    return <SpinePreview item={item} className={className} clip={clip || item.animation} loop={loop} playKey={playKey} />
  }

  if ((item.preview === 'texture' || item.preview === 'icon' || item.src || item.plateUrl) && item.preview !== 'audio') {
    const src = item.src || item.plateUrl
    return (
      <div className={`preview-mount icon-preview ${item.kind === 'arena' || item.kind === 'card' ? 'is-fill' : ''} ${className || ''}`}>
        {src ? <img src={src} alt={item.title} /> : <span>{item.title}</span>}
      </div>
    )
  }

  if (item.preview === 'audio') {
    return (
      <div className={`preview-mount audio-preview ${className || ''}`}>
        <PlayIcon size={mode === 'player' ? 36 : 28} />
        <span>{item.title}</span>
      </div>
    )
  }

  const src = item.src || item.plateUrl
  return (
    <div className={`preview-mount icon-preview ${className || ''}`}>
      {src ? <img src={src} alt={item.title} /> : <span>{item.title}</span>}
    </div>
  )
}
