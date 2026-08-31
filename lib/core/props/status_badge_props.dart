import 'package:arcane_jaspr/flutter.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../../component/view/icon.dart';
import '../decoration/arcane_decoration.dart';
import '../shared/shared.dart';
import 'status_indicator_props.dart' show StatusType;

export '../shared/shared.dart' show ComponentSize, StyleVariant;
export 'status_indicator_props.dart' show StatusType;

/// Badge variant for all badge styles.
enum BadgeVariant {
  /// Standard status-style badge with an optional dot.
  status,

  /// Primary solid badge.
  primary,

  /// Secondary/muted badge.
  secondary,

  /// Success solid badge with no dot.
  successSolid,

  /// Warning solid badge with no dot.
  warningSolid,

  /// Error/destructive solid badge with no dot.
  errorSolid,

  /// Info solid badge with no dot.
  infoSolid,

  /// Outline variant (transparent with border).
  outline,
}

/// Unified badge component properties.
///
/// Supports inline status indicators and rectangular label variants.
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

  /// Whether to show a dot indicator.
  final bool showDot;

  /// Custom accent color for the badge.
  /// When provided, this color is used for the indicator, label, and auto-generates
  /// background/border colors using color-mix.
  final String? accentColor;

  /// Custom icon component to display.
  /// For status badges: replaces the dot indicator.
  /// For solid labels: shown before the label.
  final ArcaneGlyph? icon;

  /// Override background color.
  final String? background;

  /// Override border color.
  final String? borderColor;

  /// Override label text color.
  final String? labelColor;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const StatusBadgeProps({
    required this.label,
    this.size = ComponentSize.md,
    this.variant = BadgeVariant.status,
    this.status = StatusType.info,
    this.showDot = true,
    this.accentColor,
    this.icon,
    this.background,
    this.borderColor,
    this.labelColor,
    this.styles,
    this.decoration,
  });

  /// Whether this badge should show a dot indicator.
  bool get effectiveShowDot => showDot && icon == null;
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for status badge components.
mixin StatusBadgeRendererContract {
  Widget statusBadge(StatusBadgeProps props);
}
