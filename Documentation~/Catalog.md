# VFX catalog

63 **skill** ids are shared by 188 card abilities. 42 **buff** ids cover statuses.

Source of truth: `Assets/OriginsKit/Catalogs/`.

PvE extras (same folder):

| File | Contents |
| --- | --- |
| `pve-chimeras.json` | 73 chimera rows, 35 nodes, 41 teams, extracted spines, arenas, spawn points |
| `pve-cards.json` | 38 chimera abilities + 50 other tool cards, VFX ids, art filenames |
| `pve-intents.json` | Enemy intent → `PvE/Intents/{id}.png` |
| `pve-starters.json` | Official starter Axie roster and extracted Spine folders |

See [PvE](PvE.md).

## Skill families

Each class has the same seven verbs:

`bite` · `cast` · `gore` · `projectile` · `slash` · `smash` · `throw`

Classes: `aquatic` `beast` `bird` `bug` `dawn` `dusk` `mech` `plant` `reptile`

Example: `plant_projectile`, `beast_gore`, `dusk_slash`.

| Verb | Typical mixer attack | Typical use |
| --- | --- | --- |
| bite | `attack/melee/mouth-bite` | Mouth melee |
| gore | `attack/melee/horn-gore` | Horn melee |
| slash / smash | `attack/melee/tail-smash` or `horn-gore` | Tail / heavy melee |
| projectile / throw / cast | `attack/ranged/cast-fly` | Ranged; has `OnThrow` |

Exact mapping is per ability in `skill-vfx.json` (some cards reuse another class’s VFX).

## Buff ids

`bleed_apply` `bubble` `bubble_bomb` `buff_apply` `cleanse` `cleanser` `cure` `death_mark_apply` `debuff_apply` `disarmed` `dispel` `dmg_boost` `doubt` `drain` `fear` `feather` `fragile` `fury_form` `fury_on_transfrom` `heal` `heal_block` `healing_boost` `hex` `leaf` `poison_apply` `power_awaken` `power_gain` `rage` `reflect_damage` `secret_apply` `shield` `shield_boost` `shield_break` `silence` `sleep` `stealth` `stunned` `summon_on_cast` `summon_on_death` `taunt` `vulnerable` `weak`

`fury_on_transfrom` keeps Origins’ spelling.

## Looking up a card

```json
{
  "abilityId": "beast-horn-02",
  "cardNames": ["Impale", "Impale+"],
  "vfxId": "beast_gore",
  "attackAnimation": "attack/melee/horn-gore",
  "hitAnimation": "defense/hit-by-normal",
  "isRanged": false,
  "duration": 0.92
}
```

`activation.json` then tells you when each child turns on and when `OnAttack` / `OnHit` fire.

## Templates (not shipped as gameplay)

Origins also has `Melee.prefab` and `Ranged.prefab` authoring templates. They are not in `Prefabs/` because they are empty scaffolds, not battle effects.
