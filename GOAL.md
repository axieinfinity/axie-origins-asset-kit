# Goal

Ship **full Origins skill and buff VFX coverage** on both stacks in this repo: Unity prefabs (`Assets/OriginsKit`) and additive overlay atlases (`web-vfx/`).

Done when:

1. Every skill and buff in the Unity kit has a web additive atlas + `clip.json`.
2. `web-vfx` plays any of those clips on mixer Axies via a DOM overlay.
3. The GitHub repo documents both Unity and web paths.

---

Earlier gallery goal (still true of `showcase/`):

Turn `showcase/` into a **public Origins gallery**.

A visitor lands, sees the Axie mark, and can browse every skill, buff, chimera, starter, card, arena, and track without reading Unity paths, SkillPlayer notes, or code snippets. The page has a real landing, a top navigation bar, and a tight mobile layout. The artifacts lead. Chrome recedes.

Done when:

1. `/` is a landing page, not a skill inspect panel.
2. A persistent nav with the Axie Infinity icon reaches every collection.
3. Inspect copy is gallery language (name, class, play, animations) — no prefab paths, no C# snippet, no URP note.
4. Desktop and phone both browse without leftover side-rail dead space.
5. Typecheck passes and the home + a gallery route render on desktop and mobile.
