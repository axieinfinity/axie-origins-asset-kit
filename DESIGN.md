# Design

<!-- impeccable:design-system 1 -->

The Origins Unity Kit catalog is an in-battle field, not a docs dashboard.

## Surfaces

- `showcase/` — local Experience catalog of every kit asset.

## Visitor mode

Experience. The playing piece leads. Chrome is game HUD.

## Palette

| Token | Value | Role |
| --- | --- | --- |
| Cream | `#FDE5D2` | Primary type (ColorCodeConstants.DefaultTextCode) |
| Cream dim | `#E8C9A8` | Secondary type, tinted from cream |
| Ink | `#2A1810` | Page ground, walnut |
| Wood | `#8B4A2A` | HUD rails |
| Gold | `#FFC700` | Energy / live accent |
| Ally | `#31BCEC` | ColorConstants.AvatarFrameAlly |
| Enemy | `#FF6572` | ColorConstants.AvatarFrameEnemy |
| Beast | `#F39230` | Class pigment |
| Aquatic | `#1E8BC2` | Class pigment |
| Plant | `#459A10` | Class pigment |
| Bird | `#E9567B` | Class pigment |
| Bug | `#CF2D37` | Class pigment |
| Reptile | `#7442B3` | Class pigment |
| Mech | `#8A7AB5` | Class pigment |
| Dawn | `#BECEFF` | Class pigment |
| Dusk | `#236F71` | Class pigment |

## Type

- Display: **Changa One** — stand-in for Origins `ChangeOneRegular`.
- Body: **Noto Sans** 400/600/700 — same family as Origins TMP NotoSans SDF.

## Materials

Painted class arenas (`PvE/Backgrounds/class/bg-*.jpg`) are the stage plate. Wooden HUD (`InBattle/top_part`, `name_panel`, `bottom_part`) is the chrome. Energy jar sits on the field. Locker tiles use `Frames/frame_border`. Class filters use PvE riddle cards.

Skill/buff video is keyed off near-black and drawn on the arena so the take reads as a fighter, not a floating mp4.

## Components

- Battlefield stage (arena + keyed VFX or portrait)
- Wood name plate (title, path, replay / loop / sound / copy)
- Procession of arena-backed thumbs
- Kind tabs and class riddle filters
- Locker grid in wooden frames

## Motion

One loop: the selected clip plays on the field. No scattered card entrances.
