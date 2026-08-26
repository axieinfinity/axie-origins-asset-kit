import { AdditiveAtlas } from './aquaticSlash'
import { Battlefield, type LayerMode } from './battlefield'
import { loadCatalog, loadClip, type CatalogItem } from './clip'

const host = document.querySelector<HTMLElement>('#pixi-host')
const overlay = document.querySelector<HTMLCanvasElement>('#vfx-dom')
const cssImg = document.querySelector<HTMLImageElement>('#vfx-css')
const hud = document.querySelector<HTMLElement>('#hud')
const playBtn = document.querySelector<HTMLButtonElement>('#play')
const layerSel = document.querySelector<HTMLSelectElement>('#layer')
const loopBox = document.querySelector<HTMLInputElement>('#loop')
const search = document.querySelector<HTMLInputElement>('#search')
const kindSel = document.querySelector<HTMLSelectElement>('#kind')
const list = document.querySelector<HTMLElement>('#list')

if (!host || !overlay || !cssImg || !hud || !playBtn || !layerSel || !loopBox || !search || !kindSel || !list) {
  throw new Error('Missing page mounts')
}

const hudEl = hud
const searchEl = search
const kindEl = kindSel
const listEl = list

const field = new Battlefield(host, overlay, cssImg)
field.onHud = (html) => {
  hudEl.innerHTML = html
}

let items: CatalogItem[] = []
let current = 'aquatic_slash'
const cache = new Map<string, AdditiveAtlas>()

function renderList() {
  const q = searchEl.value.trim().toLowerCase()
  const kind = kindEl.value
  const shown = items.filter((item) => {
    if (kind !== 'all' && item.kind !== kind) return false
    if (q && !item.id.toLowerCase().includes(q)) return false
    return true
  })
  listEl.innerHTML = shown
    .map(
      (item) =>
        `<button type="button" class="clip${item.id === current ? ' is-on' : ''}" data-id="${item.id}">${item.id}<span>${item.kind}</span></button>`,
    )
    .join('')
}

async function playId(id: string) {
  current = id
  renderList()
  hudEl.innerHTML = `<p>Loading <strong>${id}</strong>…</p>`
  let atlas = cache.get(id)
  if (!atlas) {
    const clip = await loadClip(id)
    atlas = await AdditiveAtlas.load(clip)
    cache.set(id, atlas)
  }
  await field.setClip(atlas)
}

try {
  const catalog = await loadCatalog()
  items = catalog.items
  hudEl.innerHTML = `<p>${catalog.skills} skills · ${catalog.buffs} buffs · ${catalog.count} web clips</p>`
  renderList()
  await field.boot()
  const start = items.find((i) => i.id === 'aquatic_slash') || items[0]
  if (start) await playId(start.id)
} catch (err) {
  hudEl.innerHTML = `<p>Could not boot. ${err instanceof Error ? err.message : String(err)}</p>`
}

playBtn.addEventListener('click', () => field.play())
layerSel.addEventListener('change', () => {
  field.layer = layerSel.value as LayerMode
  field.play()
})
loopBox.addEventListener('change', () => {
  field.loop = loopBox.checked
})
searchEl.addEventListener('input', renderList)
kindEl.addEventListener('change', renderList)
listEl.addEventListener('click', (event) => {
  const btn = (event.target as HTMLElement).closest<HTMLButtonElement>('button[data-id]')
  if (btn?.dataset.id) void playId(btn.dataset.id)
})
