import { Application, Container } from 'pixi.js'
import type { Spine } from 'pixi-spine'
import {
  AdditiveAtlas,
  playCssSprite,
  playOnCanvas,
  playOnPixi,
  type Anchors,
  type PlayHandle,
} from './aquaticSlash'
import type { ClipEvent, VfxClip } from './clip'
import { SAMPLE_GENES, createAxieSpine, fallbacksFor, playAnim, IDLE } from './mixerAxie'

const MAX_SIZE = 0.16
const MIXER_BODY = 875

export type LayerMode = 'pixi' | 'dom' | 'css'

export class Battlefield {
  app: Application
  vfxRoot = new Container()
  attacker?: Spine
  defender?: Spine
  atlas?: AdditiveAtlas
  clip?: VfxClip
  layer: LayerMode = 'dom'
  loop = true
  private playing?: PlayHandle
  private audio?: HTMLAudioElement
  private resizeObserver?: ResizeObserver
  onHud?: (html: string) => void
  onEvent?: (evt: ClipEvent & { time: number }) => void

  constructor(
    readonly host: HTMLElement,
    readonly overlay: HTMLCanvasElement,
    readonly cssImg: HTMLImageElement,
  ) {
    this.app = new Application({
      resizeTo: host,
      backgroundAlpha: 0,
      antialias: true,
      resolution: Math.min(2, window.devicePixelRatio || 1),
      autoDensity: true,
    })
    host.appendChild(this.app.view as HTMLCanvasElement)
    this.app.stage.addChild(this.vfxRoot)
    this.syncOverlay()
    this.app.renderer.on('resize', () => {
      this.layout()
      this.syncOverlay()
    })
    this.resizeObserver = new ResizeObserver(() => {
      this.layout()
      this.syncOverlay()
    })
    this.resizeObserver.observe(host)
    window.visualViewport?.addEventListener('resize', this.onViewport)
  }

  private onViewport = () => {
    this.layout()
    this.syncOverlay()
  }

  private syncOverlay() {
    const w = Math.max(1, this.host.clientWidth)
    const h = Math.max(1, this.host.clientHeight)
    const dpr = Math.min(2, window.devicePixelRatio || 1)
    const bufW = Math.max(1, Math.floor(w * dpr))
    const bufH = Math.max(1, Math.floor(h * dpr))
    const ctx = this.overlay.getContext('2d')
    if (this.overlay.width !== bufW || this.overlay.height !== bufH) {
      this.overlay.width = bufW
      this.overlay.height = bufH
    }
    this.overlay.style.width = `${w}px`
    this.overlay.style.height = `${h}px`
    if (ctx) ctx.setTransform(dpr, 0, 0, dpr, 0, 0)
  }

  async boot() {
    const [left, right] = await Promise.all([
      createAxieSpine(SAMPLE_GENES.p1),
      createAxieSpine(SAMPLE_GENES.p2),
    ])
    this.attacker = left
    this.defender = right
    this.app.stage.addChild(this.attacker as never, this.defender as never)
    this.app.stage.addChild(this.vfxRoot)
    this.layout()
    playAnim(this.attacker, IDLE, true)
    playAnim(this.defender, IDLE, true)
  }

  async setClip(atlas: AdditiveAtlas) {
    this.atlas = atlas
    this.clip = atlas.clip
    this.audio = this.makeAudio(atlas.clip.id)
    this.play()
  }

  layout() {
    const w = Math.max(1, this.app.screen.width || this.host.clientWidth)
    const h = Math.max(1, this.app.screen.height || this.host.clientHeight)
    const size = Math.min(MAX_SIZE, (w * 0.3) / MIXER_BODY)
    const inset = w < 560 ? 0.24 : 0.28
    const ground = h * (w < 560 ? 0.82 : 0.78)
    if (this.attacker) {
      this.attacker.scale.set(-size, size)
      this.attacker.position.set(w * inset, ground)
    }
    if (this.defender) {
      this.defender.scale.set(size, size)
      this.defender.position.set(w * (1 - inset), ground)
    }
  }

  private anchors(): Anchors {
    const w = Math.max(1, this.app.screen.width || this.host.clientWidth)
    const size = this.attacker ? Math.abs(this.attacker.scale.y) : MAX_SIZE
    const chest = size * 337.5
    const onTarget = this.clip?.kind === 'buff' || this.clip?.anchor.mapsTo === 'target'
    const target = onTarget ? this.defender : this.defender
    return {
      attacker: {
        x: this.attacker?.x ?? w * 0.28,
        y: (this.attacker?.y ?? 0) - chest,
      },
      defender: {
        x: target?.x ?? w * 0.72,
        y: (target?.y ?? 0) - chest,
      },
      fieldWidth: w,
    }
  }

  play() {
    this.layout()
    this.syncOverlay()
    if (!this.atlas || !this.clip || !this.attacker || !this.defender) {
      this.onHud?.('<p>Play skipped — mixer Axies or clip not ready.</p>')
      return
    }
    this.playing?.stop()
    this.onHud?.(this.hudText('armed'))
    const ctx = this.overlay.getContext('2d')
    if (!ctx) return
    ctx.setTransform(1, 0, 0, 1, 0, 0)
    ctx.clearRect(0, 0, this.overlay.width, this.overlay.height)
    this.syncOverlay()
    this.cssImg.hidden = true
    const getAnchors = () => this.anchors()
    if (this.clip.kind === 'buff') {
      playAnim(this.defender, fallbacksFor(this.clip.hitAnimation || 'battle/get-buff'), false)
      void this.audio?.play().catch(() => {})
    }

    const onEvent = (evt: ClipEvent & { time: number }) => {
      this.handleEvent(evt)
      this.onEvent?.(evt)
    }

    try {
      if (this.layer === 'pixi') {
        this.playing = playOnPixi(this.atlas, this.vfxRoot, getAnchors, {
          loop: this.loop,
          ticker: this.app.ticker,
          onEvent,
          onDone: () => this.idle(),
        })
      } else if (this.layer === 'dom') {
        this.playing = playOnCanvas(this.atlas, ctx, getAnchors, {
          loop: this.loop,
          ticker: this.app.ticker,
          onEvent,
          onFrame: (index) => {
            this.overlay.dataset.frame = String(index)
          },
          onDone: () => this.idle(),
        })
      } else {
        this.playing = playCssSprite(this.cssImg, this.atlas, getAnchors, {
          loop: this.loop,
          onEvent,
          onDone: () => this.idle(),
        })
      }
    } catch (err) {
      this.onHud?.(`<p>Play failed: ${err instanceof Error ? err.message : String(err)}</p>`)
    }
  }

  private makeAudio(id: string) {
    const candidates = [`/sfx/${id}_attack.wav`, `/sfx/${id}.wav`, `/sfx/${id}_hit.wav`]
    const audio = new Audio(candidates[0])
    audio.preload = 'auto'
    return audio
  }

  private handleEvent(evt: ClipEvent & { time: number }) {
    if (evt.function === 'OnAttack') {
      if (this.attacker) playAnim(this.attacker, fallbacksFor(evt.string || this.clip?.attackAnimation || ''), false)
      void this.audio?.play().catch(() => {})
    }
    if (evt.function === 'OnHit' && this.defender) {
      playAnim(this.defender, fallbacksFor(evt.string || this.clip?.hitAnimation || 'defense/hit-by-normal'), false)
    }
    if (evt.function === 'OnBack' && !this.loop) this.idle()
    this.onHud?.(this.hudText(evt.function))
  }

  idle() {
    if (this.attacker) playAnim(this.attacker, IDLE, true)
    if (this.defender) playAnim(this.defender, IDLE, true)
  }

  hudText(phase = 'idle') {
    const clip = this.clip
    if (!clip) return '<p>No clip</p>'
    const hit = clip.events.find((e) => e.function === 'OnHit')
    return [
      `<p><strong>${clip.id}</strong> · ${clip.kind} · ${clip.fps} fps · ${clip.frames} frames</p>`,
      clip.attackAnimation ? `<p>Mixer attack <strong>${clip.attackAnimation}</strong></p>` : '<p>Buff / status overlay</p>',
      hit ? `<p>Hit <strong>${clip.hitAnimation}</strong> @ ${hit.time.toFixed(3)}s</p>` : '',
      `<p>Phase <strong>${phase}</strong> · layer <strong>${this.layer}</strong></p>`,
    ].join('')
  }
}
