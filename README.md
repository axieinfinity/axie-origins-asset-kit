# Axie Origins Battle Kit (Unity)

First-party **Axie Infinity: Origins** battle assets, extracted as **native Unity assets** for Axie Vibeathon.

This is not a browser pack. Prefabs, clips, textures, and audio are Unity 2021.3 assets you open in the Editor or add as a UPM git package.

**Private repo.** Read `LICENSE.md` before you ship anything.

## What you get

| Count | What | Where |
| ---: | --- | --- |
| 63 | Skill VFX prefabs + clips | `Assets/OriginsKit/Prefabs/Skills/`, `Animations/` |
| 42 | Buff / status VFX prefabs + clips | `Assets/OriginsKit/Prefabs/Buffs/` |
| 105 | Activation timelines (events + child on/off) | `Assets/OriginsKit/Catalogs/activation.json` |
| 188 | Card ability → VFX + mixer animation | `Assets/OriginsKit/Catalogs/skill-vfx.json` |
| 90 | Battle VFX textures | `Assets/OriginsKit/Textures/Vfx/` |
| 152 | Battle SFX | `Assets/OriginsKit/Audio/` |
| 131 | Status icons | `Assets/OriginsKit/Textures/StatusIcons/` |
| 8 | Summoner Spine sets | `Assets/OriginsKit/Summoners/` |
| 4 | Battle UI Spine (win / lose / draw / flag) | `Assets/OriginsKit/BattleUI/` |
| 62 | Morph VFX textures | `Assets/OriginsKit/Textures/Morph/` |
| 46 | Mixer Spine animation names Origins actually uses | `Assets/OriginsKit/Catalogs/mixer-animations.json` |

Axie **bodies** are not included. Mix them with the official 2D mixer, then play the animation names in the catalog.

## Requirements

- Unity **2021.3 LTS** (kit built with 2021.3.45f2). Personal is fine.
- Built-in render pipeline (particles use `Legacy Shaders/Particles/Additive` and `Alpha Blended`).
- Optional: Spine 3.8 runtime if you play summoner / battle-UI skeletons.
- Optional: `@axieinfinity/mixer` or `unity-axie-gtk2d` for Axie bodies.

## Install

### A. Open as a project (fastest)

1. Clone this repo.
2. Unity Hub → **Open** → this folder.
3. Open `Assets/OriginsKit/Samples/Gallery/Gallery.unity` (after you add the sample scene) or drop a prefab from `Prefabs/Skills/` into any scene.

### B. UPM git (add to an existing project)

`Window → Package Manager → + → Add package from git URL`:

```
https://github.com/jaatster/axie-origins-unity-kit.git
```

Or in `Packages/manifest.json`:

```json
"com.skymavis.origins-kit": "https://github.com/jaatster/axie-origins-unity-kit.git"
```

Private repo: GitHub must already be authenticated (`gh auth login` / SSH key).

## Play a skill in 15 lines

```csharp
using Axie.OriginsKit;
using UnityEngine;

public class DemoSlash : MonoBehaviour
{
    public Transform attacker;
    public Transform defender;

    void Start()
    {
        var prefab = Resources.Load<GameObject>("ImportedVfx/beast_gore");
        var player = SkillPlayer.Spawn(prefab, attacker.position, attacker);
        player.defenderTarget = defender;
        player.Attack += (_, anim) => Debug.Log("play mixer " + anim);
        player.Hit += (_, anim) => Debug.Log("defender " + anim);
    }
}
```

Origins parents the prefab to the attacker and sets **localScale = 54**. `SkillPlayer.Spawn` does that for you.

## How Origins activates an effect

Full write-up: [`Documentation~/Activation.md`](Documentation~/Activation.md).

```
abilityId  ──►  vfxId          ──►  prefab + clip
beast-horn-02    beast_gore         Prefabs/Skills/beast_gore.prefab
                                    Animations/beast_gore.anim
```

1. Look up the card in `skill-vfx.json`.
2. Instantiate the prefab on the attacker at scale 54.
3. Bind the clip with `AnimatorOverrideController["skill"] = clip`.
4. `animator.SetTrigger("skill")`.
5. The clip turns child ParticleSystems on/off (`m_IsActive`) and fires:

| Event | When | Your game should |
| --- | --- | --- |
| `OnStartLoop` | t ≈ 0 | Show the VFX |
| `OnAttack` | string = mixer clip | Play that animation on the attacker |
| `OnThrow` | float = flight seconds | Move `@projectile` toward `@defender` |
| `OnHit` | string = mixer clip | Play hit on the defender, play `{vfx}_hit` SFX |
| `OnEndLoop` | near the end | Loop or stop |
| `OnBack` | teardown | Hide / pool the instance |

Buffs (`heal`, `shield`, `sleep`, …) skip `OnAttack` / `OnThrow` / `OnHit`. They only play the clip (often looping).

## Docs

- [Integration](Documentation~/Integration.md) — drop into a 2D Axie game
- [Activation](Documentation~/Activation.md) — events, markers, scale, facing
- [Catalog](Documentation~/Catalog.md) — every VFX id and what it is for
- [Effect list](Documentation~/Effects.md) — duration, events, card mappings
- [Mixer animations](Documentation~/MixerAnimations.md) — Spine clip names
- [Audio](Documentation~/Audio.md) — SFX naming
- [Status icons, morph, summoners, extras](Documentation~/Extras.md)

## What we deliberately left out

- Epic Toon FX and other Asset Store packages
- Shop, home, stickers, non-battle UI
- Client secrets / HMAC / Firebase
- Raw StandaloneOSX Addressable bundles (they do not load in WebGL or Windows)

## Rebuild from Origins (maintainers)

See `Documentation~/Rebuild.md`.
