# Changelog

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
