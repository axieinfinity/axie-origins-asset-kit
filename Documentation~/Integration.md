# Integration

## New Unity project

1. Unity Hub → Unity **2021.3.x** → Open this repo.
2. Wait for import (first open builds `Library/`).
3. `Assets/OriginsKit/Prefabs/Skills/beast_gore.prefab` → drag into a scene.
4. Add `SkillPlayer`, assign `Animations/beast_gore.anim` if it is not already.
5. Enter Play Mode. You should see particles and clip events in the Console if you subscribe.

The project is set up for **URP 12.1.15**. Opening it in Hub restores the Origins Shader Graphs.

## Existing Unity project

Copy `Assets/OriginsKit` into your project. Keep `.meta` files so clip ↔ prefab links survive.

Do **not** install via Package Manager → Git URL. That path is for code packages, not this art tree.

`SkillPlayer` loads clips from `Resources/ImportedVfx/{id}` and `Resources/OriginsKit/Animations/{id}`.

## Render pipeline

This kit **is** URP 12.1.15, matching live Origins.

Skill / buff materials use first-party Shader Graphs:

- `Sd_Origin2_ADD` — additive (`_ad` / slash / sparks)
- `Sd_Origin2_ADP` — alpha blend

They live in `Assets/OriginsKit/Shaders/Optimize_Shader/`. Do not switch the project back to Built-in or those graphs will pink.

## Minimal battle loop

```
card played
  map = OriginsCatalog.FindAbility(abilityId)
  prefab = Resources.Load<GameObject>("ImportedVfx/" + map.vfxId)
  player = SkillPlayer.Spawn(prefab, attacker.position, attacker)
  player.defenderTarget = defender
  player.Attack += (_, name) => PlayMixer(attacker, name)
  player.Hit    += (_, name) => PlayMixer(defender, name)
  PlaySfx(map.vfxId + "_attack")
```

`abilityId` values look like `beast-horn-02`, `aquatic-tail-08`. They match Origins `SkillVfxInfos`.

## Pooling

Origins can show the same `vfxId` on several axies at once (`SkillEffect.multipleEffect`). Pool by id:

```
inactive instance named beast_gore → reuse
else Instantiate
```

Call `Play()` again after `OnBack`. Reset `@projectile` (SkillPlayer does this).

## Facing

Home team in Origins has `localScale.x = -1`. `SkillPlayer.LateUpdate` then:

- `@scaleX` children get positive x
- `@flipX` particle renderers flip

If your mixer axies face the other way, flip the attacker root, not the VFX children.

## Addressables / AssetBundles

You do **not** need Origins Addressables. Prefabs in this kit are regular assets. Re-bundle them yourself for your platforms if you want.

## Mixer bodies

```js
// web
import { getAxieSpineFromGenes } from '@axieinfinity/mixer'
spine.state.setAnimation(0, 'attack/melee/horn-gore', false)
```

```csharp
// unity-axie-gtk2d — same clip names
skeleton.AnimationState.SetAnimation(0, "attack/melee/horn-gore", false);
```

Genes stay 512-bit `newGenes`. See `Documentation~/MixerAnimations.md`.
