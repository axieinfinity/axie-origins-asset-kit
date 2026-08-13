# Mixer animations Origins uses

Origins does not ship a second Axie skeleton. Fighters are mixed 2D Axies. Skills only **name** Spine clips. The official mixer already contains them.

## Battle usage

**Idle / move**

- `action/idle/normal`
- `action/run` `action/move-forward` `action/move-back`

**Melee**

- `attack/melee/normal-attack` (fallback)
- `attack/melee/horn-gore`
- `attack/melee/mouth-bite`
- `attack/melee/tail-smash` `tail-thrash` `tail-roll` `tail-multi-slap`
- `attack/melee/shrimp` `multi-attack`

**Ranged**

- `attack/ranged/cast-fly` (default)
- `attack/ranged/cast-high` `cast-low` `cast-tail` `cast-multi`

**Hit / status**

- `defense/hit-by-normal` `hit-by-normal-crit` `hit-by-normal-dramatic`
- `defense/hit-by-ranged-attack`
- `defense/hit-by-horn-attack` `hit-by-horn-attack-crit`
- `defense/hit-with-shield` `defense/evade`
- `battle/get-buff` `battle/get-debuff`

**Flavour**

- `activity/prepare` `appear` `entrance` `victory-pose-back-flip` `sleep`

Full list with notes: `Catalogs/mixer-animations.json`.

## Fallbacks

If the named clip is missing on that part set:

| Kind | Fallback |
| --- | --- |
| melee | `attack/melee/normal-attack` |
| ranged | `attack/ranged/cast-fly` |
| hit | `defense/hit-by-normal` |

## Mixer faces left

The 2D mixer skeleton faces **left** by default. Origins flips the home team with `scale.x = -1` so they face the enemy. Do the same or VFX `@scaleX` / `@flipX` will disagree with the body.
