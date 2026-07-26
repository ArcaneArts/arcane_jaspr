library;

class ArcaneBaseCss {
  const ArcaneBaseCss._();

  static const String shared = '''
@font-face {
  font-family: 'lucide';
  src: url('/assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('/fonts/lucide/lucide.woff2') format('woff2'),
       url('assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('fonts/lucide/lucide.woff2') format('woff2'),
       url('../assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('../fonts/lucide/lucide.woff2') format('woff2'),
       url('../../assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('../../fonts/lucide/lucide.woff2') format('woff2'),
       url('https://cdn.jsdelivr.net/gh/ArcaneArts/arcane_jaspr@master/assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('/assets/fonts/lucide/lucide.woff') format('woff'),
       url('/fonts/lucide/lucide.woff') format('woff'),
       url('assets/fonts/lucide/lucide.woff') format('woff'),
       url('fonts/lucide/lucide.woff') format('woff'),
       url('../assets/fonts/lucide/lucide.woff') format('woff'),
       url('../fonts/lucide/lucide.woff') format('woff'),
       url('../../assets/fonts/lucide/lucide.woff') format('woff'),
       url('../../fonts/lucide/lucide.woff') format('woff'),
       url('/assets/fonts/lucide/lucide.ttf') format('truetype'),
       url('/fonts/lucide/lucide.ttf') format('truetype'),
       url('assets/fonts/lucide/lucide.ttf') format('truetype'),
       url('fonts/lucide/lucide.ttf') format('truetype'),
       url('../assets/fonts/lucide/lucide.ttf') format('truetype'),
       url('../fonts/lucide/lucide.ttf') format('truetype'),
       url('../../assets/fonts/lucide/lucide.ttf') format('truetype'),
       url('../../fonts/lucide/lucide.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
  font-display: block;
}

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
  font-family: var(--font-sans);
  background-color: var(--background);
  color: var(--foreground);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

* {
  scrollbar-width: thin;
  scrollbar-color: var(--primary) transparent;
}

*::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

*::-webkit-scrollbar-track {
  background: transparent;
}

*::-webkit-scrollbar-thumb {
  background: var(--primary);
  border-radius: 9999px;
  border: 2px solid transparent;
  background-clip: padding-box;
}

*::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--primary) 80%, white);
  border: 2px solid transparent;
  background-clip: padding-box;
}

*::-webkit-scrollbar-corner {
  background: transparent;
}

html.dark, html.dark body,
html.light, html.light body {
  scrollbar-width: thin;
  scrollbar-color: var(--primary) var(--background);
}

html::-webkit-scrollbar,
body::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

html.dark::-webkit-scrollbar-track,
html.dark body::-webkit-scrollbar-track,
html.light::-webkit-scrollbar-track,
html.light body::-webkit-scrollbar-track {
  background: var(--background);
}

html.dark::-webkit-scrollbar-thumb,
html.dark body::-webkit-scrollbar-thumb,
html.light::-webkit-scrollbar-thumb,
html.light body::-webkit-scrollbar-thumb {
  background: var(--primary);
  border-radius: 9999px;
  border: 2px solid transparent;
  background-clip: padding-box;
}

html.dark::-webkit-scrollbar-thumb:hover,
html.dark body::-webkit-scrollbar-thumb:hover,
html.light::-webkit-scrollbar-thumb:hover,
html.light body::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--primary) 80%, white);
  border: 2px solid transparent;
  background-clip: padding-box;
}

html.dark::-webkit-scrollbar-corner,
html.dark body::-webkit-scrollbar-corner,
html.light::-webkit-scrollbar-corner,
html.light body::-webkit-scrollbar-corner {
  background: var(--background);
}

::selection {
  background: var(--primary);
  color: var(--primary-foreground);
}

::-moz-selection {
  background: var(--primary);
  color: var(--primary-foreground);
}

.focus-ring:focus-visible {
  outline: none;
  box-shadow: 0 0 0 2px var(--background), 0 0 0 4px var(--ring);
}

/* Text tooltips use a shared CSS-only interaction contract. Theme renderers
   own their appearance and hidden state; this rule owns discoverability for
   both pointer hover and keyboard focus. The specificity and !important
   declarations intentionally beat theme-specific hidden-state rules. */
#arcane-root .arcane-css-tooltip-trigger:is(:hover, :focus-within)
  > .arcane-css-tooltip-content {
  opacity: 1 !important;
  visibility: visible !important;
}

/* iOS Safari zooms the viewport when a focused text control renders below
   16px. Keep each theme's desktop type scale while flooring native controls on
   touch-oriented devices. !important is required because renderers emit their
   configured control size inline. */
@media (pointer: coarse) {
  #arcane-root :is(input, textarea, select) {
    font-size: max(16px, 1em) !important;
  }
}

@keyframes arcane-spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

@keyframes arcane-fade-in {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes arcane-fade-out {
  from { opacity: 1; }
  to { opacity: 0; }
}

@keyframes arcane-slide-in-up {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes arcane-slide-in-down {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes arcane-slide-in-left {
  from { opacity: 0; transform: translateX(-10px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes arcane-slide-in-right {
  from { opacity: 0; transform: translateX(10px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes arcane-scale-in {
  from { opacity: 0; transform: scale(0.95); }
  to { opacity: 1; transform: scale(1); }
}

@keyframes arcane-scale-out {
  from { opacity: 1; transform: scale(1); }
  to { opacity: 0; transform: scale(0.95); }
}

@keyframes arcane-bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

@keyframes arcane-pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

@keyframes arcane-dropdown-fade {
  from { opacity: 0; transform: scale(0.95) translateY(-4px); }
  to { opacity: 1; transform: scale(1) translateY(0); }
}

.arcane-button:hover:not([disabled]) {
  filter: brightness(0.95);
}

.arcane-button:active:not([disabled]) {
  filter: brightness(0.9);
}

@keyframes scroll-carousel {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

.arcane-carousel-track:hover {
  animation-play-state: paused;
}

.arcane-carousel-track.dragging {
  animation: none !important;
  cursor: grabbing;
}

.arcane-carousel-track.dragging * {
  pointer-events: none;
}

.arcane-carousel-track.resuming {
  transition: none;
}

.arcane-page {
  --arcane-page-max-width: 72rem;
  --arcane-page-inline-gutter: clamp(1rem, 4vw, 3rem);
  width: 100%;
  max-width: var(--arcane-page-max-width);
  min-width: 0;
  margin-inline: auto;
  padding-block: clamp(1.25rem, 3vw, 3rem);
  padding-inline: var(--arcane-page-inline-gutter);
  display: grid;
  grid-template-columns: minmax(0, 1fr);
  gap: clamp(1.25rem, 2.5vw, 2.25rem);
  color: var(--foreground);
}

.arcane-page[data-arcane-page-standalone="false"] {
  padding-block: clamp(0.75rem, 2vw, 1.5rem);
}

.arcane-page-wide {
  --arcane-page-max-width: 90rem;
}

.arcane-page-reading {
  --arcane-page-max-width: 48rem;
}

.arcane-page-workbench {
  --arcane-page-max-width: 100rem;
}

.arcane-page-full,
.arcane-page-media {
  --arcane-page-max-width: 100%;
}

.arcane-page-full {
  --arcane-page-inline-gutter: 0px;
}

.arcane-page-media {
  --arcane-page-inline-gutter: clamp(0.5rem, 1.5vw, 1.5rem);
}

.arcane-page-header {
  min-width: 0;
  display: flex;
  flex-wrap: wrap;
  align-items: flex-end;
  justify-content: space-between;
  gap: clamp(1rem, 3vw, 2rem);
  padding-bottom: clamp(1rem, 2vw, 1.625rem);
  border-bottom: 1px solid var(--border);
}

.arcane-page-heading {
  flex: 1 1 32rem;
  min-width: 0;
  max-width: 52rem;
  display: grid;
  gap: 0.45rem;
}

.arcane-page-eyebrow {
  color: var(--muted-foreground);
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  line-height: 1.35;
  text-transform: uppercase;
}

.arcane-page-title {
  min-width: 0;
  color: var(--foreground);
  font-size: clamp(2rem, 4vw, 3.25rem);
  letter-spacing: -0.035em;
  line-height: 1.04;
  overflow-wrap: anywhere;
  text-wrap: balance;
}

.arcane-page-description {
  min-width: 0;
  max-width: 45rem;
  color: var(--muted-foreground);
  font-size: 0.98rem;
  line-height: 1.55;
  overflow-wrap: anywhere;
  text-wrap: pretty;
}

.arcane-page-actions {
  flex: 0 1 auto;
  min-width: 0;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: flex-end;
  gap: 0.5rem;
}

.arcane-page-body {
  width: 100%;
  min-width: 0;
}

.arcane-page-reading .arcane-page-header {
  align-items: flex-start;
}

.arcane-page-reading .arcane-page-actions {
  justify-content: flex-start;
}

@media (max-width: 48rem) {
  .arcane-page-header {
    flex-direction: column;
    align-items: stretch;
  }

  .arcane-page-heading {
    flex-basis: auto;
    width: 100%;
  }

  .arcane-page-actions {
    width: 100%;
    justify-content: flex-start;
  }
}

.arcane-not-found {
  min-height: 100vh;
  min-height: 100dvh;
  display: grid;
  place-items: center;
  padding: clamp(1rem, 4vw, 3rem);
  background: var(--arcane-app-background, var(--background));
  color: var(--foreground);
}

.arcane-not-found[data-arcane-not-found-standalone="false"] {
  min-height: 100%;
  padding-block: clamp(1rem, 3vw, 2rem);
}

.arcane-not-found-surface {
  width: min(100%, 42rem);
  overflow: hidden;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  background: var(--card);
  color: var(--card-foreground);
  box-shadow: 0 18px 55px rgb(0 0 0 / 0.12);
}

.arcane-not-found-banner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
  min-width: 0;
  padding: 0.75rem 1rem;
  border-bottom: 1px solid var(--border);
  background: var(--muted);
  color: var(--muted-foreground);
  font-size: 0.75rem;
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.arcane-not-found-application {
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.arcane-not-found-code {
  flex: 0 0 auto;
  font-variant-numeric: tabular-nums;
}

.arcane-not-found-content {
  display: grid;
  gap: 1rem;
  padding: clamp(1.25rem, 4vw, 2.25rem);
}

.arcane-not-found-title {
  color: inherit;
  font-size: clamp(1.75rem, 6vw, 3rem);
  line-height: 1.08;
  letter-spacing: -0.035em;
}

.arcane-not-found-description {
  max-width: 58ch;
  color: var(--muted-foreground);
  line-height: 1.65;
}

.arcane-not-found-path {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem 0.65rem;
  min-width: 0;
  padding: 0.75rem;
  border: 1px solid var(--border);
  border-radius: calc(var(--radius) * 0.75);
  background: var(--muted);
  color: var(--muted-foreground);
  font-size: 0.875rem;
}

.arcane-not-found-path-label {
  flex: 0 0 auto;
  font-weight: 600;
}

.arcane-not-found-path-value {
  min-width: 0;
  overflow-wrap: anywhere;
  color: var(--foreground);
}

.arcane-not-found-actions {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 0.75rem;
}

.arcane-not-found-action {
  display: inline-flex;
  min-height: 2.5rem;
  align-items: center;
  justify-content: center;
  padding: 0.55rem 0.9rem;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  background: var(--card);
  color: var(--card-foreground);
  font-weight: 600;
  line-height: 1.2;
  text-decoration: none;
}

.arcane-not-found-action:hover {
  background: var(--accent);
  color: var(--accent-foreground);
}

.arcane-not-found-action-primary {
  border-color: var(--primary);
  background: var(--primary);
  color: var(--primary-foreground);
}

.arcane-not-found-action-primary:hover {
  filter: brightness(0.95);
}

.arcane-not-found-action:focus-visible {
  outline: 2px solid var(--ring);
  outline-offset: 2px;
}

.arcane-not-found-diagnostic {
  color: var(--muted-foreground);
  font-family: var(--font-mono, monospace);
  font-size: 0.75rem;
  overflow-wrap: anywhere;
}
''';
}
