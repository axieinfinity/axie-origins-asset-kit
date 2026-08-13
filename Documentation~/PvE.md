# PvE chimeras

Origins adventure enemies are **Chimeras**: dedicated Spine 3.8 skeletons, not mixer Axies. They still play the **same battle VFX** (`Prefabs/Skills/`) and many of the **same animation name families** (`action/idle/normal`, `attack/melee/normal-attack`, …).

## What’s in the kit

| Path | Contents |
| --- | --- |
| `Assets/OriginsKit/PvE/Chimeras/<slug>/` | `<slug>.skel` + `.atlas` + `.png` for each unique body |
| `Assets/OriginsKit/PvE/Avatars/` | Chimera portrait atlas pages |
| `Assets/OriginsKit/PvE/Backgrounds/` | Story-node battle backgrounds (textures) |
| `Assets/OriginsKit/PvE/Music/` | `pve_1.wav` `pve_2.wav` `pve_3.wav` `boss.wav` |
| `Assets/OriginsKit/Catalogs/pve-chimeras.json` | 73 chimera rows, 35 nodes, extracted file lists, animation names |

**22 unique skeletons** (73 game-data rows reuse them at different levels):

`alpha-wolf` `aqua-alpha-wolf` `aqua-slime-atk` `aqua-slime-boss` `aqua-slime-def` `aqua-slime-sup` `aqua-wolf` `daddy-bear` `dryad-fighter` `dryad-mage` `dryad-ranger` `flowering-treant` `forest-slime-fighter` `forest-slime-flower` `gray-wolf` `machito` `mommy-bear` `shilin` `slime` `treant` `treant-fighter` `werewolf`

`machito` and `shilin` are in the live Addressable catalog (extra / unused in current `ChimeraInfos`).

## Playback

Needs the **Spine 3.8** Unity runtime (same as summoners).

```csharp
// After importing .skel / .atlas / .png so spine-unity builds SkeletonData
skeleton.AnimationState.SetAnimation(0, "action/idle/normal", true);
skeleton.AnimationState.SetAnimation(0, "attack/melee/normal-attack", false);
```

Required clips Origins validates on every chimera:

- `action/idle/normal`
- `defense/hit-by-normal`
- `action/move-forward`
- `action/move-back`

Most also have `attack/melee/normal-attack`, a ranged cast, `battle/get-buff` / `get-debuff`, and `defense/hit-die`. Slimes add extras (`attack/ranged/laser-beam`, `goo-split`, `throw-slime`, …). See `extractedSkeletons[].unityClips` in the catalog (names harvested from the binary; the `.skel` is authoritative).

## VFX

Chimeras do **not** have a second VFX pack. Their cards map through the same `skill-vfx.json` (`tool-chimerabite-02` → `beast_bite`, etc.). Spawn `Prefabs/Skills/{vfxId}` with `SkillPlayer` exactly as for Axies.

## Nodes

`pve-chimeras.json` → `nodes` lists adventure fights: `background` (`battle-bg/temple`, …), `music` (`music/pve_1`, `music/boss`), and `tags` (`normal` / `elite` / `final_boss`). Textures for those BGs are under `PvE/Backgrounds/4-entrance`, `5-crossroad`, `6-river`, `7-deep-forest`, `8-temple`, `9-rocky-mountain-1`, `10-rocky-mountain-2`.
