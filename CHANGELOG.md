# Changelog

## 1.9.2 — 2026-08-26

- Move the kit to the Axie Infinity GitHub org as [`axieinfinity/axie-origins-asset-kit`](https://github.com/axieinfinity/axie-origins-asset-kit).
- GitHub description and docs cover both Unity prefabs and the additive overlay runtime.

## 1.9.1 — 2026-08-26

- Rename the GitHub repo to `axie-origins-kit` (not Unity-only).
- Call the browser path **additive overlay runtime** (Vite + PixiJS 7.2.4 mixer + DOM canvas overlay).

## 1.9.0 — 2026-08-26

- Additive overlay runtime (Vite + PixiJS 7.2.4 + mixer 1.4.9 + DOM canvas overlay).
- Additive atlases for all 63 skills, 42 buffs, and two extra Unity captures (`beast_smash 1`, `shield_break-origin`) — 107 clips under `web-vfx/public/vfx/`.
- `web-vfx` player lists every clip, plays Origins `OnAttack` / `OnHit` events on mixer Axies, and keeps the overlay sized for mobile.

## 1.8.1 — 2026-08-18

- Production `/kit` staging now copies Spine atlas PNG pages, so chimera and starter bodies can play.
- Machito and Shillin stay under Starters only. They are not listed as chimeras.

## 1.8.0 — 2026-08-16

- Impeccable initiated in-repo (hook, live config, doctor). Gallery world is Class System: paper, ink, class color only.

## 1.7.0 — 2026-08-16

- Showcase is a public gallery: landing page, top nav with the Axie mark, no Unity paths or snippets on the surface.
- Chimeras and starters still expose Spine animations under the preview.

## 1.6.3 — 2026-08-16

- Chimeras and starters show their Spine animations under the preview. Group chips, then clip names. `[` / `]` cycles them. Tiles with more than one clip say how many.

## 1.6.2 — 2026-08-16

- Finder is three columns: kind rail, pinned inspect, scrolling grid. The player stays on screen while you browse.
- Skill/buff player no longer stacks a still poster over the video.
- Starter, chimera, and summoner tiles play the Spine body. Atlas sheets and avatar portraits are not used as thumbs.
- Inspect says skill/buff clips are preview videos; the Unity prefab is the file to use.
- Empty takes (`plant_throw`, `taunt`, `vulnerable`) no longer play a black MP4. Buffs show the status icon; plant throw says the prefab is in the kit.
- Recaptured bubble, cleanser, cure, dispel, and fragile so the catalog is not an atlas card.

## 1.6.1 — 2026-08-16

- Reverted the Origins-battlefield chrome.
- Catalog is a finder: grouped kind rail, 16:9 preview well, facts + copy path, scannable grid.
- Skills and buffs still use recorded videos; characters use portraits in the grid.

## 1.5.0 — 2026-08-16

- Local Unity player (`VfxLocalPlayer`) plays every skill/buff the same way battle does: holder 1/54, instance 54, clip override, OnThrow projectile.
- Catalog skill/buff previews are videos recorded from that player (960×540, 30 fps), not flipbook sheets.
- Menu: Origins → Setup Local Player / Play Local Player / Record Kit Videos.

## 1.4.1 — 2026-08-16

- Showcase: skill/buff previews recaptured from live Unity particles (not texture-atlas dumps).
- Showcase: starter thumbnails use character portraits instead of Spine atlas sheets.
- Empty looping buffs fall back to their status icons.

## 1.4.0 — 2026-08-16

- Local showcase at `showcase/` (`npm run dev` → http://127.0.0.1:5177/).
- Pinned live stage plus a catalog of every kit category (830 entries).
- Flipbook previews for skills/buffs; Spine for chimeras, starters, summoners, battle UI; stills for cards, arenas, icons; audio for music/SFX.
- Integration snippet, Unity path, and “What you can build” on the same page.

## 1.3.0 — 2026-08-13

- Full PvE pack: 22 chimera bodies, 38 starter-Axie spines, 73 chimera rows, 41 teams, 35 nodes.
- Chimera portraits, 75 NPC card arts, 91 tool-card arts, 17 intent icons, chapter / lobby / HP-bar UI.
- 7 story arenas + 13 event arenas (Halloween, Lunar, Xmas, Ragnarok, Summer, Valentine, …).
- 15 music loops (adventure, boss, seasonal, PvP, home).
- Catalogs: `pve-chimeras.json`, `pve-cards.json`, `pve-intents.json`, `pve-starters.json`.
- Chimera cards still play the existing `Prefabs/Skills/` VFX (`tool-chimerabite-02` → `beast_bite`, …).

## 1.2.0 — 2026-08-13

- PvE: 22 chimera Spine skeletons (atlas + png + skel) and 73 catalog rows.
- PvE node backgrounds (7 story arenas) and music (`pve_1`–`3`, `boss`).
- Chimera portrait atlas. See `Documentation~/PvE.md`.

## 1.1.0 — 2026-08-13

- Skill/buff materials now use Origins URP Shader Graphs (`Sd_Origin2_ADD` / `Sd_Origin2_ADP`), not Built-in Additive.
- Kit project is URP 12.1.15.
- Morph prefabs: `morph_aura_burst`, `morph_aura_loop_battle`, `morph_card`, `MetamorphDrawerRT`.
- Extra prefabs (banish, energy orbs, card FX, weather) copied with first-party materials; host scripts stubbed; ETFX materials excluded.

## 1.0.0 — 2026-08-13

- First Vibeathon kit.
- 63 skill VFX + 42 buff VFX as Unity prefabs and rebuilt editor clips.
- Per-effect activation catalog (clip events + `m_IsActive` tracks).
- 90 battle VFX textures, 152 SFX, 131 status icons, 8 summoner spines, battle UI Spine, morph textures, mixer animation list.
- `SkillPlayer` / `BuffPlayer` matching Origins scale 54 and event names.
- Card → VFX → mixer animation map (188 abilities).
