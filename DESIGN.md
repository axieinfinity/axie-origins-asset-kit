---
name: Origins Kit Showcase
description: Dango catalog of the Unity Origins kit
colors:
  background: "#13161B"
  text: "#FFFFFF"
  primary: "#FF9345"
  primary-hover: "#EB6F3A"
  secondary: "#0094FF"
  info: "#0094FF"
  success: "#00B21D"
  danger: "#E22737"
  default: "#282C34"
  box: "#1C1F25"
  plant: "#AFDB1B"
  beast: "#FDB014"
  bug: "#FF433E"
  bird: "#FA59A0"
  aquatic: "#00F5F8"
  reptile: "#9967FB"
  dusk: "#029FAE"
  mech: "#71898E"
  dawn: "#7183E3"
typography:
  display:
    fontFamily: "Work Sans, sans-serif"
    fontWeight: 600
  body:
    fontFamily: "Work Sans, sans-serif"
    fontWeight: 400
rounded:
  default: "4px"
---

# Design System: Origins Kit Showcase

## Overview

**Creative North Star: App.Axie catalog, one figure in motion**

Dango 0.4.54-beta.4. Dark room, kam orange on the live asset, Work Sans everywhere. The first viewport is a theater: the selected kit item plays, its Unity path and activation sit beside it, and neighbors process across a strip. The library below is an equal-fragment field.

## Colors

Dango dark-first. Kam is the only brand accent.

- Background `#13161B`
- Box `#1C1F25`
- Kam `#FF9345` — play, selected cell, active tab
- Info `#0094FF` — kind badges
- Class colors via `SpecialTag`

## Typography

Work Sans via Dango tokens. IDs and Unity paths use the system mono only inside code blocks.

## Components

Dango only: Box, Tabs, Search, Tag, SpecialTag, Button, IconButton, Switch, Slider, Dialog, Drawer, Dropdown, Alert, Typography, Space, Loader, Badge.

No custom buttons. Selected gallery cell is kam outline 1px.

## Layout

- Sticky theater at top: stage | integration | controls
- Neighbor procession under the stage (same-size fragments)
- Tabbed equal field below
- Mobile: theater stacks; procession scrolls sideways

## Motion

One authored moment: the selected fragment stays put while the stage replay fires. Gallery loops only when visible.
