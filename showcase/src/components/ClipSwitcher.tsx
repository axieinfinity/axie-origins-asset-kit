import { useMemo, useState, useEffect } from 'react'

const GROUP_ORDER = ['action', 'attack', 'defense', 'battle', 'activity', 'draft']

type ClipRow = { full: string; label: string }

function groupName(clip?: string) {
  if (!clip) return 'other'
  const slash = clip.indexOf('/')
  return slash > 0 ? clip.slice(0, slash) : 'other'
}

function clipLabel(clip: string) {
  const slash = clip.indexOf('/')
  return slash > 0 ? clip.slice(slash + 1) : clip
}

function groupClips(clips: string[]) {
  const map = new Map<string, ClipRow[]>()
  for (const full of clips) {
    const group = groupName(full)
    const rows = map.get(group) || []
    rows.push({ full, label: clipLabel(full) })
    map.set(group, rows)
  }
  const names = [...map.keys()].sort((a, b) => {
    const ia = GROUP_ORDER.indexOf(a)
    const ib = GROUP_ORDER.indexOf(b)
    if (ia === -1 && ib === -1) return a.localeCompare(b)
    if (ia === -1) return 1
    if (ib === -1) return -1
    return ia - ib
  })
  return names.map((name) => ({ name, rows: map.get(name) || [] }))
}

type Props = {
  clips: string[]
  value?: string
  onChange: (clip: string) => void
}

export function ClipSwitcher({ clips, value, onChange }: Props) {
  const groups = useMemo(() => groupClips(clips), [clips])
  const current = value && clips.includes(value) ? value : clips[0]
  const currentGroup = groupName(current || '')
  const [open, setOpen] = useState(currentGroup)

  useEffect(() => {
    setOpen(currentGroup)
  }, [currentGroup, clips])

  if (clips.length < 2) return null

  const shown = groups.find((group) => group.name === open) || groups[0]

  return (
    <div className="anims">
      <div className="anims-head">
        <p id="anims-label">Animations</p>
        <span>{clips.length}</span>
      </div>
      {groups.length > 1 ? (
        <div className="anims-groups" role="tablist" aria-label="Animation groups">
          {groups.map((group) => (
            <button
              key={group.name}
              type="button"
              role="tab"
              aria-selected={group.name === shown.name}
              className={group.name === shown.name ? 'is-on' : ''}
              onClick={() => setOpen(group.name)}
            >
              {group.name}
              <span>{group.rows.length}</span>
            </button>
          ))}
        </div>
      ) : null}
      <div className="anims-list" role="listbox" aria-labelledby="anims-label">
        {shown.rows.map((row) => (
          <button
            key={row.full}
            type="button"
            role="option"
            aria-selected={row.full === current}
            title={row.full}
            className={row.full === current ? 'is-on' : ''}
            onClick={() => onChange(row.full)}
          >
            {row.label}
          </button>
        ))}
      </div>
    </div>
  )
}
