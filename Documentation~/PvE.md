# PvE kit

Origins adventure is a card-battler PvE mode. Enemies are **Chimeras** (dedicated Spine 3.8 bodies). They play the **same battle VFX** and many of the **same animation names** as mixer Axies.

This folder is everything a builder needs to ship an Origins-style PvE fight without the live client.

## What’s in the kit

| Path | What |
| --- | --- |
| `Assets/OriginsKit/PvE/Chimeras/<slug>/` | 22 enemy Spine bodies (`.skel` or `.json` + `.atlas` + `.png`) |
| `Assets/OriginsKit/PvE/Starters/<id>/` | 19 official starter Axies × 2 body stages (38 Spine sets) |
| `Assets/OriginsKit/PvE/Avatars/portraits/` | 22 chimera portraits |
| `Assets/OriginsKit/PvE/Cards/Chimeras/` | 75 chimera card arts (per body / level) |
| `Assets/OriginsKit/PvE/Cards/Tools/` | 91 tool / chimera ability card arts |
| `Assets/OriginsKit/PvE/Intents/` | 15 enemy-intent icons + melee/ranged markers |
| `Assets/OriginsKit/PvE/Backgrounds/story/` | 7 adventure arenas, layered |
| `Assets/OriginsKit/PvE/Backgrounds/events/` | 13 seasonal / ranked arenas |
| `Assets/OriginsKit/PvE/Backgrounds/class/` | Class and mode backdrop paintings |
| `Assets/OriginsKit/PvE/Music/` | 15 loops (`pve_1`–`3`, `boss`, seasonal, PvP, home) |
| `Assets/OriginsKit/PvE/UI/` | Chapter map, lobby, HP bars, in-battle HUD, node icons, riddle cards |
| `Assets/OriginsKit/PvE/Story/` | Tutorial story portraits (Xia / Bing) |
| `Catalogs/pve-chimeras.json` | 73 chimera rows, 35 nodes, 41 teams, spawn points |
| `Catalogs/pve-cards.json` | 38 chimera abilities + 50 other tool cards, with VFX ids |
| `Catalogs/pve-intents.json` | Intent → icon map |
| `Catalogs/pve-starters.json` | Starter Axie genes / names / extracted spines |

`machito` and `shilin` ship as extra chimera bodies (live Addressable catalog) even though they are not in the current 73 `ChimeraInfos` rows.

## Characters

### Chimeras (enemies)

22 unique skeletons. Game data reuses them across 73 rows at different levels:

`alpha-wolf` `aqua-alpha-wolf` `aqua-slime-atk` `aqua-slime-boss` `aqua-slime-def` `aqua-slime-sup` `aqua-wolf` `daddy-bear` `dryad-fighter` `dryad-mage` `dryad-ranger` `flowering-treant` `forest-slime-fighter` `forest-slime-flower` `gray-wolf` `machito` `mommy-bear` `shilin` `slime` `treant` `treant-fighter` `werewolf`

Most folders are binary Spine 3.8 (`.skel`). `machito` and `shilin` are JSON skeletons (same 3.8.79 runtime).

```csharp
// After spine-unity imports .skel / .atlas / .png
skeleton.AnimationState.SetAnimation(0, "action/idle/normal", true);
skeleton.AnimationState.SetAnimation(0, "attack/melee/normal-attack", false);
```

Origins validates these clips on every chimera:

- `action/idle/normal`
- `defense/hit-by-normal`
- `action/move-forward`
- `action/move-back`

Most also have `attack/melee/normal-attack`, a ranged cast, `battle/get-buff` / `get-debuff`, and a death clip. Slimes add `attack/ranged/laser-beam`, `goo-split`, `throw-slime`. Full per-body lists live in `extractedSkeletons[].unityClips` (harvested from the skeleton; the `.skel` / `.json` is authoritative).

Scale and HP-bar offsets are on each `ChimeraInfos` row (`scale`, `hpBarOffset`).

### Starter Axies (playable PvE roster)

These are **fixed official Spine bodies**, not mixer NFT Axies. Origins uses them in tutorial / story / the starter roster.

| Folder | Name | Folder | Name |
| --- | --- | --- | --- |
| `1` | Buba | `16` | Ena |
| `2` | Olek | `17` | Pomodoro |
| `3` | Puffy | `18` | Machito |
| `5` | Tripp | `19` | Hope |
| `7` | Venoki | `20` | Bard |
| `11` | Shillin | `21` | Xia |
| `12` | Momo | `22` | Bing |
| `14` | Temujin | `23` | Noir |
| `15` | Shufen | `24` | Rouge |
| | | `25` | Mit |

`<id>-1` is body stage 1 (awakened). Same mixer clip names as other Axies. Genes and part ids are in `pve-starters.json`. Custom NFT Axies still come from `@axieinfinity/mixer` / `unity-axie-gtk2d`.

## VFX and effects

Chimeras do **not** have a second particle pack. Their cards map through `skill-vfx.json`:

| Ability | VFX prefab | Typical mixer clip |
| --- | --- | --- |
| `tool-chimerabite-02` | `beast_bite` | melee bite |
| `tool-chimerachomp-02` | `aquatic_gore` | melee gore |
| `tool-chimerathornyattack-02` | `plant_smash` | melee smash |
| `tool-chimeraalienbeam-02` | `mech_cast` | ranged cast |
| `tool-chimerasplash-02` | `aquatic_cast` | ranged cast |

Spawn `Prefabs/Skills/{vfxId}` with `SkillPlayer` exactly as for Axies (scale 54, `OnAttack` / `OnHit`).

Shield / heal / secret chimera cards have **no** skill VFX id. Play `Prefabs/Buffs/shield`, `heal`, `sleep`, … instead.

Passive icons (`status/chimera_passive_*`) are already in `Textures/StatusIcons/`.

## Cards

`pve-cards.json`:

- `chimeraAbilities` — 38 enemy cards (`ChimeraBite`, `ChimeraAlienBeam`, `PveRiddle`, …)
- `otherToolCards` — 50 extra tools Origins also uses in PvE / tutorial (LumberShield, Goo, ForestWrath, …)
- `art.tools` / `art.chimeraCards` — PNG filenames

Card art lives next to the catalog:

```
PvE/Cards/Tools/tool-chimerabite-02-00.png
PvE/Cards/Chimeras/werewolf-01-00.png
```

NPC card suffixes are `<slug>-<variant>-00.png` (usually 01–04 per body).

## Intents

Origins shows the next enemy action on the HP bar (`intent/{id}.png`). Icons are in `PvE/Intents/`.

`WeakAttack` `ModerateAttack` `StrongAttack` `WeakDefend` `ModerateDefend` `StrongDefend` `AttackAndDefend` `AttackAndBuff` `AttackAndDebuff` `DefendAndBuff` `DefendAndDebuff` `Buff` `Debuff` `DangerousAction` `SecretAction`

`AttackMelee` / `AttackRanged` are extra HUD markers from the same atlas.

## Backgrounds

Adventure nodes address `battle-bg/entrance`, `battle-bg/temple`, … Those names are **layout prefabs**. The painted layers live in the numbered folders:

| Node address | Layers |
| --- | --- |
| `battle-bg/entrance` | `PvE/Backgrounds/story/4-entrance` |
| `battle-bg/crossroad` | `PvE/Backgrounds/story/5-crossroad` |
| `battle-bg/river` | `PvE/Backgrounds/story/6-river` |
| `battle-bg/deep-forest` | `PvE/Backgrounds/story/7-deep-forest` |
| `battle-bg/temple` | `PvE/Backgrounds/story/8-temple` |
| `battle-bg/rocky-mountain-1` | `PvE/Backgrounds/story/9-rocky-mountain-1` |
| `battle-bg/rocky-mountain-2` | `PvE/Backgrounds/story/10-rocky-mountain-2` |

Stack the PNGs in folder order (BG behind, FRONT / FOG / CLOUD on top). Event arenas under `Backgrounds/events/` are already split into `*_bg` / `*_fg` (or `layers/` when the source was a sprite atlas).

`pve-chimeras.json` → `spawnPoints` lists `SP1`–`SP6` local positions for each named arena (left / right teams).

## Music

| File | Used by |
| --- | --- |
| `pve_1.wav` `pve_2.wav` `pve_3.wav` | Adventure nodes |
| `boss.wav` | Final / elite nodes (`music/boss`) |
| `pvp.wav` | Ranked / blitz default |
| `halloween.wav` `halloween_2023.wav` `halloween_battle_2023.wav` | Halloween seasons |
| `lunar_battle.wav` `lunar_bloodmoon.wav` `lunar_menu.wav` | Lunar seasons |
| `xmas_battle.wav` `xmas_menu.wav` | Winter seasons |
| `summer23.wav` | Summer season |
| `home.wav` | Home / lobby |

Node → track is `nodes[].music` (`music/pve_1`, `music/boss`, …).

## UI

Reusable 2D chrome (no client scripts):

- `UI/Chapter/` — chapter maps, elite/boss/normal stage icons, riddle cards, Dryad Mage
- `UI/Lobby/` — PvE lobby portraits by Axie / chimera level
- `UI/Frames/` — wood frames, loading, stars
- `UI/InBattle/` — energy, discard, enemy deck, name plates
- `UI/HpBar/` + `HpBar2/` — fighter bars
- `UI/Nodes/` — win / lose / draw / current node markers
- `UI/Icons/icon_ticket_pve.png`

## Minimal PvE loop

```
1. Pick a node from pve-chimeras.json → background + music + team id
2. Resolve team.members ("Treant_lv_1,Treant_lv_1") against ChimeraInfos
3. Load PvE/Chimeras/<slug> Spine, play action/idle/normal
4. Show portrait PvE/Avatars/portraits/<slug>.png
5. For each chimera card:
     map = pve-cards.json / skill-vfx.json
     SkillPlayer.Spawn(Prefabs/Skills/{vfxId})
     OnAttack → play chimera clip (attack/melee/normal-attack, …)
     OnHit    → play defender hit + {vfxId}_hit SFX
6. Draw intent icon from PvE/Intents/{intentId}.png on the HP bar
```

Same `SkillPlayer` / scale 54 / clip events as Axie vs Axie. See [Activation](Activation.md).

## What is still not here

- Per-level **deck lists** (which cards each `Treant_lv_2` draws) live on the battle server, not in client game data.
- Adventure map **prefabs** (full chapter scene) depend on client UI scripts; only the art was copied.
- Mixer NFT Axie bodies — use the official mixer.
