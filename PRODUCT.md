# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Anyone opening the kit gallery — Vibeathon builders first, plus anyone who wants to see Origins battle art. They are browsing, not wiring Unity yet.

## Product Purpose

A local public gallery of everything the kit ships. Success is: land on a real home, pick a collection from the nav, play the asset, keep browsing. No Unity jargon on the surface.

## Positioning

An Origins gallery, not a DAM and not a battlefield HUD. First-party skills, buffs, chimeras, starters, cards, arenas, and music — shown as they look, named as they play.

## Operating Context

Served locally from `showcase/` inside the kit clone. Kit binaries stay at `Assets/OriginsKit/`. Browser VFX playback uses videos recorded from the local Unity player (same SkillPlayer path as battle). Spine 3.8 bodies (chimeras, starters, summoners, battle UI) play from the kit files. This is an organizer Vibeathon resource; it is not a public OSS dump.

## Capabilities and Constraints

- Catalog covers the whole kit: 63 skill VFX, 42 buffs, 188 ability maps, 105 activation timelines, 90 VFX textures, 152 SFX, 131 status icons, 8 summoners, 4 battle-UI spines, 20 chimeras, 38 starter spines, 20 arenas, 15 music loops, chimera/tool card art, intents, PvE UI, morph textures.
- Sample stage stays pinned. Selecting a library item plays that item there (Unity-recorded video, Spine, still, or audio).
- Gallery cards show a real preview of the same asset.
- Skill/buff videos are catalog previews. Unity prefabs + `SkillPlayer` are the source of truth.
- NFT Axie bodies are not in the kit; mixer animation *names* are.
- Do not ship Epic Toon FX, client secrets, or Addressable OSX bundles.
- Confirmed this turn: lives in the kit repo; playback is a full live stage (VFX, Spine, music, SFX) plus integration instructions.

## Brand Commitments

Use the Axie Infinity mark. Do not dress the page as live Origins HUD. Do not put Unity paths, snippets, or engine notes on the gallery surface.

## Evidence on Hand

- `Assets/OriginsKit/` native Unity tree
- `Assets/OriginsKit/Catalogs/*.json` (skill-vfx, activation, pve-*, statuses, sfx, mixer-animations)
- Flipbook previews extracted earlier into `origins-battle-mixer-pack/vfx/flipbooks/` (copied into showcase for browser play)
- Spine triples under `PvE/Chimeras`, `PvE/Starters`, `Summoners`, `BattleUI`
- `Documentation~/` integration, activation, PvE, catalog

Do not invent license grants, public CDN URLs, or per-level chimera deck lists (those are server-side).

## Product Principles

1. The asset is the product — chrome exists to find and play it.
2. What you see in the gallery is what the stage plays.
3. Names stay human. Engine paths stay out of the gallery.
4. Chrome recedes. Do not look like the game HUD.
5. Prefabs remain the Unity source of truth; the gallery does not explain that unless asked.

## Accessibility & Inclusion

Keyboard selection of gallery cards and a visible focus ring are required so the catalog is operable without a pointer. `/` focuses search, `j`/`k` move the selection, `[` `]` change animations.
