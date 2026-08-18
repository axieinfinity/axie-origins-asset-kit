/**
 * THESIS: Origins as a public gallery — play the art, skip the engine notes.
 * OWN-WORLD: Uncoated paper, hairline rules, Atkinson Hyperlegible, nine Axie class pigments.
 * STORY: Land, pick a collection, play it, keep browsing.
 * FIRST VIEWPORT: Axie mark + nav. Home is a hero slash. Gallery is viewer over a full grid.
 * FORM: Experience gallery with a Persuade landing. Artifact leads.
 */
import { useEffect, useMemo, useRef, useState } from 'react'
import {
  AXIE_CLASSES,
  NAV_MORE,
  NAV_PRIMARY,
  TABS,
  loadCatalog,
  type ItemKind,
  type LibraryItem,
} from './catalog'
import { AssetPreview } from './components/AssetPreview'
import { AxieMark } from './components/AxieMark'
import { ClipSwitcher } from './components/ClipSwitcher'
import { Landing } from './Landing'
import { playLoop, playSfx, stopLoop, unlockAudio } from './audio'

const LABEL: Record<ItemKind, string> = Object.fromEntries(TABS.map((entry) => [entry.key, entry.label])) as Record<
  ItemKind,
  string
>

export function App() {
  const [items, setItems] = useState<LibraryItem[]>([])
  const [error, setError] = useState<string | null>(null)
  const params = new URLSearchParams(window.location.search)
  const initialTab = params.get('tab') as ItemKind | null
  const initialId = params.get('id')
  const [home, setHome] = useState(!initialTab && !initialId)
  const [tab, setTab] = useState<ItemKind>(TABS.some((entry) => entry.key === initialTab) ? (initialTab as ItemKind) : 'skill')
  const [query, setQuery] = useState('')
  const [classFilter, setClassFilter] = useState('all')
  const [selected, setSelected] = useState<LibraryItem | null>(null)
  const [loop, setLoop] = useState(true)
  const [muted, setMuted] = useState(false)
  const [playKey, setPlayKey] = useState(0)
  const [clip, setClip] = useState<string | undefined>()
  const [moreOpen, setMoreOpen] = useState(false)
  const [menuOpen, setMenuOpen] = useState(false)
  const searchRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    void loadCatalog()
      .then((next) => {
        setItems(next)
        const fromId = initialId ? next.find((item) => item.id === initialId) : null
        if (fromId) {
          setHome(false)
          setTab(fromId.kind)
          setSelected(fromId)
          setClip(fromId.animation)
          return
        }
        if (initialTab) {
          const first = next.find((item) => item.kind === initialTab) || next[0] || null
          setSelected(first)
          setClip(first?.animation)
        }
      })
      .catch((err: unknown) => setError(err instanceof Error ? err.message : 'Could not load the gallery'))
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
      return [item.title, item.name, item.className, ...(item.tags || [])]
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

  const writeUrl = (nextHome: boolean, nextTab: ItemKind, id?: string) => {
    const url = new URL(window.location.href)
    if (nextHome) {
      url.searchParams.delete('tab')
      url.searchParams.delete('id')
    } else {
      url.searchParams.set('tab', nextTab)
      if (id) url.searchParams.set('id', id)
      else url.searchParams.delete('id')
    }
    window.history.replaceState(null, '', url)
  }

  const select = (item: LibraryItem) => {
    unlockAudio()
    setHome(false)
    setSelected(item)
    setClip(item.animation || item.clips?.[0])
    setPlayKey((value) => value + 1)
    setTab(item.kind)
    writeUrl(false, item.kind, item.id)
    setMenuOpen(false)
    setMoreOpen(false)
    if (item.kind === 'music') {
      if (!muted && item.audioUrl) playLoop(item.audioUrl)
      return
    }
    stopLoop()
    if (!muted && item.sfxUrl) playSfx(item.sfxUrl)
  }

  const openKind = (next: ItemKind) => {
    setHome(false)
    setTab(next)
    const first = items.find((item) => item.kind === next)
    if (first) select(first)
    else writeUrl(false, next)
    setMenuOpen(false)
    setMoreOpen(false)
  }

  const goHome = () => {
    setHome(true)
    setMenuOpen(false)
    setMoreOpen(false)
    stopLoop()
    writeUrl(true, tab)
  }

  useEffect(() => {
    const onKey = (event: KeyboardEvent) => {
      const target = event.target as HTMLElement | null
      const typing = target?.tagName === 'INPUT' || target?.tagName === 'SELECT' || target?.tagName === 'TEXTAREA'
      if (event.key === '/' && !typing) {
        event.preventDefault()
        searchRef.current?.focus()
        return
      }
      if (typing || home) return
      if (event.key === 'r' && selected) {
        event.preventDefault()
        select(selected)
        return
      }
      if ((event.key === '[' || event.key === ']') && clips.length > 1) {
        event.preventDefault()
        const current = clip && clips.includes(clip) ? clip : clips[0]
        const index = clips.indexOf(current)
        const next =
          event.key === ']' ? clips[(index + 1) % clips.length] : clips[(index - 1 + clips.length) % clips.length]
        setClip(next)
        setPlayKey((value) => value + 1)
        return
      }
      if (event.key === 'Escape') {
        setQuery('')
        setMoreOpen(false)
        setMenuOpen(false)
        return
      }
      const index = selected ? filtered.findIndex((item) => item.id === selected.id) : -1
      if (event.key === 'ArrowDown' || event.key === 'j') {
        event.preventDefault()
        const next = filtered[Math.min(filtered.length - 1, Math.max(0, index) + 1)]
        if (next) select(next)
      }
      if (event.key === 'ArrowUp' || event.key === 'k') {
        event.preventDefault()
        const next = filtered[Math.max(0, index - 1)]
        if (next) select(next)
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  })

  if (!items.length && !error) {
    return (
      <div className="boot">
        <AxieMark size={36} />
        <p>Opening Origins…</p>
      </div>
    )
  }

  const showClass = tab === 'skill' || tab === 'buff' || tab === 'sfx'
  const inMore = NAV_MORE.includes(tab)

  return (
    <div className={`shell${home ? ' is-home' : ''}`}>
      <header className="topnav">
        <button type="button" className="brand" onClick={goHome}>
          <AxieMark size={28} />
          <span>Origins</span>
        </button>
        <nav className="nav-desk" aria-label="Collections">
          {NAV_PRIMARY.map((kind) => (
            <button
              key={kind}
              type="button"
              className={!home && tab === kind ? 'is-on' : ''}
              aria-current={!home && tab === kind ? 'page' : undefined}
              onClick={() => openKind(kind)}
            >
              {LABEL[kind]}
            </button>
          ))}
          <div className="nav-more">
            <button type="button" className={inMore && !home ? 'is-on' : ''} onClick={() => setMoreOpen((value) => !value)}>
              More
            </button>
            {moreOpen ? (
              <div className="nav-pop">
                {NAV_MORE.map((kind) => (
                  <button key={kind} type="button" className={tab === kind && !home ? 'is-on' : ''} onClick={() => openKind(kind)}>
                    {LABEL[kind]}
                    <span>{counts[kind] || 0}</span>
                  </button>
                ))}
              </div>
            ) : null}
          </div>
        </nav>
        <button type="button" className="nav-burger" aria-expanded={menuOpen} onClick={() => setMenuOpen((value) => !value)}>
          {menuOpen ? 'Close' : 'Menu'}
        </button>
      </header>

      {menuOpen ? (
        <nav className="nav-sheet" aria-label="Collections">
          <button type="button" className={home ? 'is-on' : ''} onClick={goHome}>
            Home
          </button>
          {[...NAV_PRIMARY, ...NAV_MORE].map((kind) => (
            <button key={kind} type="button" className={!home && tab === kind ? 'is-on' : ''} onClick={() => openKind(kind)}>
              {LABEL[kind]}
              <span>{counts[kind] || 0}</span>
            </button>
          ))}
        </nav>
      ) : null}

      {error ? <p className="banner">{error}</p> : null}

      {home ? (
        <Landing items={items} onOpen={openKind} />
      ) : (
        <div className="gallery">
          <section className="viewer" aria-label={selected?.title || 'Preview'}>
            <div className="well">
              <AssetPreview mode="player" item={stageItem} loop={loop} playKey={playKey} clip={clip} />
            </div>
            <div className="caption">
              <h1>{selected?.title || 'Pick one'}</h1>
              <ul className="meta">
                {selected?.className ? (
                  <li className={`chip-${selected.className}`} data-class={selected.className}>
                    {selected.className}
                  </li>
                ) : null}
                {selected?.isRanged ? <li>ranged</li> : null}
                {clips.length > 1 ? <li>{clips.length} animations</li> : null}
              </ul>
              <div className="actions">
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
              <ClipSwitcher
                clips={clips}
                value={clip}
                onChange={(next) => {
                  setClip(next)
                  setPlayKey((value) => value + 1)
                }}
              />
            </div>
          </section>

          <div className="browse">
            <header className="browse-bar">
              <label className="search-wrap">
                <span className="sr-only">Search {LABEL[tab]}</span>
                <input
                  ref={searchRef}
                  className="search"
                  value={query}
                  onChange={(event) => setQuery(event.currentTarget.value)}
                  placeholder={`Search ${LABEL[tab].toLowerCase()}…`}
                />
              </label>
              <span className="result-count">
                {filtered.length} {LABEL[tab].toLowerCase()}
              </span>
            </header>

            {showClass ? (
              <div className="filters" role="group" aria-label="Class">
                <button type="button" className={classFilter === 'all' ? 'is-on' : ''} onClick={() => setClassFilter('all')}>
                  All
                </button>
                {AXIE_CLASSES.map((cls) => (
                  <button
                    key={cls}
                    type="button"
                    className={`${classFilter === cls ? 'is-on' : ''} chip-${cls}`}
                    data-class={cls}
                    onClick={() => setClassFilter(cls)}
                  >
                    {cls}
                  </button>
                ))}
              </div>
            ) : null}

            {filtered.length ? (
              <div
                className={`grid ${tab === 'status' || tab === 'sfx' || tab === 'hud' || tab === 'intent' ? 'is-dense' : ''}`}
              >
                {filtered.map((item) => (
                  <button
                    key={item.id}
                    type="button"
                    className={`tile${selected?.id === item.id ? ' is-on' : ''}`}
                    aria-pressed={selected?.id === item.id}
                    onClick={() => select(item)}
                  >
                    <AssetPreview className="tile-preview" mode="mini" item={item} loop />
                    <span className="tile-title">{item.title}</span>
                    {item.className ? (
                      <span className={`tile-chip chip-${item.className}`}>{item.className}</span>
                    ) : null}
                    {item.clips && item.clips.length > 1 ? (
                      <span className="tile-anims">{item.clips.length} animations</span>
                    ) : null}
                  </button>
                ))}
              </div>
            ) : (
              <div className="empty">
                <p>Nothing matches “{query}”.</p>
                <button type="button" onClick={() => setQuery('')}>
                  Clear search
                </button>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
