# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Vibeathon builders who cloned the private Origins Unity kit and need to see every reusable asset before they wire it into a 2D Axie game. They are at a desk, comparing clips, copying IDs and Unity paths, and checking how a skill, chimera, card, or arena will feel.

## Product Purpose

A local page inside `axie-origins-unity-kit` that showcases everything the repo ships and explains what you can build with it. Success is: every kit category is findable, selecting an item plays it on a pinned live stage, and the same panel shows exact IDs, Unity paths, and how Origins activates it.

## Positioning

Not a fighting game and not a folder dump. It is the live catalog of the Unity kit: first-party Origins battle VFX, mixer names, PvE chimeras, starter Axies, cards, intents, arenas, music, SFX, and HUD art, demonstrated in the browser with the same IDs a builder will call in Unity.

## Operating Context

Served locally from `showcase/` inside the kit clone. Kit binaries stay at `Assets/OriginsKit/`. Browser VFX playback uses videos recorded from the local Unity player (same SkillPlayer path as battle). Spine 3.8 bodies (chimeras, starters, summoners, battle UI) play from the kit files. This is an organizer Vibeathon resource; it is not a public OSS dump.

## Capabilities and Constraints

- Catalog covers the whole kit: 63 skill VFX, 42 buffs, 188 ability maps, 105 activation timelines, 90 VFX textures, 152 SFX, 131 status icons, 8 summoners, 4 battle-UI spines, 22 chimeras, 38 starter spines, 20 arenas, 15 music loops, chimera/tool card art, intents, PvE UI, morph textures.
- Sample stage stays pinned. Selecting a library item plays that item there (Unity-recorded video, Spine, still, or audio).
- Gallery cards show a real preview of the same asset.
- Skill/buff videos are catalog previews. Unity prefabs + `SkillPlayer` are the source of truth.
- NFT Axie bodies are not in the kit; mixer animation *names* are.
- Do not ship Epic Toon FX, client secrets, or Addressable OSX bundles.
- Confirmed this turn: lives in the kit repo; playback is a full live stage (VFX, Spine, music, SFX) plus integration instructions.

## Brand Commitments

This surface is a catalog, not a mock battle screen and not an App.Axie marketing shell. Visual chrome stays quiet so the asset, the Unity path, and the copy action stay first. Do not dress the page as Origins HUD.

## Evidence on Hand

- `Assets/OriginsKit/` native Unity tree
- `Assets/OriginsKit/Catalogs/*.json` (skill-vfx, activation, pve-*, statuses, sfx, mixer-animations)
- Flipbook previews extracted earlier into `origins-battle-mixer-pack/vfx/flipbooks/` (copied into showcase for browser play)
- Spine triples under `PvE/Chimeras`, `PvE/Starters`, `Summoners`, `BattleUI`
- `Documentation~/` integration, activation, PvE, catalog

Do not invent license grants, public CDN URLs, or per-level chimera deck lists (those are server-side).

## Product Principles

1. The asset is the product — chrome exists to find, play, and copy it.
2. What you see in the gallery is what the stage plays.
3. Names, ability IDs, and Unity paths stay copyable and exact.
4. Chrome exists to find, play, and copy — not to look like the game.
5. Be honest about Unity vs browser: videos here, prefabs in the Editor.

## Accessibility & Inclusion

Keyboard selection of gallery cards and a visible focus ring are required so the catalog is operable without a pointer. `/` focuses search, `j`/`k` move the selection, `c` copies the Unity path.
