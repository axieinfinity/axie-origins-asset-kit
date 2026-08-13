# Status icons, morph, summoners, battle UI

## Status icons

131 sprites from the Origins status atlas, plus the atlas pages.

Use them on HP bars / tooltips. Status **gameplay** definitions (stack rules) are in `Catalogs/statuses.json` (632 rows — Origins has more logical statuses than unique icons).

## Morph VFX

Prefabs (from `morph-vfx`, same playback as skills):

| Prefab | Use |
| --- | --- |
| `Prefabs/Morph/morph_aura_burst` | Burst when a morph starts |
| `Prefabs/Morph/morph_aura_loop_battle` | Looping aura while morphed |
| `Prefabs/Morph/morph_card` | Card-side morph sting |
| `Prefabs/Morph/MetamorphDrawerRT` | Offscreen RT drawer (advanced) |

Textures remain in `Textures/Morph/`. Play burst/loop with `SkillPlayer` / `BuffPlayer` the same way as other effects.

## Summoners

Eight Spine 3.8 sets (clover, fruitsloth, littlerobin, mavis, mushroom, sparrow, truefanhermitcrab, trunk). Each folder has `.skel` / `.atlas` / `.png`.

Needs the Spine 3.8 Unity runtime. Not mixable with the Axie mixer skeleton.

## Battle UI Spine

Win / lose / draw / PvP flag under `BattleUI/`. Same Spine 3.8 note.

## First-party helper textures

Noise, glow, water, lightning tiles authored by the Origins VFX team (not Epic Toon FX) are in `Textures/Helpers/`. Useful if you build extra particles in the same look.

## Card attribute VFX

Origins plays a small UI burst on the card when an attribute procs. Prefabs are under `Prefabs/CardAttribute/` (`Card_Blue_FX`, `Green`, `Yellow`, `Red`, `Other`, plus `CardAttributeVFX`).

## Extra first-party battle particles

`Prefabs/BattleExtras/` (not in the Addressable skill bundle):

- Hand: `card-addition`, `card-banish`, `card-banish-green`, `card-banish-dead`, `BanishBurnOut`, `BanishGlow`, `BanishMist`, `CardCursedAppear`
- Board: `WindlinesStormy`, `BlowingLeaves`, `SmokeWhiteSoft`, `LightningStrikeSharpRed`, `SmokeSummon`
- Energy: `Energy Orb`, `Energy Orb Aura`, `Energy Orb Broken`
- HUD: `SleepAnimator`, `StunAnimator`, `Laser Beam`
- Shield clips: `Animations/ShieldHud/shield-up-clip`, `shield-down-clip`, `shield-broken-clip`

These prefabs ship with first-party materials/textures. Origins host scripts are stubbed (`GameObjectBattleParticleEffect`, `CardAttributeVFXSource`) so Unity does not show missing-script errors. ParticleSystems still `playOnAwake`.

Five extras originally pointed at Epic Toon FX materials (`LightningStrikeSharpRed`, `card-addition`, `WindlinesStormy`, `SmokeWhiteSoft`, `CardCursedAppear`). Those ETFX materials were **not** copied. `FixExtraPrefabs` remaps any leftover pink material to URP / Origins graphs.
