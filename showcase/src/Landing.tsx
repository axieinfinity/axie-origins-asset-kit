import type { ItemKind, LibraryItem } from './catalog'
import { AssetPreview } from './components/AssetPreview'

export const COLLECTIONS: { kind: ItemKind; title: string; line: string }[] = [
  { kind: 'skill', title: 'Skills', line: 'Class attacks as they play' },
  { kind: 'buff', title: 'Buffs', line: 'Shields, hexes, heals, bombs' },
  { kind: 'chimera', title: 'Chimeras', line: 'Enemy bodies you can play' },
  { kind: 'starter', title: 'Starters', line: 'The official roster Axies' },
  { kind: 'card', title: 'Cards', line: 'Chimera and tool art' },
  { kind: 'arena', title: 'Arenas', line: 'Story and seasonal stages' },
  { kind: 'music', title: 'Music', line: 'Adventure, boss, and season' },
  { kind: 'summoner', title: 'Summoners', line: 'The eight commanders' },
]

type Props = {
  items: LibraryItem[]
  onOpen: (kind: ItemKind) => void
}

export function Landing({ items, onOpen }: Props) {
  const hero =
    items.find((item) => item.id === 'skill:beast_smash') ||
    items.find((item) => item.id === 'skill:aquatic_slash') ||
    items.find((item) => item.kind === 'skill')
  const pick = (kind: ItemKind) => items.find((item) => item.kind === kind)

  return (
    <div className="home">
      <section className="hero">
        <div className="hero-media">
          {hero ? <AssetPreview mode="player" item={hero} loop /> : null}
        </div>
        <div className="hero-copy">
          <h1>Origins</h1>
          <p>Battle art from Axie Infinity: Origins. Play it here.</p>
          <div className="hero-actions">
            <span className="chip-beast" data-class="beast">
              beast
            </span>
            <button type="button" className="hero-go" onClick={() => onOpen('skill')}>
              Browse skills
            </button>
          </div>
        </div>
      </section>

      <section className="collections" aria-label="Collections">
        {COLLECTIONS.map((entry) => {
          const sample = pick(entry.kind)
          const count = items.filter((item) => item.kind === entry.kind).length
          return (
            <button key={entry.kind} type="button" className="collection" onClick={() => onOpen(entry.kind)}>
              <div className="collection-media">
                {sample ? <AssetPreview className="collection-preview" mode="mini" item={sample} loop /> : null}
              </div>
              <span className="collection-title">{entry.title}</span>
              <span className="collection-line">{entry.line}</span>
              <span className="collection-count">{count}</span>
            </button>
          )
        })}
      </section>
    </div>
  )
}
