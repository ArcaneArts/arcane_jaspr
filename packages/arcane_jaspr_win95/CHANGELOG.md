# Changelog

## 3.3.0

- Initial Windows 95 renderer package for Arcane Jaspr.
- Faithful Win95 look built entirely from layered-inset 3D bevels: raised control
  faces (buttons, panels, tabs), sunken wells (inputs, progress, group boxes),
  navy→cyan gradient title bars, segmented progress meters, etched-groove
  separators, chunky beveled scrollbars, and dotted focus rectangles. Sharp
  corners throughout; no blur; press-only interaction.
- Five real appearance schemes (Standard, Rainy Day, Eggplant, Desert, Rose) plus
  a period-accurate High Contrast Black dark mode.
- Configurable window chrome via `Win95Chrome` (classic / everything / minimal).
- Export `Win95KnowledgeBaseRenderers` (moved here from `arcane_lexicon`). The
  package now depends on `arcane_lexicon` and owns its docs-chrome renderers, so a
  lexicon site selects this theme's chrome via
  `knowledgeBaseRenderers: const Win95KnowledgeBaseRenderers()`.
- Self-hosted "Pixelated MS Sans Serif" bitmap font, inlined so the theme is
  authentic offline.
- Component-accuracy pass: form action buttons (Submit/Cancel) are silver 3D
  faces instead of navy/teal fills; cycle and toggle buttons get proper silver
  bevels; textareas and multiline fields render as sunken white wells; standard
  radio options draw a round sunken well with a selected centre dot (previously
  bare text with no control); checkboxes show a single check (the stray literal
  glyph is collapsed); separators use the etched groove, status indicators are
  round, and the progress `%` readout is plain text rather than a second meter
  strip; field wrappers stack label / helper / error.
- Docs-chrome layout: the Explorer sidebar and right-hand TOC now reserve the
  fixed Start-bar height (`max-height: calc(100vh - 96px)`), so the tree, its
  internal scrollbar, and a long TOC stop above the taskbar instead of being
  eclipsed by it.
- Date-picker popup: the calendar dropdown had no position rule and fell through
  to a placeholder `position: fixed; top: 4px; left: 4px`, pinning it to the
  top-left corner behind other content. It now anchors below the trigger via CSS
  anchor positioning (`position: fixed` + `anchor()`), so it escapes clipping
  ancestors and floats on top; a `position: absolute` fallback covers browsers
  without anchor-positioning support.
- Docs-chrome topbar: the stylesheet/palette `<select>` switchers rendered their
  value in the macOS system font (native `appearance` ignores the theme font, and
  `<select>` does not inherit `font-family`); they now use `appearance: none` with
  the explicit pixel-font stack and a Win95 dropdown arrow (black in light, white
  in dark).
- Docs-chrome muted labels (article "min read / Updated" metadata, the "Live
  Demo" / "Code" demo kickers) used `--w95-shadow` for text, which is a bevel
  colour that turns near-black in dark mode and was unreadable on the dark panel.
  They now use the theme-aware `--muted-foreground`, readable in both modes.
