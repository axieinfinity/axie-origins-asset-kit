/**
 * THESIS: The kit is a live procession — one asset in motion, every sibling
 * an equal fragment. Not a docs homepage with thumbnail cards.
 * OWN-WORLD: Dango dark / kam / Work Sans. Chrome recedes; the playing figure leads.
 * STORY: A builder lands on a playing skill, copies the Unity path, walks PvE next.
 * FIRST VIEWPORT: Sticky theater (stage + integration + neighbor strip). Field below.
 * FORM: Assigned procession (#5) fused with equal-fragment field. Seed 7aac86dd.
 */
import { useEffect, useMemo, useState } from 'react'
import {
  Alert,
  Badge,
  Box,
  Button,
  ButtonVariant,
  Dialog,
  Dropdown,
  IconButton,
  Intent,
  Loader,
  Radio,
  Search,
  Size,
  Space,
  SpaceAlignItems,
  SpaceDirection,
  SpaceJustify,
  SpecialTag,
  Switch,
  Tag,
  Tabs,
  Tooltip,
  Typography,
} from '@axieinfinity/dango'
import {
  CopyIcon,
  InformationCircle01Icon,
  PlayIcon,
  ReloadIcon,
  SpeakerIcon,
  SpeakerMuteIcon,
} from '@axieinfinity/dango-icons'
import { AXIE_CLASSES, TABS, loadCatalog, snippetFor, type ItemKind, type LibraryItem } from './catalog'
import { AssetPreview } from './components/AssetPreview'
import { useAppToast } from './providers/ToastProvider'
import { playLoop, playSfx, stopLoop, unlockAudio } from './audio'

function kindIntent(kind: ItemKind) {
  if (kind === 'skill' || kind === 'card') return Intent.Primary
  if (kind === 'buff' || kind === 'status') return Intent.Success
  if (kind === 'animation' || kind === 'ui') return Intent.Info
  if (kind === 'chimera' || kind === 'starter') return Intent.Danger
  return Intent.Default
}

function classTag(name?: string) {
  if (!name) return null
  const map: Record<string, (typeof SpecialTag.Type)[keyof typeof SpecialTag.Type]> = {
    plant: SpecialTag.Type.Plant,
    beast: SpecialTag.Type.Beast,
    bug: SpecialTag.Type.Bug,
    bird: SpecialTag.Type.Bird,
    aquatic: SpecialTag.Type.Aquatic,
    reptile: SpecialTag.Type.Reptile,
    dusk: SpecialTag.Type.Dusk,
    mech: SpecialTag.Type.Mech,
    dawn: SpecialTag.Type.Dawn,
  }
  const type = map[name]
  return type ? <SpecialTag type={type}>{name}</SpecialTag> : <Tag size={Size.Small}>{name}</Tag>
}

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
      toast.open({ duration: 2, content: <Typography.Text>Copied {value}</Typography.Text> })
    } catch {
      toast.open({ duration: 2, content: <Typography.Text>Could not copy</Typography.Text> })
    }
  }

  if (!items.length && !error) {
    return (
      <div className="app-shell">
        <Space direction={SpaceDirection.Vertical} align={SpaceAlignItems.Center} justify={SpaceJustify.Center} style={{ minHeight: '60vh' }}>
          <Loader.Circle size={Size.Large} />
          <Typography.Text color="gray">Loading the Origins Unity kit…</Typography.Text>
        </Space>
      </div>
    )
  }

  return (
    <div className="app-shell">
      <header className="mast">
        <div>
          <Typography.Heading level="4">Origins Unity Kit</Typography.Heading>
          <Typography.Text level="3" color="gray">
            Everything this repo ships — play it, copy the path, drop it into Unity 2021.3.
          </Typography.Text>
        </div>
        <Space>
          <Badge intent={Intent.Primary} text={`${items.length} assets`} size={Size.Small} />
          <Button text="What you can build" icon={InformationCircle01Icon} variant={ButtonVariant.Outlined} size={Size.Small} onClick={() => setHelpOpen(true)} />
        </Space>
      </header>

      <div className="player-dock">
        <Box level="2" className="player-bar">
          <AssetPreview className="player-stage" mode="player" item={stageItem} loop={loop} playKey={playKey} clip={clip} />
          <div className="player-meta">
            <Space justify={SpaceJustify.Between} align={SpaceAlignItems.Center}>
              <Typography.Heading level="5">{selected?.title || 'Sample stage'}</Typography.Heading>
              {selected ? <Badge intent={kindIntent(selected.kind)} text={selected.kind} size={Size.Small} /> : null}
            </Space>
            <Typography.Text level="3" color="gray">
              {selected?.unityPath || selected?.name || 'Pick any fragment'}
            </Typography.Text>
            <Space wrap size="5">
              {classTag(selected?.className)}
              {selected?.isRanged ? (
                <Tag intent={Intent.Info} size={Size.Small}>
                  ranged
                </Tag>
              ) : null}
              {selected?.cards?.length ? <Tag size={Size.Small}>{selected.cards.length} cards</Tag> : null}
              {selected?.kind === 'skill' || selected?.kind === 'buff' ? (
                <Tag size={Size.Small}>{selected.video ? 'Unity player video' : 'flipbook preview'}</Tag>
              ) : null}
            </Space>
            <Typography.Text level="3">{selected?.usage}</Typography.Text>
            {selected?.attackAnimation ? (
              <Typography.Text level="4" color="gray">
                OnAttack → {selected.attackAnimation}
                {selected.hitAnimation ? ` · OnHit → ${selected.hitAnimation}` : ''}
              </Typography.Text>
            ) : null}
            <pre className="snippet">{selected ? snippetFor(selected) : ''}</pre>
            <Space align={SpaceAlignItems.Center} wrap>
              <Tooltip target={<IconButton icon={PlayIcon} intent={Intent.Primary} onClick={() => selected && select(selected)} />}>
                Play
              </Tooltip>
              <Tooltip target={<IconButton icon={ReloadIcon} onClick={() => selected && select(selected)} />}>
                Replay
              </Tooltip>
              <Switch label="Loop" checked={loop} intent={Intent.Primary} onChange={(event) => setLoop(event.currentTarget.checked)} />
              <Tooltip
                target={
                  <IconButton
                    icon={muted ? SpeakerMuteIcon : SpeakerIcon}
                    onClick={() => {
                      setMuted((value) => !value)
                      stopLoop()
                    }}
                  />
                }
              >
                {muted ? 'Unmute' : 'Mute'}
              </Tooltip>
              <Tooltip target={<IconButton icon={CopyIcon} onClick={() => copyId(selected?.unityPath || selected?.name)} />}>
                Copy path
              </Tooltip>
              {clips.length > 1 ? (
                <Dropdown
                  label="Clip"
                  selectedOption={clip ? { key: clip, value: clip, label: clip } : undefined}
                  onChange={(event) => {
                    const next = String(event.option.value)
                    setClip(next)
                    setPlayKey((value) => value + 1)
                  }}
                >
                  {clips.map((name) => (
                    <Dropdown.Item key={name} data={{ key: name, value: name, label: name }} />
                  ))}
                </Dropdown>
              ) : null}
            </Space>
          </div>
        </Box>
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
                <AssetPreview mode="mini" item={item} loop />
                <span>{item.title}</span>
              </button>
            ))}
          </div>
        ) : null}
      </div>

      <Space className="library-body" direction={SpaceDirection.Vertical} size="3" block align={SpaceAlignItems.Stretch}>
        {error ? <Alert intent={Intent.Danger} title="Catalog error" content={error} /> : null}

        <Tabs
          activeKey={tab}
          onChange={(key) => {
            const next = String(key) as ItemKind
            setTab(next)
            const url = new URL(window.location.href)
            url.searchParams.set('tab', next)
            window.history.replaceState(null, '', url)
          }}
          intent={Intent.Primary}
          variant="underline"
        >
          {TABS.map((entry) => (
            <Tabs.TabPane tab={`${entry.label} (${counts[entry.key] || 0})`} key={entry.key} />
          ))}
        </Tabs>

        <div className="toolbar">
          <div className="grow">
            <Search
              placeholder={`Search ${TABS.find((entry) => entry.key === tab)?.label.toLowerCase() || 'the kit'}…`}
              value={query}
              onChange={(event) => setQuery(event.currentTarget.value)}
              showRemoveIcon
              onClickRemove={() => setQuery('')}
            />
          </div>
          <Typography.Text level="3" color="gray">
            {filtered.length} of {counts[tab] || 0}
          </Typography.Text>
        </div>

        {tab === 'skill' || tab === 'sfx' ? (
          <Radio.Group value={classFilter} onChange={(event) => setClassFilter(event.currentTarget.value)}>
            <Space wrap size="5">
              <Radio value="all" label="All classes" />
              {AXIE_CLASSES.map((cls) => (
                <Radio key={cls} value={cls} label={cls} />
              ))}
            </Space>
          </Radio.Group>
        ) : null}

        {filtered.length ? (
          <div className={`library-grid ${tab === 'status' || tab === 'sfx' || tab === 'hud' || tab === 'intent' ? 'is-dense' : ''}`}>
            {filtered.map((item) => (
              <button
                key={item.id}
                type="button"
                className={`gallery-card${selected?.id === item.id ? ' is-active' : ''}`}
                onClick={() => select(item)}
              >
                <AssetPreview className="card-stage" mode="mini" item={item} loop />
                <span className="gallery-title">{item.title}</span>
                <span className="gallery-name">{item.name}</span>
              </button>
            ))}
          </div>
        ) : (
          <Box level="3" className="empty-state">
            <Space direction={SpaceDirection.Vertical} align={SpaceAlignItems.Center}>
              <Typography.Heading level="5">No assets match</Typography.Heading>
              <Typography.Text color="gray">Clear search to see the rest of this tab.</Typography.Text>
              <Button text="Clear search" intent={Intent.Primary} onClick={() => setQuery('')} />
            </Space>
          </Box>
        )}
      </Space>

      <Dialog
        visible={helpOpen}
        onClose={() => setHelpOpen(false)}
        title={<Typography.Heading level="4">What this repo can do</Typography.Heading>}
        size="large"
      >
        <Space direction={SpaceDirection.Vertical} size="2">
          <Alert
            intent={Intent.Info}
            title="Private Vibeathon kit"
            content="Sky Mavis / Axie IP. Use for Axie Vibeathon and approved programs. Not a public dump. Skill and buff clips are recorded from the local Unity player (SkillPlayer at scale 54)."
          />
          <Typography.Text>
            Open the clone in Unity 2021.3 LTS (URP 12.1.15). Copy <code>Assets/OriginsKit</code> into your project, or open this repo as the project. Do not add it as a UPM Git URL.
          </Typography.Text>
          <Typography.Heading level="5">You can build</Typography.Heading>
          <Typography.Text>
            A 2D Origins-style battler: mixer Axies (or starter spines) play the 46 battle clip names. Cards map through <code>skill-vfx.json</code> to 63 skill prefabs. <code>SkillPlayer.Spawn</code> runs them at scale 54 and fires OnStartLoop / OnAttack / OnThrow / OnHit / OnEndLoop / OnBack.
          </Typography.Text>
          <Typography.Text>
            A PvE adventure: 22 chimera bodies, 19 starter Axies, 38 chimera abilities, intent icons, 7 story arenas + 13 event arenas, and 15 music loops. Chimeras reuse the same skill VFX.
          </Typography.Text>
          <Typography.Text>
            HUD and juice: 152 SFX, 131 status icons, summoner spines, win/lose/draw, morph auras, energy orbs, card attribute bursts.
          </Typography.Text>
          <Typography.Heading level="5">Not in the kit</Typography.Heading>
          <Typography.Text>
            NFT Axie bodies (use the official mixer). Per-level chimera deck lists (server). Epic Toon FX. Client secrets.
          </Typography.Text>
          <Typography.Text color="gray">
            Docs live in Documentation~/ — Integration, Activation, PvE, Catalog, MixerAnimations.
          </Typography.Text>
        </Space>
      </Dialog>
    </div>
  )
}
