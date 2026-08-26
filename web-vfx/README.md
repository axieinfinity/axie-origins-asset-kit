# Additive overlay runtime

Browser playback of every Origins **skill** and **buff** SkillEffect. The runtime is Vite + TypeScript, PixiJS 7.2.4 mixer Axies, and a DOM canvas overlay with additive blending (`plus-lighter` / canvas `lighter`):

```
Vite + TypeScript
├─ DOM + CSS     HUD / combat VFX overlay (mix-blend plus-lighter)
├─ PixiJS 7.2.4  mixer Axies (@axieinfinity/mixer 1.4.9)
└─ Phaser map    sits under the overlay in the host game
```

Unity Shuriken stays in `Assets/OriginsKit`. This folder is the web plate: additive atlases recorded from those same prefabs.

## Coverage

| | Count |
| --- | ---: |
| Skill VFX | 63 + `beast_smash 1` capture |
| Buff / status VFX | 42 + `shield_break-origin` capture |
| Total web clips | **107** |

Each clip is `public/vfx/<id>/atlas.png` + `clip.json` (fps, crop, defender/target anchor, Origins clip events). Catalog: `public/vfx/index.json`.

## Run

```bash
cd web-vfx
npm install
npm run dev          # http://127.0.0.1:5178/
```

Rebuild atlases from Unity PNG sequences (18-core batch):

```bash
npm run process
```

## Drop-in for a Vite game

Copy `src/aquaticSlash.ts`, `src/clip.ts`, and `public/vfx/`. Overlay canvas:

```css
.vfx-overlay { pointer-events: none; mix-blend-mode: plus-lighter; }
```

```ts
const clip = await loadClip('aquatic_slash')
const atlas = await AdditiveAtlas.load(clip)
playOnCanvas(atlas, overlayCtx, () => ({
  attacker: attackerPos,
  defender: defenderPos,
  fieldWidth: battlefieldWidth,
}), {
  onEvent({ function: name, string: anim }) {
    if (name === 'OnAttack') playMixer(attacker, anim)
    if (name === 'OnHit') playMixer(defender, anim)
  }
})
```

Buffs have no `OnAttack` / `OnHit`; play the atlas on the target Axie for `clip.duration`.

## Unity vs web

| | Unity | Web |
| --- | --- | --- |
| Path | `Assets/OriginsKit/Prefabs/Skills|Buffs/<id>.prefab` | `web-vfx/public/vfx/<id>/` |
| Playback | `SkillPlayer` + ParticleSystems | additive atlas + DOM overlay |
| Events | Animator clip | `clip.json` `events` |
