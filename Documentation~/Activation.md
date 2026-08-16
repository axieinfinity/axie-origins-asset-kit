# How Origins activates VFX

This is the contract your game should follow. The prefabs in this kit were extracted from production `battle-vfx` Addressables. Playback in Origins is **not** “enable the prefab and hope”. A clip drives child visibility and tells the fighter which mixer animation to play.

## Objects

| Object | Role |
| --- | --- |
| Skill prefab | Root `Animator` + ParticleSystem tree. Missing `SkillEffect` is replaced by `SkillPlayer`. |
| Matching `.anim` | Same file name as the prefab. Contains events **and** stepped `m_IsActive` curves. |
| `AnimatorController` | Empty default state + `skill` trigger → `skill` state. Override the `skill` motion with the clip. |
| Attacker transform | Prefab parent. Origins sets `localScale = 54 * Vector3.one`. |
| Defender transform | Assigned to `SkillPlayer.defenderTarget`. `@defender` follows it every `LateUpdate`. |

ParticleSystems in these prefabs use **scalingMode = Local**. Parent scale 54 moves **positions**, not particle size. Do not “fix” sizes by changing 54 unless you also re-author start sizes.

## Markers (child names)

| Name contains | Meaning |
| --- | --- |
| `@attacker` | Stays on the caster. |
| `@defender` | Hit / splash. Origins overwrites world position with the real target. Authored local position is a default (often `(-8.89, 2.41)`). |
| `@projectile` | Flies on `OnThrow`. Reset to local home before each play. |
| `@scaleX` / `@scaleY` / `@scaleZ` | Flip local scale when the caster faces left (`lossyScale.x < 0`). |
| `@flipX` / `@flipY` / `@flipZ` | Flip `ParticleSystemRenderer.flip` for left side. |

## Code path (Origins)

```
FighterEffect.SpawnSkill
  Instantiate(prefab, attacker)
  localPosition = 0
  localScale = 54
  effect.defenders = targets
  effect.Play(attackAnim, hitAnim)
    GenerateRuntimeAnimator()   // override ["skill"] = clip
    animator.SetTrigger("skill")
```

`SkillPlayer.Spawn` is that path without DOTween / EasyButtons / Addressables.

## Local player

The kit ships `VfxLocalPlayer`. In Unity: **Origins → Play Local Player** (baker) or drop `VfxLocalPlayer` on an empty scene camera (kit). Arrow keys cycle every ImportedVfx clip, Space replays. Catalog videos were recorded from this player at 960×540 / 30 fps.

## Clip events

Every **skill** clip (63) fires some of these. Buffs usually fire none.

| Function | Parameter | Origins reaction |
| --- | --- | --- |
| `OnStartLoop` | — | Skill VFX visible |
| `OnAttack` | `string` mixer name, e.g. `attack/melee/horn-gore` | Play on attacker Spine |
| `OnThrow` | `float` seconds | `DOMove` `@projectile` to defender |
| `OnHit` | `string` mixer name, e.g. `defense/hit-by-normal` | Play on defender Spine; hide projectile sprite |
| `OnEndLoop` | — | If `loopCount > 1`, jump to loop start |
| `OnBack` | — | Teardown after ~1s |

Wire mixer like this:

```csharp
player.Attack += (_, anim) => attackerMixer.SetAnimation(0, anim, false);
player.Hit    += (_, anim) => defenderMixer.SetAnimation(0, anim, false);
```

If a part-specific clip is missing on that Axie, Origins falls back to:

- melee → `attack/melee/normal-attack`
- ranged → `attack/ranged/cast-fly`
- hit → `defense/hit-by-normal`

## Child activation (`m_IsActive`)

Most children start **inactive**. The clip turns them on at specific frames (stepped Infinity tangents). If you play the prefab **without the clip**, you will see nothing — that is expected.

`Catalogs/activation.json` lists every track, for example `aquatic_slash`:

```json
{
  "path": "Slash1@scaleX",
  "keys": [
    { "time": 0.0, "active": false },
    { "time": 0.0833, "active": true },
    { "time": 0.85, "active": false }
  ]
}
```

103 of 105 effects have at least one activation track. `stealth` is the empty exception (visual is almost invisible by design).

## Ranged vs melee

A clip is ranged if it has `OnThrow`. Then:

1. `@projectile` sits on the attacker.
2. `OnThrow(duration)` — lerp to `@defender` in `duration` seconds (see `projectileTravel` in `skill-vfx.json`).
3. `OnHit` — impact particles under `@defender` turn on.

Melee clips skip the projectile and turn slash / bite / gore children on near `OnAttack` / `OnHit`.

## Buffs

`BuffPlayer` uses the same controller and trigger. Origins also plays `BuffSoundFx` named after the prefab (`heal`, `shield`, …). Persistent statuses (`sleep`, `stunned`, `shield`) are long clips; treat them as looping until the status expires, then `SetActive(false)`.

## SFX (parallel to VFX)

| File pattern | When |
| --- | --- |
| `{vfxId}_attack.wav` | `OnAttack` |
| `{vfxId}_fly.wav` | `OnThrow` |
| `{vfxId}_hit.wav` | `OnHit` |
| `{buffId}.wav` | buff start |

Not every id has all three stems. See `Documentation~/Audio.md`.

## World scale cheat sheet

Origins battle camera: `viewHeight = 720 / 64 = 11.25`, ortho size `5.625`.

Fighter root scale is 1 (x flipped to −1 on the home team). VFX local scale is 54. Authored child positions around 3–9 local units become tens of world units — that is correct next to Spine axies authored at similar scale.

If your axies are ~1 unit tall, parent the VFX to the axie and keep 54, **or** wrap the instance:

```csharp
holder.localScale = Vector3.one / 54f;
instance.localScale = Vector3.one * 54f;
```

Particle sizes stay the same (Local scaling). Positions shrink with the holder.

## Do not

- Play the prefab with no clip.
- Strip `@` children.
- Change 54 without understanding Local scaling.
- Load the original StandaloneOSX `battle-vfx.bundle` in WebGL / Windows — it will not work.
- Ship Epic Toon FX from origin-client.
