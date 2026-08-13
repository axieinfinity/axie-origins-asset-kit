# Packaging research (Vibeathon)

Verified findings used to choose this kit’s shape. Full claim list was produced by the session deep-research run (status: Partial — see uncertainties below).

## Decision

| Payload | Use for Vibeathon? |
| --- | --- |
| Regular YAML prefabs + rebuilt `.anim` + PNG + WAV in an `Assets/` tree | **Yes — this repo** |
| Editor-exported `.unitypackage` of `Assets/OriginsKit` | Yes, for Slack/Drive one-shots (do not commit; too large for GitHub) |
| StandaloneOSX `battle-vfx.bundle` as the player asset | **No** — platform-locked, not an import format |
| Flipbook PNG baker | **No** — not native ParticleSystems |
| UPM Git URL | **No** — Unity reserves that for versioned *code* |

## Why

- Production SkillEffect / BuffEffect prefabs are **not** in public `origin-client`. They live in Addressable `battle-vfx/{id}` (Unity 2021.3.42f1 UnityFS).
- `AssetBundle.LoadFromFile` of the OSX bundle fails on WebGL/Windows. Jam teams need Project-window assets.
- `CreateAsset` on a bundle clip drops StreamedClip `m_IsActive` curves. Clips in this kit were rebuilt from that data.
- Origins client is URP; this kit remaps materials to Built-in Legacy Particles so Personal / Built-in starters work.
- Epic Toon FX stays out.

## Playback contract (document + `SkillPlayer`)

`AnimatorOverrideController["skill"] = clip` → `SetTrigger("skill")`.

Events: `OnStartLoop`, `OnAttack(string)`, `OnThrow(float)`, `OnHit(string)`, `OnEndLoop`, `OnBack`.

Markers: `@defender`, `@projectile`, `@flipX` / `@scaleX` (and Y/Z). Scale **54** on the attacker.

## Uncertainties the research did not close

- Windows/Linux Editor was not used to *load* the OSX bundle (we extracted on macOS 2021.3.45f2). Recipients never need the bundle.
- Remapped materials keep the first sampled texture; extra URP texture slots may differ from live Origins.
- spine-unity 3.8’s published Unity range ends at 2020.3; 2021.3 usually still imports the data files.
- A few production textures share names with ETFX; they came from the live Sky Mavis bundle, not the Asset Store folder.
