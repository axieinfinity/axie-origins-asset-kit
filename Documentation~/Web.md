# Web VFX

Jack-stack playback of Origins skill and buff plates. Unity prefabs remain the source of truth; these atlases are the browser drop-in.

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
