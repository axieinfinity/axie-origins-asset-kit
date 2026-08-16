/**
 * THESIS: A kit catalog is a finder — see the asset, read the path, copy it.
 * OWN-WORLD: Cool slate, warm type, one blue accent. Dark 16:9 preview well.
 * STORY: Open a kind, scan the grid, inspect one item, copy the Unity path.
 * FIRST VIEWPORT: Kind rail + search. Preview and facts on top. Grid below.
 * FORM: Catalog / DAM layout. User-pinned after rejecting game HUD.
 */
import { useEffect, useMemo, useState } from 'react'
import { AXIE_CLASSES, NAV_GROUPS, TABS, loadCatalog, snippetFor, type ItemKind, type LibraryItem } from './catalog'
import { AssetPreview } from './components/AssetPreview'
import { playLoop, playSfx, stopLoop, unlockAudio } from './audio'

const LABEL: Record<ItemKind, string> = Object.fromEntries(TABS.map((entry) => [entry.key, entry.label])) as Record<ItemKind, string>

export function App() {
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
  const [copied, setCopied] = useState(false)

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
      .catch((err: unknown) => setError(err instanceof Error ? err.message : 'Could not load catalog.json'))
  }, [])

  const counts = useMemo(() => {
    const next: Record<string, number> = {}
    for (const item of items) next[item.kind] = (next[item.kind] || 0) + 1
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

  const setKind = (next: ItemKind) => {
    setTab(next)
    const url = new URL(window.location.href)
    url.searchParams.set('tab', next)
    window.history.replaceState(null, '', url)
    const first = items.find((item) => item.kind === next)
    if (first) select(first)
  }

  const copyPath = async () => {
    const value = selected?.unityPath || selected?.name
    if (!value) return
    try {
      await navigator.clipboard.writeText(value)
      setCopied(true)
      window.setTimeout(() => setCopied(false), 1600)
    } catch {
      setCopied(false)
    }
  }

  if (!items.length && !error) {
    return (
      <div className="boot">
        <p>Loading the kit catalog…</p>
      </div>
    )
  }

  const showClass = tab === 'skill' || tab === 'buff' || tab === 'sfx'

  return (
    <div className="shell">
      <aside className="rail" aria-label="Asset kinds">
        <div className="brand">
          <strong>Origins Kit</strong>
          <span>{items.length} assets</span>
        </div>
        <nav>
          {NAV_GROUPS.map((group) => (
            <div key={group.label} className="nav-group">
              <p>{group.label}</p>
              {group.kinds.map((kind) => (
                <button
                  key={kind}
                  type="button"
                  className={tab === kind ? 'is-on' : ''}
                  aria-current={tab === kind ? 'page' : undefined}
                  onClick={() => setKind(kind)}
                >
                  <span>{LABEL[kind]}</span>
                  <span className="nav-count">{counts[kind] || 0}</span>
                </button>
              ))}
            </div>
          ))}
        </nav>
        <button type="button" className="text-btn rail-help" onClick={() => setHelpOpen((value) => !value)}>
          {helpOpen ? 'Hide guide' : 'How to use this kit'}
        </button>
      </aside>

      <div className="main">
        <header className="top">
          <label className="search-wrap">
            <span className="sr-only">Search {LABEL[tab]}</span>
            <input
              className="search"
              value={query}
              onChange={(event) => setQuery(event.currentTarget.value)}
              placeholder={`Search ${LABEL[tab].toLowerCase()}…`}
            />
          </label>
          <span className="result-count">
            {filtered.length} of {counts[tab] || 0}
          </span>
        </header>

        {error ? <p className="banner">{error}</p> : null}

        {helpOpen ? (
          <section className="guide" aria-label="How to use">
            <p>Open the clone in Unity 2021.3 LTS. Copy <code>Assets/OriginsKit</code> into your project, or open this repo as the project.</p>
            <p>Skills and buffs here are videos recorded from <code>SkillPlayer</code> at scale 54. Prefabs in the kit are the source of truth.</p>
            <p>Not in the kit: NFT Axie bodies, per-level chimera decks, Epic Toon FX, client secrets.</p>
          </section>
        ) : null}

        <section className="inspect">
          <div className="well">
            <AssetPreview mode="player" item={stageItem} loop={loop} playKey={playKey} clip={clip} />
          </div>
          <div className="facts">
            <h1>{selected?.title || 'Select an asset'}</h1>
            <p className="path">{selected?.unityPath || selected?.name}</p>
            <div className="actions">
              <button type="button" className="primary" onClick={copyPath}>
                {copied ? 'Copied' : 'Copy path'}
              </button>
              <button type="button" onClick={() => selected && select(selected)}>
                Replay
              </button>
              <button type="button" aria-pressed={loop} onClick={() => setLoop((value) => !value)}>
                Loop {loop ? 'on' : 'off'}
              </button>
              <button
                type="button"
                aria-pressed={!muted}
                onClick={() => {
                  setMuted((value) => !value)
                  stopLoop()
                }}
              >
                {muted ? 'Sound off' : 'Sound on'}
              </button>
            </div>
            <p className="usage">{selected?.usage}</p>
            {selected?.attackAnimation ? (
              <p className="events">
                OnAttack → {selected.attackAnimation}
                {selected.hitAnimation ? ` · OnHit → ${selected.hitAnimation}` : ''}
              </p>
            ) : null}
            <ul className="meta">
              {selected ? <li>{selected.kind}</li> : null}
              {selected?.className ? <li>{selected.className}</li> : null}
              {selected?.isRanged ? <li>ranged</li> : null}
              {selected?.cards?.length ? <li>{selected.cards.length} cards</li> : null}
              {selected?.video ? <li>video</li> : null}
            </ul>
            <pre className="snippet">{selected ? snippetFor(selected) : ''}</pre>
            {clips.length > 1 ? (
              <label className="clip-select">
                Clip
                <select
                  value={clip || clips[0]}
                  onChange={(event) => {
                    setClip(event.currentTarget.value)
                    setPlayKey((value) => value + 1)
                  }}
                >
                  {clips.map((name) => (
                    <option key={name} value={name}>
                      {name}
                    </option>
                  ))}
                </select>
              </label>
            ) : null}
          </div>
        </section>

        {showClass ? (
          <div className="filters" role="group" aria-label="Class">
            <button type="button" className={classFilter === 'all' ? 'is-on' : ''} onClick={() => setClassFilter('all')}>
              All classes
            </button>
            {AXIE_CLASSES.map((cls) => (
              <button
                key={cls}
                type="button"
                className={classFilter === cls ? 'is-on' : ''}
                onClick={() => setClassFilter(cls)}
              >
                {cls}
              </button>
            ))}
          </div>
        ) : null}

        {filtered.length ? (
          <div className={`grid ${tab === 'status' || tab === 'sfx' || tab === 'hud' || tab === 'intent' ? 'is-dense' : ''}`}>
            {filtered.map((item) => (
              <button
                key={item.id}
                type="button"
                className={`tile${selected?.id === item.id ? ' is-on' : ''}`}
                onClick={() => select(item)}
              >
                <AssetPreview className="tile-preview" mode="mini" item={item} loop />
                <span className="tile-title">{item.title}</span>
                <span className="tile-id">{item.name}</span>
              </button>
            ))}
          </div>
        ) : (
          <div className="empty">
            <p>Nothing matches “{query}” in {LABEL[tab]}.</p>
            <button type="button" onClick={() => setQuery('')}>
              Clear search
            </button>
          </div>
        )}
      </div>
    </div>
  )
}
