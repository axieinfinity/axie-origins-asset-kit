/**
 * THESIS: The catalog is an Origins battlefield, not a docs dashboard.
 * OWN-WORLD: Painted class arenas, wooden HUD, cream on walnut, Changa One + Noto Sans.
 * STORY: Arrive mid-fight, copy the Unity path, walk the locker.
 * FIRST VIEWPORT: Full-bleed arena, screen-blended VFX, wood name plate.
 * FORM: In-battle HUD as catalog shell. User-pinned Origins world.
 */
import { useEffect, useMemo, useState } from 'react'
import { AXIE_CLASSES, TABS, loadCatalog, snippetFor, type ItemKind, type LibraryItem } from './catalog'
import { AssetPreview } from './components/AssetPreview'
import { useAppToast } from './providers/ToastProvider'
import { playLoop, playSfx, stopLoop, unlockAudio } from './audio'
import { CLASS_COLOR, HUD, KIND_LABEL, arenaUrl, riddleCard, usesArenaBlend } from './origins'

export function App() {
  const toast = useAppToast()
  const [items, setItems] = useState<LibraryItem[]>([])
  const [error, setError] = useState<string | null>(null)
  const initialTab = (new URLSearchParams(window.location.search).get('tab') as ItemKind) || 'skill'
  const [tab, setTab] = useState<ItemKind>(TABS.some((entry) => entry.key === initialTab) ? initialTab : 'skill')
  const [query, setQuery] = useState('')
  const [classFilter, setClassFilter] = useState('all')
  const [selected, setSelected] = useState<LibraryItem | null>(null)
  const [loop, setLoop] = useState(true)
  const [muted, setMuted] = useState(false)
  const [playKey, setPlayKey] = useState(0)
  const [clip, setClip] = useState<string | undefined>()
  const [helpOpen, setHelpOpen] = useState(false)

  useEffect(() => {
    void loadCatalog()
      .then((next) => {
        setItems(next)
        const fromTab = next.find((item) => item.kind === initialTab)
        const first =
          (initialTab !== 'skill' && fromTab) ||
          next.find((item) => item.id === 'skill:aquatic_slash') ||
          next.find((item) => item.kind === 'skill') ||
          next[0] ||
          null
        setSelected(first)
        setClip(first?.animation)
      })
      .catch((err: unknown) => setError(err instanceof Error ? err.message : 'Failed to load catalog'))
  }, [])

  const counts = useMemo(() => {
    const next: Record<string, number> = {}
    for (const item of items) next[item.kind] = (item.kind in next ? next[item.kind] : 0) + 1
    return next
  }, [items])

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase()
    return items.filter((item) => {
      if (item.kind !== tab) return false
      if (classFilter !== 'all' && item.className !== classFilter && item.family !== classFilter) return false
      if (!q) return true
      return [item.title, item.name, item.vfxId, item.animation, item.usage, item.unityPath, ...(item.cards || []), ...(item.tags || [])]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(q)
    })
  }, [items, tab, query, classFilter])

  const stageItem = useMemo(() => {
    if (!selected) return null
    if (selected.kind === 'animation') {
      const actor = items.find((item) => item.id === 'starter:1') || items.find((item) => item.kind === 'starter')
      if (!actor) return selected
      return { ...actor, animation: clip || selected.name, id: selected.id, title: selected.title }
    }
    return selected
  }, [selected, items, clip])

  const procession = useMemo(() => {
    if (!selected) return []
    const pool = items.filter((item) => item.kind === selected.kind)
    const index = Math.max(0, pool.findIndex((item) => item.id === selected.id))
    const start = Math.max(0, index - 4)
    return pool.slice(start, start + 9)
  }, [items, selected])

  const clips = selected?.clips?.length
    ? selected.clips
    : selected?.kind === 'animation'
      ? [selected.name]
      : selected?.animation
        ? [selected.animation]
        : []

  useEffect(() => {
    setClassFilter('all')
    setQuery('')
  }, [tab])

  const select = (item: LibraryItem) => {
    unlockAudio()
    setSelected(item)
    setClip(item.animation || item.clips?.[0])
    setPlayKey((value) => value + 1)
    setTab(item.kind)
    if (item.kind === 'music') {
      if (!muted && item.audioUrl) playLoop(item.audioUrl)
      return
    }
    stopLoop()
    if (!muted && item.sfxUrl) playSfx(item.sfxUrl)
  }

  const copyId = async (value?: string) => {
    if (!value) return
    try {
      await navigator.clipboard.writeText(value)
      toast.open({ duration: 2, content: 'Copied ' + value })
    } catch {
      toast.open({ duration: 2, content: 'Could not copy' })
    }
  }

  const setKind = (next: ItemKind) => {
    setTab(next)
    const url = new URL(window.location.href)
    url.searchParams.set('tab', next)
    window.history.replaceState(null, '', url)
    const first = items.find((item) => item.kind === next)
    if (first) select(first)
  }

  if (!items.length && !error) {
    return <div className="boot">Opening the battlefield…</div>
  }

  const arena = arenaUrl(stageItem || selected)
  const blend = usesArenaBlend(stageItem || selected)

  return (
    <div className="origin-root">
      <header className="hud-top">
        <div>
          <h1>Origins Unity Kit</h1>
          <p>Play it on the field. Copy the path. Drop it into Unity 2021.3.</p>
        </div>
        <div style={{ display: 'flex', gap: 10, alignItems: 'center' }}>
          <span className="hud-count">{items.length} pieces</span>
          <button type="button" className="ghost-btn" onClick={() => setHelpOpen(true)}>
            What you can build
          </button>
        </div>
      </header>

      <section className="battlefield" aria-label="Battle stage">
        <div className="arena-plate" style={{ backgroundImage: `url(${arena})` }} />
        <div className={`stage-play${blend ? ' is-blend' : ''}`}>
          <AssetPreview className="player-stage" mode="player" item={stageItem} loop={loop} playKey={playKey} clip={clip} />
        </div>
        <img className="jar" src={HUD.energy} alt="" />
        <div className="name-plate">
          <div>
            <h2>{selected?.title || 'Pick a piece'}</h2>
            <small>{selected?.unityPath || selected?.name}</small>
          </div>
          <div className="plate-actions">
            <button type="button" className="wood-btn" onClick={() => selected && select(selected)}>
              Replay
            </button>
            <button type="button" className={`wood-btn${loop ? ' is-on' : ''}`} onClick={() => setLoop((value) => !value)}>
              {loop ? 'Loop on' : 'Loop off'}
            </button>
            <button
              type="button"
              className="wood-btn"
              onClick={() => {
                setMuted((value) => !value)
                stopLoop()
              }}
            >
              {muted ? 'Muted' : 'Sound'}
            </button>
            <button type="button" className="wood-btn" onClick={() => copyId(selected?.unityPath || selected?.name)}>
              Copy path
            </button>
          </div>
        </div>
      </section>

      <div className="meta-rail">
        <div>
          <p className="usage">{selected?.usage}</p>
          {selected?.attackAnimation ? (
            <p className="events">
              OnAttack → {selected.attackAnimation}
              {selected.hitAnimation ? ` · OnHit → ${selected.hitAnimation}` : ''}
            </p>
          ) : null}
          <div className="chip-row">
            {selected?.className ? (
              <span className="chip" style={{ background: CLASS_COLOR[selected.className] || undefined, color: '#2a1810' }}>
                {selected.className}
              </span>
            ) : null}
            {selected ? <span className="chip">{selected.kind}</span> : null}
            {selected?.isRanged ? <span className="chip">ranged</span> : null}
            {selected?.cards?.length ? <span className="chip">{selected.cards.length} cards</span> : null}
            {selected?.video ? <span className="chip">player video</span> : null}
          </div>
        </div>
        <pre className="snippet">{selected ? snippetFor(selected) : ''}</pre>
      </div>

      {clips.length > 1 ? (
        <div className="kind-row">
          {clips.map((name) => (
            <button
              key={name}
              type="button"
              className={`kind-tab${clip === name ? ' is-on' : ''}`}
              onClick={() => {
                setClip(name)
                setPlayKey((value) => value + 1)
              }}
            >
              {name}
            </button>
          ))}
        </div>
      ) : null}

      {procession.length ? (
        <div className="procession" role="list">
          {procession.map((item) => (
            <button
              key={item.id}
              type="button"
              role="listitem"
              className={`procession-cell${selected?.id === item.id ? ' is-live' : ''}`}
              onClick={() => select(item)}
            >
              <Thumb item={item} />
              <span>{item.title}</span>
            </button>
          ))}
        </div>
      ) : null}

      <div className="kind-row" role="tablist">
        {TABS.map((entry) => (
          <button
            key={entry.key}
            type="button"
            role="tab"
            aria-selected={tab === entry.key}
            className={`kind-tab${tab === entry.key ? ' is-on' : ''}`}
            onClick={() => setKind(entry.key)}
          >
            {KIND_LABEL[entry.key]} ({counts[entry.key] || 0})
          </button>
        ))}
      </div>

      {tab === 'skill' || tab === 'buff' || tab === 'sfx' ? (
        <div className="class-row">
          <button type="button" className={`class-tab${classFilter === 'all' ? ' is-on' : ''}`} onClick={() => setClassFilter('all')}>
            All
          </button>
          {AXIE_CLASSES.map((cls) => (
            <button
              key={cls}
              type="button"
              className={`class-tab${classFilter === cls ? ' is-on' : ''}`}
              onClick={() => setClassFilter(cls)}
            >
              {riddleCard(cls) ? <img src={riddleCard(cls)} alt="" /> : null}
              {cls}
            </button>
          ))}
        </div>
      ) : null}

      <div className="toolbar">
        <div className="grow">
          <input
            className="search"
            placeholder={`Search ${KIND_LABEL[tab].toLowerCase()}…`}
            value={query}
            onChange={(event) => setQuery(event.currentTarget.value)}
          />
        </div>
        <span className="count">
          {filtered.length} of {counts[tab] || 0}
        </span>
      </div>

      {error ? <p className="empty-state">{error}</p> : null}

      {filtered.length ? (
        <div className={`library-grid ${tab === 'status' || tab === 'sfx' || tab === 'hud' || tab === 'intent' ? 'is-dense' : ''}`}>
          {filtered.map((item) => (
            <button
              key={item.id}
              type="button"
              className={`gallery-card${selected?.id === item.id ? ' is-active' : ''}`}
              onClick={() => select(item)}
            >
              <Thumb item={item} tall />
              <span className="gallery-title">{item.title}</span>
              <span className="gallery-name">{item.name}</span>
            </button>
          ))}
        </div>
      ) : (
        <div className="empty-state">
          <p>No assets match. Clear search to see the rest of this rack.</p>
          <button type="button" className="wood-btn" onClick={() => setQuery('')}>
            Clear search
          </button>
        </div>
      )}

      {helpOpen ? (
        <div className="help-scrim" onClick={() => setHelpOpen(false)} role="presentation">
          <div
            className="help-panel"
            role="dialog"
            aria-labelledby="help-title"
            onClick={(event) => event.stopPropagation()}
          >
            <h2 id="help-title">What this repo can do</h2>
            <p>Sky Mavis / Axie IP. Use for Axie Vibeathon and approved programs. Skill and buff clips are recorded from the local Unity player (SkillPlayer at scale 54).</p>
            <p>
              Open the clone in Unity 2021.3 LTS (URP 12.1.15). Copy <code>Assets/OriginsKit</code> into your project, or open this repo as the project.
            </p>
            <h3>You can build</h3>
            <p>
              A 2D Origins-style battler: mixer Axies (or starter spines) play the 46 battle clip names. Cards map through <code>skill-vfx.json</code> to 63 skill prefabs.
            </p>
            <p>A PvE adventure: 22 chimera bodies, 19 starter Axies, 38 chimera abilities, intent icons, 7 story arenas + 13 event arenas, and 15 music loops.</p>
            <p>HUD and juice: 152 SFX, 131 status icons, summoner spines, win/lose/draw, morph auras, energy orbs, card attribute bursts.</p>
            <h3>Not in the kit</h3>
            <p>NFT Axie bodies (use the official mixer). Per-level chimera deck lists (server). Epic Toon FX. Client secrets.</p>
            <button type="button" className="wood-btn" onClick={() => setHelpOpen(false)}>
              Close
            </button>
          </div>
        </div>
      ) : null}
    </div>
  )
}

function Thumb({ item, tall }: { item: LibraryItem; tall?: boolean }) {
  const arena = arenaUrl(item)
  const blend = usesArenaBlend(item)
  return (
    <div className={`${tall ? 'card-stage' : 'thumb'}${blend ? ' is-blend' : ''}`}>
      {blend || item.kind === 'skill' || item.kind === 'buff' ? (
        <div className="thumb-arena" style={{ backgroundImage: `url(${arena})` }} />
      ) : null}
      <AssetPreview mode="mini" item={item} loop />
    </div>
  )
}
