import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/status_badge_props.dart';

/// Unified badge component for status indicators and card overlays.
///
/// Supports multiple usage patterns:
/// 1. **Status badges**: `.success()`, `.warning()`, `.error()`, `.info()`, `.offline()`
///    - Pill-shaped with dot indicator and optional pulse animation
/// 2. **Custom status badges**: `.custom()` with any accent color
/// 3. **Card overlay badges**: `.popular()`, `.recommended()`, `.isNew()`
///    - Solid background, positioned absolutely on cards
/// 4. **Generic badges**: `.primary()`, `.secondary()`
class ArcaneStatusBadge extends StatelessWidget {
  final String label;
  final ComponentSize size;
  final BadgeVariant variant;
  final StatusType status;
  final bool showGlow;
  final bool showPulse;
  final bool showDot;
  final String? accentColor;
  final Widget? icon;
  final bool showDefaultIcon;
  final BadgePosition? position;
  final String? gradient;
  final String? background;
  final String? borderColor;
  final String? labelColor;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ArcaneStatusBadge({
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
    this.styles,
    this.decoration,
    super.key,
  });

  // ===========================================================================
  // STATUS BADGE FACTORIES (inline, with dot indicators)
  // ===========================================================================

  /// Creates a success status badge (green).
  const ArcaneStatusBadge.success(
    this.label, {
    this.size = ComponentSize.md,
    this.showGlow = false,
    this.showPulse = true,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.status,
        status = StatusType.success,
        showDot = true,
        accentColor = null,
        showDefaultIcon = false,
        position = null,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates a warning status badge (orange/yellow).
  const ArcaneStatusBadge.warning(
    this.label, {
    this.size = ComponentSize.md,
    this.showGlow = false,
    this.showPulse = false,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.status,
        status = StatusType.warning,
        showDot = true,
        accentColor = null,
        showDefaultIcon = false,
        position = null,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates an error status badge (red).
  const ArcaneStatusBadge.error(
    this.label, {
    this.size = ComponentSize.md,
    this.showGlow = false,
    this.showPulse = false,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.status,
        status = StatusType.error,
        showDot = true,
        accentColor = null,
        showDefaultIcon = false,
        position = null,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates an info status badge (blue).
  const ArcaneStatusBadge.info(
    this.label, {
    this.size = ComponentSize.md,
    this.showGlow = false,
    this.showPulse = false,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.status,
        status = StatusType.info,
        showDot = true,
        accentColor = null,
        showDefaultIcon = false,
        position = null,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates an offline status badge (gray).
  const ArcaneStatusBadge.offline(
    this.label, {
    this.size = ComponentSize.md,
    this.showGlow = false,
    this.showPulse = false,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.status,
        status = StatusType.offline,
        showDot = true,
        accentColor = null,
        showDefaultIcon = false,
        position = null,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates a badge with a custom accent color.
  ///
  /// The accent color is used for the indicator, label text,
  /// and auto-generates background/border colors using color-mix.
  ///
  /// Example:
  /// ```dart
  /// ArcaneStatusBadge.custom(
  ///   label: 'Java & Bedrock',
  ///   accentColor: '#62C555',
  /// )
  /// ```
  const ArcaneStatusBadge.custom({
    required this.label,
    required this.accentColor,
    this.size = ComponentSize.md,
    this.showGlow = false,
    this.showPulse = false,
    this.showDot = true,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.status,
        status = StatusType.info,
        showDefaultIcon = false,
        position = null,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  // ===========================================================================
  // CARD OVERLAY BADGE FACTORIES (positioned, solid background)
  // ===========================================================================

  /// Creates a "Popular" badge for card overlays.
  /// Solid primary background with star icon, positioned top-right by default.
  ArcaneStatusBadge.popular({
    String label = 'Popular',
    this.size = ComponentSize.md,
    this.icon,
    this.position = const BadgePosition.topRight(),
    this.styles,
    this.decoration,
    super.key,
  })  : label = label,
        variant = BadgeVariant.popular,
        status = StatusType.info,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        showDefaultIcon = true,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates a "Recommended" badge with gradient background.
  /// Positioned top-right by default.
  ArcaneStatusBadge.recommended({
    String label = 'Recommended',
    this.size = ComponentSize.md,
    this.icon,
    this.position = const BadgePosition.topRight(),
    this.styles,
    this.decoration,
    super.key,
  })  : label = label,
        variant = BadgeVariant.recommended,
        status = StatusType.info,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        showDefaultIcon = true,
        gradient = 'linear-gradient(135deg, var(--primary), var(--accent))',
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates a "New" badge for card overlays.
  /// Success color with star icon, positioned top-right by default.
  ArcaneStatusBadge.isNew({
    String label = 'New',
    this.size = ComponentSize.md,
    this.icon,
    this.position = const BadgePosition.topRight(),
    this.styles,
    this.decoration,
    super.key,
  })  : label = label,
        variant = BadgeVariant.isNew,
        status = StatusType.success,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        showDefaultIcon = true,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  // ===========================================================================
  // SOLID PILL BADGE FACTORIES (no dot, solid background)
  // ===========================================================================

  /// Creates a success solid badge (green pill, no dot).
  /// Use for tags and labels, not status indicators.
  const ArcaneStatusBadge.successSolid(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.position,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.successSolid,
        status = StatusType.success,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        showDefaultIcon = false,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates a warning solid badge (orange/yellow pill, no dot).
  /// Use for tags and labels, not status indicators.
  const ArcaneStatusBadge.warningSolid(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.position,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.warningSolid,
        status = StatusType.warning,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        showDefaultIcon = false,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates an error solid badge (red pill, no dot).
  /// Use for tags and labels, not status indicators.
  const ArcaneStatusBadge.errorSolid(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.position,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.errorSolid,
        status = StatusType.error,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        showDefaultIcon = false,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates an info solid badge (blue pill, no dot).
  /// Use for tags and labels, not status indicators.
  const ArcaneStatusBadge.infoSolid(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.position,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.infoSolid,
        status = StatusType.info,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        showDefaultIcon = false,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates an outline badge (transparent with border).
  const ArcaneStatusBadge.outline(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.position,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.outline,
        status = StatusType.info,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        showDefaultIcon = false,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  // ===========================================================================
  // GENERIC BADGE FACTORIES
  // ===========================================================================

  /// Creates a primary badge (solid primary background).
  const ArcaneStatusBadge.primary(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.showDefaultIcon = false,
    this.position,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.primary,
        status = StatusType.info,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  /// Creates a secondary badge (muted background).
  const ArcaneStatusBadge.secondary(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.showDefaultIcon = false,
    this.position,
    this.styles,
    this.decoration,
    super.key,
  })  : variant = BadgeVariant.secondary,
        status = StatusType.info,
        showGlow = false,
        showPulse = false,
        showDot = false,
        accentColor = null,
        gradient = null,
        background = null,
        borderColor = null,
        labelColor = null;

  @override
  Widget build(BuildContext context) {
    return context.renderers.statusBadge(StatusBadgeProps(
      label: label,
      size: size,
      variant: variant,
      status: status,
      showGlow: showGlow,
      showPulse: showPulse,
      showDot: showDot,
      accentColor: accentColor,
      icon: icon,
      showDefaultIcon: showDefaultIcon,
      position: position,
      gradient: gradient,
      background: background,
      borderColor: borderColor,
      labelColor: labelColor,
      styles: styles,
      decoration: decoration,
    ));
  }
}
