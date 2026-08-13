# Changelog

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
