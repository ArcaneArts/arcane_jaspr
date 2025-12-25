import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Status indicator types
enum StatusType {
  /// Green - operational, success, active
  success,

  /// Yellow - warning, degraded, pending
  warning,

  /// Red - error, down, failed
  error,

  /// Blue - info, maintenance, neutral
  info,

  /// Gray - offline, unknown, disabled
  offline,
}

/// Status badge size
enum StatusBadgeSize {
  /// Small: compact, minimal text
  sm,

  /// Medium: default size
  md,

  /// Large: prominent display
  lg,
}

/// A status indicator badge with pulse animation.
///
/// Used for showing system status, service health, or state indicators.
///
/// ```dart
/// ArcaneStatusBadge(
///   status: StatusType.success,
///   label: 'All Systems Operational',
/// )
///
/// ArcaneStatusBadge.success('Online')
/// ArcaneStatusBadge.error('Service Down')
/// ```
class ArcaneStatusBadge extends StatelessComponent {
  /// The status type (determines color)
  final StatusType status;

  /// The label text
  final String label;

  /// Badge size
  final StatusBadgeSize size;

  /// Whether to show the glow effect on the indicator
  final bool showGlow;

  /// Whether to show the pulse animation
  final bool showPulse;

  /// Custom indicator color (overrides status default)
  final String? indicatorColor;

  /// Custom background color
  final String? background;

  /// Custom border color
  final String? borderColor;

  const ArcaneStatusBadge({
    required this.status,
    required this.label,
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  });

  /// Create a success status badge
  const ArcaneStatusBadge.success(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.success;

  /// Create a warning status badge
  const ArcaneStatusBadge.warning(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.warning;

  /// Create an error status badge
  const ArcaneStatusBadge.error(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.error;

  /// Create an info status badge
  const ArcaneStatusBadge.info(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.info;

  /// Create an offline status badge
  const ArcaneStatusBadge.offline(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = false,
    this.showPulse = false,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.offline;

  @override
  Component build(BuildContext context) {
    final color = _getStatusColor();
    final indicatorSize = _getIndicatorSize();
    final padding = _getPadding();
    final fontSize = _getFontSize();

    final effectiveBackground =
        background ?? 'rgba(${_getStatusRgb()}, 0.1)';
    final effectiveBorder =
        borderColor ?? 'rgba(${_getStatusRgb()}, 0.25)';

    return div(
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': padding,
        'background': effectiveBackground,
        'border': '1px solid $effectiveBorder',
        'border-radius': ArcaneRadius.sm,
      }),
      [
        // Pulse indicator
        span(
          styles: Styles(raw: {
            'width': indicatorSize,
            'height': indicatorSize,
            'border-radius': '50%',
            'background': indicatorColor ?? color,
            if (showGlow) 'box-shadow': '0 0 8px ${indicatorColor ?? color}',
            if (showPulse) 'animation': 'arcane-pulse 2s ease-in-out infinite',
          }),
          [],
        ),
        // Label
        span(
          styles: Styles(raw: {
            'font-size': fontSize,
            'font-weight': size == StatusBadgeSize.sm ? '400' : '500',
            'color': size == StatusBadgeSize.sm
                ? (indicatorColor ?? color)
                : ArcaneColors.onSurface,
          }),
          [text(label)],
        ),
      ],
    );
  }

  String _getStatusColor() {
    switch (status) {
      case StatusType.success:
        return ArcaneColors.success;
      case StatusType.warning:
        return ArcaneColors.warning;
      case StatusType.error:
        return ArcaneColors.error;
      case StatusType.info:
        return ArcaneColors.info;
      case StatusType.offline:
        return ArcaneColors.muted;
    }
  }

  String _getStatusRgb() {
    switch (status) {
      case StatusType.success:
        return ArcaneColors.successRgb;
      case StatusType.warning:
        return ArcaneColors.warningRgb;
      case StatusType.error:
        return ArcaneColors.errorRgb;
      case StatusType.info:
        return ArcaneColors.infoRgb;
      case StatusType.offline:
        return ArcaneColors.mutedRgb;
    }
  }

  String _getIndicatorSize() {
    switch (size) {
      case StatusBadgeSize.sm:
        return '6px';
      case StatusBadgeSize.md:
        return '8px';
      case StatusBadgeSize.lg:
        return '10px';
    }
  }

  String _getPadding() {
    switch (size) {
      case StatusBadgeSize.sm:
        return '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}';
      case StatusBadgeSize.md:
        return '${ArcaneSpacing.xs} ${ArcaneSpacing.md}';
      case StatusBadgeSize.lg:
        return '${ArcaneSpacing.sm} ${ArcaneSpacing.lg}';
    }
  }

  String _getFontSize() {
    switch (size) {
      case StatusBadgeSize.sm:
        return ArcaneTypography.fontSizeXs;
      case StatusBadgeSize.md:
        return ArcaneTypography.fontSizeSm;
      case StatusBadgeSize.lg:
        return ArcaneTypography.fontSizeBase;
    }
  }
}
