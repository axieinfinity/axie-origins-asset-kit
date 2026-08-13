# Battle SFX

152 WAVs from Origins `battle-sfx`.

## Naming

| Pattern | Trigger |
| --- | --- |
| `{vfxId}_attack.wav` | `OnAttack` |
| `{vfxId}_fly.wav` | `OnThrow` |
| `{vfxId}_hit.wav` | `OnHit` |
| `{buffId}.wav` | buff `Play()` |

Examples: `beast_gore_attack.wav`, `plant_projectile_fly.wav`, `heal.wav`.

Index: `Catalogs/sfx.json`.

## Playback

```csharp
var clip = Resources.Load<AudioClip>("OriginsKit/Audio/beast_gore_attack");
AudioSource.PlayClipAtPoint(clip, attacker.position);
```

Origins uses a small `SoundFx` wrapper with a volume callback. Any `AudioSource` is enough for a jam game.
