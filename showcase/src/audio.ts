let unlocked = false
const cache = new Map<string, HTMLAudioElement>()
let music: HTMLAudioElement | null = null

export function unlockAudio() {
  if (unlocked) return
  unlocked = true
}

export function playSfx(url: string, volume = 0.42) {
  unlockAudio()
  let base = cache.get(url)
  if (!base) {
    base = new Audio(url)
    cache.set(url, base)
  }
  const node = base.cloneNode(true) as HTMLAudioElement
  node.volume = volume
  void node.play().catch(() => {})
}

export function playLoop(url: string, volume = 0.35) {
  unlockAudio()
  stopLoop()
  music = new Audio(url)
  music.loop = true
  music.volume = volume
  void music.play().catch(() => {})
}

export function stopLoop() {
  if (!music) return
  music.pause()
  music = null
}
