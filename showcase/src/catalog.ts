export type ItemKind =
  | 'skill'
  | 'buff'
  | 'animation'
  | 'chimera'
  | 'starter'
  | 'card'
  | 'intent'
  | 'arena'
  | 'music'
  | 'sfx'
  | 'status'
  | 'summoner'
  | 'ui'
  | 'hud'

export type PreviewKind = 'flipbook' | 'texture' | 'icon' | 'audio' | 'spine' | 'video'

export type VideoPreviewInfo = {
  url: string
  webm?: string
  poster?: string
  duration: number
  fps: number
  width: number
  height: number
}

export type ClipEvent = {
  time: number
  function?: string
  string?: string | null
  float?: number | null
}

export type LibraryItem = {
  id: string
  kind: ItemKind
  name: string
  title: string
  tags: string[]
  family: string
  preview: PreviewKind
  className?: string
  style?: string
  animation?: string
  vfxId?: string
  attackAnimation?: string
  hitAnimation?: string
  isRanged?: boolean
  duration: number
  usage?: string
  cards?: string[]
  abilityIds?: string[]
  events?: ClipEvent[]
  clips?: string[]
  unityPath?: string
  clipPath?: string
  src?: string
  plateUrl?: string
  sfxUrl?: string
  audioUrl?: string
  spineAtlas?: string
  spineSkel?: string
  spineBase?: string
  format?: 'skel' | 'json'
  flipbook?: { url: string; cols: number; rows: number; frames: number; fps: number; duration: number }
  video?: VideoPreviewInfo
  actor?: string
  layers?: string[]
  usedInOriginsBattle?: boolean
}

export const TABS: { key: ItemKind; label: string }[] = [
  { key: 'skill', label: 'Skills' },
  { key: 'buff', label: 'Buffs' },
  { key: 'animation', label: 'Anims' },
  { key: 'chimera', label: 'Chimeras' },
  { key: 'starter', label: 'Starters' },
  { key: 'card', label: 'Cards' },
  { key: 'arena', label: 'Arenas' },
  { key: 'music', label: 'Music' },
  { key: 'sfx', label: 'SFX' },
  { key: 'status', label: 'Icons' },
  { key: 'intent', label: 'Intents' },
  { key: 'summoner', label: 'Summoners' },
  { key: 'ui', label: 'Battle UI' },
  { key: 'hud', label: 'HUD' },
]

export const AXIE_CLASSES = ['aquatic', 'beast', 'bird', 'bug', 'plant', 'reptile', 'mech', 'dawn', 'dusk']

export async function loadCatalog(): Promise<LibraryItem[]> {
  const res = await fetch('/catalog.json')
  if (!res.ok) throw new Error('Could not load catalog.json')
  const data = await res.json()
  return data.items as LibraryItem[]
}

export function snippetFor(item: LibraryItem) {
  if (item.kind === 'skill' || item.kind === 'buff') {
    return `var prefab = Resources.Load<GameObject>("ImportedVfx/${item.vfxId}");
var player = SkillPlayer.Spawn(prefab, attacker.position, attacker);
player.defenderTarget = defender;
player.Attack += (_, anim) => PlayMixer(attacker, anim);
player.Hit += (_, anim) => PlayMixer(defender, anim);`
  }
  if (item.kind === 'chimera' || item.kind === 'starter' || item.kind === 'summoner') {
    return `skeleton.AnimationState.SetAnimation(0, "${item.animation || 'action/idle/normal'}", true);`
  }
  if (item.kind === 'animation') {
    return `skeleton.AnimationState.SetAnimation(0, "${item.name}", false);`
  }
  return item.unityPath || item.name
}
