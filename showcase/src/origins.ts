import type { ItemKind, LibraryItem } from './catalog'

/** Colors from origin-client ColorConstants + painted class arenas. */
export const CLASS_COLOR: Record<string, string> = {
  beast: '#f39230',
  aquatic: '#1e8bc2',
  plant: '#459a10',
  bird: '#e9567b',
  bug: '#cf2d37',
  reptile: '#7442b3',
  mech: '#8a7ab5',
  dawn: '#beceff',
  dusk: '#236f71',
}

export const CLASS_ARENA: Record<string, string> = {
  aquatic: '/kit/PvE/Backgrounds/class/bg-aquatic.jpg',
  beast: '/kit/PvE/Backgrounds/class/bg-beast.jpg',
  bird: '/kit/PvE/Backgrounds/class/bg-bird.jpg',
  bug: '/kit/PvE/Backgrounds/class/bg-bug.jpg',
  plant: '/kit/PvE/Backgrounds/class/bg-plant.jpg',
  reptile: '/kit/PvE/Backgrounds/class/bg-reptile.jpg',
  mech: '/kit/PvE/Backgrounds/class/bg-mech.jpg',
  dawn: '/kit/PvE/Backgrounds/class/bg-dawn.jpg',
  dusk: '/kit/PvE/Backgrounds/class/bg-dusk.jpg',
}

const RIDDLE: Record<string, string> = {
  aquatic: '/kit/PvE/UI/Chapter/riddle_card_aquatic.png',
  beast: '/kit/PvE/UI/Chapter/riddle_card_beast.png',
  bird: '/kit/PvE/UI/Chapter/riddle_card_bird.png',
  bug: '/kit/PvE/UI/Chapter/riddle_card_bug.png',
  plant: '/kit/PvE/UI/Chapter/riddle_card_plant.png',
  reptile: '/kit/PvE/UI/Chapter/riddle_card_reptile.png',
  mech: '/kit/PvE/UI/Chapter/riddle_card_merch.png',
  dawn: '/kit/PvE/UI/Chapter/riddle_card_dawn.png',
  dusk: '/kit/PvE/UI/Chapter/riddle_card_dusk.png',
}

export const HUD = {
  top: '/kit/PvE/UI/InBattle/top_part.png',
  bottom: '/kit/PvE/UI/InBattle/bottom_part.png',
  name: '/kit/PvE/UI/InBattle/name_panel.png',
  energy: '/kit/PvE/UI/InBattle/energy_jar.png',
  frame: '/kit/PvE/UI/Frames/frame_border.png',
  wood: '/kit/PvE/UI/Frames/bg_wood_ground.png',
  card: '/kit/PvE/UI/InBattle/card.png',
  forest: '/kit/PvE/Backgrounds/story/7-deep-forest/7_BG-FOREST.png',
  entrance: '/kit/PvE/Backgrounds/story/4-entrance/4_BG.png',
  morph: '/kit/PvE/Backgrounds/class/bg_metamorph.png',
}

export function riddleCard(cls: string) {
  return RIDDLE[cls]
}

export function arenaUrl(item?: LibraryItem | null) {
  if (!item) return HUD.entrance
  if (item.kind === 'arena' && (item.src || item.plateUrl)) return item.src || item.plateUrl || HUD.entrance
  if (item.className && CLASS_ARENA[item.className]) return CLASS_ARENA[item.className]
  if (item.kind === 'buff' || item.kind === 'status') return HUD.morph
  if (item.kind === 'chimera' || item.kind === 'starter' || item.kind === 'summoner') return HUD.entrance
  if (item.kind === 'animation') return HUD.entrance
  return HUD.forest
}

export function usesArenaBlend(item?: LibraryItem | null) {
  return Boolean(item && (item.kind === 'skill' || item.kind === 'buff') && (item.video || item.flipbook))
}

export const KIND_LABEL: Record<ItemKind, string> = {
  skill: 'Skills',
  buff: 'Buffs',
  animation: 'Anims',
  chimera: 'Chimeras',
  starter: 'Starters',
  card: 'Cards',
  intent: 'Intents',
  arena: 'Arenas',
  music: 'Music',
  sfx: 'SFX',
  status: 'Icons',
  summoner: 'Summoners',
  ui: 'Battle UI',
  hud: 'HUD',
}
