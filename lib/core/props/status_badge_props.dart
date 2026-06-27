import 'package:arcane_jaspr/flutter.dart';

import '../shared/shared.dart';
import 'status_indicator_props.dart' show StatusType;

export '../shared/shared.dart' show ComponentSize, StyleVariant;
export 'status_indicator_props.dart' show StatusType;

/// Position configuration for absolutely positioned badges.
class BadgePosition {
  final String? top;
  final String? right;
  final String? bottom;
  final String? left;

  const BadgePosition({
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  /// Top-right corner positioning (common for card badges).
  const BadgePosition.topRight({
    this.top = '12px',
    this.right = '12px',
    this.bottom,
    this.left,
  });

  /// Top-left corner positioning.
  const BadgePosition.topLeft({
    this.top = '12px',
    this.right,
    this.bottom,
    this.left = '12px',
  });
}

/// Badge variant for all badge styles.
enum BadgeVariant {
  /// Standard status-style badge (inline, pill-shaped with dot).
  status,

  /// Popular badge (solid primary, star icon, for card overlays).
  popular,

  /// Recommended badge (gradient background, for card overlays).
  recommended,

  /// New badge (success color, for card overlays).
  isNew,

  /// Primary solid badge.
  primary,

  /// Secondary/muted badge.
  secondary,

  /// Success solid badge (simple pill, no dot).
  successSolid,

  /// Warning solid badge (simple pill, no dot).
  warningSolid,

  /// Error/destructive solid badge (simple pill, no dot).
  errorSolid,

  /// Info solid badge (simple pill, no dot).
  infoSolid,

  /// Outline variant (transparent with border).
  outline,
}

/// Unified badge component properties.
///
/// Supports both status indicators (with dots/pulse) and card overlay badges
/// (with positioning and style variants).
class StatusBadgeProps {
  /// The label text to display.
  final String label;

  /// Size variant (sm, md, lg).
  final ComponentSize size;

  /// Badge variant determining the overall style.
  final BadgeVariant variant;

  /// The status type for status-style badges.
  /// Used to determine default colors if no accent color is specified.
  final StatusType status;

  /// Whether to show a glow effect on the indicator.
  final bool showGlow;

  /// Whether to show a pulse animation on the indicator.
  final bool showPulse;

  /// Whether to show a dot indicator (for status badges).
  /// Defaults to true for status variant, false for card overlay variants.
  final bool showDot;

  /// Custom accent color for the badge.
  /// When provided, this color is used for the indicator, label, and auto-generates
  /// background/border colors using color-mix.
  final String? accentColor;

  /// Custom icon component to display.
  /// For status badges: replaces the dot indicator.
  /// For card badges: shown before the label.
  final Widget? icon;

  /// Whether to show a default icon (star) when no icon is provided.
  /// Used by popular/recommended/new variants.
  final bool showDefaultIcon;

  /// When set, badge uses absolute positioning for card overlays.
  final BadgePosition? position;

  /// Custom gradient background (overrides accentColor when set).
  /// Example: 'linear-gradient(135deg, var(--primary), var(--accent))'
  final String? gradient;

  /// Override background color.
  final String? background;

  /// Override border color.
  final String? borderColor;

  /// Override label text color.
  final String? labelColor;

  const StatusBadgeProps({
    required this.label,
    this.size = ComponentSize.md,
    this.variant = BadgeVariant.status,
    this.status = StatusType.info,
    this.showGlow = false,
    this.showPulse = false,
    this.showDot = true,
    this.accentColor,
    this.icon,
    this.showDefaultIcon = false,
    this.position,
    this.gradient,
    this.background,
    this.borderColor,
    this.labelColor,
  });

  /// Whether this is a card overlay badge (positioned absolutely).
  bool get isCardBadge => position != null;

  /// Whether this badge should show a dot indicator.
  bool get effectiveShowDot {
    // Card overlay badges don't show dots by default
    if (isCardBadge || variant != BadgeVariant.status) {
      return showDot && icon == null && !showDefaultIcon;
    }
    // Status badges show dots unless an icon is provided
    return showDot && icon == null;
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for status badge components.
mixin StatusBadgeRendererContract {
  Widget statusBadge(StatusBadgeProps props);
}
