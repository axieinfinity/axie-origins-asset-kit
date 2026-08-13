# Status icons, morph, summoners, battle UI

## Status icons

131 sprites from the Origins status atlas, plus the atlas pages.

Use them on HP bars / tooltips. Status **gameplay** definitions (stack rules) are in `Catalogs/statuses.json` (632 rows — Origins has more logical statuses than unique icons).

## Morph VFX

Textures only (`Textures/Morph/`). Morph skill prefabs live in a separate Addressable (`morph-vfx`) that is OSX-only. For a jam, overlay these textures on a particle or UI image when an axie morphs.

## Summoners

Eight Spine 3.8 sets (clover, fruitsloth, littlerobin, mavis, mushroom, sparrow, truefanhermitcrab, trunk). Each folder has `.skel` / `.atlas` / `.png`.

Needs the Spine 3.8 Unity runtime. Not mixable with the Axie mixer skeleton.

## Battle UI Spine

Win / lose / draw / PvP flag under `BattleUI/`. Same Spine 3.8 note.

## First-party helper textures

Noise, glow, water, lightning tiles authored by the Origins VFX team (not Epic Toon FX) are in `Textures/Helpers/`. Useful if you build extra particles in the same look.

## Card attribute VFX

Origins plays a small UI burst on the card when an attribute procs. Prefabs live in origin-client `Resources/Prefabs/Components/Card_*_FX`. First-party copies are under `Prefabs/CardAttribute/` when present.
