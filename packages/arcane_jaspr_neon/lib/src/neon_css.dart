import 'package:arcane_jaspr/component/navigation/toc.dart'
    show arcaneTocTreeLinesCss;
import 'package:arcane_jaspr/component/view/map/map_style.dart'
    show arcaneMapCss;
import 'package:arcane_jaspr/util/content/prose_styles.dart';

import 'neon_theme.dart';

class NeonCss {
  const NeonCss._();

  static String _hex(int argb) {
    final int r = (argb >> 16) & 0xFF;
    final int g = (argb >> 8) & 0xFF;
    final int b = argb & 0xFF;
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }

  static String componentCss(NeonTheme theme) {
    final String accentHot = _hex(theme.accentHot);
    final String accentCool = _hex(theme.accentCool);

    return '''
#arcane-root.arcane-theme-neon {
  --neon-accent: var(--primary);
  --neon-accent-rgb: var(--primary-rgb);
  --neon-accent-hot: $accentHot;
  --neon-accent-cool: $accentCool;

  --neon-accent-soft: color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --neon-accent-medium: color-mix(in srgb, var(--neon-accent) 32%, transparent);
  --neon-accent-strong: color-mix(in srgb, var(--neon-accent) 56%, transparent);
  --neon-on-accent: #03110f;

  --neon-cool-soft: color-mix(in srgb, var(--neon-accent-cool) 22%, transparent);
  --neon-cool-medium: color-mix(in srgb, var(--neon-accent-cool) 40%, transparent);

  --neon-hot-soft: color-mix(in srgb, var(--neon-accent-hot) 18%, transparent);

  --neon-surface-0: #12151C;
  --neon-surface-1: rgba(25, 29, 38, 0.94);
  --neon-surface-2: rgba(27, 34, 44, 0.9);
  --neon-surface-3: rgba(45, 45, 48, 0.82);

  --neon-cut-xs: 0.375rem;
  --neon-cut-sm: 0.625rem;
  --neon-cut-md: 1rem;

  --neon-radius-control: 0.375rem;
  --neon-radius-panel: 0.625rem;

  --neon-clip-xs: polygon(0 var(--neon-cut-xs), var(--neon-cut-xs) 0, 100% 0, 100% calc(100% - var(--neon-cut-xs)), calc(100% - var(--neon-cut-xs)) 100%, 0 100%);
  --neon-clip-sm: polygon(0 var(--neon-cut-sm), var(--neon-cut-sm) 0, 100% 0, 100% calc(100% - var(--neon-cut-sm)), calc(100% - var(--neon-cut-sm)) 100%, 0 100%);
  --neon-clip-md: polygon(0 var(--neon-cut-md), var(--neon-cut-md) 0, 100% 0, 100% calc(100% - var(--neon-cut-md)), calc(100% - var(--neon-cut-md)) 100%, 0 100%);

  --neon-control-clip: var(--neon-clip-sm);
  --neon-panel-clip: var(--neon-clip-md);

  --neon-panel-border: color-mix(in srgb, var(--neon-accent) 16%, #3E3E42);
  --neon-panel-border-hot: color-mix(in srgb, var(--neon-accent-cool) 38%, #3E3E42);
  --neon-control-border: color-mix(in srgb, var(--neon-accent) 10%, #3E3E42);
  --neon-control-border-strong: color-mix(in srgb, var(--neon-accent) 34%, #3E3E42);

  --neon-panel-surface: color-mix(in srgb, var(--card) 86%, transparent);
  --neon-panel-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 7%, transparent), transparent 58%);
  --neon-control-surface: color-mix(in srgb, var(--card) 88%, transparent);
  --neon-control-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), transparent 64%);

  --neon-shadow-sm: 0 6px 16px rgba(0, 0, 0, 0.3);
  --neon-shadow-md: 0 14px 32px rgba(0, 0, 0, 0.38);
  --neon-shadow-lg: 0 24px 48px rgba(0, 0, 0, 0.48);

  --neon-glow-sm: 0 0 16px color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --neon-glow-md: 0 0 24px color-mix(in srgb, var(--neon-accent) 22%, transparent);
  --neon-glow-lg: 0 0 36px color-mix(in srgb, var(--neon-accent) 28%, transparent);

  --neon-inset: inset 0 1px 0 rgba(255, 255, 255, 0.08);
  --neon-inset-strong: inset 0 1px 0 rgba(255, 255, 255, 0.14);

  --neon-grid-line: color-mix(in srgb, var(--neon-accent) 10%, transparent);

  background: transparent !important;
  isolation: isolate;
}

html.dark #arcane-root.arcane-theme-neon,
#arcane-root.dark.arcane-theme-neon {
  --background: #12151C;
  --foreground: #F2F0EA;
  --card: #191D26;
  --card-foreground: #F2F0EA;
  --card-hover: #1B222C;
  --popover: #1B222C;
  --popover-foreground: #F2F0EA;
  --secondary: #191D26;
  --secondary-foreground: #F2F0EA;
  --accent: #1B222C;
  --accent-foreground: #F2F0EA;
  --muted: #191D26;
  --muted-foreground: #A8ADB6;
  --border: #3E3E42;
  --input: #2D2D30;
  --ring: #007ACC;
  --info: #007ACC;
  --destructive: #661B1C;
  --destructive-hover: #7A2022;
  --code-background: #1E1E1E;
  --neon-surface-0: #12151C;
  --neon-surface-1: rgba(25, 29, 38, 0.96);
  --neon-surface-2: rgba(27, 34, 44, 0.92);
  --neon-surface-3: rgba(45, 45, 48, 0.86);
  --neon-panel-surface: color-mix(in srgb, #191D26 92%, transparent);
  --neon-control-surface: color-mix(in srgb, #1B222C 90%, transparent);
  --neon-panel-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 6%, transparent), transparent 58%);
  --neon-control-tint: linear-gradient(135deg, color-mix(in srgb, #007ACC 4%, transparent), transparent 64%);
  --neon-grid-line: rgba(0, 122, 204, 0.075);
  --neon-on-accent: #101216;
}

html:has(#arcane-root.arcane-theme-neon),
html:has(#arcane-root.arcane-theme-neon) body,
#arcane-root.arcane-theme-neon,
#arcane-root.arcane-theme-neon * {
  scrollbar-width: thin;
  scrollbar-color: color-mix(in srgb, var(--neon-accent-cool) 52%, transparent) transparent;
}

html:has(#arcane-root.arcane-theme-neon)::-webkit-scrollbar,
html:has(#arcane-root.arcane-theme-neon) body::-webkit-scrollbar,
#arcane-root.arcane-theme-neon *::-webkit-scrollbar {
  width: 0.5rem;
  height: 0.5rem;
}

html:has(#arcane-root.arcane-theme-neon)::-webkit-scrollbar-track,
html:has(#arcane-root.arcane-theme-neon) body::-webkit-scrollbar-track,
#arcane-root.arcane-theme-neon *::-webkit-scrollbar-track {
  background: transparent;
}

html:has(#arcane-root.arcane-theme-neon)::-webkit-scrollbar-thumb,
html:has(#arcane-root.arcane-theme-neon) body::-webkit-scrollbar-thumb,
#arcane-root.arcane-theme-neon *::-webkit-scrollbar-thumb {
  background: color-mix(in srgb, var(--neon-accent-cool) 44%, var(--border));
  border: 2px solid transparent;
  border-radius: 999px;
  background-clip: padding-box;
}

html:has(#arcane-root.arcane-theme-neon)::-webkit-scrollbar-thumb:hover,
html:has(#arcane-root.arcane-theme-neon) body::-webkit-scrollbar-thumb:hover,
#arcane-root.arcane-theme-neon *::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--neon-accent-cool) 68%, var(--foreground));
}

html.dark #arcane-root.arcane-theme-neon::before {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -2;
  pointer-events: none;
  background-color: #12151C;
  background-image:
    radial-gradient(ellipse 60rem 40rem at 12% -8%, rgba(0, 122, 204, 0.1), transparent 70%),
    radial-gradient(ellipse 50rem 32rem at 92% 100%, rgba(102, 27, 28, 0.12), transparent 70%),
    linear-gradient(var(--neon-grid-line) 1px, transparent 1px),
    linear-gradient(90deg, var(--neon-grid-line) 1px, transparent 1px);
  background-size: auto, auto, 64px 64px, 64px 64px;
  background-attachment: fixed;
  transform: translateZ(0);
}

html.dark #arcane-root.arcane-theme-neon::after {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -1;
  pointer-events: none;
  opacity: 0.06;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
  background-size: 200px 200px;
  mix-blend-mode: overlay;
}

#arcane-root.arcane-theme-neon ::selection {
  background: color-mix(in srgb, var(--neon-accent) 38%, transparent);
  color: var(--foreground);
}

#arcane-root.arcane-theme-neon :focus-visible {
  outline: 2px solid var(--neon-accent);
  outline-offset: 2px;
  box-shadow: 0 0 0 3px color-mix(in srgb, var(--neon-accent) 20%, transparent), var(--neon-glow-md);
}

#arcane-root.arcane-theme-neon a {
  color: var(--neon-accent);
  text-underline-offset: 2px;
  transition: color 0.15s ease, text-shadow 0.15s ease;
}

#arcane-root.arcane-theme-neon a:hover {
  color: var(--neon-accent-cool);
  text-shadow: 0 0 12px color-mix(in srgb, var(--neon-accent-cool) 32%, transparent);
}

#arcane-root.arcane-theme-neon .arcane-scaffold-sidebar,
#arcane-root.arcane-theme-neon .arcane-scaffold-main,
#arcane-root.arcane-theme-neon .arcane-scaffold-secondary,
#arcane-root.arcane-theme-neon .neon-card,
#arcane-root.arcane-theme-neon .neon-command-dialog,
#arcane-root.arcane-theme-neon .neon-accordion,
#arcane-root.arcane-theme-neon .neon-calendar,
#arcane-root.arcane-theme-neon .neon-chart,
#arcane-root.arcane-theme-neon .neon-data-table-container,
#arcane-root.arcane-theme-neon .neon-static-table-container,
#arcane-root.arcane-theme-neon .neon-sidebar,
#arcane-root.arcane-theme-neon .neon-empty-state-card,
#arcane-root.arcane-theme-neon .neon-resizable,
#arcane-root.arcane-theme-neon .neon-scroll-area,
#arcane-root.arcane-theme-neon .neon-form-section,
#arcane-root.arcane-theme-neon .neon-input-group,
#arcane-root.arcane-theme-neon .neon-disclosure,
#arcane-root.arcane-theme-neon .neon-field-wrapper,
#arcane-root.arcane-theme-neon .neon-otp-input,
#arcane-root.arcane-theme-neon .neon-radio-group,
#arcane-root.arcane-theme-neon .neon-tabs,
#arcane-root.arcane-theme-neon .neon-toggle-group,
#arcane-root.arcane-theme-neon .neon-slot-counter,
#arcane-root.arcane-theme-neon .neon-slot-counter-card,
#arcane-root.arcane-theme-neon .neon-kv-table,
#arcane-root.arcane-theme-neon .neon-button-panel,
#arcane-root.arcane-theme-neon .neon-toolbar,
#arcane-root.arcane-theme-neon .neon-button-group,
#arcane-root.arcane-theme-neon .neon-panel {
  position: relative;
  isolation: isolate;
  overflow: hidden;
  border-radius: var(--neon-radius-panel) !important;
  clip-path: var(--neon-panel-clip);
  border: 1px solid var(--neon-panel-border) !important;
  background: var(--neon-panel-tint), var(--neon-panel-surface) !important;
  box-shadow: var(--neon-shadow-sm), var(--neon-inset);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
  transition: border-color 0.18s ease, box-shadow 0.18s ease, transform 0.18s ease;
}

#arcane-root.arcane-theme-neon .neon-card.clickable {
  cursor: pointer;
}

#arcane-root.arcane-theme-neon .neon-card.clickable:hover {
  border-color: var(--neon-panel-border-hot) !important;
  transform: translateY(-2px);
  box-shadow: var(--neon-shadow-md), var(--neon-glow-md), var(--neon-inset-strong);
}

#arcane-root.arcane-theme-neon .neon-dropdown-menu,
#arcane-root.arcane-theme-neon .neon-dropdown-submenu,
#arcane-root.arcane-theme-neon .neon-context-menu,
#arcane-root.arcane-theme-neon .neon-menubar-content,
#arcane-root.arcane-theme-neon .neon-select-content,
#arcane-root.arcane-theme-neon .neon-date-picker,
#arcane-root.arcane-theme-neon .neon-time-picker,
#arcane-root.arcane-theme-neon .neon-popover,
#arcane-root.arcane-theme-neon .neon-tooltip,
#arcane-root.arcane-theme-neon .neon-toast,
#arcane-root.arcane-theme-neon .neon-tabs-list,
#arcane-root.arcane-theme-neon .neon-command,
#arcane-root.arcane-theme-neon .neon-data-table,
#arcane-root.arcane-theme-neon .neon-static-table {
  position: relative;
  overflow: hidden;
  border-radius: var(--neon-radius-panel) !important;
  clip-path: var(--neon-panel-clip);
  border-color: var(--neon-panel-border) !important;
  background: var(--neon-panel-tint), color-mix(in srgb, var(--popover, var(--card)) 88%, transparent) !important;
  box-shadow: var(--neon-shadow-md), var(--neon-inset);
  backdrop-filter: blur(18px) saturate(1.18);
  -webkit-backdrop-filter: blur(18px) saturate(1.18);
}

#arcane-root.arcane-theme-neon .neon-tooltip {
  background: color-mix(in srgb, var(--neon-surface-2) 92%, transparent) !important;
  border-color: color-mix(in srgb, var(--neon-accent) 18%, var(--border)) !important;
}

#arcane-root.arcane-theme-neon .neon-button,
#arcane-root.arcane-theme-neon .neon-text-input,
#arcane-root.arcane-theme-neon .neon-text-input-container,
#arcane-root.arcane-theme-neon .neon-select-trigger,
#arcane-root.arcane-theme-neon .neon-date-picker-trigger,
#arcane-root.arcane-theme-neon .neon-otp-digit,
#arcane-root.arcane-theme-neon .neon-calendar-nav-btn,
#arcane-root.arcane-theme-neon .neon-calendar-today-btn,
#arcane-root.arcane-theme-neon .neon-calendar-day,
#arcane-root.arcane-theme-neon .neon-pagination-button,
#arcane-root.arcane-theme-neon .neon-menubar-trigger,
#arcane-root.arcane-theme-neon .neon-toggle-button,
#arcane-root.arcane-theme-neon .neon-radio-card,
#arcane-root.arcane-theme-neon .neon-radio-button,
#arcane-root.arcane-theme-neon .neon-radio-chip,
#arcane-root.arcane-theme-neon .neon-toggle-group-item,
#arcane-root.arcane-theme-neon .neon-tabs-trigger,
#arcane-root.arcane-theme-neon .neon-tab-bar-item {
  border-radius: var(--neon-radius-control) !important;
  clip-path: var(--neon-control-clip);
  transition: color 0.16s ease, background 0.16s ease, border-color 0.16s ease, box-shadow 0.16s ease, transform 0.16s ease;
}

#arcane-root.arcane-theme-neon .neon-select-trigger,
#arcane-root.arcane-theme-neon .neon-date-picker-trigger,
#arcane-root.arcane-theme-neon .neon-text-input,
#arcane-root.arcane-theme-neon .neon-text-input-container,
#arcane-root.arcane-theme-neon .neon-otp-digit,
#arcane-root.arcane-theme-neon .neon-calendar-nav-btn,
#arcane-root.arcane-theme-neon .neon-calendar-today-btn,
#arcane-root.arcane-theme-neon .neon-pagination-button,
#arcane-root.arcane-theme-neon .neon-menubar-trigger,
#arcane-root.arcane-theme-neon .neon-toggle-button,
#arcane-root.arcane-theme-neon .neon-radio-card,
#arcane-root.arcane-theme-neon .neon-radio-button,
#arcane-root.arcane-theme-neon .neon-radio-chip,
#arcane-root.arcane-theme-neon .neon-toggle-group-item,
#arcane-root.arcane-theme-neon .neon-tabs-trigger,
#arcane-root.arcane-theme-neon .neon-tab-bar-item {
  background: var(--neon-control-tint), var(--neon-control-surface) !important;
  border: 1px solid var(--neon-control-border) !important;
  color: var(--foreground);
  box-shadow: var(--neon-inset);
}

#arcane-root.arcane-theme-neon .neon-select-trigger:hover,
#arcane-root.arcane-theme-neon .neon-date-picker-trigger:hover,
#arcane-root.arcane-theme-neon .neon-text-input:hover,
#arcane-root.arcane-theme-neon .neon-text-input-container:hover,
#arcane-root.arcane-theme-neon .neon-otp-digit:hover,
#arcane-root.arcane-theme-neon .neon-calendar-nav-btn:hover,
#arcane-root.arcane-theme-neon .neon-calendar-today-btn:hover,
#arcane-root.arcane-theme-neon .neon-calendar-day:hover,
#arcane-root.arcane-theme-neon .neon-pagination-button:hover,
#arcane-root.arcane-theme-neon .neon-menubar-trigger:hover,
#arcane-root.arcane-theme-neon .neon-toggle-button:hover,
#arcane-root.arcane-theme-neon .neon-radio-card:hover,
#arcane-root.arcane-theme-neon .neon-radio-button:hover,
#arcane-root.arcane-theme-neon .neon-radio-chip:hover,
#arcane-root.arcane-theme-neon .neon-toggle-group-item:hover,
#arcane-root.arcane-theme-neon .neon-tabs-trigger:hover,
#arcane-root.arcane-theme-neon .neon-tab-bar-item:hover {
  border-color: var(--neon-panel-border-hot) !important;
  color: var(--neon-accent-cool);
  box-shadow: var(--neon-inset-strong), var(--neon-glow-sm);
}

#arcane-root.arcane-theme-neon .neon-breadcrumbs {
  width: fit-content;
  max-width: 100%;
  gap: 0.28rem !important;
  padding: 0.24rem 0.38rem;
  border: 1px solid color-mix(in srgb, var(--neon-accent-cool) 16%, transparent);
  border-radius: 0.3rem;
  clip-path: polygon(0 0.38rem, 0.38rem 0, 100% 0, 100% calc(100% - 0.38rem), calc(100% - 0.38rem) 100%, 0 100%);
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--neon-surface-2) 70%, transparent), color-mix(in srgb, var(--neon-surface-1) 58%, transparent)),
    linear-gradient(90deg, color-mix(in srgb, var(--neon-accent-cool) 8%, transparent), transparent 48%, color-mix(in srgb, var(--neon-accent-hot) 5%, transparent));
  box-shadow:
    inset 0 1px 0 color-mix(in srgb, #ffffff 8%, transparent),
    0 0 18px color-mix(in srgb, var(--neon-accent-cool) 6%, transparent);
  backdrop-filter: blur(12px) saturate(1.08);
  -webkit-backdrop-filter: blur(12px) saturate(1.08);
}

#arcane-root.arcane-theme-neon .neon-breadcrumb-link,
#arcane-root.arcane-theme-neon .neon-breadcrumb-button,
#arcane-root.arcane-theme-neon .neon-breadcrumb-current {
  position: relative;
  min-height: 1.35rem;
  padding: 0 0.34rem 0 0.78rem !important;
  border: 0 !important;
  border-radius: 0.18rem !important;
  clip-path: none !important;
  background: transparent !important;
  color: color-mix(in srgb, var(--muted-foreground) 82%, var(--foreground)) !important;
  box-shadow: none !important;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  line-height: 1;
}

#arcane-root.arcane-theme-neon .neon-breadcrumb-link::before,
#arcane-root.arcane-theme-neon .neon-breadcrumb-button::before,
#arcane-root.arcane-theme-neon .neon-breadcrumb-current::before {
  content: '';
  position: absolute;
  left: 0.28rem;
  top: 50%;
  width: 0.34rem;
  height: 0.34rem;
  border: 1px solid color-mix(in srgb, var(--neon-accent-cool) 44%, transparent);
  background: color-mix(in srgb, var(--background) 74%, transparent);
  transform: translateY(-50%) rotate(45deg);
  box-shadow: 0 0 8px color-mix(in srgb, var(--neon-accent-cool) 10%, transparent);
}

#arcane-root.arcane-theme-neon .neon-breadcrumb-link:hover,
#arcane-root.arcane-theme-neon .neon-breadcrumb-button:hover {
  color: var(--neon-accent-cool) !important;
  background: color-mix(in srgb, var(--neon-accent-cool) 8%, transparent) !important;
}

#arcane-root.arcane-theme-neon .neon-breadcrumb-link:hover::before,
#arcane-root.arcane-theme-neon .neon-breadcrumb-button:hover::before,
#arcane-root.arcane-theme-neon .neon-breadcrumb-current::before {
  border-color: var(--neon-accent-cool);
  background: color-mix(in srgb, var(--neon-accent-cool) 34%, var(--background));
  box-shadow: 0 0 10px color-mix(in srgb, var(--neon-accent-cool) 22%, transparent);
}

#arcane-root.arcane-theme-neon .neon-breadcrumb-current {
  color: var(--foreground) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-accent-cool) 12%, transparent), color-mix(in srgb, var(--neon-accent-hot) 6%, transparent)) !important;
}

#arcane-root.arcane-theme-neon .neon-breadcrumb-separator {
  position: relative;
  width: 1.25rem;
  min-width: 1.25rem;
  height: 1px;
  overflow: visible;
  color: transparent !important;
  opacity: 1 !important;
}

#arcane-root.arcane-theme-neon .neon-breadcrumb-separator::before {
  content: '';
  position: absolute;
  left: 0.14rem;
  right: 0.14rem;
  top: 50%;
  height: 1px;
  background: linear-gradient(90deg, transparent, color-mix(in srgb, var(--neon-accent-cool) 44%, transparent), transparent);
  transform: translateY(-50%);
}

#arcane-root.arcane-theme-neon .neon-breadcrumb-separator::after {
  content: '';
  position: absolute;
  right: 0.14rem;
  top: 50%;
  width: 0.28rem;
  height: 0.28rem;
  border-top: 1px solid color-mix(in srgb, var(--neon-accent-cool) 50%, transparent);
  border-right: 1px solid color-mix(in srgb, var(--neon-accent-cool) 50%, transparent);
  transform: translateY(-50%) rotate(45deg);
}

html.light #arcane-root.arcane-theme-neon .neon-breadcrumbs,
#arcane-root.light.arcane-theme-neon .neon-breadcrumbs {
  border-color: rgba(36, 78, 209, 0.14);
  background:
    linear-gradient(135deg, rgba(255, 255, 255, 0.76), rgba(243, 246, 251, 0.68)),
    linear-gradient(90deg, rgba(132, 165, 242, 0.12), transparent 52%, rgba(255, 102, 0, 0.05));
  box-shadow: 0 8px 20px rgba(36, 78, 209, 0.08), inset 0 1px 0 rgba(255, 255, 255, 0.9);
}

html.light #arcane-root.arcane-theme-neon .neon-breadcrumb-link,
html.light #arcane-root.arcane-theme-neon .neon-breadcrumb-button,
html.light #arcane-root.arcane-theme-neon .neon-breadcrumb-current,
#arcane-root.light.arcane-theme-neon .neon-breadcrumb-link,
#arcane-root.light.arcane-theme-neon .neon-breadcrumb-button,
#arcane-root.light.arcane-theme-neon .neon-breadcrumb-current {
  color: #52638d !important;
}

html.light #arcane-root.arcane-theme-neon .neon-breadcrumb-current,
#arcane-root.light.arcane-theme-neon .neon-breadcrumb-current {
  color: #101a3a !important;
  background: linear-gradient(90deg, rgba(132, 165, 242, 0.2), rgba(255, 102, 0, 0.06)) !important;
}

#arcane-root.arcane-theme-neon .neon-text-input:focus,
#arcane-root.arcane-theme-neon .neon-text-input-container:focus-within,
#arcane-root.arcane-theme-neon .neon-otp-digit:focus {
  border-color: var(--neon-accent) !important;
  box-shadow: 0 0 0 1px color-mix(in srgb, var(--neon-accent) 32%, transparent), var(--neon-glow-md);
}

#arcane-root.arcane-theme-neon .neon-tabs-trigger[data-state="active"],
#arcane-root.arcane-theme-neon .neon-tab-bar-item.active,
#arcane-root.arcane-theme-neon .neon-toggle-button.active,
#arcane-root.arcane-theme-neon .neon-toggle-group-item.selected,
#arcane-root.arcane-theme-neon .neon-radio-card.selected,
#arcane-root.arcane-theme-neon .neon-radio-button.selected,
#arcane-root.arcane-theme-neon .neon-radio-chip.selected,
#arcane-root.arcane-theme-neon .neon-pagination-button.active,
#arcane-root.arcane-theme-neon .neon-calendar-day.selected,
#arcane-root.arcane-theme-neon .neon-calendar-day[aria-selected="true"],
#arcane-root.arcane-theme-neon .neon-select-trigger.open,
#arcane-root.arcane-theme-neon .neon-select-trigger[data-state="open"] {
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 22%, transparent), color-mix(in srgb, var(--neon-accent-cool) 12%, transparent)),
    color-mix(in srgb, var(--card) 80%, transparent) !important;
  border-color: var(--neon-accent) !important;
  color: var(--foreground) !important;
  box-shadow: var(--neon-inset-strong), var(--neon-glow-md);
}

#arcane-root.arcane-theme-neon .neon-button {
  isolation: isolate;
  overflow: hidden;
  text-transform: uppercase;
  letter-spacing: 0.06em;
}

#arcane-root.arcane-theme-neon .neon-button::before {
  content: '';
  position: absolute;
  inset: 0;
  pointer-events: none;
  opacity: 0;
  background: linear-gradient(120deg, transparent 38%, color-mix(in srgb, #ffffff 18%, transparent) 50%, transparent 62%);
  transform: translateX(-120%);
  transition: opacity 0.18s ease, transform 0.55s ease;
  z-index: 1;
}

#arcane-root.arcane-theme-neon .neon-button:hover::before {
  opacity: 0.6;
  transform: translateX(120%);
}

#arcane-root.arcane-theme-neon .neon-button:hover {
  transform: translateY(-1px);
  filter: brightness(1.06);
}

#arcane-root.arcane-theme-neon .neon-button:active {
  transform: translateY(0);
  filter: brightness(0.96);
}

#arcane-root.arcane-theme-neon .neon-alert {
  position: relative;
  isolation: isolate;
  overflow: hidden;
  border-radius: var(--neon-radius-panel) !important;
  clip-path: var(--neon-clip-sm);
  align-items: flex-start;
  border-left: 0 !important;
  box-shadow: var(--neon-shadow-sm), var(--neon-inset);
}

#arcane-root.arcane-theme-neon .neon-alert-title,
#arcane-root.arcane-theme-neon .neon-card h1,
#arcane-root.arcane-theme-neon .neon-card h2,
#arcane-root.arcane-theme-neon .neon-card h3 {
  letter-spacing: 0.06em;
}

#arcane-root.arcane-theme-neon .neon-alert-icon,
#arcane-root.arcane-theme-neon .neon-empty-state-icon,
#arcane-root.arcane-theme-neon .neon-check-item-icon,
#arcane-root.arcane-theme-neon .neon-feature-row-icon {
  border: 1px solid var(--neon-panel-border-hot);
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  background: var(--neon-panel-tint), color-mix(in srgb, var(--card) 80%, transparent) !important;
  box-shadow: var(--neon-glow-sm);
}

#arcane-root.arcane-theme-neon .neon-badge,
#arcane-root.arcane-theme-neon .neon-status-badge,
#arcane-root.arcane-theme-neon .neon-kbd {
  border-radius: var(--neon-radius-control) !important;
  clip-path: var(--neon-clip-xs);
  background: var(--neon-panel-tint), color-mix(in srgb, var(--card) 84%, transparent) !important;
  border: 1px solid var(--neon-panel-border) !important;
  box-shadow: var(--neon-inset);
}

#arcane-root.arcane-theme-neon .neon-status-label {
  letter-spacing: 0.08em;
}

#arcane-root.arcane-theme-neon .neon-data-table,
#arcane-root.arcane-theme-neon .neon-static-table,
#arcane-root.arcane-theme-neon .neon-kv-table {
  border-collapse: separate !important;
  border-spacing: 0;
  overflow: hidden;
  font-variant-numeric: tabular-nums;
}

#arcane-root.arcane-theme-neon .neon-data-table th,
#arcane-root.arcane-theme-neon .neon-static-table th,
#arcane-root.arcane-theme-neon .neon-kv-table-key {
  background: color-mix(in srgb, var(--neon-accent) 8%, var(--card)) !important;
  color: var(--neon-accent) !important;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  font-size: 0.75rem;
  font-weight: 600;
  border-color: color-mix(in srgb, var(--neon-accent) 18%, var(--border)) !important;
}

#arcane-root.arcane-theme-neon .neon-data-table td,
#arcane-root.arcane-theme-neon .neon-static-table td,
#arcane-root.arcane-theme-neon .neon-kv-table-value {
  border-color: color-mix(in srgb, var(--neon-accent) 8%, var(--border)) !important;
}

#arcane-root.arcane-theme-neon .neon-data-table-row:hover,
#arcane-root.arcane-theme-neon .neon-static-table tbody tr:hover,
#arcane-root.arcane-theme-neon .neon-kv-table-row:hover {
  background: color-mix(in srgb, var(--neon-accent) 6%, transparent) !important;
}

#arcane-root.arcane-theme-neon .neon-progress-track,
#arcane-root.arcane-theme-neon .neon-slider-track {
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  border: 1px solid color-mix(in srgb, var(--neon-accent) 14%, var(--border));
  background: color-mix(in srgb, var(--foreground) 8%, transparent) !important;
}

#arcane-root.arcane-theme-neon .neon-progress-indicator,
#arcane-root.arcane-theme-neon .neon-slider-range {
  background: linear-gradient(90deg, var(--neon-accent), var(--neon-accent-cool)) !important;
  box-shadow: 0 0 14px color-mix(in srgb, var(--neon-accent) 36%, transparent);
}

#arcane-root.arcane-theme-neon .neon-slider-thumb,
#arcane-root.arcane-theme-neon .neon-radio-circle,
#arcane-root.arcane-theme-neon .neon-status-indicator {
  box-shadow:
    0 0 0 1px color-mix(in srgb, var(--neon-accent) 38%, transparent),
    0 0 12px color-mix(in srgb, var(--neon-accent) 24%, transparent) !important;
}

#arcane-root.arcane-theme-neon .neon-sidebar-item,
#arcane-root.arcane-theme-neon .neon-dropdown-item,
#arcane-root.arcane-theme-neon .neon-context-menu-item,
#arcane-root.arcane-theme-neon .neon-menubar-item,
#arcane-root.arcane-theme-neon .neon-select-option,
#arcane-root.arcane-theme-neon .neon-select-item,
#arcane-root.arcane-theme-neon .neon-command-item {
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  border: 1px solid transparent;
  transition: background 0.14s ease, border-color 0.14s ease, color 0.14s ease, box-shadow 0.14s ease;
}

#arcane-root.arcane-theme-neon .neon-sidebar-item:hover,
#arcane-root.arcane-theme-neon .neon-dropdown-item:hover,
#arcane-root.arcane-theme-neon .neon-context-menu-item:hover,
#arcane-root.arcane-theme-neon .neon-menubar-item:hover,
#arcane-root.arcane-theme-neon .neon-select-option:hover,
#arcane-root.arcane-theme-neon .neon-select-item:hover,
#arcane-root.arcane-theme-neon .neon-command-item:hover {
  border-color: color-mix(in srgb, var(--neon-accent) 32%, transparent);
  background: color-mix(in srgb, var(--neon-accent) 10%, transparent) !important;
  color: var(--foreground);
}

#arcane-root.arcane-theme-neon .neon-sidebar-item.selected,
#arcane-root.arcane-theme-neon .neon-sidebar-item.active,
#arcane-root.arcane-theme-neon .neon-command-item.selected,
#arcane-root.arcane-theme-neon .neon-select-option.selected,
#arcane-root.arcane-theme-neon .neon-select-item.selected {
  border-color: var(--neon-panel-border-hot);
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-accent) 14%, transparent), color-mix(in srgb, var(--neon-accent-cool) 8%, transparent)) !important;
  color: var(--foreground);
  box-shadow: inset 2px 0 0 var(--neon-accent), var(--neon-glow-sm);
}

#arcane-root.arcane-theme-neon .neon-separator,
#arcane-root.arcane-theme-neon .neon-dropdown-divider,
#arcane-root.arcane-theme-neon .neon-context-menu-separator,
#arcane-root.arcane-theme-neon .neon-menubar-separator,
#arcane-root.arcane-theme-neon .neon-sidebar-separator {
  background: linear-gradient(90deg, transparent, var(--neon-panel-border-hot), transparent) !important;
  height: 1px !important;
}

#arcane-root.arcane-theme-neon .neon-separator-with-label span {
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  border: 1px solid var(--neon-control-border);
  background: color-mix(in srgb, var(--card) 86%, transparent);
  color: var(--neon-accent);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  font-size: 0.75rem;
}

#arcane-root.arcane-theme-neon .neon-skeleton,
#arcane-root.arcane-theme-neon .neon-skeleton-card {
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  background:
    linear-gradient(100deg, color-mix(in srgb, var(--foreground) 6%, transparent) 8%, color-mix(in srgb, var(--neon-accent) 12%, transparent) 22%, color-mix(in srgb, var(--foreground) 6%, transparent) 36%),
    color-mix(in srgb, var(--card) 80%, transparent) !important;
  background-size: 240% 100%, auto !important;
}

html.light #arcane-root.arcane-theme-neon {
  --neon-surface-0: var(--background);
  --neon-grid-line: color-mix(in srgb, var(--neon-accent) 8%, transparent);
  --neon-panel-surface: color-mix(in srgb, #ffffff 92%, var(--neon-accent));
  --neon-panel-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), transparent 70%);
  --neon-control-surface: color-mix(in srgb, #ffffff 96%, var(--neon-accent));
  --neon-control-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 4%, transparent), transparent 75%);
  --neon-panel-border: color-mix(in srgb, var(--neon-accent) 30%, var(--border));
  --neon-panel-border-hot: color-mix(in srgb, var(--neon-accent) 60%, var(--border));
  --neon-control-border: color-mix(in srgb, var(--neon-accent) 22%, var(--border));
  --neon-shadow-sm: 0 4px 10px color-mix(in srgb, var(--neon-accent) 7%, transparent);
  --neon-shadow-md: 0 10px 24px color-mix(in srgb, var(--neon-accent) 10%, transparent);
  --neon-shadow-lg: 0 20px 36px color-mix(in srgb, var(--neon-accent) 12%, transparent);
  --neon-glow-sm: 0 0 12px color-mix(in srgb, var(--neon-accent) 14%, transparent);
  --neon-glow-md: 0 0 18px color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --neon-glow-lg: 0 0 26px color-mix(in srgb, var(--neon-accent) 22%, transparent);
  --neon-inset: inset 0 1px 0 rgba(255, 255, 255, 0.7);
  --neon-inset-strong: inset 0 1px 0 rgba(255, 255, 255, 0.85);
}

html.light #arcane-root.arcane-theme-neon::before {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -2;
  pointer-events: none;
  background-image:
    radial-gradient(ellipse 60rem 40rem at 12% -8%, color-mix(in srgb, var(--neon-accent) 8%, transparent), transparent 70%),
    linear-gradient(var(--neon-grid-line) 1px, transparent 1px),
    linear-gradient(90deg, var(--neon-grid-line) 1px, transparent 1px);
  background-size: auto, 64px 64px, 64px 64px;
  background-attachment: fixed;
}

html.light #arcane-root.arcane-theme-neon::after {
  display: none;
}

.prose {
  max-width: 65ch;
  color: var(--foreground);
  font-size: 0.9375rem;
  line-height: 1.65;
}

.prose h1, .prose h2, .prose h3,
.prose h4, .prose h5, .prose h6 {
  font-family: var(--font-heading);
  color: var(--foreground);
  font-weight: 600;
  line-height: 1.3;
  margin-top: 1.75rem;
  margin-bottom: 0.75rem;
  letter-spacing: 0.02em;
}

.prose h1 {
  font-size: 1.75rem;
  margin-top: 0;
  letter-spacing: 0.04em;
}

.prose h2 {
  font-size: 1.375rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid color-mix(in srgb, var(--neon-accent) 30%, transparent);
}

.prose h3 { font-size: 1.125rem; }
.prose h4 { font-size: 1rem; }

.prose p {
  margin-bottom: 1rem;
}

.prose a {
  color: var(--neon-accent);
  text-decoration: none;
  border-bottom: 1px solid color-mix(in srgb, var(--neon-accent) 36%, transparent);
  transition: color 0.15s ease, border-color 0.15s ease;
}

.prose a:hover {
  color: var(--neon-accent-cool);
  border-bottom-color: var(--neon-accent-cool);
}

.prose strong, .prose b {
  font-weight: 600;
  color: var(--foreground);
}

.prose ul, .prose ol {
  margin-bottom: 1rem;
  padding-left: 1.5rem;
}

.prose li {
  margin-bottom: 0.375rem;
}

.prose li::marker {
  color: var(--neon-accent);
}

.prose blockquote {
  border-left: 3px solid var(--neon-accent);
  padding: 0.75rem 1rem;
  margin: 1rem 0;
  background: color-mix(in srgb, var(--neon-accent) 6%, transparent);
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
}

.prose blockquote p:last-child {
  margin-bottom: 0;
}

.prose hr {
  border: none;
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--neon-accent), transparent);
  margin: 1.75rem 0;
  opacity: 0.6;
}

.prose table {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
  font-variant-numeric: tabular-nums;
}

.prose th, .prose td {
  border: 1px solid var(--border);
  padding: 0.625rem 0.75rem;
  text-align: left;
  font-size: 0.875rem;
}

.prose th {
  background: color-mix(in srgb, var(--neon-accent) 8%, var(--muted));
  font-family: var(--font-heading);
  font-weight: 600;
  color: var(--neon-accent);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  font-size: 0.75rem;
}

.prose img {
  max-width: 100%;
  height: auto;
  border-radius: var(--radius-lg);
  margin: 1.5rem 0;
  border: 1px solid var(--border);
}

.prose pre {
  background: var(--neon-surface-1);
  border: 1px solid color-mix(in srgb, var(--neon-accent) 22%, var(--border));
  border-radius: var(--radius-md);
  padding: 1rem 1.25rem;
  overflow-x: auto;
  margin: 1rem 0;
  box-shadow: var(--neon-inset), 0 8px 24px color-mix(in srgb, var(--neon-accent) 8%, transparent);
}

.prose code {
  font-family: var(--font-mono);
  font-size: 0.875em;
}

.prose :not(pre) > code {
  background: color-mix(in srgb, var(--neon-accent) 10%, var(--muted));
  padding: 0.2rem 0.5rem;
  border-radius: var(--radius-sm);
  font-size: 0.875em;
  color: var(--neon-accent);
  border: 1px solid color-mix(in srgb, var(--neon-accent) 16%, transparent);
}

.prose .hljs-keyword { color: var(--neon-accent-hot); }
.prose .hljs-string { color: var(--neon-accent); }
.prose .hljs-number { color: var(--neon-accent-cool); }
.prose .hljs-function, .prose .hljs-title { color: var(--neon-accent-cool); }
.prose .hljs-comment { color: var(--muted-foreground); font-style: italic; }
.prose .hljs-variable { color: var(--neon-accent-hot); }
.prose .hljs-class, .prose .hljs-built_in { color: var(--neon-accent); }

#arcane-root.arcane-theme-neon h1,
#arcane-root.arcane-theme-neon h2,
#arcane-root.arcane-theme-neon h3,
#arcane-root.arcane-theme-neon h4,
#arcane-root.arcane-theme-neon h5,
#arcane-root.arcane-theme-neon h6,
#arcane-root.arcane-theme-neon .arcane-heading,
#arcane-root.arcane-theme-neon .arcane-headline,
#arcane-root.arcane-theme-neon .arcane-subheadline,
#arcane-root.arcane-theme-neon .arcane-title {
  font-family: var(--font-heading);
  letter-spacing: 0.03em;
}

#arcane-root.arcane-theme-neon .neon-button,
#arcane-root.arcane-theme-neon .neon-tabs-trigger,
#arcane-root.arcane-theme-neon .neon-tab-bar-item,
#arcane-root.arcane-theme-neon .neon-toggle-group-item {
  font-family: var(--font-heading);
}

#arcane-root.arcane-theme-neon .neon-glow {
  box-shadow: var(--neon-glow-sm);
}

#arcane-root.arcane-theme-neon .neon-glow-strong {
  box-shadow: var(--neon-glow-lg);
}

${theme == NeonTheme.rainbow ? rainbowCss : ''}

#arcane-root.arcane-theme-neon .arcane-tree-lines {
  position: relative;
  --tree-indent: 1rem;
  --tree-line-color: var(--border);
}

#arcane-root.arcane-theme-neon .arcane-tree-lines > * {
  position: relative;
  padding-left: var(--tree-indent);
}

#arcane-root.arcane-theme-neon .arcane-tree-lines > *::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  width: calc(var(--tree-indent) - 4px);
  height: 1px;
  background: var(--tree-line-color);
}

#arcane-root.arcane-theme-neon .arcane-tree-lines > *::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--tree-line-color);
}

#arcane-root.arcane-theme-neon .arcane-tree-lines > *:last-child::after {
  bottom: 50%;
}

#arcane-root.arcane-theme-neon .arcane-tree-lines > *:first-child::after {
  top: 50%;
}

#arcane-root.arcane-theme-neon .arcane-tree-lines > *:only-child::after {
  display: none;
}

#arcane-root.arcane-theme-neon .arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 70%, transparent);
}

#arcane-root.arcane-theme-neon .arcane-tree-lines .arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 50%, transparent);
}

#arcane-root.arcane-theme-neon .arcane-tree-lines .arcane-tree-lines .arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 35%, transparent);
}

$arcaneSidebarTreeStyles

$arcaneSidebarComponentStyles

$arcaneTocTreeLinesCss

$arcaneMapCss

@keyframes neon-card-appear {
  from {
    opacity: 0;
    transform: scale(0.96) translateY(8px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

.neon-game-tile--animated {
  animation: neon-card-appear 0.3s ease-out forwards;
  opacity: 0;
}

.neon-game-tile--interactive {
  transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.neon-game-tile--interactive:hover {
  transform: translateY(-3px);
  border-color: var(--neon-panel-border-hot);
  box-shadow: var(--neon-shadow-md), var(--neon-glow-md);
}

.neon-platform-icon {
  position: relative;
}

.neon-platform-icon[data-tooltip]::after {
  content: attr(data-tooltip);
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%) translateY(-4px);
  padding: 6px 10px;
  background: var(--card);
  border: 1px solid color-mix(in srgb, var(--foreground) 15%, transparent);
  border-radius: 6px;
  font-size: 12px;
  font-weight: 500;
  color: var(--foreground);
  white-space: nowrap;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.15s ease, visibility 0.15s ease, transform 0.15s ease;
  pointer-events: none;
  z-index: 100;
  box-shadow: var(--neon-shadow-sm);
}

.neon-platform-icon[data-tooltip]:hover::after {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(-8px);
}

.neon-game-tile--cta {
  border: 2px dashed color-mix(in srgb, var(--foreground) 15%, transparent);
  transition: border-color 0.2s ease, background 0.2s ease;
}

.neon-game-tile--cta:hover {
  border-color: var(--neon-panel-border-hot);
  background: color-mix(in srgb, var(--neon-accent) 5%, var(--card));
}

@media (prefers-reduced-motion: reduce) {
  #arcane-root.arcane-theme-neon *,
  #arcane-root.arcane-theme-neon *::before,
  #arcane-root.arcane-theme-neon *::after {
    animation-duration: 0.001ms !important;
    animation-iteration-count: 1 !important;
    scroll-behavior: auto !important;
    transition-duration: 0.001ms !important;
  }
}

#arcane-root.arcane-theme-neon .arcane-demo-panel {
  padding: 1.25rem !important;
  clip-path: var(--neon-panel-clip);
  border: 1px solid var(--neon-panel-border) !important;
  border-radius: var(--neon-radius-panel) !important;
  background:
    radial-gradient(circle at top left, color-mix(in srgb, var(--neon-accent-cool) 9%, transparent), transparent 18rem),
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 4%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 72%, transparent) !important;
  background-size: auto, 24px 24px, auto !important;
  box-shadow: var(--neon-shadow-sm), var(--neon-inset) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-kicker,
#arcane-root.arcane-theme-neon .arcane-demo-code-label {
  color: var(--neon-accent-cool) !important;
  text-shadow: 0 0 14px color-mix(in srgb, var(--neon-accent-cool) 24%, transparent);
}

#arcane-root.arcane-theme-neon .arcane-demo-component-chip {
  border: 1px solid color-mix(in srgb, var(--neon-accent) 32%, transparent) !important;
  border-radius: 0.375rem !important;
  background: color-mix(in srgb, var(--neon-accent) 9%, transparent) !important;
  color: var(--foreground) !important;
  box-shadow: var(--neon-inset) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-section-title {
  color: var(--foreground) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope {
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  border-radius: var(--neon-radius-panel);
  clip-path: var(--neon-panel-clip);
  border-color: var(--neon-panel-border);
  background:
    radial-gradient(circle at 12% 0%, color-mix(in srgb, var(--neon-cyan) 12%, transparent), transparent 16rem),
    radial-gradient(circle at 88% 100%, color-mix(in srgb, var(--neon-magenta) 9%, transparent), transparent 14rem),
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 6%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--neon-cyan) 5%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 70%, transparent);
  background-size: auto, auto, 28px 28px, 28px 28px, auto;
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.12),
    0 18px 42px rgba(0,0,0,0.28),
    0 0 30px color-mix(in srgb, var(--primary) 10%, transparent);
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope > .arcane-box {
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope::before {
  content: '';
  display: block;
  position: absolute;
  inset: 0;
  pointer-events: none;
  background:
    linear-gradient(90deg, var(--neon-accent), transparent 26%) top left / 42% 1px no-repeat,
    linear-gradient(180deg, var(--neon-accent), transparent 42%) top left / 1px 46% no-repeat,
    linear-gradient(270deg, var(--neon-cyan), transparent 28%) bottom right / 46% 1px no-repeat,
    linear-gradient(0deg, var(--neon-cyan), transparent 42%) bottom right / 1px 46% no-repeat;
  opacity: 0.72;
  z-index: 1;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope::after {
  content: '';
  display: block;
  position: absolute;
  inset: 0;
  pointer-events: none;
  background: repeating-linear-gradient(0deg, transparent 0 6px, color-mix(in srgb, var(--neon-cyan) 8%, transparent) 6px 7px);
  opacity: 0.2;
  z-index: 1;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-dialog-overlay,
#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-command-overlay,
#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-sheet-overlay,
#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-drawer-overlay,
#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-dropdown-backdrop {
  position: absolute !important;
  inset: 0 !important;
  z-index: 25 !important;
  border-radius: inherit;
  overflow: hidden;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-dialog-overlay {
  padding: 1rem !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-command-overlay {
  padding: 1rem !important;
  padding-top: 1rem !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-sheet,
#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-drawer {
  position: absolute !important;
  max-width: 100% !important;
  max-height: 100% !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-command-dialog {
  max-width: min(640px, calc(100% - 2rem)) !important;
  max-height: calc(100% - 2rem) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope .neon-context-menu {
  position: absolute !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-code {
  clip-path: var(--neon-panel-clip);
  border-color: var(--neon-panel-border) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 7%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 78%, transparent) !important;
  background-size: 24px 24px, auto !important;
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.1),
    0 14px 34px color-mix(in srgb, var(--primary) 10%, transparent);
}

#arcane-root.arcane-theme-neon .arcane-demo-missing {
  clip-path: var(--neon-panel-clip);
  border: 1px solid color-mix(in srgb, var(--neon-orange) 46%, var(--neon-panel-border)) !important;
  border-radius: var(--neon-radius-panel) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-orange) 12%, transparent), transparent 58%),
    color-mix(in srgb, var(--card) 84%, transparent) !important;
  color: var(--foreground) !important;
  box-shadow:
    var(--neon-inset),
    0 0 24px color-mix(in srgb, var(--neon-orange) 12%, transparent) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-missing-icon {
  border: 1px solid color-mix(in srgb, var(--neon-orange) 72%, transparent) !important;
  border-radius: 0.25rem !important;
  background: color-mix(in srgb, var(--neon-orange) 18%, transparent) !important;
  color: var(--neon-orange) !important;
  box-shadow: 0 0 16px color-mix(in srgb, var(--neon-orange) 18%, transparent) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-missing-body {
  color: var(--muted-foreground) !important;
}
#arcane-root.arcane-theme-neon {
  --kb-neon-shell-gap: 0.55rem;
  --kb-neon-sidebar-width: 14.25rem;
  --kb-neon-article-width: 66rem;
  --kb-neon-route-width: 12.25rem;
  --kb-neon-dock-top: 0.7rem;
  --kb-neon-dock-height: 2.75rem;
  --kb-neon-dock-clearance: 4.85rem;
  --kb-neon-ink: var(--foreground);
  --kb-neon-muted: var(--muted-foreground);
  --kb-neon-panel: color-mix(in srgb, var(--background) 78%, transparent);
  --kb-neon-panel-strong: color-mix(in srgb, var(--card) 86%, transparent);
  --kb-neon-panel-faint: color-mix(in srgb, var(--card) 48%, transparent);
  --kb-neon-line: color-mix(in srgb, var(--neon-accent) 24%, var(--border));
  --kb-neon-line-soft: color-mix(in srgb, var(--neon-accent) 14%, var(--border));
  --kb-neon-node: var(--neon-accent);
  --kb-neon-node-soft: color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --kb-neon-node-alt: color-mix(in srgb, var(--primary) 72%, var(--foreground));
  --kb-neon-hazard: color-mix(in srgb, var(--neon-magenta) 70%, var(--primary));
  --kb-neon-punk-hot: color-mix(in srgb, var(--neon-orange) 58%, var(--neon-magenta));
  --kb-neon-punk-cold: color-mix(in srgb, var(--neon-cyan) 68%, var(--primary));
  --kb-neon-punk-spray: color-mix(in srgb, var(--neon-magenta) 16%, transparent);
  --kb-neon-clip-lg: polygon(0 1rem, 1rem 0, 100% 0, 100% calc(100% - 1rem), calc(100% - 1rem) 100%, 0 100%);
  --kb-neon-clip-md: polygon(0 0.7rem, 0.7rem 0, 100% 0, 100% calc(100% - 0.7rem), calc(100% - 0.7rem) 100%, 0 100%);
  --kb-neon-clip-sm: polygon(0 0.45rem, 0.45rem 0, 100% 0, 100% calc(100% - 0.45rem), calc(100% - 0.45rem) 100%, 0 100%);
  --kb-neon-shadow-panel: 0 22px 70px rgba(0, 0, 0, 0.34), 0 0 32px color-mix(in srgb, var(--primary) 10%, transparent);
  --kb-neon-shadow-soft: 0 0 22px color-mix(in srgb, var(--neon-accent) 10%, transparent);
}

html.dark #arcane-root.arcane-theme-neon,
#arcane-root.dark.arcane-theme-neon {
  --background: #12151C;
  --foreground: #F2F0EA;
  --card: #191D26;
  --card-foreground: #F2F0EA;
  --card-hover: #1B222C;
  --popover: #1B222C;
  --popover-foreground: #F2F0EA;
  --muted: #191D26;
  --muted-foreground: #A8ADB6;
  --border: #3E3E42;
  --input: #2D2D30;
  --accent: #1B222C;
  --accent-foreground: #F2F0EA;
  --ring: #007ACC;
  --info: #007ACC;
  --destructive: #661B1C;
  --neon-cyan: #007ACC;
  --neon-green: #00B884;
  --neon-magenta: #661B1C;
  --neon-purple: #3E3E42;
  --neon-orange: #B86B16;
  --neon-red: #661B1C;
  --kb-neon-ink: #F2F0EA;
  --kb-neon-muted: #A8ADB6;
  --kb-neon-panel: rgba(25, 29, 38, 0.9);
  --kb-neon-panel-strong: rgba(27, 34, 44, 0.94);
  --kb-neon-panel-faint: rgba(45, 45, 48, 0.64);
  --kb-neon-line: color-mix(in srgb, var(--neon-accent) 28%, #3E3E42);
  --kb-neon-line-soft: color-mix(in srgb, var(--neon-accent) 16%, #3E3E42);
  --kb-neon-node: var(--neon-accent);
  --kb-neon-node-soft: color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --kb-neon-node-alt: color-mix(in srgb, var(--neon-accent) 74%, #F2F0EA);
  --kb-neon-hazard: #9E2B2D;
  --kb-neon-shadow-panel: 0 22px 70px rgba(0, 0, 0, 0.5), 0 0 24px color-mix(in srgb, var(--neon-accent) 8%, transparent);
  --kb-neon-shadow-soft: 0 0 18px color-mix(in srgb, var(--neon-accent) 10%, transparent);
}

html.light #arcane-root.arcane-theme-neon,
#arcane-root.light.arcane-theme-neon {
  --background: #f3f6fb;
  --foreground: #101a3a;
  --card: #fbfdff;
  --card-foreground: #101a3a;
  --popover: #ffffff;
  --popover-foreground: #101a3a;
  --muted: #e8eefb;
  --muted-foreground: #52638d;
  --border: #c6d4f6;
  --input: #b7c8f2;
  --primary: #244ed1;
  --primary-rgb: 36, 78, 209;
  --primary-foreground: #ffffff;
  --accent: #e7eefc;
  --accent-foreground: #173a9f;
  --ring: #244ed1;
  --neon-cyan: #84a5f2;
  --neon-green: #1d8f73;
  --neon-magenta: #7a4ce0;
  --neon-purple: #4d42c9;
  --neon-orange: #ff6600;
  --neon-red: #c83136;
  --kb-neon-ink: #101a3a;
  --kb-neon-muted: #52638d;
  --kb-neon-panel: rgba(243, 246, 251, 0.82);
  --kb-neon-panel-strong: rgba(255, 255, 255, 0.94);
  --kb-neon-panel-faint: rgba(226, 235, 254, 0.74);
  --kb-neon-line: color-mix(in srgb, var(--neon-accent) 24%, var(--border));
  --kb-neon-line-soft: color-mix(in srgb, var(--neon-accent) 14%, var(--border));
  --kb-neon-node: var(--neon-accent);
  --kb-neon-node-soft: color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --kb-neon-node-alt: color-mix(in srgb, var(--neon-accent) 74%, var(--foreground));
  --kb-neon-hazard: #ff6600;
  --kb-neon-shadow-panel: 0 18px 42px color-mix(in srgb, var(--neon-accent) 12%, transparent), 0 1px 0 rgba(255, 255, 255, 0.95);
  --kb-neon-shadow-soft: 0 10px 24px color-mix(in srgb, var(--neon-accent) 10%, transparent);
}

#arcane-root.arcane-theme-neon .kb-page-shell {
  background:
    linear-gradient(115deg, transparent 0 58%, color-mix(in srgb, var(--kb-neon-punk-cold) 10%, transparent) 58% 58.45%, transparent 58.45% 100%),
    repeating-linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-punk-cold) 5%, transparent) 0 1px, transparent 1px 4.8rem),
    repeating-linear-gradient(0deg, color-mix(in srgb, var(--foreground) 2.4%, transparent) 0 1px, transparent 1px 0.72rem),
    radial-gradient(circle at 12% 7%, color-mix(in srgb, var(--primary) 14%, transparent), transparent 28rem),
    radial-gradient(circle at 90% 9%, color-mix(in srgb, var(--neon-cyan) 10%, transparent), transparent 31rem),
    radial-gradient(circle at 74% 88%, color-mix(in srgb, var(--neon-magenta) 7%, transparent), transparent 34rem),
    transparent;
}

html.dark #arcane-root.arcane-theme-neon::before {
  background-image:
    radial-gradient(circle at 18% 8%, rgba(0, 122, 204, 0.08), transparent 30rem),
    radial-gradient(circle at 82% 2%, rgba(27, 34, 44, 0.72), transparent 32rem),
    radial-gradient(circle at 70% 78%, rgba(102, 27, 28, 0.08), transparent 36rem),
    linear-gradient(rgba(0, 122, 204, 0.035) 1px, transparent 1px),
    linear-gradient(90deg, rgba(0, 122, 204, 0.035) 1px, transparent 1px) !important;
  background-size: auto, auto, auto, 96px 96px, 96px 96px !important;
}

html.dark #arcane-root.arcane-theme-neon::after {
  opacity: 0.045 !important;
  background:
    linear-gradient(rgba(255,255,255,0.018) 1px, transparent 1px) !important;
  background-size: 100% 6px !important;
}

html.light #arcane-root.arcane-theme-neon .kb-page-shell,
#arcane-root.light.arcane-theme-neon .kb-page-shell {
  background:
    linear-gradient(115deg, transparent 0 58%, rgba(36, 78, 209, 0.1) 58% 58.45%, transparent 58.45% 100%),
    repeating-linear-gradient(90deg, rgba(36, 78, 209, 0.045) 0 1px, transparent 1px 4.8rem),
    radial-gradient(circle at 10% 8%, rgba(132, 165, 242, 0.2), transparent 25rem),
    radial-gradient(circle at 92% 12%, rgba(36, 78, 209, 0.13), transparent 26rem),
    radial-gradient(circle at 78% 86%, rgba(122, 76, 224, 0.06), transparent 25rem),
    linear-gradient(135deg, #f3f6fb 0%, #eef3fd 46%, #fbfdff 100%);
}

#arcane-root.arcane-theme-neon .kb-scaffold {
  min-height: 100vh !important;
  padding: 0 !important;
}

#arcane-root.arcane-theme-neon .neon-kb-mobile-dock {
  display: none;
}

#arcane-root.arcane-theme-neon .neon-kb-stage {
  display: grid !important;
  grid-template-columns: minmax(12.5rem, var(--kb-neon-sidebar-width)) minmax(0, calc(var(--kb-neon-article-width) + var(--kb-neon-route-width) + 1.7rem)) !important;
  align-items: start !important;
  justify-content: center !important;
  gap: clamp(1rem, 1.8vw, 1.65rem) !important;
  width: 100% !important;
  max-width: calc(var(--kb-neon-sidebar-width) + var(--kb-neon-article-width) + var(--kb-neon-route-width) + 4.4rem) !important;
  margin: 0 auto !important;
  padding: clamp(0.9rem, 1.6vw, 1.55rem) clamp(0.75rem, 1.8vw, 1.6rem) 4.5rem !important;
}

#arcane-root.arcane-theme-neon .neon-kb-nav-rail {
  position: sticky;
  top: clamp(0.65rem, 1.4vw, 1.05rem);
  z-index: 12;
  min-width: 0;
  align-self: start;
}

#arcane-root.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar {
  position: relative !important;
  top: auto !important;
  width: 100% !important;
  min-width: 0 !important;
  max-height: calc(100vh - 2rem) !important;
  overflow: visible !important;
}

#arcane-root.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar-panel {
  position: relative !important;
  display: grid;
  grid-template-rows: auto minmax(0, 1fr);
  min-height: 0 !important;
  max-height: calc(100vh - 2rem) !important;
  overflow: hidden !important;
  clip-path: polygon(0.75rem 0, calc(100% - 0.85rem) 0, 100% 0.85rem, 100% calc(100% - 0.7rem), calc(100% - 0.7rem) 100%, 0 100%, 0 0.75rem) !important;
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 26%, var(--border)) !important;
  border-left: 1px solid color-mix(in srgb, var(--kb-neon-punk-cold) 44%, var(--kb-neon-node)) !important;
  border-radius: 0 !important;
  background:
    linear-gradient(180deg, color-mix(in srgb, var(--kb-neon-panel-strong) 86%, transparent), color-mix(in srgb, var(--background) 78%, transparent)),
    radial-gradient(circle at 0 0, color-mix(in srgb, var(--kb-neon-punk-cold) 14%, transparent), transparent 11rem) !important;
  box-shadow:
    inset 0 1px 0 color-mix(in srgb, var(--foreground) 6%, transparent),
    inset 1px 0 0 color-mix(in srgb, var(--kb-neon-node) 20%, transparent),
    0 18px 42px color-mix(in srgb, #000000 24%, transparent),
    0 0 24px color-mix(in srgb, var(--kb-neon-node) 7%, transparent) !important;
}

#arcane-root.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar-panel::before {
  content: '';
  position: absolute;
  top: 4.1rem;
  bottom: 0.9rem;
  left: 1.03rem;
  width: 1px;
  background: linear-gradient(180deg, transparent, color-mix(in srgb, var(--kb-neon-node) 38%, transparent), transparent);
  opacity: 0.55;
  pointer-events: none;
}

#arcane-root.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar-panel::after {
  content: '';
  position: absolute;
  top: 0.55rem;
  right: 0.72rem;
  width: 2.7rem;
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--kb-neon-node), transparent);
  box-shadow: 0 0 14px color-mix(in srgb, var(--kb-neon-node) 22%, transparent);
  pointer-events: none;
}

#arcane-root.arcane-theme-neon .neon-kb-nav-head {
  position: relative;
  z-index: 1;
  padding: 0.72rem 0.7rem 0.64rem;
  border-bottom: 1px solid color-mix(in srgb, var(--kb-neon-node) 18%, transparent);
  background: linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-node) 12%, transparent), transparent 76%);
}

#arcane-root.arcane-theme-neon .neon-kb-nav-brand {
  display: grid;
  grid-template-columns: 2.1rem minmax(0, 1fr);
  align-items: center;
  gap: 0.62rem;
  color: var(--foreground);
  text-decoration: none;
}

#arcane-root.arcane-theme-neon .neon-kb-brand-glyph {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 1.85rem;
  height: 1.85rem;
  clip-path: polygon(0.28rem 0, 100% 0, 100% calc(100% - 0.28rem), calc(100% - 0.28rem) 100%, 0 100%, 0 0.28rem);
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 62%, transparent);
  background: color-mix(in srgb, var(--kb-neon-node) 16%, var(--background));
  color: var(--kb-neon-node-alt);
  font-family: var(--font-mono);
  font-size: 0.78rem;
  font-weight: 820;
  line-height: 1;
  box-shadow:
    inset 0 0 0 1px color-mix(in srgb, var(--foreground) 6%, transparent),
    0 0 16px color-mix(in srgb, var(--kb-neon-node) 18%, transparent);
}

#arcane-root.arcane-theme-neon .neon-kb-brand-stack {
  display: grid;
  min-width: 0;
  gap: 0.18rem;
}

#arcane-root.arcane-theme-neon .neon-kb-brand-name {
  min-width: 0;
  overflow: hidden;
  color: var(--kb-neon-ink);
  font-family: var(--font-heading);
  font-size: 0.8rem;
  font-weight: 820;
  letter-spacing: 0;
  line-height: 1;
  text-overflow: ellipsis;
  text-transform: uppercase;
  white-space: nowrap;
}

#arcane-root.arcane-theme-neon .neon-kb-brand-code {
  color: color-mix(in srgb, var(--kb-neon-node) 74%, var(--kb-neon-muted));
  font-family: var(--font-mono);
  font-size: 0.58rem;
  font-weight: 760;
  letter-spacing: 0.1em;
  line-height: 1;
  text-transform: uppercase;
  white-space: nowrap;
}

#arcane-root.arcane-theme-neon .sidebar-brand,
#arcane-root.arcane-theme-neon .sidebar-brand-subtitle {
  display: none !important;
}

#arcane-root.arcane-theme-neon .sidebar-header {
  display: none !important;
}

#arcane-root.arcane-theme-neon .sidebar-nav {
  position: relative;
  z-index: 1;
  display: grid;
  gap: 0.32rem !important;
  max-height: calc(100vh - 6.4rem);
  overflow-y: auto;
  padding: 0.62rem 0.52rem 0.82rem !important;
}

#arcane-root.arcane-theme-neon .sidebar-section-header {
  color: color-mix(in srgb, var(--foreground) 74%, var(--kb-neon-node));
  font-family: var(--font-mono);
  font-size: 0.64rem;
  font-weight: 760;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

#arcane-root.arcane-theme-neon .sidebar-tree {
  margin-left: 0 !important;
  padding-left: 0.48rem !important;
  gap: 0.1rem !important;
}

#arcane-root.arcane-theme-neon .sidebar-tree .sidebar-tree {
  padding-left: 0.42rem !important;
}

#arcane-root.arcane-theme-neon .sidebar-tree > .sidebar-tree-item,
#arcane-root.arcane-theme-neon .sidebar-tree > .sidebar-section {
  position: relative;
  margin: 0.14rem 0 !important;
}

#arcane-root.arcane-theme-neon .sidebar-tree > .sidebar-tree-item::before,
#arcane-root.arcane-theme-neon .sidebar-tree > .sidebar-tree-item::after,
#arcane-root.arcane-theme-neon .sidebar-tree > .sidebar-section::before,
#arcane-root.arcane-theme-neon .sidebar-tree > .sidebar-section::after,
#arcane-root.arcane-theme-neon .sidebar-tree .sidebar-details[open] > .sidebar-tree::before {
  content: none !important;
  display: none !important;
}

#arcane-root.arcane-theme-neon .sidebar-link,
#arcane-root.arcane-theme-neon .sidebar-summary {
  position: relative;
  min-height: 1.95rem;
  margin: 0 !important;
  padding: 0.42rem 0.56rem 0.42rem 0.88rem !important;
  clip-path: polygon(0.3rem 0, calc(100% - 0.16rem) 0, 100% calc(100% - 0.34rem), calc(100% - 0.34rem) 100%, 0 100%, 0 0.3rem) !important;
  border: 1px solid transparent !important;
  border-radius: 0 !important;
  background: transparent !important;
  color: var(--kb-neon-muted);
  font-size: 0.82rem;
  line-height: 1.15;
  transition: background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease, color 0.15s ease;
}

#arcane-root.arcane-theme-neon .sidebar-summary {
  color: color-mix(in srgb, var(--kb-neon-ink) 82%, var(--kb-neon-node));
  font-size: 0.72rem;
  font-weight: 760;
  text-transform: uppercase;
}

#arcane-root.arcane-theme-neon .sidebar-tree .sidebar-link::before,
#arcane-root.arcane-theme-neon .sidebar-tree .sidebar-summary::before {
  content: '';
  position: absolute;
  left: 0.32rem;
  top: 50%;
  width: 0.28rem;
  height: 0.28rem;
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 38%, transparent);
  background: color-mix(in srgb, var(--background) 72%, transparent);
  transform: translateY(-50%) rotate(45deg);
}

#arcane-root.arcane-theme-neon .sidebar-link:hover,
#arcane-root.arcane-theme-neon .sidebar-summary:hover,
#arcane-root.arcane-theme-neon .sidebar-link.active {
  border-color: color-mix(in srgb, var(--kb-neon-node) 34%, transparent) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-node) 14%, transparent), color-mix(in srgb, var(--kb-neon-panel-faint) 64%, transparent)) !important;
  color: var(--kb-neon-node-alt);
  box-shadow:
    inset 2px 0 0 color-mix(in srgb, var(--kb-neon-punk-cold) 74%, transparent),
    0 0 18px color-mix(in srgb, var(--kb-neon-node) 10%, transparent);
}

#arcane-root.arcane-theme-neon .sidebar-link:hover::before,
#arcane-root.arcane-theme-neon .sidebar-summary:hover::before,
#arcane-root.arcane-theme-neon .sidebar-link.active::before {
  border-color: var(--kb-neon-node);
  background: var(--kb-neon-node);
  box-shadow: 0 0 12px color-mix(in srgb, var(--kb-neon-node) 30%, transparent);
}

#arcane-root.arcane-theme-neon .neon-kb-main-frame {
  min-width: 0 !important;
  width: 100% !important;
  padding: 0 !important;
  margin: 0 !important;
}

#arcane-root.arcane-theme-neon .neon-kb-content-area {
  position: relative;
  display: grid !important;
  grid-template-columns: minmax(0, var(--kb-neon-article-width)) minmax(10.5rem, var(--kb-neon-route-width)) !important;
  grid-template-rows: 3.45rem auto !important;
  align-items: start !important;
  gap: 0 clamp(1.05rem, 1.8vw, 1.7rem) !important;
  width: 100% !important;
  max-width: calc(var(--kb-neon-article-width) + var(--kb-neon-route-width) + 1.7rem) !important;
  margin: 0 auto !important;
  padding: 0 0 4.8rem !important;
}

#arcane-root.arcane-theme-neon .neon-kb-command-layer {
  grid-column: 1;
  grid-row: 1;
  position: sticky;
  top: clamp(0.55rem, 1.2vw, 0.85rem);
  z-index: 32;
  display: flex;
  align-items: start;
  justify-content: center;
  min-width: 0;
  height: 3.45rem;
  pointer-events: none;
}

#arcane-root.arcane-theme-neon .neon-kb-command-drawer {
  position: relative;
  z-index: 1;
  display: grid !important;
  grid-template-columns: minmax(11.5rem, 1fr) minmax(21rem, 32rem) minmax(5.6rem, 1fr);
  align-items: center;
  width: 100%;
  gap: clamp(0.38rem, 0.7vw, 0.68rem);
  pointer-events: none;
  overflow: visible;
  border: 0;
  background: transparent !important;
  box-shadow: none !important;
  backdrop-filter: none;
  -webkit-backdrop-filter: none;
}

#arcane-root.arcane-theme-neon .neon-kb-command-drawer::before {
  display: none;
}

#arcane-root.arcane-theme-neon .neon-kb-command-drawer::after {
  display: none;
}

#arcane-root.arcane-theme-neon .neon-kb-floating-search {
  grid-column: 2;
  justify-self: stretch;
  min-width: 0;
  pointer-events: auto;
}

#arcane-root.arcane-theme-neon .neon-kb-floating-controls {
  display: flex;
  align-items: center;
  min-width: 0;
  pointer-events: auto;
}

#arcane-root.arcane-theme-neon .neon-kb-floating-controls-left {
  grid-column: 1;
  justify-self: end;
}

#arcane-root.arcane-theme-neon .neon-kb-floating-controls-right {
  grid-column: 3;
  justify-self: start;
}

#arcane-root.arcane-theme-neon .neon-kb-command-drawer .kb-search {
  display: block;
  width: 100%;
  min-width: 0;
  height: 2.42rem;
  margin: 0;
  clip-path: polygon(0.62rem 0, calc(100% - 0.34rem) 0, 100% 0.34rem, 100% calc(100% - 0.62rem), calc(100% - 0.62rem) 100%, 0.28rem 100%, 0 70%, 0 0.62rem);
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 48%, var(--border)) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-punk-cold) 18%, transparent), transparent 58%),
    linear-gradient(180deg, color-mix(in srgb, var(--foreground) 7%, transparent), transparent 46%),
    color-mix(in srgb, var(--kb-neon-panel-strong) 76%, var(--background)) !important;
  box-shadow:
    inset 0 1px 0 color-mix(in srgb, var(--foreground) 7%, transparent),
    inset 0 -1px 0 color-mix(in srgb, var(--kb-neon-node) 18%, transparent),
    0 12px 28px color-mix(in srgb, #000000 24%, transparent),
    0 0 24px color-mix(in srgb, var(--kb-neon-node) 13%, transparent);
  backdrop-filter: blur(18px) saturate(1.08);
  -webkit-backdrop-filter: blur(18px) saturate(1.08);
}

#arcane-root.arcane-theme-neon .kb-search-input {
  width: 100%;
  height: 100%;
  border: 0 !important;
  border-radius: 0 !important;
  background: transparent !important;
  color: var(--foreground);
  padding-left: 2.18rem;
  font-family: var(--font-body);
  font-size: 0.86rem;
  font-weight: 560;
  box-shadow: none !important;
}

#arcane-root.arcane-theme-neon .kb-search-input-wrap {
  height: 100%;
}

#arcane-root.arcane-theme-neon .kb-search-icon {
  color: color-mix(in srgb, var(--kb-neon-node) 78%, var(--foreground));
}

#arcane-root.arcane-theme-neon .neon-kb-command-controls {
  display: flex;
  align-items: stretch;
  gap: 0.52rem;
  min-width: 0;
}

#arcane-root.arcane-theme-neon .kb-style-switcher {
  position: relative;
  display: inline-flex;
  align-items: center;
  flex: 0 0 auto;
  flex-wrap: nowrap;
  height: 2.42rem;
  gap: 1px;
  padding: 0.18rem;
  clip-path: polygon(0.58rem 0, 100% 0, 100% calc(100% - 0.58rem), calc(100% - 0.58rem) 100%, 0 100%, 0 0.58rem);
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 42%, var(--border));
  border-radius: 0;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-punk-hot) 10%, transparent), transparent 72%),
    color-mix(in srgb, var(--kb-neon-panel-strong) 76%, var(--background));
  box-shadow:
    inset 0 1px 0 color-mix(in srgb, var(--foreground) 6%, transparent),
    inset 0 -1px 0 color-mix(in srgb, var(--kb-neon-node) 14%, transparent),
    0 12px 28px color-mix(in srgb, #000000 22%, transparent),
    0 0 18px color-mix(in srgb, var(--kb-neon-node) 9%, transparent);
  backdrop-filter: blur(18px) saturate(1.08);
  -webkit-backdrop-filter: blur(18px) saturate(1.08);
}

#arcane-root.arcane-theme-neon .neon-kb-command-controls .kb-style-switcher {
  flex: 1 1 auto;
}

#arcane-root.arcane-theme-neon .neon-kb-floating-controls .kb-style-switcher {
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-punk-hot) 10%, transparent), transparent 72%),
    color-mix(in srgb, var(--kb-neon-panel-strong) 76%, var(--background));
}

#arcane-root.arcane-theme-neon .kb-stylesheet-select,
#arcane-root.arcane-theme-neon .kb-palette-select {
  height: 2.04rem;
  min-width: 6.15rem;
  outline: 0;
  padding: 0 1.36rem 0 0.64rem;
  appearance: none;
  -webkit-appearance: none;
  clip-path: polygon(0.36rem 0, 100% 0, 100% calc(100% - 0.36rem), calc(100% - 0.36rem) 100%, 0 100%, 0 0.36rem);
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 26%, transparent) !important;
  border-radius: 0 !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-node) 12%, transparent), transparent 55%),
    linear-gradient(45deg, transparent 50%, currentColor 50%),
    linear-gradient(135deg, currentColor 50%, transparent 50%),
    color-mix(in srgb, var(--background) 58%, transparent) !important;
  background-position:
    0 0,
    calc(100% - 0.82rem) 52%,
    calc(100% - 0.58rem) 52%,
    0 0 !important;
  background-repeat: no-repeat !important;
  background-size: auto, 0.28rem 0.28rem, 0.28rem 0.28rem, auto !important;
  color: var(--foreground);
  font-family: var(--font-heading);
  font-size: 0.76rem;
  font-weight: 680;
  letter-spacing: 0;
}

#arcane-root.arcane-theme-neon .kb-palette-select {
  min-width: 5.25rem;
}

#arcane-root.arcane-theme-neon .neon-kb-command-actions {
  display: flex;
  align-items: stretch;
  gap: 0.4rem;
}

#arcane-root.arcane-theme-neon .kb-topbar-github,
#arcane-root.arcane-theme-neon .kb-theme-toggle,
#arcane-root.arcane-theme-neon .kb-hamburger {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 2.42rem;
  height: 2.42rem;
  clip-path: polygon(0.46rem 0, 100% 0, 100% calc(100% - 0.46rem), calc(100% - 0.46rem) 100%, 0 100%, 0 0.46rem);
  border-radius: 0 !important;
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 42%, var(--border)) !important;
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-punk-cold) 12%, transparent), transparent 58%),
    color-mix(in srgb, var(--kb-neon-panel-strong) 76%, var(--background)) !important;
  color: var(--foreground);
  box-shadow:
    inset 0 1px 0 color-mix(in srgb, var(--foreground) 6%, transparent),
    inset 0 -1px 0 color-mix(in srgb, var(--kb-neon-node) 14%, transparent),
    0 12px 28px color-mix(in srgb, #000000 22%, transparent),
    0 0 18px color-mix(in srgb, var(--kb-neon-node) 9%, transparent) !important;
  backdrop-filter: blur(18px) saturate(1.08);
  -webkit-backdrop-filter: blur(18px) saturate(1.08);
}

#arcane-root.arcane-theme-neon .kb-theme-toggle:hover,
#arcane-root.arcane-theme-neon .kb-topbar-github:hover,
#arcane-root.arcane-theme-neon .kb-hamburger:hover,
#arcane-root.arcane-theme-neon .kb-stylesheet-select:hover,
#arcane-root.arcane-theme-neon .kb-palette-select:hover {
  border-color: color-mix(in srgb, var(--kb-neon-node) 42%, transparent) !important;
  background: color-mix(in srgb, var(--kb-neon-node) 12%, var(--background)) !important;
  color: var(--kb-neon-node-alt);
}

#arcane-root.arcane-theme-neon .neon-kb-article-lane {
  grid-column: 1;
  grid-row: 2;
  min-width: 0;
  width: 100%;
}

#arcane-root.arcane-theme-neon .neon-kb-content-stack {
  display: grid;
  align-items: start;
  min-width: 0;
  width: 100%;
  gap: 1rem;
}

#arcane-root.arcane-theme-neon .kb-article-panel {
  position: relative;
  min-width: 0 !important;
  width: 100% !important;
  max-width: none !important;
  padding: clamp(0.2rem, 0.6vw, 0.5rem) !important;
  clip-path: none !important;
  border: 0 !important;
  border-radius: 0 !important;
  background: transparent !important;
  box-shadow: none !important;
  backdrop-filter: none !important;
  -webkit-backdrop-filter: none !important;
}

#arcane-root.arcane-theme-neon .kb-article-panel::before {
  content: none !important;
  display: none !important;
}

#arcane-root.arcane-theme-neon .kb-page-title {
  position: relative;
  display: inline-block;
  text-shadow: none;
}

#arcane-root.arcane-theme-neon .kb-page-title::after {
  content: '';
  position: absolute;
  left: 0;
  right: -0.8rem;
  bottom: -0.36rem;
  height: 0.14rem;
  background: linear-gradient(90deg, var(--kb-neon-node), color-mix(in srgb, var(--kb-neon-punk-cold) 58%, transparent), transparent);
  clip-path: polygon(0 0, 100% 0, calc(100% - 0.42rem) 100%, 0.3rem 100%);
  opacity: 0.88;
}

#arcane-root.arcane-theme-neon .kb-page-metadata,
#arcane-root.arcane-theme-neon .kb-tags-footer,
#arcane-root.arcane-theme-neon .kb-page-nav {
  border-color: color-mix(in srgb, var(--kb-neon-node) 16%, var(--border));
}

#arcane-root.arcane-theme-neon .prose {
  max-width: none;
}

#arcane-root.arcane-theme-neon .prose h1,
#arcane-root.arcane-theme-neon .prose h2,
#arcane-root.arcane-theme-neon .prose h3 {
  letter-spacing: 0;
  scroll-margin-top: calc(var(--kb-neon-dock-height) + 1.5rem);
  text-transform: uppercase;
}

#arcane-root.arcane-theme-neon .prose pre,
#arcane-root.arcane-theme-neon .kb-code-group,
#arcane-root.arcane-theme-neon .kb-panel,
#arcane-root.arcane-theme-neon .kb-frame,
#arcane-root.arcane-theme-neon .kb-card,
#arcane-root.arcane-theme-neon .kb-tile,
#arcane-root.arcane-theme-neon .kb-step,
#arcane-root.arcane-theme-neon .kb-banner {
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
  border-color: var(--kb-neon-line);
  box-shadow: var(--kb-neon-shadow-soft);
}

#arcane-root.arcane-theme-neon .kb-callout {
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
}

#arcane-root.arcane-theme-neon .markdown-alert {
  clip-path: polygon(0 0, 100% 0, 100% 100%, 0 100%);
  border-radius: 0.125rem;
}

#arcane-root.arcane-theme-neon .kb-page-nav {
  position: relative;
  gap: 0.8rem !important;
  padding-top: 1.15rem !important;
  border-top: 0 !important;
}

#arcane-root.arcane-theme-neon .kb-page-nav::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent, color-mix(in srgb, var(--kb-neon-node) 44%, transparent), transparent);
  box-shadow: 0 0 16px color-mix(in srgb, var(--kb-neon-node) 12%, transparent);
}

#arcane-root.arcane-theme-neon .kb-page-nav-link {
  position: relative;
  flex: 0 1 calc(50% - 0.5rem) !important;
  max-width: 25rem;
  min-height: 5rem;
  overflow: hidden;
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.48rem;
  border-color: color-mix(in srgb, var(--kb-neon-node) 22%, var(--border));
  background:
    radial-gradient(circle at 12% 0%, color-mix(in srgb, var(--kb-neon-node) 14%, transparent), transparent 11rem),
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 92%, transparent), color-mix(in srgb, var(--background) 86%, transparent)) !important;
  box-shadow:
    inset 0 1px 0 color-mix(in srgb, var(--foreground) 8%, transparent),
    0 14px 30px color-mix(in srgb, #000000 20%, transparent),
    0 0 24px color-mix(in srgb, var(--kb-neon-node) 7%, transparent);
}

#arcane-root.arcane-theme-neon .kb-page-nav-link::before {
  content: '';
  position: absolute;
  top: 0.75rem;
  width: 3.75rem;
  height: 2px;
  background: linear-gradient(90deg, var(--kb-neon-node), color-mix(in srgb, var(--kb-neon-punk-cold) 58%, transparent));
  box-shadow: 0 0 16px color-mix(in srgb, var(--kb-neon-node) 22%, transparent);
}

#arcane-root.arcane-theme-neon .kb-page-nav-prev::before {
  left: 0.95rem;
}

#arcane-root.arcane-theme-neon .kb-page-nav-next::before {
  right: 0.95rem;
}

#arcane-root.arcane-theme-neon .kb-page-nav-link:hover {
  border-color: color-mix(in srgb, var(--kb-neon-node) 46%, var(--border));
  background:
    radial-gradient(circle at 12% 0%, color-mix(in srgb, var(--kb-neon-node) 22%, transparent), transparent 12rem),
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-node-soft) 68%, transparent), color-mix(in srgb, var(--kb-neon-panel-strong) 90%, transparent)) !important;
  box-shadow:
    inset 0 1px 0 color-mix(in srgb, var(--foreground) 10%, transparent),
    0 16px 34px color-mix(in srgb, #000000 24%, transparent),
    0 0 28px color-mix(in srgb, var(--kb-neon-node) 12%, transparent);
}

#arcane-root.arcane-theme-neon .neon-kb-route-index {
  grid-column: 2;
  grid-row: 2;
  position: sticky;
  top: 4.35rem;
  display: block;
  align-self: start;
  width: 100%;
  max-height: calc(100vh - 5.25rem);
  overflow-y: auto;
  padding-bottom: 1rem;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .kb-toc-panel {
  position: static !important;
  top: auto !important;
  width: 100% !important;
  max-height: none !important;
  overflow: visible !important;
  padding: 0 !important;
  clip-path: none !important;
  border: 0 !important;
  border-radius: 0 !important;
  background: transparent !important;
  box-shadow: none !important;
  backdrop-filter: none !important;
  -webkit-backdrop-filter: none !important;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc {
  position: relative;
  padding: 0.18rem 0 0.24rem 0.78rem;
  clip-path: none;
  border: 0;
  border-left: 1px solid color-mix(in srgb, var(--kb-neon-node) 26%, transparent);
  border-radius: 0;
  background: transparent;
  box-shadow: none;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc::before {
  content: '';
  position: absolute;
  top: 0;
  bottom: 0;
  left: -1px;
  width: 1px;
  background: linear-gradient(180deg, var(--kb-neon-node), transparent 82%);
  opacity: 0.72;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-title {
  margin: 0 0 0.8rem;
  padding: 0 0 0.55rem;
  border-bottom: 1px solid color-mix(in srgb, var(--kb-neon-node) 18%, transparent);
  color: var(--foreground);
  font-family: var(--font-mono);
  font-size: 0.66rem;
  font-weight: 780;
  letter-spacing: 0.1em;
  text-transform: uppercase;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content > ul,
#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content ul ul {
  padding-left: 0;
  margin-left: 0;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content li::before,
#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content li::after {
  display: none !important;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content a {
  position: relative;
  margin: 0.1rem 0;
  padding: 0.36rem 0.34rem 0.36rem 0.85rem !important;
  border: 0;
  background: transparent;
  color: var(--kb-neon-muted);
  font-size: 0.78rem;
  line-height: 1.25;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content ul ul a {
  margin-left: 0.48rem;
  font-size: 0.74rem;
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content a::before {
  content: '';
  position: absolute;
  left: 0.12rem;
  top: 50%;
  width: 0.32rem;
  height: 0.32rem;
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 42%, transparent);
  background: transparent;
  transform: translateY(-50%);
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content a:hover,
#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content a.toc-active {
  color: var(--kb-neon-node-alt);
  background: linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-node) 10%, transparent), transparent);
}

#arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content a.toc-active::before {
  background: var(--kb-neon-node);
  border-color: var(--kb-neon-node);
  box-shadow: 0 0 12px color-mix(in srgb, var(--kb-neon-node) 30%, transparent);
}

html.light #arcane-root.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar-panel,
#arcane-root.light.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar-panel,
html.light #arcane-root.arcane-theme-neon .neon-kb-command-drawer .kb-search,
html.light #arcane-root.arcane-theme-neon .kb-style-switcher,
html.light #arcane-root.arcane-theme-neon .kb-theme-toggle,
html.light #arcane-root.arcane-theme-neon .kb-topbar-github,
html.light #arcane-root.arcane-theme-neon .kb-hamburger,
#arcane-root.light.arcane-theme-neon .neon-kb-command-drawer .kb-search,
#arcane-root.light.arcane-theme-neon .kb-style-switcher,
#arcane-root.light.arcane-theme-neon .kb-theme-toggle,
#arcane-root.light.arcane-theme-neon .kb-topbar-github,
#arcane-root.light.arcane-theme-neon .kb-hamburger {
  border-color: rgba(36, 78, 209, 0.34) !important;
  background:
    linear-gradient(135deg, rgba(36, 78, 209, 0.11), transparent 58%),
    linear-gradient(180deg, rgba(255, 255, 255, 0.72), rgba(226, 235, 255, 0.86)) !important;
  color: #101a3a;
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.92),
    inset 0 -1px 0 rgba(36, 78, 209, 0.14),
    0 12px 26px rgba(36, 78, 209, 0.1),
    0 0 18px rgba(36, 78, 209, 0.08) !important;
}

html.light #arcane-root.arcane-theme-neon .kb-stylesheet-select,
html.light #arcane-root.arcane-theme-neon .kb-palette-select,
#arcane-root.light.arcane-theme-neon .kb-stylesheet-select,
#arcane-root.light.arcane-theme-neon .kb-palette-select {
  border-color: rgba(36, 78, 209, 0.18) !important;
  background:
    linear-gradient(90deg, rgba(36, 78, 209, 0.1), transparent 62%),
    linear-gradient(45deg, transparent 50%, currentColor 50%),
    linear-gradient(135deg, currentColor 50%, transparent 50%),
    rgba(242, 246, 255, 0.7) !important;
  background-position:
    0 0,
    calc(100% - 0.82rem) 52%,
    calc(100% - 0.58rem) 52%,
    0 0 !important;
  background-repeat: no-repeat !important;
  background-size: auto, 0.28rem 0.28rem, 0.28rem 0.28rem, auto !important;
  color: #101a3a;
}

html.light #arcane-root.arcane-theme-neon .kb-search-input,
#arcane-root.light.arcane-theme-neon .kb-search-input {
  color: #111827;
}

html.light #arcane-root.arcane-theme-neon .sidebar-link,
#arcane-root.light.arcane-theme-neon .sidebar-link,
html.light #arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content a,
#arcane-root.light.arcane-theme-neon .neon-kb-route-index .toc-content a {
  color: rgba(16, 26, 58, 0.72);
}

html.light #arcane-root.arcane-theme-neon .sidebar-summary,
#arcane-root.light.arcane-theme-neon .sidebar-summary,
html.light #arcane-root.arcane-theme-neon .neon-kb-route-index .toc-title,
#arcane-root.light.arcane-theme-neon .neon-kb-route-index .toc-title {
  color: #101a3a;
}

html.light #arcane-root.arcane-theme-neon .sidebar-link:hover,
html.light #arcane-root.arcane-theme-neon .sidebar-summary:hover,
html.light #arcane-root.arcane-theme-neon .sidebar-link.active,
#arcane-root.light.arcane-theme-neon .sidebar-link:hover,
#arcane-root.light.arcane-theme-neon .sidebar-summary:hover,
#arcane-root.light.arcane-theme-neon .sidebar-link.active,
html.light #arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content a:hover,
html.light #arcane-root.arcane-theme-neon .neon-kb-route-index .toc-content a.toc-active,
#arcane-root.light.arcane-theme-neon .neon-kb-route-index .toc-content a:hover,
#arcane-root.light.arcane-theme-neon .neon-kb-route-index .toc-content a.toc-active {
  color: #173a9f;
  background: linear-gradient(90deg, rgba(132, 165, 242, 0.22), rgba(255, 255, 255, 0.64)) !important;
}

html.light #arcane-root.arcane-theme-neon .prose a,
#arcane-root.light.arcane-theme-neon .prose a {
  color: #244ed1;
}

html.light #arcane-root.arcane-theme-neon .prose h1,
html.light #arcane-root.arcane-theme-neon .prose h2,
html.light #arcane-root.arcane-theme-neon .prose h3,
#arcane-root.light.arcane-theme-neon .prose h1,
#arcane-root.light.arcane-theme-neon .prose h2,
#arcane-root.light.arcane-theme-neon .prose h3 {
  color: #101a3a;
  text-shadow: none;
}

html.light #arcane-root.arcane-theme-neon .prose code:not(pre code),
html.light #arcane-root.arcane-theme-neon .kb-kbd,
html.light #arcane-root.arcane-theme-neon .kb-tag,
#arcane-root.light.arcane-theme-neon .prose code:not(pre code),
#arcane-root.light.arcane-theme-neon .kb-kbd,
#arcane-root.light.arcane-theme-neon .kb-tag {
  background: rgba(231, 238, 252, 0.86);
  border-color: rgba(36, 78, 209, 0.16);
  color: #173a9f;
}

@media (max-width: 1250px) {
  #arcane-root.arcane-theme-neon .neon-kb-content-area {
    grid-template-columns: minmax(0, 1fr) !important;
  }

  #arcane-root.arcane-theme-neon .neon-kb-command-layer,
  #arcane-root.arcane-theme-neon .neon-kb-article-lane {
    grid-column: 1;
  }

  #arcane-root.arcane-theme-neon .neon-kb-route-index {
    display: none !important;
  }
}

@media (max-width: 980px) {
  #arcane-root.arcane-theme-neon .neon-kb-stage {
    grid-template-columns: minmax(0, 1fr) !important;
    padding: 0.75rem !important;
  }

  #arcane-root.arcane-theme-neon .neon-kb-nav-rail {
    position: static;
  }

  #arcane-root.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar {
    position: fixed !important;
    top: 0 !important;
    left: 0 !important;
    z-index: 70 !important;
    width: min(20.5rem, 88vw) !important;
    height: 100vh !important;
    transform: translateX(-105%);
    transition: transform 0.18s ease;
  }

  #arcane-root.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar.open {
    transform: translateX(0);
  }

  #arcane-root.arcane-theme-neon .neon-kb-nav-rail .kb-sidebar-panel {
    max-height: 100vh !important;
    min-height: 100vh !important;
  }

  #arcane-root.arcane-theme-neon .neon-kb-mobile-dock {
    position: sticky;
    top: 0;
    z-index: 50;
    display: flex;
    align-items: center;
    gap: 0.55rem;
    min-height: var(--kb-neon-dock-height);
    padding: 0.5rem 0.75rem;
    border-bottom: 1px solid var(--kb-neon-line);
    background:
      linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-node) 10%, transparent), transparent 16rem),
      color-mix(in srgb, var(--background) 92%, #050816);
    box-shadow: 0 10px 24px color-mix(in srgb, #000000 26%, transparent);
  }

  #arcane-root.arcane-theme-neon .neon-kb-mobile-dock .kb-topbar-brand {
    flex: 1 1 auto;
    min-width: 0;
  }

  #arcane-root.arcane-theme-neon .neon-kb-mobile-actions {
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
  }

  #arcane-root.arcane-theme-neon .kb-topbar-brand {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 0;
  }

  #arcane-root.arcane-theme-neon .kb-topbar-brand-label {
    display: none;
  }
}

@media (max-width: 760px) {
  #arcane-root.arcane-theme-neon .neon-kb-content-area {
    grid-template-rows: 5.9rem auto !important;
  }

  #arcane-root.arcane-theme-neon .neon-kb-command-layer {
    height: 5.9rem;
    top: 0.5rem;
  }

  #arcane-root.arcane-theme-neon .neon-kb-command-drawer {
    grid-template-columns: minmax(0, 1fr) auto;
    width: min(100%, calc(100vw - 1.5rem));
  }

  #arcane-root.arcane-theme-neon .neon-kb-floating-search {
    grid-column: 1 / -1;
    grid-row: 1;
  }

  #arcane-root.arcane-theme-neon .neon-kb-floating-controls-left {
    grid-column: 1;
    grid-row: 2;
    justify-self: start;
  }

  #arcane-root.arcane-theme-neon .neon-kb-floating-controls-right {
    grid-column: 2;
    grid-row: 2;
    justify-self: end;
  }

  #arcane-root.arcane-theme-neon .neon-kb-command-actions {
    display: flex;
  }

  #arcane-root.arcane-theme-neon .kb-style-switcher {
    display: grid;
    grid-template-columns: minmax(0, 1fr);
    height: auto;
  }

  #arcane-root.arcane-theme-neon .kb-stylesheet-select,
  #arcane-root.arcane-theme-neon .kb-palette-select {
    width: 100%;
  }
}

.arcane-theme-neon .toc-content a,
.neon .toc-content a {
  margin: 0.125rem 0;
  padding: 0.5rem 0.75rem 0.5rem 0.625rem !important;
  font-size: 0.8125rem;
  line-height: 1.3;
}

#arcane-root.arcane-theme-neon .kb-callout {
  border-color: color-mix(in srgb, var(--kb-callout-accent) 34%, var(--border));
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--kb-callout-accent) 6%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--kb-callout-accent) 5%, transparent) 1px, transparent 1px),
    radial-gradient(circle at 1.5rem 1.4rem, color-mix(in srgb, var(--kb-callout-accent) 26%, transparent), transparent 6rem),
    color-mix(in srgb, var(--card) 76%, transparent);
  background-size: 18px 18px, 18px 18px, auto, auto;
  border-radius: var(--arcane-radius-sm, var(--radius-md, 8px));
  box-shadow:
    0 18px 42px rgba(0, 0, 0, 0.24),
    0 0 28px color-mix(in srgb, var(--kb-callout-accent) 12%, transparent);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
}

#arcane-root.arcane-theme-neon .kb-callout::before {
  box-shadow:
    0 0 16px color-mix(in srgb, var(--kb-callout-accent) 30%, transparent),
    inset 0 0 14px color-mix(in srgb, var(--kb-callout-accent) 14%, transparent);
}

#arcane-root.arcane-theme-neon .markdown-alert {
  background: color-mix(in srgb, var(--kb-alert-accent) 6%, transparent);
  box-shadow: 0 0 18px color-mix(in srgb, var(--kb-alert-accent) 8%, transparent);
}

#arcane-root.arcane-theme-neon .kb-landing-content-area {
  padding: clamp(1.5rem, 2.5vw, 2.75rem);
}

#arcane-root.arcane-theme-neon .kb-landing-page {
  display: grid;
  gap: clamp(1.25rem, 2vw, 2rem);
  max-width: none !important;
}

#arcane-root.arcane-theme-neon .kb-landing-prose {
  display: grid;
  gap: clamp(1.65rem, 2.8vw, 2.75rem);
}

#arcane-root.arcane-theme-neon .kb-landing-prose > * + * {
  margin-top: 0;
}

#arcane-root.arcane-theme-neon .kb-landing-grid {
  gap: clamp(1.45rem, 2.6vw, 2.2rem);
  margin-top: 1.35rem;
  margin-bottom: 1.65rem;
}

#arcane-root.arcane-theme-neon .kb-landing-band {
  gap: clamp(1.6rem, 2.8vw, 2.35rem);
  margin-top: 1.35rem;
  padding: clamp(1.65rem, 2.4vw, 2.4rem);
}

#arcane-root.arcane-theme-neon .kb-landing-hero,
#arcane-root.arcane-theme-neon .kb-landing-card,
#arcane-root.arcane-theme-neon .kb-landing-band,
#arcane-root.arcane-theme-neon .kb-landing-terminal,
#arcane-root.arcane-theme-neon .kb-landing-list-item {
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
  border-color: var(--kb-neon-line);
  box-shadow: var(--kb-neon-shadow-panel);
}

#arcane-root.arcane-theme-neon .kb-landing-hero {
  min-height: 30rem;
  padding: clamp(2.25rem, 4vw, 4rem);
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 88%, transparent), color-mix(in srgb, var(--background) 74%, transparent)),
    linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-node) 16%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--kb-neon-hazard) 12%, transparent) 1px, transparent 1px);
  background-size: auto, 2.25rem 2.25rem, 2.25rem 2.25rem;
}

#arcane-root.arcane-theme-neon .kb-landing-card {
  gap: 1rem;
  padding: clamp(1.35rem, 1.75vw, 1.85rem);
}

#arcane-root.arcane-theme-neon .kb-landing-terminal-body {
  gap: 1rem;
}

#arcane-root.arcane-theme-neon .kb-landing-list {
  gap: 1.1rem;
}

#arcane-root.arcane-theme-neon .kb-landing-kicker,
#arcane-root.arcane-theme-neon .kb-landing-actions a,
#arcane-root.arcane-theme-neon .kb-landing-terminal-row,
#arcane-root.arcane-theme-neon .kb-landing-list-index {
  clip-path: var(--kb-neon-clip-sm);
  border-radius: 0.25rem;
}

#arcane-root.arcane-theme-neon .kb-landing-kicker {
  border-color: var(--kb-neon-line);
  background: var(--kb-neon-node-soft);
  color: var(--kb-neon-node-alt);
  font-family: var(--font-mono);
  text-shadow: 0 0 14px color-mix(in srgb, var(--kb-neon-node) 30%, transparent);
}

#arcane-root.arcane-theme-neon .kb-landing-hero h1 {
  color: var(--kb-neon-ink);
  text-shadow: 0 0 22px color-mix(in srgb, var(--kb-neon-node) 18%, transparent);
}

#arcane-root.arcane-theme-neon .kb-landing-primary {
  border-color: var(--kb-neon-line);
  background:
    linear-gradient(90deg, var(--kb-neon-node), color-mix(in srgb, var(--kb-neon-node-alt) 64%, var(--kb-neon-node)));
  color: #071015 !important;
  box-shadow: 0 0 24px color-mix(in srgb, var(--kb-neon-node) 24%, transparent);
}

#arcane-root.arcane-theme-neon .kb-landing-secondary,
#arcane-root.arcane-theme-neon .kb-landing-card,
#arcane-root.arcane-theme-neon .kb-landing-band,
#arcane-root.arcane-theme-neon .kb-landing-terminal {
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 90%, transparent), color-mix(in srgb, var(--kb-neon-panel) 84%, transparent));
}

#arcane-root.arcane-theme-neon .kb-landing-card h2,
#arcane-root.arcane-theme-neon .kb-landing-band h2,
#arcane-root.arcane-theme-neon .kb-landing-card a {
  color: var(--kb-neon-node-alt);
}

#arcane-root.arcane-theme-neon .kb-landing-list-index {
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 72%, var(--kb-neon-line));
  background:
    linear-gradient(135deg, var(--kb-neon-node), color-mix(in srgb, var(--kb-neon-node) 58%, var(--kb-neon-panel-strong)));
  color: var(--primary-foreground);
  box-shadow: 0 0 18px color-mix(in srgb, var(--kb-neon-node) 28%, transparent);
}


/* ============================================
   SIDEBAR (Neon overrides) - moved from arcane_jaspr base
   ============================================ */
/* ============================================
   SIDEBAR NAVIGATION - Neon v2
   Disciplined gaming-console aesthetic
   ============================================ */

.arcane-theme-neon .sidebar-header,
.neon .sidebar-header {
  padding: 0;
  gap: 0;
  border-bottom: none;
  background:
    linear-gradient(180deg, color-mix(in srgb, var(--card) 90%, transparent), color-mix(in srgb, var(--background) 72%, transparent));
  position: sticky;
  top: 0;
  z-index: 4;
  backdrop-filter: blur(12px) saturate(1.08);
  -webkit-backdrop-filter: blur(12px) saturate(1.08);
}

.arcane-theme-neon .sidebar-brand,
.neon .sidebar-brand {
  padding: 1rem 1rem 0.875rem;
  background:
    linear-gradient(180deg, color-mix(in srgb, var(--neon-accent) 8%, transparent) 0%, transparent 100%);
  border-bottom: 1px solid var(--neon-panel-border);
}

.arcane-theme-neon .sidebar-brand-title,
.neon .sidebar-brand-title {
  font-family: var(--font-heading);
  font-size: 1.0625rem;
  letter-spacing: 0.04em;
  background:
    linear-gradient(135deg, var(--foreground) 0%, color-mix(in srgb, var(--neon-accent) 70%, var(--foreground)) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.arcane-theme-neon .sidebar-brand-subtitle,
.neon .sidebar-brand-subtitle {
  font-family: var(--font-mono);
  letter-spacing: 0.16em;
  text-transform: uppercase;
  font-size: 0.5625rem;
  color: var(--neon-accent);
  opacity: 0.72;
  margin-top: 0.3125rem;
}

.arcane-theme-neon .sidebar-tabs,
.neon .sidebar-tabs {
  flex-direction: column;
  padding: 0.375rem 0;
  background: transparent;
  border-radius: 0;
  gap: 0;
  border-bottom: 1px solid var(--neon-panel-border);
}

.arcane-theme-neon .sidebar-tab,
.neon .sidebar-tab {
  font-family: var(--font-heading);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  font-size: 0.6875rem;
  padding: 0.5rem 1rem;
  border-radius: 0;
  text-align: left;
  border-left: 2px solid transparent;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease;
}

.arcane-theme-neon .sidebar-tab:hover,
.neon .sidebar-tab:hover {
  background: color-mix(in srgb, var(--neon-accent) 8%, transparent);
  border-left-color: color-mix(in srgb, var(--neon-accent-cool) 50%, transparent);
  color: var(--neon-accent-cool);
}

.arcane-theme-neon .sidebar-tab.active,
.neon .sidebar-tab.active {
  background: color-mix(in srgb, var(--neon-accent) 12%, transparent);
  color: var(--foreground);
  border-left-color: var(--neon-accent);
  box-shadow: inset 0 0 0 1px color-mix(in srgb, var(--neon-accent) 12%, transparent);
}

.arcane-theme-neon .sidebar-controls,
.neon .sidebar-controls {
  padding: 0.625rem 0.75rem;
  background: color-mix(in srgb, var(--neon-accent) 3%, transparent);
  border-bottom: 1px solid var(--neon-panel-border);
}

#arcane-root.arcane-theme-neon .neon-kb-command-dock,
#arcane-root.arcane-theme-neon .neon-kb-command-center {
  display: none !important;
}

.arcane-theme-neon .sidebar-search input,
.neon .sidebar-search input {
  font-family: var(--font-sans);
  font-size: 0.75rem;
  border: 1px solid var(--neon-control-border);
  background: color-mix(in srgb, var(--neon-accent) 4%, var(--muted));
  border-radius: var(--neon-radius-control, 0.375rem);
}

.arcane-theme-neon .sidebar-search input:focus,
.neon .sidebar-search input:focus {
  border-color: var(--neon-accent);
  box-shadow: 0 0 0 1px color-mix(in srgb, var(--neon-accent) 24%, transparent),
    0 0 12px color-mix(in srgb, var(--neon-accent) 18%, transparent);
}

.arcane-theme-neon .sidebar-theme-toggle,
.neon .sidebar-theme-toggle {
  border: 1px solid var(--neon-control-border);
  background: color-mix(in srgb, var(--neon-accent) 4%, var(--muted));
  border-radius: var(--neon-radius-control, 0.375rem);
}

.arcane-theme-neon .sidebar-theme-toggle:hover,
.neon .sidebar-theme-toggle:hover {
  color: var(--neon-accent-cool);
  border-color: var(--neon-panel-border-hot);
}

.arcane-theme-neon .sidebar-section-header,
.neon .sidebar-section-header {
  font-family: var(--font-heading);
  text-transform: uppercase;
  letter-spacing: 0.12em;
  font-size: 0.6875rem;
  color: var(--neon-accent);
  border-bottom: 1px solid var(--neon-panel-border);
  padding-bottom: 0.5rem;
  margin-bottom: 0.25rem;
  opacity: 0.86;
}

.arcane-theme-neon .sidebar-summary,
.neon .sidebar-summary {
  font-family: var(--font-heading);
  letter-spacing: 0.04em;
  color: var(--muted-foreground);
  background: color-mix(in srgb, var(--neon-accent) 5%, transparent);
  border: 1px solid var(--neon-control-border);
  border-radius: var(--neon-radius-control, 0.375rem);
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease;
}

.arcane-theme-neon .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) > .sidebar-details > .sidebar-summary,
.neon .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) > .sidebar-details > .sidebar-summary {
  color: var(--neon-accent-cool);
  background: color-mix(in srgb, var(--neon-accent) 10%, transparent);
  border-color: var(--neon-panel-border-hot);
}

.arcane-theme-neon .sidebar-details[open] > .sidebar-summary,
.neon .sidebar-details[open] > .sidebar-summary {
  color: var(--kb-neon-node-alt);
  background: color-mix(in srgb, var(--kb-neon-node) 16%, transparent);
  border-color: color-mix(in srgb, var(--kb-neon-node) 45%, transparent);
  box-shadow:
    inset 0 -1px 0 var(--kb-neon-node),
    0 0 18px color-mix(in srgb, var(--kb-neon-node) 14%, transparent);
}

.arcane-theme-neon .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) > .sidebar-details[open] > .sidebar-summary,
.neon .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) > .sidebar-details[open] > .sidebar-summary {
  color: var(--kb-neon-node-alt);
  background: color-mix(in srgb, var(--kb-neon-node) 20%, transparent);
  border-color: color-mix(in srgb, var(--kb-neon-node) 58%, transparent);
}

.arcane-theme-neon .sidebar-details[open] > .sidebar-tree::before,
.neon .sidebar-details[open] > .sidebar-tree::before {
  content: '';
  display: block;
  height: 1px;
  background:
    linear-gradient(90deg, transparent, var(--neon-panel-border), transparent);
  margin: 0.375rem 0 0.625rem 0;
}

.arcane-theme-neon .sidebar-chevron::before,
.neon .sidebar-chevron::before {
  border-color: var(--neon-accent);
  opacity: 0.78;
}

.arcane-theme-neon .sidebar-details[open] .sidebar-chevron::before,
.neon .sidebar-details[open] .sidebar-chevron::before {
  opacity: 1;
}

.arcane-theme-neon .sidebar-tree .sidebar-tree-item::before,
.neon .sidebar-tree .sidebar-tree-item::before {
  background: color-mix(in srgb, var(--neon-accent) 50%, transparent);
  opacity: 1;
  height: 1px !important;
  width: 0.75rem !important;
  top: 50%;
  left: -1rem;
}

.arcane-theme-neon .sidebar-tree .sidebar-tree-item:not(:last-child)::after,
.neon .sidebar-tree .sidebar-tree-item:not(:last-child)::after {
  background: color-mix(in srgb, var(--neon-accent) 40%, transparent);
  width: 1px !important;
  left: -1rem;
  top: calc(-0.25rem - 1px);
  bottom: calc(-0.25rem - 1px);
}

.arcane-theme-neon .sidebar-tree .sidebar-tree-item:last-child::after,
.neon .sidebar-tree .sidebar-tree-item:last-child::after {
  background: color-mix(in srgb, var(--neon-accent) 40%, transparent);
  width: 1px !important;
  left: -1rem;
  top: calc(-0.25rem - 1px);
  height: calc(50% + 0.25rem + 1px);
}

.arcane-theme-neon .sidebar-tree .sidebar-section::before,
.neon .sidebar-tree .sidebar-section::before {
  content: '';
  position: absolute;
  background: color-mix(in srgb, var(--neon-accent) 50%, transparent);
  opacity: 1;
  height: 1px !important;
  width: calc(0.75rem + 1px) !important;
  top: 50%;
  left: calc(-1rem - 1px);
}

.arcane-theme-neon .sidebar-tree .sidebar-section:not(:last-child)::after,
.neon .sidebar-tree .sidebar-section:not(:last-child)::after {
  content: '';
  position: absolute;
  background: color-mix(in srgb, var(--neon-accent) 40%, transparent);
  width: 1px !important;
  left: calc(-1rem - 1px);
  top: calc(-0.25rem - 1px);
  bottom: calc(-0.25rem - 1px);
}

.arcane-theme-neon .sidebar-tree .sidebar-section:last-child::after,
.neon .sidebar-tree .sidebar-section:last-child::after {
  content: '';
  position: absolute;
  background: color-mix(in srgb, var(--neon-accent) 40%, transparent);
  width: 1px !important;
  left: calc(-1rem - 1px);
  top: calc(-0.25rem - 1px);
  height: calc(50% + 0.25rem + 1px);
}

.arcane-theme-neon .sidebar-tree .sidebar-section,
.neon .sidebar-tree .sidebar-section {
  position: relative;
  margin: 0.25rem 0;
  padding: 0;
  border-radius: var(--neon-radius-control, 0.375rem);
  background: transparent;
  border: 1px solid transparent;
  transition: background 0.15s ease, border-color 0.15s ease;
}

.arcane-theme-neon .sidebar-tree .sidebar-section:has(.sidebar-details[open]),
.neon .sidebar-tree .sidebar-section:has(.sidebar-details[open]) {
  padding-bottom: 0.375rem;
}

.arcane-theme-neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree,
.neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree {
  padding-left: 0.875rem;
}

.arcane-theme-neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree > .sidebar-tree-item:not(:last-child)::before,
.arcane-theme-neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree > .sidebar-section:not(:last-child)::before,
.neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree > .sidebar-tree-item:not(:last-child)::before,
.neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree > .sidebar-section:not(:last-child)::before {
  display: none;
}

.arcane-theme-neon .sidebar-tree .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)),
.neon .sidebar-tree .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) {
  background: color-mix(in srgb, var(--neon-accent) 5%, transparent);
}

.arcane-theme-neon .sidebar-tree .sidebar-tree .sidebar-section,
.neon .sidebar-tree .sidebar-tree .sidebar-section {
  background: transparent;
  border-color: transparent;
}

.arcane-theme-neon .sidebar-tree .sidebar-tree .sidebar-tree .sidebar-section,
.neon .sidebar-tree .sidebar-tree .sidebar-tree .sidebar-section {
  background: transparent;
  border-color: transparent;
}

.arcane-theme-neon .sidebar-tree .sidebar-details .sidebar-summary,
.arcane-theme-neon .sidebar-tree-items .sidebar-details .sidebar-summary,
.neon .sidebar-tree .sidebar-details .sidebar-summary,
.neon .sidebar-tree-items .sidebar-details .sidebar-summary {
  font-family: var(--font-sans);
  font-size: 0.75rem;
  font-weight: 500;
  letter-spacing: 0;
  text-transform: none;
  color: var(--muted-foreground);
  background: transparent !important;
  border: none !important;
  border-radius: var(--radius-sm) !important;
  box-shadow: none !important;
  margin: 0;
  padding: 0.5rem 0.75rem 0.5rem 1.25rem !important;
  gap: 0.5rem;
}

.arcane-theme-neon .sidebar-tree .sidebar-details .sidebar-summary:hover,
.arcane-theme-neon .sidebar-tree-items .sidebar-details .sidebar-summary:hover,
.neon .sidebar-tree .sidebar-details .sidebar-summary:hover,
.neon .sidebar-tree-items .sidebar-details .sidebar-summary:hover {
  color: var(--neon-accent-cool);
}

.arcane-theme-neon .sidebar-tree .sidebar-details[open] > .sidebar-summary,
.arcane-theme-neon .sidebar-tree-items .sidebar-details[open] > .sidebar-summary,
.neon .sidebar-tree .sidebar-details[open] > .sidebar-summary,
.neon .sidebar-tree-items .sidebar-details[open] > .sidebar-summary {
  color: var(--kb-neon-node-alt);
  background: color-mix(in srgb, var(--kb-neon-node) 10%, transparent) !important;
  border-color: color-mix(in srgb, var(--kb-neon-node) 32%, transparent) !important;
  box-shadow: inset 0 -1px 0 color-mix(in srgb, var(--kb-neon-node) 54%, transparent) !important;
}

.arcane-theme-neon .sidebar-tree .sidebar-tree,
.neon .sidebar-tree .sidebar-tree {
  padding-left: 1.5rem;
  margin-left: 0;
}

.arcane-theme-neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-tree-item::before,
.arcane-theme-neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-tree-item::after,
.neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-tree-item::before,
.neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-tree-item::after {
  display: none;
}

.arcane-theme-neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-section::before,
.arcane-theme-neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-section::after,
.neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-section::before,
.neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-section::after {
  display: none;
}

.arcane-theme-neon .sidebar-tree .sidebar-link,
.neon .sidebar-tree .sidebar-link {
  font-size: 0.8125rem;
  padding: 0.5rem 0.75rem 0.5rem 1.25rem !important;
  margin: 0.125rem 0;
  border-left: none !important;
}

.arcane-theme-neon .sidebar-link,
.neon .sidebar-link {
  font-family: var(--font-sans);
  padding: 0.5rem 0.75rem;
  border-left: 2px solid transparent;
  border-radius: 0 var(--neon-radius-control, 0.375rem) var(--neon-radius-control, 0.375rem) 0;
  background: transparent;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease;
}

.arcane-theme-neon .sidebar-link:hover,
.neon .sidebar-link:hover {
  color: var(--neon-accent-cool);
  background: color-mix(in srgb, var(--neon-accent) 7%, transparent);
  border-left-color: color-mix(in srgb, var(--neon-accent-cool) 45%, transparent);
}

.arcane-theme-neon .sidebar-link.active,
.neon .sidebar-link.active {
  color: var(--kb-neon-node-alt);
  font-weight: 600;
  background: color-mix(in srgb, var(--kb-neon-node) 14%, transparent);
  border-left-color: var(--kb-neon-node);
  box-shadow: inset 2px 0 0 var(--kb-neon-node);
}
/* Neon styling for ArcaneSidebar tree lines */
.arcane-theme-neon .arcane-sidebar-submenu-content > .arcane-sidebar-item::before,
.arcane-theme-neon .arcane-sidebar-group-items > .arcane-sidebar-item::before,
.neon .arcane-sidebar-submenu-content > .arcane-sidebar-item::before,
.neon .arcane-sidebar-group-items > .arcane-sidebar-item::before {
  background: var(--primary);
  opacity: 0.6;
  height: 2px;
}

.arcane-theme-neon .arcane-sidebar-submenu-content > .arcane-sidebar-item:not(:last-child)::after,
.arcane-theme-neon .arcane-sidebar-group-items > .arcane-sidebar-item:not(:last-child)::after,
.neon .arcane-sidebar-submenu-content > .arcane-sidebar-item:not(:last-child)::after,
.neon .arcane-sidebar-group-items > .arcane-sidebar-item:not(:last-child)::after {
  background: var(--primary);
  width: 2px;
  box-shadow: none;
}

.arcane-theme-neon .arcane-sidebar-submenu-content > .arcane-sidebar-item:last-child::after,
.arcane-theme-neon .arcane-sidebar-group-items > .arcane-sidebar-item:last-child::after,
.neon .arcane-sidebar-submenu-content > .arcane-sidebar-item:last-child::after,
.neon .arcane-sidebar-group-items > .arcane-sidebar-item:last-child::after {
  background: var(--primary);
  width: 2px;
  box-shadow: none;
}

/* Neon link styling for ArcaneSidebar items */
.arcane-theme-neon .arcane-sidebar-item,
.neon .arcane-sidebar-item {
  border-left: 3px solid transparent;
  border-radius: 0 var(--radius-md) var(--radius-md) 0 !important;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease;
}

.arcane-theme-neon .arcane-sidebar-item:hover,
.neon .arcane-sidebar-item:hover {
  color: var(--primary) !important;
  background: color-mix(in srgb, var(--primary) 10%, transparent) !important;
  border-left-color: color-mix(in srgb, var(--primary) 50%, transparent);
}

.arcane-theme-neon .arcane-sidebar-item.selected,
.neon .arcane-sidebar-item.selected {
  color: var(--primary) !important;
  font-weight: 600;
  background: color-mix(in srgb, var(--primary) 15%, transparent) !important;
  border-left-color: var(--primary);
  box-shadow: inset 0 0 0 1px color-mix(in srgb, var(--primary) 14%, transparent);
}
/* ============================================
   TABLE OF CONTENTS - Neon Gaming Style
   Cyberpunk with glowing tree lines
   ============================================ */
.arcane-theme-neon .toc,
.neon .toc {
  background: color-mix(in srgb, var(--card) 82%, transparent);
  border-color: color-mix(in srgb, var(--primary) 20%, var(--border));
  box-shadow: 0 0 20px color-mix(in srgb, var(--primary) 5%, transparent);
}

.arcane-theme-neon .toc-title,
.neon .toc-title {
  font-family: var(--font-mono);
  color: var(--primary);
  border-bottom-color: color-mix(in srgb, var(--primary) 22%, transparent);
  letter-spacing: 0;
}

.arcane-theme-neon .toc-content > ul > li::before,
.arcane-theme-neon .toc-content > ul > li::after,
.arcane-theme-neon .toc-content ul ul li::before,
.arcane-theme-neon .toc-content ul ul li::after,
.neon .toc-content > ul > li::before,
.neon .toc-content > ul > li::after,
.neon .toc-content ul ul li::before,
.neon .toc-content ul ul li::after {
  background: color-mix(in srgb, var(--primary) 36%, var(--border));
  box-shadow: none;
}

.arcane-theme-neon .toc-content a,
.neon .toc-content a {
  font-size: 0.8125rem;
  line-height: 1.3;
  margin: 0.125rem 0;
  padding: 0.5rem 0.625rem !important;
  border: 1px solid transparent;
  border-radius: var(--radius-sm);
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease;
}

.arcane-theme-neon .toc-content a:hover,
.neon .toc-content a:hover {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 8%, transparent);
  border-color: color-mix(in srgb, var(--primary) 18%, transparent);
}

.arcane-theme-neon .toc-content a.toc-active,
.neon .toc-content a.toc-active {
  color: var(--primary);
  font-weight: 600;
  background: color-mix(in srgb, var(--primary) 12%, transparent);
  border-color: color-mix(in srgb, var(--primary) 24%, transparent);
  box-shadow: 0 0 8px color-mix(in srgb, var(--primary) 6%, transparent);
}

#arcane-root.arcane-theme-neon .sidebar-tree .sidebar-tree-item::after,
#arcane-root.arcane-theme-neon .sidebar-tree .sidebar-section::after,
#arcane-root.arcane-theme-neon .sidebar-details[open] > .sidebar-tree::before {
  content: none !important;
  display: none !important;
}

#arcane-root.arcane-theme-neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree,
#arcane-root.arcane-theme-neon .sidebar-tree .sidebar-tree {
  padding-left: 0.42rem !important;
}

#arcane-root.arcane-theme-neon .sidebar-tree .sidebar-tree .sidebar-tree {
  padding-left: 0.24rem !important;
}

/* ============================================
   ARCANE MAP - Neon Style
   ============================================ */

.arcane-theme-neon .arcane-world-map,
.arcane-theme-neon .arcane-usa-map,
.neon .arcane-world-map,
.neon .arcane-usa-map {
  background: color-mix(in srgb, var(--card) 92%, transparent);
  border-color: var(--neon-panel-border, var(--border));
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.34);
}

.arcane-theme-neon .arcane-world-map path[data-region]:hover,
.arcane-theme-neon .arcane-usa-map path[data-region]:hover,
.neon .arcane-world-map path[data-region]:hover,
.neon .arcane-usa-map path[data-region]:hover {
  fill: var(--primary) !important;
  opacity: 0.72;
}

.arcane-theme-neon .arcane-world-map path[data-region][data-active="true"],
.arcane-theme-neon .arcane-usa-map path[data-region][data-active="true"],
.neon .arcane-world-map path[data-region][data-active="true"],
.neon .arcane-usa-map path[data-region][data-active="true"] {
  fill: var(--primary) !important;
  opacity: 0.9;
}

.arcane-theme-neon .arcane-world-map circle[data-location],
.arcane-theme-neon .arcane-usa-map circle[data-location],
.neon .arcane-world-map circle[data-location],
.neon .arcane-usa-map circle[data-location] {
  filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.35));
}

.arcane-theme-neon .arcane-world-map circle[data-location]:hover,
.arcane-theme-neon .arcane-usa-map circle[data-location]:hover,
.neon .arcane-world-map circle[data-location]:hover,
.neon .arcane-usa-map circle[data-location]:hover {
  filter: drop-shadow(0 2px 6px rgba(0, 0, 0, 0.45));
}

.arcane-theme-neon .arcane-map-debug-tooltip > div,
.neon .arcane-map-debug-tooltip > div {
  background: color-mix(in srgb, var(--card) 96%, transparent);
  border-color: var(--neon-panel-border, var(--border));
  box-shadow: 0 10px 26px rgba(0, 0, 0, 0.42);
}

.arcane-theme-neon .arcane-map-debug-tooltip .debug-lat,
.arcane-theme-neon .arcane-map-debug-tooltip .debug-lng,
.neon .arcane-map-debug-tooltip .debug-lat,
.neon .arcane-map-debug-tooltip .debug-lng {
  color: var(--primary);
}

.arcane-theme-neon .arcane-map-debug-tooltip .debug-hint,
.neon .arcane-map-debug-tooltip .debug-hint {
  color: var(--primary);
}

''';
  }

  static const String rainbowCss = '''
@keyframes neon-rainbow-primary {
  0%, 100% { --primary: #ff5169; --ring: #e54154; }
  14%      { --primary: #ffaa1f; --ring: #e0951a; }
  28%      { --primary: #f6c43c; --ring: #e0b035; }
  42%      { --primary: #00f5a0; --ring: #00d68b; }
  57%      { --primary: #00d9ff; --ring: #00b8d9; }
  71%      { --primary: #6366f1; --ring: #4f52d4; }
  85%      { --primary: #a855f7; --ring: #9242d4; }
}

@keyframes neon-rainbow-hot {
  0%, 100% { --neon-accent-hot: #ffaa1f; }
  14%      { --neon-accent-hot: #f6c43c; }
  28%      { --neon-accent-hot: #00f5a0; }
  42%      { --neon-accent-hot: #00d9ff; }
  57%      { --neon-accent-hot: #6366f1; }
  71%      { --neon-accent-hot: #a855f7; }
  85%      { --neon-accent-hot: #ff5169; }
}

@keyframes neon-rainbow-cool {
  0%, 100% { --neon-accent-cool: #6366f1; }
  14%      { --neon-accent-cool: #a855f7; }
  28%      { --neon-accent-cool: #ff5169; }
  42%      { --neon-accent-cool: #ffaa1f; }
  57%      { --neon-accent-cool: #f6c43c; }
  71%      { --neon-accent-cool: #00f5a0; }
  85%      { --neon-accent-cool: #00d9ff; }
}

#arcane-root.neon-rainbow,
.neon-rainbow {
  animation:
    neon-rainbow-primary 16s linear infinite,
    neon-rainbow-hot 16s linear infinite,
    neon-rainbow-cool 16s linear infinite;
}

@media (prefers-reduced-motion: reduce) {
  #arcane-root.neon-rainbow,
  .neon-rainbow {
    animation: none;
  }
}
''';
}
