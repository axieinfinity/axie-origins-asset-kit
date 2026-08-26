# Additive overlay runtime

Browser playback of Origins skill and buff plates: Vite + PixiJS 7.2.4 mixer Axies + a DOM canvas overlay with additive blending. Unity prefabs remain the source of truth; these atlases are the web drop-in.

See `web-vfx/README.md`.

| Unity | Web |
| --- | --- |
| `Assets/OriginsKit/Prefabs/Skills/<id>.prefab` | `web-vfx/public/vfx/<id>/atlas.png` |
| `Assets/OriginsKit/Prefabs/Buffs/<id>.prefab` | same |
| Animator clip events | `web-vfx/public/vfx/<id>/clip.json` |

Rebuild from recorded PNG sequences:

```bash
python3 web-vfx/scripts/process_all.py --jobs 16
```
