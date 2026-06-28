import 'package:arcane_jaspr/component/navigation/toc.dart'
    show arcaneTocTreeLinesCss;
import 'package:arcane_jaspr/component/view/map/map_style.dart' show arcaneMapCss;
import 'package:arcane_jaspr/util/content/prose_styles.dart'
    show arcaneAllDocsStyles;

import 'neon_theme.dart';

/// Component CSS for the Neon (gamer) theme.
///
/// Every rule is scoped to `#arcane-root.arcane-theme-neon` so it can never
/// affect the shadcn or neubrutalism themes. Colors come from the seeded palette
/// variables (`--primary`, `--card`, `--border`, `--shadow-*`, …) which the
/// stylesheet derives from [NeonTheme]; the `--shadow-*` tokens already carry a
/// neon glow in dark mode (via the seed's `accentGlow`). This is deliberately a
/// restrained baseline — enough to read as "gamer" while staying trivial to
/// override.
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

  static String _rgb(int argb) {
    final int r = (argb >> 16) & 0xFF;
    final int g = (argb >> 8) & 0xFF;
    final int b = argb & 0xFF;
    return '$r, $g, $b';
  }

  static String componentCss(NeonTheme theme) {
    final String cool = _hex(theme.accentCool);
    final String hot = _hex(theme.accentHot);
    final String coolRgb = _rgb(theme.accentCool);
    final String hotRgb = _rgb(theme.accentHot);

    return '''
/* ============================================================
   NEON THEME — gamer aesthetic. Scoped to .arcane-theme-neon.
   ============================================================ */

#arcane-root.arcane-theme-neon {
  --neon-cool: $cool;
  --neon-hot: $hot;
  --neon-cool-rgb: $coolRgb;
  --neon-hot-rgb: $hotRgb;
  --neon-gradient: linear-gradient(135deg, var(--primary), var(--neon-cool));
  --neon-glow-sm: 0 0 10px rgba(var(--primary-rgb), 0.35);
  --neon-glow: 0 0 18px rgba(var(--primary-rgb), 0.45);
  --neon-glow-cool: 0 0 18px rgba(var(--neon-cool-rgb), 0.45);
}

#arcane-root.arcane-theme-neon ::selection {
  background: rgba(var(--primary-rgb), 0.35);
  color: var(--foreground);
}

#arcane-root.arcane-theme-neon :focus-visible {
  outline: none;
  box-shadow: 0 0 0 2px var(--background), 0 0 0 4px rgba(var(--primary-rgb), 0.6);
}

/* ---------- Buttons ---------- */

#arcane-root.arcane-theme-neon .neon-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  font-family: inherit;
  font-weight: 600;
  line-height: 1;
  white-space: nowrap;
  border: 1px solid transparent;
  border-radius: var(--radius-md);
  cursor: pointer;
  text-decoration: none;
  transition: transform var(--transition), box-shadow var(--transition),
    background var(--transition), border-color var(--transition);
  padding: 0.5rem 1rem;
  font-size: var(--font-size-sm);
}

#arcane-root.arcane-theme-neon .neon-button[data-size="sm"] {
  padding: 0.375rem 0.75rem;
  font-size: var(--font-size-xs);
}
#arcane-root.arcane-theme-neon .neon-button[data-size="lg"] {
  padding: 0.625rem 1.25rem;
  font-size: var(--font-size-base);
}
#arcane-root.arcane-theme-neon .neon-button[data-size="iconSm"] {
  padding: 0.375rem;
  width: 2rem;
  height: 2rem;
}
#arcane-root.arcane-theme-neon .neon-button[data-size="iconMd"] {
  padding: 0.5rem;
  width: 2.5rem;
  height: 2.5rem;
}
#arcane-root.arcane-theme-neon .neon-button[data-size="iconLg"] {
  padding: 0.625rem;
  width: 3rem;
  height: 3rem;
}

#arcane-root.arcane-theme-neon .neon-button[data-variant="primary"] {
  background: var(--primary);
  color: var(--primary-foreground);
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="secondary"] {
  background: var(--secondary);
  color: var(--secondary-foreground);
  border-color: var(--border);
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="accent"] {
  background: var(--neon-cool);
  color: #04121a;
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="outline"] {
  background: transparent;
  color: var(--primary);
  border-color: color-mix(in srgb, var(--primary) 55%, var(--border));
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="ghost"] {
  background: transparent;
  color: var(--foreground);
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="link"] {
  background: transparent;
  color: var(--primary);
  padding-left: 0;
  padding-right: 0;
  text-decoration: underline;
  text-underline-offset: 3px;
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="destructive"] {
  background: var(--destructive);
  color: var(--destructive-foreground);
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="success"] {
  background: var(--success);
  color: var(--success-foreground);
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="warning"] {
  background: var(--warning);
  color: var(--warning-foreground);
}
#arcane-root.arcane-theme-neon .neon-button[data-variant="info"] {
  background: var(--info);
  color: var(--info-foreground);
}

#arcane-root.arcane-theme-neon
  .neon-button:hover:not([data-disabled="true"]):not([data-variant="link"]):not([data-variant="ghost"]) {
  transform: translateY(-1px);
  box-shadow: var(--neon-glow);
}
#arcane-root.arcane-theme-neon
  .neon-button[data-variant="outline"]:hover:not([data-disabled="true"]) {
  background: rgba(var(--primary-rgb), 0.12);
}
#arcane-root.arcane-theme-neon
  .neon-button[data-variant="ghost"]:hover:not([data-disabled="true"]) {
  background: rgba(var(--primary-rgb), 0.12);
  color: var(--primary);
}
#arcane-root.arcane-theme-neon
  .neon-button:active:not([data-disabled="true"]) {
  transform: translateY(0);
}
#arcane-root.arcane-theme-neon .neon-button[data-disabled="true"] {
  opacity: 0.5;
  cursor: not-allowed;
}

#arcane-root.arcane-theme-neon .neon-button-group {
  display: inline-flex;
  gap: 0.5rem;
}
#arcane-root.arcane-theme-neon .neon-button-panel {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

/* ---------- Surfaces (cards, popovers, menus, dialogs) ---------- */

#arcane-root.arcane-theme-neon .neon-card,
#arcane-root.arcane-theme-neon .neon-popover,
#arcane-root.arcane-theme-neon .neon-dropdown-menu,
#arcane-root.arcane-theme-neon .neon-select-dropdown,
#arcane-root.arcane-theme-neon .neon-command-dialog,
#arcane-root.arcane-theme-neon .neon-command-list,
#arcane-root.arcane-theme-neon .neon-toast,
#arcane-root.arcane-theme-neon .neon-accordion,
#arcane-root.arcane-theme-neon .neon-empty-state {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  color: var(--card-foreground);
}

#arcane-root.arcane-theme-neon .neon-card {
  position: relative;
  padding: 1.25rem;
  transition: transform var(--transition), box-shadow var(--transition),
    border-color var(--transition);
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="elevated"] {
  box-shadow: var(--shadow-md);
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="elevated"],
#arcane-root.arcane-theme-neon .neon-card[data-variant="interactive"],
#arcane-root.arcane-theme-neon .neon-card.clickable {
  overflow: hidden;
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="elevated"]::before,
#arcane-root.arcane-theme-neon .neon-card[data-variant="interactive"]::before,
#arcane-root.arcane-theme-neon .neon-card.clickable::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: var(--neon-gradient);
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="flat"] {
  box-shadow: none;
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="outlined"] {
  background: transparent;
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="ghost"] {
  background: transparent;
  border-color: transparent;
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="glass"] {
  background: color-mix(in srgb, var(--card) 55%, transparent);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="interactive"],
#arcane-root.arcane-theme-neon .neon-card.clickable {
  cursor: pointer;
}
#arcane-root.arcane-theme-neon .neon-card[data-variant="interactive"]:hover,
#arcane-root.arcane-theme-neon .neon-card.clickable:hover {
  transform: translateY(-3px);
  box-shadow: var(--shadow-lg);
  border-color: color-mix(in srgb, var(--primary) 40%, var(--border));
}

/* ---------- Dropdown / popover / command items ---------- */

#arcane-root.arcane-theme-neon .neon-dropdown-menu,
#arcane-root.arcane-theme-neon .neon-popover,
#arcane-root.arcane-theme-neon .neon-select-dropdown {
  padding: 0.35rem;
  box-shadow: var(--shadow-lg);
}
#arcane-root.arcane-theme-neon .neon-dropdown-item,
#arcane-root.arcane-theme-neon .neon-command-item,
#arcane-root.arcane-theme-neon .neon-select-option {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.45rem 0.6rem;
  border-radius: var(--radius-sm);
  cursor: pointer;
  color: var(--foreground);
  transition: background var(--transition), color var(--transition);
}
#arcane-root.arcane-theme-neon .neon-dropdown-item:hover,
#arcane-root.arcane-theme-neon .neon-command-item:hover,
#arcane-root.arcane-theme-neon .neon-command-item[aria-selected="true"],
#arcane-root.arcane-theme-neon .neon-select-option:hover {
  background: rgba(var(--primary-rgb), 0.14);
  color: var(--primary);
}
#arcane-root.arcane-theme-neon .neon-dropdown-label,
#arcane-root.arcane-theme-neon .neon-command-group-heading {
  padding: 0.35rem 0.6rem;
  font-size: var(--font-size-xs);
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: var(--muted-foreground);
}
#arcane-root.arcane-theme-neon .neon-dropdown-divider {
  height: 1px;
  background: var(--border);
  margin: 0.35rem 0;
  border: none;
}

/* ---------- Inputs ---------- */

#arcane-root.arcane-theme-neon .neon-text-input,
#arcane-root.arcane-theme-neon .neon-select-trigger,
#arcane-root.arcane-theme-neon .neon-command-input,
#arcane-root.arcane-theme-neon .neon-select-search,
#arcane-root.arcane-theme-neon .neon-otp-digit {
  width: 100%;
  background: var(--input);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  padding: 0.5rem 0.75rem;
  color: var(--foreground);
  font: inherit;
  transition: border-color var(--transition), box-shadow var(--transition);
}
#arcane-root.arcane-theme-neon .neon-otp-digit {
  width: 2.75rem;
  text-align: center;
  font-weight: 600;
}
#arcane-root.arcane-theme-neon .neon-text-input::placeholder,
#arcane-root.arcane-theme-neon .neon-command-input::placeholder {
  color: var(--muted-foreground);
}
#arcane-root.arcane-theme-neon .neon-text-input:focus,
#arcane-root.arcane-theme-neon .neon-select-trigger:focus,
#arcane-root.arcane-theme-neon .neon-command-input:focus,
#arcane-root.arcane-theme-neon .neon-select-search:focus,
#arcane-root.arcane-theme-neon .neon-otp-digit:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: 0 0 0 3px rgba(var(--primary-rgb), 0.25);
}
#arcane-root.arcane-theme-neon .neon-text-input-wrapper {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
}
#arcane-root.arcane-theme-neon .neon-text-input-error,
#arcane-root.arcane-theme-neon .neon-select-error,
#arcane-root.arcane-theme-neon .neon-radio-group-error {
  color: var(--destructive);
  font-size: var(--font-size-xs);
}
#arcane-root.arcane-theme-neon .neon-text-input-helper,
#arcane-root.arcane-theme-neon .neon-select-helper,
#arcane-root.arcane-theme-neon .neon-radio-group-helper {
  color: var(--muted-foreground);
  font-size: var(--font-size-xs);
}
#arcane-root.arcane-theme-neon .neon-select.error .neon-select-trigger,
#arcane-root.arcane-theme-neon .neon-text-input[data-error="true"] {
  border-color: var(--destructive);
}

/* ---------- Checkbox / radio / toggle ---------- */

#arcane-root.arcane-theme-neon .neon-checkbox-box {
  width: 1.1rem;
  height: 1.1rem;
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  background: var(--input);
  transition: all var(--transition);
}
#arcane-root.arcane-theme-neon .neon-checkbox-box[data-state="checked"],
#arcane-root.arcane-theme-neon input:checked + .neon-checkbox-box {
  background: var(--primary);
  border-color: var(--primary);
  box-shadow: var(--neon-glow-sm);
}
#arcane-root.arcane-theme-neon .neon-toggle-switch {
  position: relative;
  display: inline-flex;
  align-items: center;
  flex-shrink: 0;
  width: 2.5rem;
  height: 1.4rem;
  border: none;
  border-radius: var(--radius-full);
  background: var(--border);
  padding: 2px;
  cursor: pointer;
  transition: background var(--transition);
}
#arcane-root.arcane-theme-neon .neon-toggle-switch[data-state="checked"],
#arcane-root.arcane-theme-neon .neon-toggle-switch.active {
  background: var(--primary);
  box-shadow: var(--neon-glow-sm);
}
#arcane-root.arcane-theme-neon .neon-toggle-switch[data-disabled="true"] {
  opacity: 0.5;
  cursor: not-allowed;
}
#arcane-root.arcane-theme-neon .neon-toggle-thumb {
  width: 1rem;
  height: 1rem;
  border-radius: 50%;
  background: #ffffff;
  transition: transform var(--transition);
}
#arcane-root.arcane-theme-neon .neon-toggle-switch[data-state="checked"] .neon-toggle-thumb,
#arcane-root.arcane-theme-neon .neon-toggle-switch.active .neon-toggle-thumb {
  transform: translateX(1.1rem);
}
#arcane-root.arcane-theme-neon .neon-radio-button {
  width: 1.1rem;
  height: 1.1rem;
  border: 1px solid var(--border);
  border-radius: 50%;
  background: var(--input);
}
#arcane-root.arcane-theme-neon .neon-radio-option {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

/* ---------- Tabs ---------- */

#arcane-root.arcane-theme-neon .neon-tabs-list,
#arcane-root.arcane-theme-neon .neon-tab-bar {
  display: inline-flex;
  gap: 0.25rem;
  padding: 0.25rem;
  background: var(--secondary);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
}
#arcane-root.arcane-theme-neon .neon-tabs-trigger,
#arcane-root.arcane-theme-neon .neon-tab-bar-item {
  padding: 0.375rem 0.75rem;
  border: none;
  background: transparent;
  color: var(--muted-foreground);
  border-radius: var(--radius-sm);
  font: inherit;
  font-weight: 600;
  cursor: pointer;
  transition: all var(--transition);
}
#arcane-root.arcane-theme-neon .neon-tabs-trigger:hover,
#arcane-root.arcane-theme-neon .neon-tab-bar-item:hover {
  color: var(--foreground);
}
#arcane-root.arcane-theme-neon .neon-tabs-trigger.active,
#arcane-root.arcane-theme-neon .neon-tab-bar-item.active {
  background: var(--card);
  color: var(--primary);
  box-shadow: 0 0 12px rgba(var(--primary-rgb), 0.35);
}
#arcane-root.arcane-theme-neon .neon-tabs-content {
  padding-top: 1rem;
}

/* ---------- Alerts ---------- */

#arcane-root.arcane-theme-neon .neon-alert {
  display: flex;
  gap: 0.75rem;
  padding: 1rem;
  border-radius: var(--radius-lg);
  border: 1px solid var(--border);
  border-left: 3px solid var(--primary);
  background: var(--card);
}
#arcane-root.arcane-theme-neon .neon-alert[data-variant="destructive"] {
  border-left-color: var(--destructive);
}
#arcane-root.arcane-theme-neon .neon-alert[data-variant="success"] {
  border-left-color: var(--success);
}
#arcane-root.arcane-theme-neon .neon-alert[data-variant="warning"] {
  border-left-color: var(--warning);
}
#arcane-root.arcane-theme-neon .neon-alert[data-variant="info"] {
  border-left-color: var(--info);
}
#arcane-root.arcane-theme-neon .neon-alert-title {
  font-weight: 700;
}
#arcane-root.arcane-theme-neon .neon-alert-description {
  color: var(--muted-foreground);
}
#arcane-root.arcane-theme-neon .neon-alert-dismiss {
  margin-left: auto;
  background: transparent;
  border: none;
  color: var(--muted-foreground);
  cursor: pointer;
}

/* ---------- Badges / status ---------- */

#arcane-root.arcane-theme-neon .neon-badge,
#arcane-root.arcane-theme-neon .neon-status-badge,
#arcane-root.arcane-theme-neon .neon-promo-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.2rem 0.6rem;
  border-radius: var(--radius-full);
  font-size: var(--font-size-xs);
  font-weight: 700;
  letter-spacing: 0.04em;
  text-transform: uppercase;
  border: 1px solid color-mix(in srgb, var(--primary) 35%, transparent);
  background: rgba(var(--primary-rgb), 0.16);
  color: var(--primary);
}
#arcane-root.arcane-theme-neon .neon-status-indicator {
  width: 0.5rem;
  height: 0.5rem;
  border-radius: 50%;
  background: currentColor;
  box-shadow: 0 0 8px currentColor;
}
#arcane-root.arcane-theme-neon .neon-status-label {
  text-transform: uppercase;
  letter-spacing: 0.04em;
  font-weight: 700;
}

/* ---------- Progress ---------- */

#arcane-root.arcane-theme-neon .neon-progress,
#arcane-root.arcane-theme-neon .neon-progress-track {
  background: var(--secondary);
  border-radius: var(--radius-full);
  overflow: hidden;
}
#arcane-root.arcane-theme-neon .neon-progress-indicator,
#arcane-root.arcane-theme-neon .neon-progress-value {
  height: 100%;
  background: var(--neon-gradient);
  border-radius: var(--radius-full);
  box-shadow: 0 0 12px rgba(var(--primary-rgb), 0.5);
}
#arcane-root.arcane-theme-neon .neon-loading-spinner,
#arcane-root.arcane-theme-neon .neon-toast-spinner {
  color: var(--primary);
}

/* ---------- Misc components ---------- */

#arcane-root.arcane-theme-neon .neon-avatar {
  border-radius: var(--radius-full);
  border: 1px solid var(--border);
  overflow: hidden;
  background: var(--secondary);
}
#arcane-root.arcane-theme-neon .neon-avatar-status {
  border: 2px solid var(--background);
}
#arcane-root.arcane-theme-neon .neon-separator {
  background: var(--border);
  border: none;
}
#arcane-root.arcane-theme-neon .neon-separator:not(.neon-separator-vertical) {
  height: 1px;
  width: 100%;
}
#arcane-root.arcane-theme-neon .neon-separator-vertical {
  width: 1px;
  align-self: stretch;
}
#arcane-root.arcane-theme-neon .neon-kbd {
  font-family: var(--font-mono);
  font-size: 0.8em;
  padding: 0.1rem 0.4rem;
  border: 1px solid var(--border);
  border-bottom-width: 2px;
  border-radius: var(--radius-sm);
  background: var(--secondary);
  color: var(--foreground);
}
#arcane-root.arcane-theme-neon .neon-breadcrumb-separator {
  color: var(--muted-foreground);
}
#arcane-root.arcane-theme-neon .neon-empty-state {
  text-align: center;
  padding: 2rem;
}
#arcane-root.arcane-theme-neon .neon-empty-state-icon {
  color: var(--muted-foreground);
}
#arcane-root.arcane-theme-neon .neon-empty-state-title {
  font-weight: 700;
}
#arcane-root.arcane-theme-neon .neon-empty-state-description {
  color: var(--muted-foreground);
}
#arcane-root.arcane-theme-neon .neon-toast-title {
  font-weight: 700;
}
#arcane-root.arcane-theme-neon .neon-toast-description {
  color: var(--muted-foreground);
}

/* ---------- Sidebar + scaffold chrome ---------- */

#arcane-root.arcane-theme-neon .neon-sidebar {
  background: var(--card);
  border-right: 1px solid var(--border);
}
#arcane-root.arcane-theme-neon .neon-sidebar-group-label {
  text-transform: uppercase;
  letter-spacing: 0.06em;
  font-size: var(--font-size-xs);
  font-weight: 700;
  color: var(--muted-foreground);
}
#arcane-root.arcane-theme-neon .neon-sidebar-separator {
  height: 1px;
  background: var(--border);
}

/* ---------- Docs chrome layout (scaffold + kb-*) ---------- */

#arcane-root.arcane-theme-neon .arcane-scaffold {
  min-height: 100vh !important;
  display: flex !important;
  flex-direction: column !important;
  padding-top: 0 !important;
  background: var(--background) !important;
  color: var(--foreground) !important;
}

#arcane-root.arcane-theme-neon .arcane-scaffold-header {
  position: sticky !important;
  top: 0 !important;
  left: auto !important;
  right: auto !important;
  z-index: 40 !important;
  height: 3.5rem !important;
  min-height: 3.5rem !important;
  padding: 0 !important;
  border-bottom: 1px solid var(--border) !important;
  border-bottom-color: var(--border) !important;
  background: color-mix(in srgb, var(--background) 85%, transparent) !important;
  box-shadow: none !important;
  backdrop-filter: blur(8px) saturate(1.08) !important;
  -webkit-backdrop-filter: blur(8px) saturate(1.08) !important;
}

#arcane-root.arcane-theme-neon .arcane-scaffold-body {
  display: grid !important;
  grid-template-columns: minmax(15rem, 17.5rem) minmax(0, 1fr) !important;
  align-items: start !important;
  gap: 0 !important;
  padding: 0 !important;
  overflow: visible !important;
}

#arcane-root.arcane-theme-neon .arcane-scaffold-sidebar,
#arcane-root.arcane-theme-neon .arcane-scaffold-secondary {
  border-color: var(--border) !important;
  background: var(--card) !important;
  box-shadow: none !important;
}

#arcane-root.arcane-theme-neon .arcane-scaffold-sidebar.arcane-scaffold-sidebar {
  position: sticky !important;
  top: 3.5rem !important;
  left: auto !important;
  right: auto !important;
  bottom: auto !important;
  align-self: start !important;
  width: 17.5rem !important;
  border-right: 1px solid var(--border) !important;
  height: max-content !important;
  max-height: none !important;
  min-height: 0 !important;
  overflow: visible !important;
  padding: 0 !important;
}

#arcane-root.arcane-theme-neon .arcane-scaffold-main.arcane-scaffold-main {
  min-width: 0 !important;
  width: 100% !important;
  max-width: none !important;
  min-height: 0 !important;
  margin-left: 0 !important;
  padding: 0 !important;
  border: 0 !important;
  overflow: visible !important;
}

#arcane-root.arcane-theme-neon .kb-topbar {
  position: sticky;
  top: 0;
  z-index: 50;
  border: 0;
  border-bottom: 1px solid var(--border);
  background: color-mix(in srgb, var(--background) 85%, transparent);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  box-shadow: none;
}

#arcane-root.arcane-theme-neon .arcane-scaffold-header .kb-topbar {
  border-bottom: 0 !important;
}

#arcane-root.arcane-theme-neon .kb-topbar-inner {
  width: 100%;
  max-width: none;
  height: 3.5rem;
  min-height: 3.5rem;
  padding: 0 1.5rem;
  gap: 1.25rem;
}

#arcane-root.arcane-theme-neon .kb-topbar-left,
#arcane-root.arcane-theme-neon .kb-topbar-right {
  min-width: 0;
  gap: 0.875rem;
}

#arcane-root.arcane-theme-neon .kb-topbar-left {
  flex: 1 1 auto;
}

#arcane-root.arcane-theme-neon .kb-topbar-right {
  flex: 0 1 auto;
  padding: 0;
  border: 0;
  border-radius: 0;
  background: transparent;
}

#arcane-root.arcane-theme-neon .kb-topbar-nav {
  min-width: 0;
  margin-left: 0.25rem;
  padding: 0;
  gap: 1.25rem;
  border: 0;
  border-radius: 0;
  background: transparent;
}

#arcane-root.arcane-theme-neon .kb-topbar-brand {
  height: auto;
  padding: 0;
  gap: 0;
  border: 0;
  border-radius: 0;
  background: transparent;
  color: var(--foreground);
  box-shadow: none;
  font-size: 0.875rem;
  font-weight: 600;
  line-height: 1;
  text-decoration: none;
}

#arcane-root.arcane-theme-neon .kb-topbar-brand-icon {
  display: none;
}

#arcane-root.arcane-theme-neon .kb-topbar-brand-label {
  color: var(--foreground);
}

#arcane-root.arcane-theme-neon .kb-style-switcher {
  flex: 0 0 auto;
  flex-wrap: nowrap;
}

#arcane-root.arcane-theme-neon .kb-topbar-link {
  position: relative;
  height: auto;
  padding: 0.125rem 0;
  border: 0;
  border-radius: 0;
  background: transparent;
  color: var(--muted-foreground);
  box-shadow: none;
  font-size: 0.875rem;
  font-weight: 500;
  line-height: 1;
  text-decoration: none;
}

#arcane-root.arcane-theme-neon .kb-topbar-link:hover,
#arcane-root.arcane-theme-neon .kb-topbar-link.active {
  background: transparent;
  color: var(--primary);
  text-shadow: 0 0 8px rgba(var(--primary-rgb), 0.5);
  box-shadow: none;
}

#arcane-root.arcane-theme-neon .kb-topbar-link.active {
  font-weight: 600;
}

#arcane-root.arcane-theme-neon .kb-topbar-link::after {
  content: '';
  position: absolute;
  left: 0;
  right: 0;
  bottom: -0.7rem;
  height: 2px;
  border-radius: 999px;
  background: transparent;
}

#arcane-root.arcane-theme-neon .kb-topbar-link.active::after {
  background: var(--primary);
}

#arcane-root.arcane-theme-neon .arcane-scaffold-sidebar .kb-sidebar {
  position: relative !important;
  top: auto !important;
  width: 100% !important;
  height: max-content !important;
  max-height: none !important;
  min-height: 0 !important;
  padding: 0.375rem !important;
  overflow: visible !important;
}

#arcane-root.arcane-theme-neon .arcane-scaffold-sidebar .kb-sidebar-panel {
  min-height: 0 !important;
}

/* Docs knowledge-base sidebar: pin it directly below the 3.5rem sticky topbar
   (the inline --kb-sidebar-rail-top otherwise double-counts the topbar height,
   leaving a gap above the nav) and give it its own scroll rail instead of
   forcing the whole page to scroll. Targets the generic `.kb-sidebar` so it
   applies whatever the renderer prefix is (neon-kb-sidebar, default-kb-sidebar). */
#arcane-root.arcane-theme-neon .kb-sidebar {
  top: 3.5rem;
  max-height: calc(100vh - 3.5rem);
  overflow-y: auto;
}

#arcane-root.arcane-theme-neon .sidebar-header {
  margin: 0 0 0.5rem;
  padding: 0.625rem;
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  background: var(--card);
  box-shadow: 0 1px 0 color-mix(in srgb, var(--foreground) 4%, transparent);
}

#arcane-root.arcane-theme-neon .sidebar-nav {
  padding: 0.375rem 0.125rem 0.625rem !important;
  gap: 0.375rem !important;
}

#arcane-root.arcane-theme-neon .sidebar-section {
  margin-bottom: 0.375rem;
}

#arcane-root.arcane-theme-neon .sidebar-section-header {
  padding: 0.375rem 0.5rem 0.25rem;
  color: var(--muted-foreground);
  font-size: 0.6875rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

#arcane-root.arcane-theme-neon .sidebar-tree {
  padding-left: 0.75rem;
  margin-left: 0.25rem;
  gap: 0.25rem;
  /* Space the first child away from the parent summary at every nesting level
     (deeper subfolders otherwise rendered flush against their header). */
  margin-top: 0.25rem;
}

#arcane-root.arcane-theme-neon .kb-topbar-github,
#arcane-root.arcane-theme-neon .kb-theme-toggle,
#arcane-root.arcane-theme-neon .kb-stylesheet-select,
#arcane-root.arcane-theme-neon .kb-palette-select,
#arcane-root.arcane-theme-neon .kb-hamburger {
  height: 2.125rem;
  border: 1px solid var(--border);
  background: var(--background);
  border-radius: var(--radius);
  box-shadow: none;
}

#arcane-root.arcane-theme-neon .kb-topbar-github,
#arcane-root.arcane-theme-neon .kb-theme-toggle,
#arcane-root.arcane-theme-neon .kb-hamburger {
  width: 2.125rem;
}

#arcane-root.arcane-theme-neon .kb-topbar .kb-hamburger {
  display: none !important;
}

@media (max-width: 900px) {
  #arcane-root.arcane-theme-neon .kb-topbar .kb-hamburger {
    display: inline-flex !important;
  }
}

#arcane-root.arcane-theme-neon .kb-topbar-github:hover,
#arcane-root.arcane-theme-neon .kb-theme-toggle:hover,
#arcane-root.arcane-theme-neon .kb-stylesheet-select:hover,
#arcane-root.arcane-theme-neon .kb-palette-select:hover,
#arcane-root.arcane-theme-neon .kb-hamburger:hover {
  background: rgba(var(--primary-rgb), 0.12);
  border-color: var(--border);
}

#arcane-root.arcane-theme-neon .kb-search-input,
#arcane-root.arcane-theme-neon .sidebar-search input {
  height: 2.125rem;
  border-color: var(--border);
  background: var(--background);
  border-radius: var(--radius);
}

#arcane-root.arcane-theme-neon .kb-search-input:focus,
#arcane-root.arcane-theme-neon .sidebar-search input:focus {
  border-color: var(--primary);
  background: var(--background);
  box-shadow: 0 0 0 3px rgba(var(--primary-rgb), 0.25);
}

#arcane-root.arcane-theme-neon .search-results {
  border-color: var(--border);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-lg);
}

#arcane-root.arcane-theme-neon .sidebar-tabs {
  background: var(--secondary);
  border-radius: var(--radius);
}

#arcane-root.arcane-theme-neon .sidebar-tab {
  border-radius: calc(var(--radius) - 2px);
}

#arcane-root.arcane-theme-neon .sidebar-tab.active {
  box-shadow: none;
}

#arcane-root.arcane-theme-neon .sidebar-summary,
#arcane-root.arcane-theme-neon .sidebar-link {
  border-radius: calc(var(--radius) - 2px);
  color: color-mix(in srgb, var(--foreground) 78%, var(--muted-foreground));
  outline: 1px solid transparent;
  outline-offset: -1px;
}

#arcane-root.arcane-theme-neon .sidebar-summary:hover,
#arcane-root.arcane-theme-neon .sidebar-details[open] > .sidebar-summary,
#arcane-root.arcane-theme-neon .sidebar-link:hover {
  background: rgba(var(--primary-rgb), 0.12);
  color: var(--foreground);
  outline-color: var(--border);
}

#arcane-root.arcane-theme-neon .sidebar-link.active {
  background: rgba(var(--primary-rgb), 0.12);
  color: var(--primary);
  text-shadow: 0 0 8px rgba(var(--primary-rgb), 0.5);
  outline-color: var(--border);
  box-shadow: none;
}

#arcane-root.arcane-theme-neon .sidebar-tree > .sidebar-section::before,
#arcane-root.arcane-theme-neon .sidebar-tree > .sidebar-section::after,
#arcane-root.arcane-theme-neon .sidebar-tree-item::before,
#arcane-root.arcane-theme-neon .sidebar-tree-item::after,
#arcane-root.arcane-theme-neon .sidebar-tree-item:not(:last-child)::after {
  content: none !important;
  display: none !important;
  background: transparent !important;
}

#arcane-root.arcane-theme-neon .toc-content > ul > li::before,
#arcane-root.arcane-theme-neon .toc-content > ul > li::after,
#arcane-root.arcane-theme-neon .toc-content ul ul li::before,
#arcane-root.arcane-theme-neon .toc-content ul ul li::after {
  background: var(--border) !important;
}

#arcane-root.arcane-theme-neon .kb-toc-panel .toc {
  padding: 0.125rem 0 0;
  border: 0 !important;
  border-radius: 0 !important;
  background: transparent !important;
  box-shadow: none !important;
}

#arcane-root.arcane-theme-neon .kb-toc-panel .toc-title {
  border-bottom: 0 !important;
  padding-bottom: 0.125rem;
  margin-bottom: 0.5rem;
}

#arcane-root.arcane-theme-neon .toc-content a {
  border-radius: calc(var(--radius) - 2px);
  background: transparent;
}

#arcane-root.arcane-theme-neon .toc-content a:hover,
#arcane-root.arcane-theme-neon .toc-content a.toc-active {
  background: rgba(var(--primary-rgb), 0.12);
}

#arcane-root.arcane-theme-neon .kb-main-area {
  min-width: 0 !important;
  width: 100% !important;
  overflow: visible !important;
}

#arcane-root.arcane-theme-neon .kb-content-area {
  display: grid !important;
  grid-template-columns: minmax(0, 1fr) !important;
  align-items: start !important;
  width: 100% !important;
  max-width: var(--container-2xl, 90rem) !important;
  margin: 0 auto !important;
  gap: clamp(1.75rem, 3vw, 3rem) !important;
  padding: clamp(1.75rem, 3vw, 3rem) clamp(1.5rem, 4vw, 3.5rem) !important;
}

@media (min-width: 1201px) {
  #arcane-root.arcane-theme-neon .kb-content-area:has(.kb-toc-panel) {
    grid-template-columns: minmax(0, 1fr) minmax(12rem, 17rem) !important;
  }
}

#arcane-root.arcane-theme-neon .kb-article-panel {
  min-width: 0 !important;
  width: 100% !important;
  max-width: 68rem !important;
  margin-left: auto !important;
  margin-right: auto !important;
}

#arcane-root.arcane-theme-neon .kb-page-metadata,
#arcane-root.arcane-theme-neon .kb-tags-footer {
  border-color: var(--border) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope,
#arcane-root.arcane-theme-neon .arcane-demo-code {
  border-color: var(--border) !important;
  border-radius: var(--radius-lg);
  box-shadow: none !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-panel {
  padding: 1.5rem !important;
  border: 1px solid var(--border) !important;
  border-radius: var(--radius-xl) !important;
  background: color-mix(in srgb, var(--card) 96%, var(--background)) !important;
  box-shadow: none !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-kicker,
#arcane-root.arcane-theme-neon .arcane-demo-code-label {
  color: var(--muted-foreground) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-component-chip {
  border: 1px solid transparent !important;
  border-radius: 999px !important;
  background: var(--secondary) !important;
  color: var(--muted-foreground) !important;
  box-shadow: none !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-section-title {
  color: var(--foreground) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope {
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  border-width: 1px !important;
  background: color-mix(in srgb, var(--card) 96%, var(--background)) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-preview-scope > .arcane-box {
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-missing {
  border: 1px solid var(--border) !important;
  border-radius: var(--radius-lg) !important;
  background: var(--background) !important;
  color: var(--foreground) !important;
  box-shadow: none !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-missing-icon {
  border: 1px solid color-mix(in srgb, var(--warning, #f59e0b) 42%, var(--border)) !important;
  border-radius: var(--radius-sm) !important;
  background: color-mix(in srgb, var(--warning, #f59e0b) 16%, var(--background)) !important;
  color: color-mix(in srgb, var(--warning, #f59e0b) 74%, var(--foreground)) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-missing-title {
  color: var(--foreground) !important;
}

#arcane-root.arcane-theme-neon .arcane-demo-missing-body {
  color: var(--muted-foreground) !important;
}

@media (max-width: 900px) {
  #arcane-root.arcane-theme-neon .arcane-scaffold-sidebar.arcane-scaffold-sidebar {
    position: static !important;
    top: auto !important;
    height: auto !important;
    max-height: none !important;
    min-height: 0 !important;
    overflow: visible !important;
  }
}

#arcane-root.arcane-theme-neon .kb-topbar::before,
#arcane-root.arcane-theme-neon .kb-topbar::after {
  content: none !important;
  display: none !important;
  box-shadow: none !important;
}

#arcane-root.arcane-theme-neon .kb-toc-panel {
  position: sticky !important;
  top: 5rem !important;
  align-self: flex-start !important;
  width: 100% !important;
  max-height: none !important;
  overflow: visible !important;
}

@media (max-width: 1200px) {
  #arcane-root.arcane-theme-neon .kb-content-area {
    grid-template-columns: minmax(0, 1fr) !important;
  }

  #arcane-root.arcane-theme-neon .kb-toc-panel {
    display: none !important;
  }
}

@media (max-width: 900px) {
  #arcane-root.arcane-theme-neon .arcane-scaffold-body {
    grid-template-columns: minmax(0, 1fr) !important;
  }

  #arcane-root.arcane-theme-neon .arcane-scaffold-sidebar.arcane-scaffold-sidebar {
    position: static !important;
    width: auto !important;
  }

  #arcane-root.arcane-theme-neon .kb-content-area {
    padding: 1.25rem !important;
  }
}

#arcane-root.arcane-theme-neon .kb-landing-hero {
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--card) 92%, var(--primary) 8%), color-mix(in srgb, var(--background) 88%, var(--primary) 12%)),
    linear-gradient(90deg, color-mix(in srgb, var(--primary) 7%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--border) 54%, transparent) 1px, transparent 1px);
  background-size: auto, 4rem 4rem, 4rem 4rem;
}

#arcane-root.arcane-theme-neon .kb-landing-prose {
  display: grid;
  gap: clamp(1.5rem, 2.4vw, 2.4rem);
}

#arcane-root.arcane-theme-neon .kb-landing-prose > * + * {
  margin-top: 0;
}

#arcane-root.arcane-theme-neon .kb-landing-grid {
  gap: clamp(1.25rem, 2vw, 1.8rem);
  margin-top: 1.25rem;
  margin-bottom: 1.5rem;
}

#arcane-root.arcane-theme-neon .kb-landing-band {
  gap: clamp(1.45rem, 2.4vw, 2.2rem);
  margin-top: 1.25rem;
  padding: clamp(1.5rem, 2.4vw, 2.25rem);
}

#arcane-root.arcane-theme-neon .kb-landing-terminal-body,
#arcane-root.arcane-theme-neon .kb-landing-list {
  gap: 1rem;
}

#arcane-root.arcane-theme-neon .kb-landing-card:hover {
  border-color: color-mix(in srgb, var(--primary) 42%, var(--border));
  box-shadow: 0 1rem 2.5rem color-mix(in srgb, var(--primary) 10%, transparent);
}

/* ---------- Shared docs / prose / TOC / map (variable-driven) ---------- */

$arcaneAllDocsStyles

$arcaneMapCss

$arcaneTocTreeLinesCss
''';
  }
}
