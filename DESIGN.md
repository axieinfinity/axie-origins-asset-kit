---
name: Origins Kit Showcase
description: Operate catalog of the Unity Origins kit
colors:
  background: "#12141A"
  panel: "#191C23"
  well: "#0C0E12"
  text: "#F3EFE6"
  muted: "#C9C3B6"
  accent: "#6EA8FF"
  line: "#2B303A"
typography:
  body:
    fontFamily: "ui-sans-serif, system-ui, sans-serif"
    fontWeight: 400
---

# Design System: Origins Kit Showcase

## Overview

An Operate catalog. A builder finds a kit asset, inspects it, and copies the Unity path. The page is a finder, not a theater and not a battlefield.

## Colors

Restrained. Cool slate panels, warm off-white type, one blue accent for selection and the copy action.

## Typography

One system sans. Fixed rem steps. Mono only inside the snippet.

## Layout

- Desktop: three columns — kind rail | pinned inspect (preview + facts) | scrolling search + grid
- The inspect column stays on screen while the grid scrolls. That is the finder: see the asset, copy the path, keep browsing.
- Narrow: rail becomes a horizontal kind list; inspect stays a sticky band above the grid
- Phone: inspect stacks (preview then facts) and remains in the top of the viewport

## Components

Native buttons and inputs. Preview well is a dark 16:9 plate. Grid tiles are the media, not marketing cards.

## Motion

Selecting an item replays it in the well. No page-load choreography.
