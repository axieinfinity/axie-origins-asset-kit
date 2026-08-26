#!/usr/bin/env python3
"""Batch-convert every Unity-recorded Origins skill/buff PNG sequence to additive web atlases."""

from __future__ import annotations

import argparse
import json
import math
import os
from concurrent.futures import ProcessPoolExecutor, as_completed
from pathlib import Path

import numpy as np
from PIL import Image

NAVY = np.array([19, 22, 27], dtype=np.int16)
ORTHO_SKILL = 6.1
ORTHO_BUFF = 5.2
CAM_SKILL = (0.0, -0.35)
CAM_BUFF = (0.0, 0.35)
HOLDER_SKILL = (4.4, -0.6)
HOLDER_BUFF = (0.0, 0.0)
PAD = 12
THRESH = 2
COLS = 8

ROOT = Path("/Users/jaatster/Work/Projects/axie-origins-unity-kit")
FRAMES = ROOT / "showcase/public/previews/video/frames"
DST = ROOT / "web-vfx/public/vfx"
CATALOGS = ROOT / "Assets/OriginsKit/Catalogs"
SKIP = {"Melee", "Ranged"}


def world_to_screen(wx: float, wy: float, width: int, height: int, ortho: float, cam: tuple[float, float]) -> tuple[float, float]:
    ppu = height / (2.0 * ortho)
    sx = (wx - cam[0]) * ppu + width / 2.0
    sy = height / 2.0 - (wy - cam[1]) * ppu
    return sx, sy


def find_defender(node: dict) -> dict | None:
    if node.get("name") == "@defender":
        return node.get("position")
    for child in node.get("children") or []:
        hit = find_defender(child)
        if hit:
            return hit
    return None


def load_catalogs() -> tuple[dict, dict]:
    clips = {row["id"]: row for row in json.loads((CATALOGS / "vfx-clips.json").read_text())["items"]}
    prefabs = {row["id"]: row for row in json.loads((CATALOGS / "vfx-prefabs.json").read_text())["items"]}
    return clips, prefabs


def extract_stack(paths: list[Path]) -> tuple[np.ndarray, tuple[int, int, int], np.ndarray]:
    first = np.asarray(Image.open(paths[0]).convert("RGBA"))
    h, w = first.shape[:2]
    corners = np.stack(
        [first[2, 2, :3], first[2, w - 3, :3], first[h - 3, 2, :3], first[h - 3, w - 3, :3]]
    ).astype(np.int16)
    bg = corners.mean(axis=0).astype(np.int16)
    if np.abs(bg - NAVY).max() <= 3:
        bg = NAVY
    stack = np.empty((len(paths), h, w, 4), dtype=np.uint8)
    masks = np.empty((len(paths), h, w), dtype=bool)
    for i, path in enumerate(paths):
        arr = np.asarray(Image.open(path).convert("RGBA"))
        rgb = arr[:, :, :3].astype(np.int16) - bg
        np.clip(rgb, 0, 255, out=rgb)
        mask = (rgb > THRESH).any(axis=2)
        out = np.zeros((h, w, 4), dtype=np.uint8)
        out[mask, :3] = rgb[mask].astype(np.uint8)
        out[mask, 3] = 255
        stack[i] = out
        masks[i] = mask
    return stack, (int(bg[0]), int(bg[1]), int(bg[2])), masks


def union_bbox(masks: np.ndarray) -> tuple[int, int, int, int]:
    any_mask = masks.any(axis=0)
    ys, xs = np.where(any_mask)
    if xs.size == 0:
        h, w = masks.shape[1:]
        return 0, 0, w - 1, h - 1
    x0 = max(0, int(xs.min()) - PAD)
    y0 = max(0, int(ys.min()) - PAD)
    x1 = min(masks.shape[2] - 1, int(xs.max()) + PAD)
    y1 = min(masks.shape[1] - 1, int(ys.max()) + PAD)
    return x0, y0, x1, y1


def centroid(mask: np.ndarray) -> tuple[float, float]:
    ys, xs = np.where(mask)
    if xs.size == 0:
        h, w = mask.shape
        return w / 2.0, h / 2.0
    return float(xs.mean()), float(ys.mean())


def pack_atlas(crops: np.ndarray) -> tuple[Image.Image, int, int]:
    n, fh, fw, _ = crops.shape
    cols = min(COLS, n)
    rows = math.ceil(n / cols)
    atlas = np.zeros((rows * fh, cols * fw, 4), dtype=np.uint8)
    for i in range(n):
        col = i % cols
        row = i // cols
        atlas[row * fh : (row + 1) * fh, col * fw : (col + 1) * fw] = crops[i]
    return Image.fromarray(atlas, "RGBA"), cols, rows


def last_lit_index(masks: np.ndarray) -> int:
    lit = masks.reshape(masks.shape[0], -1).any(axis=1)
    idx = np.where(lit)[0]
    return int(idx[-1]) if idx.size else 0


def process_one(args: tuple) -> dict:
    clip_id, src, dst_root, clip_row, prefab = args
    src = Path(src)
    dst = Path(dst_root) / clip_id
    paths = sorted(p for p in src.glob("*.png") if p.stem.isdigit())
    if not paths:
        return {"id": clip_id, "ok": False, "error": "no frames"}
    meta_in = {}
    meta_path = src / "meta.json"
    if meta_path.exists():
        meta_in = json.loads(meta_path.read_text())
    stack, bg, masks = extract_stack(paths)
    h, w = stack.shape[1:3]
    x0, y0, x1, y1 = union_bbox(masks)
    crops = stack[:, y0 : y1 + 1, x0 : x1 + 1, :]
    peak = int(masks.reshape(len(paths), -1).sum(axis=1).argmax())
    last = last_lit_index(masks)
    fps = float(meta_in.get("fps") or 30)
    duration = min(float(meta_in.get("duration") or (len(paths) / fps)), (last + 1) / fps)
    cx, cy = centroid(masks[peak])
    atlas, cols, rows = pack_atlas(crops)
    dst.mkdir(parents=True, exist_ok=True)
    atlas.save(dst / "atlas.png", optimize=True)
    events = []
    if prefab and prefab.get("events"):
        events = prefab["events"]
    elif clip_row and clip_row.get("events"):
        events = clip_row["events"]
    kind = (clip_row or {}).get("kind") or ("skill" if events else "buff")
    def_pos = find_defender((prefab or {}).get("tree") or {})
    has_def = bool(def_pos)
    ortho = ORTHO_SKILL if has_def else ORTHO_BUFF
    cam = CAM_SKILL if has_def else CAM_BUFF
    holder = HOLDER_SKILL if has_def else HOLDER_BUFF
    atk = world_to_screen(holder[0], holder[1], w, h, ortho, cam)
    if has_def:
        defn = world_to_screen(holder[0] + float(def_pos["x"]), holder[1] + float(def_pos["y"]), w, h, ortho, cam)
    else:
        defn = (cx, cy)
    attack = None
    hit = None
    is_ranged = False
    travel = None
    for ev in events:
        fn = ev.get("function")
        if fn == "OnAttack" and ev.get("string"):
            attack = ev["string"]
        if fn == "OnHit" and ev.get("string"):
            hit = ev["string"]
        if fn == "OnThrow":
            is_ranged = True
            travel = ev.get("float")
    anchor_src = defn if has_def else (cx, cy)
    maps_to = "defender" if has_def else "target"
    clip = {
        "id": clip_id,
        "kind": kind,
        "blend": "additive",
        "source": {
            "capture": "unity-SkillEffect",
            "fps": fps,
            "width": w,
            "height": h,
            "duration": duration,
            "frames": len(paths),
            "background": list(bg),
            "camera": {"orthographicSize": ortho, "position": [cam[0], cam[1], -20]},
            "holder": list(holder),
            "defenderLocal": [float(def_pos["x"]), float(def_pos["y"])] if has_def else None,
        },
        "crop": {"x": x0, "y": y0, "w": int(x1 - x0 + 1), "h": int(y1 - y0 + 1)},
        "atlas": {
            "file": "atlas.png",
            "cols": cols,
            "rows": rows,
            "frameW": int(x1 - x0 + 1),
            "frameH": int(y1 - y0 + 1),
        },
        "frames": len(paths),
        "fps": fps,
        "duration": duration,
        "clipDuration": float((prefab or {}).get("duration") or duration),
        "attackAnimation": attack or (clip_row or {}).get("attackAnimation"),
        "hitAnimation": hit or (clip_row or {}).get("hitAnimation"),
        "isRanged": bool(is_ranged or (clip_row or {}).get("isRanged")),
        "projectileTravel": travel or (clip_row or {}).get("projectileTravel"),
        "anchor": {
            "x": round(anchor_src[0] - x0, 3),
            "y": round(anchor_src[1] - y0, 3),
            "space": "crop",
            "mapsTo": maps_to,
        },
        "attackerInCrop": {"x": round(atk[0] - x0, 3), "y": round(atk[1] - y0, 3)},
        "captureAttacker": {"x": round(atk[0], 3), "y": round(atk[1], 3)},
        "captureDefender": {"x": round(defn[0], 3), "y": round(defn[1], 3)},
        "peakFrame": peak,
        "events": events,
        "systems": (prefab or {}).get("systems"),
    }
    (dst / "clip.json").write_text(json.dumps(clip, indent=2) + "\n")
    return {
        "id": clip_id,
        "ok": True,
        "kind": kind,
        "frames": len(paths),
        "duration": duration,
        "atlasBytes": (dst / "atlas.png").stat().st_size,
        "peakFrame": peak,
        "mapsTo": maps_to,
        "hasDefender": has_def,
    }


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--src", default=str(FRAMES))
    ap.add_argument("--dst", default=str(DST))
    ap.add_argument("--jobs", type=int, default=max(8, (os.cpu_count() or 8) - 2))
    ap.add_argument("--only", default="")
    args = ap.parse_args()
    src_root = Path(args.src)
    dst_root = Path(args.dst)
    clips, prefabs = load_catalogs()
    ids = sorted(p.name for p in src_root.iterdir() if p.is_dir() and p.name not in SKIP)
    if args.only:
        want = {part.strip() for part in args.only.split(",") if part.strip()}
        ids = [i for i in ids if i in want]
    work = []
    for clip_id in ids:
        work.append(
            (
                clip_id,
                str(src_root / clip_id),
                str(dst_root),
                clips.get(clip_id),
                prefabs.get(clip_id) or prefabs.get(clip_id.replace(" 1", "")),
            )
        )
    print(f"converting {len(work)} clips with {args.jobs} workers -> {dst_root}", flush=True)
    results = []
    failed = []
    with ProcessPoolExecutor(max_workers=args.jobs) as pool:
        futs = {pool.submit(process_one, item): item[0] for item in work}
        done = 0
        for fut in as_completed(futs):
            done += 1
            try:
                row = fut.result()
            except Exception as exc:
                row = {"id": futs[fut], "ok": False, "error": str(exc)}
            if row.get("ok"):
                results.append(row)
            else:
                failed.append(row)
            print(f"[{done}/{len(work)}] {row.get('id')} ok={row.get('ok')} {row.get('error') or ''}", flush=True)
    results.sort(key=lambda r: r["id"])
    index = {
        "count": len(results),
        "failed": failed,
        "skills": sum(1 for r in results if r.get("kind") == "skill"),
        "buffs": sum(1 for r in results if r.get("kind") == "buff"),
        "atlasBytes": sum(r.get("atlasBytes") or 0 for r in results),
        "items": results,
    }
    dst_root.mkdir(parents=True, exist_ok=True)
    (dst_root / "index.json").write_text(json.dumps(index, indent=2) + "\n")
    print(
        "done",
        len(results),
        "ok,",
        len(failed),
        "failed, atlas MB",
        round(index["atlasBytes"] / 1e6, 1),
        "skills",
        index["skills"],
        "buffs",
        index["buffs"],
    )
    if failed:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
