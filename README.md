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
| 20 | PvE chimera Spine bodies + animations | `Assets/OriginsKit/PvE/Chimeras/` |
| 38 | Starter Axie Spine bodies (19 characters × 2 stages) | `Assets/OriginsKit/PvE/Starters/` |
| 20 | Story + event battle arenas | `Assets/OriginsKit/PvE/Backgrounds/` |
| 15 | PvE / boss / seasonal music | `Assets/OriginsKit/PvE/Music/` |
| 38 | Chimera ability cards + 91 tool-card arts | `Assets/OriginsKit/PvE/Cards/` + `Catalogs/pve-cards.json` |
| 17 | Enemy intent icons | `Assets/OriginsKit/PvE/Intents/` |
| 46 | Mixer Spine animation names Origins actually uses | `Assets/OriginsKit/Catalogs/mixer-animations.json` |

Axie **bodies** are not included. Mix them with the official 2D mixer, then play the animation names in the catalog.

## Requirements

- Unity **2021.3 LTS** (kit built with 2021.3.45f2). Personal is fine.
- **URP 12.1.15** (same as Origins). Particle materials use first-party `Sd_Origin2_ADD` / `Sd_Origin2_ADP` Shader Graphs, not Built-in Additive.
- Optional: Spine 3.8 runtime if you play summoner / battle-UI skeletons.
- Optional: `@axieinfinity/mixer` or `unity-axie-gtk2d` for Axie bodies.

## Install

**Do not add this repo as a UPM Git URL.** The kit is binary art (prefabs, clips, textures, audio). Unity’s Package Manager Git install is for versioned *code*; it is a bad fit here (immutable checkout, credential friction, LFS pointer risk).

### A. Open as a project (recommended)

1. Get access to this private repo, then:
   ```bash
   git clone https://github.com/jaatster/axie-origins-unity-kit.git
   ```
2. Unity Hub → Unity **2021.3 LTS** → **Open** → the clone.
3. Drop a prefab from `Assets/OriginsKit/Prefabs/Skills/` into a scene, or use `SkillPlayer.Spawn`.

### Browse everything locally

```bash
cd showcase
npm install
npm run dev
```

Open http://127.0.0.1:5177/ — pick a kind, inspect the asset, copy the Unity path. Skill and buff clips are videos recorded from `SkillPlayer`. In the Editor: **Origins → Play Local Player**.

### B. Copy into an existing project

Copy the whole `Assets/OriginsKit` folder (keep `.meta` files) into your project’s `Assets/`. Skill/buff materials use first-party `Sd_Origin2` Shader Graphs — they need **URP 12.1.15**. Built-in RP will pink those graphs.

### C. Optional `.unitypackage`

In the Editor: select `Assets/OriginsKit` → **Assets → Export Package…**. That is the informal art-share format. We do **not** commit a prebuilt `.unitypackage` (it would exceed GitHub’s 100 MB file limit).

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
- [Packaging research](Documentation~/Research.md) — why Assets tree, not UPM Git or OSX bundles
- [PvE](Documentation~/PvE.md) — chimera + starter characters, cards, intents, arenas, music, UI

## What we deliberately left out

- Epic Toon FX and other Asset Store packages
- Shop, home stickers, and other non-battle UI (PvE chapter / lobby / HUD art is included)
- Client secrets / HMAC / Firebase
- Raw StandaloneOSX Addressable bundles (they do not load in WebGL or Windows)

## Rebuild from Origins (maintainers)

See `Documentation~/Rebuild.md`.
