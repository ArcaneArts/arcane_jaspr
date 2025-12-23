import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Status types
enum StatusType {
  online,
  offline,
  busy,
  away,
  success,
  error,
  warning,
  info,
}

/// Status indicator dot with optional label
class ArcaneStatusIndicator extends StatelessComponent {
  final StatusType status;
  final String? label;
  final String? size;
  final bool pulse;

  const ArcaneStatusIndicator({
    required this.status,
    this.label,
    this.size,
    this.pulse = false,
    super.key,
  });

  /// Online status
  const ArcaneStatusIndicator.online({
    this.label,
    this.size,
    this.pulse = true,
    super.key,
  }) : status = StatusType.online;

  /// Offline status
  const ArcaneStatusIndicator.offline({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.offline,
        pulse = false;

  /// Busy status
  const ArcaneStatusIndicator.busy({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.busy,
        pulse = false;

  /// Away status
  const ArcaneStatusIndicator.away({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.away,
        pulse = false;

  String get _color {
    return switch (status) {
      StatusType.online || StatusType.success => ArcaneColors.success,
      StatusType.offline => ArcaneColors.muted,
      StatusType.busy || StatusType.error => ArcaneColors.error,
      StatusType.away || StatusType.warning => ArcaneColors.warning,
      StatusType.info => ArcaneColors.info,
    };
  }

  @override
  Component build(BuildContext context) {
    final effectiveSize = size ?? '10px';

    return div(
      classes: 'arcane-status-indicator',
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Dot
        div(
          classes: 'arcane-status-dot',
          styles: Styles(raw: {
            'position': 'relative',
            'width': effectiveSize,
            'height': effectiveSize,
            'border-radius': ArcaneRadius.full,
            'background': _color,
            'flex-shrink': '0',
          }),
          [
            if (pulse && (status == StatusType.online || status == StatusType.success))
              div(
                classes: 'arcane-status-pulse',
                styles: Styles(raw: {
                  'position': 'absolute',
                  'inset': '-2px',
                  'border-radius': ArcaneRadius.full,
                  'background': _color,
                  'opacity': '0.4',
                  'animation': 'arcane-pulse 2s infinite',
                }),
                [],
              ),
          ],
        ),
        // Label
        if (label != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontMd,
              'color': ArcaneColors.muted,
            }),
            [text(label!)],
          ),
      ],
    );
  }
}

/// Status badge combining status indicator with text
class ArcaneStatusBadge extends StatelessComponent {
  final StatusType status;
  final String label;

  const ArcaneStatusBadge({
    required this.status,
    required this.label,
    super.key,
  });

  /// Success status badge
  const ArcaneStatusBadge.success({
    required this.label,
    super.key,
  }) : status = StatusType.success;

  /// Error status badge
  const ArcaneStatusBadge.error({
    required this.label,
    super.key,
  }) : status = StatusType.error;

  /// Warning status badge
  const ArcaneStatusBadge.warning({
    required this.label,
    super.key,
  }) : status = StatusType.warning;

  /// Info status badge
  const ArcaneStatusBadge.info({
    required this.label,
    super.key,
  }) : status = StatusType.info;

  (String, String) get _colors {
    return switch (status) {
      StatusType.online || StatusType.success =>
        (ArcaneColors.success, ArcaneColors.successAlpha15),
      StatusType.offline => (ArcaneColors.muted, ArcaneColors.mutedAlpha15),
      StatusType.busy || StatusType.error =>
        (ArcaneColors.error, ArcaneColors.errorAlpha15),
      StatusType.away || StatusType.warning =>
        (ArcaneColors.warning, ArcaneColors.warningAlpha15),
      StatusType.info => (ArcaneColors.info, ArcaneColors.infoAlpha15),
    };
  }

  @override
  Component build(BuildContext context) {
    final (color, bgColor) = _colors;

    return span(
      classes: 'arcane-status-badge',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
        'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
        'border-radius': ArcaneRadius.md,
        'background': bgColor,
        'color': color,
        'font-size': ArcaneTypography.fontSm,
        'font-weight': ArcaneTypography.weightMedium,
      }),
      [
        div(
          styles: Styles(raw: {
            'width': '6px',
            'height': '6px',
            'border-radius': ArcaneRadius.full,
            'background': color,
          }),
          [],
        ),
        text(label),
      ],
    );
  }
}
