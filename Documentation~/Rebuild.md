# Rebuild (maintainers)

Sources:

- `origin-client` (public GitHub) — mixer names, SkillEffect playback, helper textures
- Origins Addressables `StandaloneOSX` — `battle-vfx`, `battle-sfx`, `morph-vfx`, `status`, summoners
- Remote `game1.data` — `SkillVfxInfos`, cards, statuses

Workspace scripts (not in this repo):

```
_extract/export_vfx_graphs.py
_extract/export_activation.py
_extract/rebuild_vfx_clips.py
_extract/build_pack.py
origins-vfx-baker  →  OriginsVfxPreview.SetupScene
```

Clips **must** be rebuilt with `rebuild_vfx_clips.py`. `AssetDatabase.CreateAsset` on a bundle clip drops StreamedClip `m_IsActive` data and the prefab will look empty.
