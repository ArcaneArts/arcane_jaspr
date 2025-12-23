import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Alert style variants
enum AlertStyle {
  /// Subtle/soft background
  subtle,

  /// Solid/filled background
  solid,

  /// Outline/bordered style
  outline,

  /// Left accent border
  accent,
}

/// Alert severity/type
enum AlertSeverity {
  /// Informational
  info,

  /// Success/positive
  success,

  /// Warning
  warning,

  /// Error/danger
  error,
}

/// Inline alert component
///
/// Use for important messages that need user attention.
///
/// ```dart
/// ArcaneAlert(
///   severity: AlertSeverity.warning,
///   title: 'Warning',
///   message: 'Your session will expire in 5 minutes.',
/// )
/// ```
class ArcaneAlert extends StatelessComponent {
  /// Alert severity/type
  final AlertSeverity severity;

  /// Optional title
  final String? title;

  /// Alert message
  final String? message;

  /// Child component (alternative to message)
  final Component? child;

  /// Style variant
  final AlertStyle style;

  /// Custom icon (overrides default)
  final Component? icon;

  /// Whether to show icon
  final bool showIcon;

  /// Whether the alert is dismissible
  final bool dismissible;

  /// Callback when dismissed
  final VoidCallback? onDismiss;

  /// Action button
  final Component? action;

  const ArcaneAlert({
    required this.severity,
    this.title,
    this.message,
    this.child,
    this.style = AlertStyle.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  });

  /// Info alert
  const ArcaneAlert.info({
    this.title,
    this.message,
    this.child,
    this.style = AlertStyle.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  }) : severity = AlertSeverity.info;

  /// Success alert
  const ArcaneAlert.success({
    this.title,
    this.message,
    this.child,
    this.style = AlertStyle.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  }) : severity = AlertSeverity.success;

  /// Warning alert
  const ArcaneAlert.warning({
    this.title,
    this.message,
    this.child,
    this.style = AlertStyle.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  }) : severity = AlertSeverity.warning;

  /// Error alert
  const ArcaneAlert.error({
    this.title,
    this.message,
    this.child,
    this.style = AlertStyle.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  }) : severity = AlertSeverity.error;

  String get _defaultIcon => switch (severity) {
        AlertSeverity.info => 'ℹ',
        AlertSeverity.success => '✓',
        AlertSeverity.warning => '⚠',
        AlertSeverity.error => '✕',
      };

  (String primary, String background, String border, String foreground) get _colors =>
      switch (severity) {
        AlertSeverity.info => (
            ArcaneColors.info,
            ArcaneColors.infoAlpha10,
            ArcaneColors.infoAlpha30,
            ArcaneColors.infoForeground,
          ),
        AlertSeverity.success => (
            ArcaneColors.success,
            ArcaneColors.successAlpha10,
            ArcaneColors.successAlpha30,
            ArcaneColors.successForeground,
          ),
        AlertSeverity.warning => (
            ArcaneColors.warning,
            ArcaneColors.warningAlpha10,
            ArcaneColors.warningAlpha30,
            ArcaneColors.warningForeground,
          ),
        AlertSeverity.error => (
            ArcaneColors.error,
            ArcaneColors.errorAlpha10,
            ArcaneColors.errorAlpha30,
            ArcaneColors.errorForeground,
          ),
      };

  @override
  Component build(BuildContext context) {
    final (primary, bgColor, borderColor, foreground) = _colors;

    final containerStyles = switch (style) {
      AlertStyle.subtle => {
          'background': bgColor,
          'border': 'none',
          'border-radius': ArcaneRadius.md,
        },
      AlertStyle.solid => {
          'background': primary,
          'border': 'none',
          'border-radius': ArcaneRadius.md,
          'color': foreground,
        },
      AlertStyle.outline => {
          'background': 'transparent',
          'border': '1px solid $borderColor',
          'border-radius': ArcaneRadius.md,
        },
      AlertStyle.accent => {
          'background': bgColor,
          'border': 'none',
          'border-left': '4px solid $primary',
          'border-radius': '0 ${ArcaneRadius.md} ${ArcaneRadius.md} 0',
        },
    };

    final isSolid = style == AlertStyle.solid;

    return div(
      attributes: {'role': 'alert'},
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': ArcaneSpacing.md,
        'padding': ArcaneSpacing.md,
        ...containerStyles,
      }),
      [
        // Icon
        if (showIcon)
          div(
            styles: Styles(raw: {
              'flex-shrink': '0',
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': isSolid ? foreground : primary,
              'font-size': ArcaneTypography.fontMd,
              'font-weight': ArcaneTypography.weightBold,
            }),
            [icon ?? text(_defaultIcon)],
          ),

        // Content
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (title != null)
              div(
                styles: Styles(raw: {
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': isSolid ? foreground : ArcaneColors.onSurface,
                  if (message != null || child != null)
                    'margin-bottom': ArcaneSpacing.xs,
                }),
                [text(title!)],
              ),
            if (message != null)
              div(
                styles: Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': isSolid ? foreground : ArcaneColors.onSurface,
                  'line-height': ArcaneTypography.lineHeightRelaxed,
                }),
                [text(message!)],
              ),
            if (child != null) child!,
            if (action != null)
              div(
                styles: const Styles(raw: {
                  'margin-top': ArcaneSpacing.sm,
                }),
                [action!],
              ),
          ],
        ),

        // Dismiss button
        if (dismissible)
          button(
            type: ButtonType.button,
            attributes: {'aria-label': 'Dismiss'},
            styles: Styles(raw: {
              'flex-shrink': '0',
              'width': '24px',
              'height': '24px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'color': isSolid ? foreground : ArcaneColors.muted,
              'cursor': 'pointer',
              'border-radius': ArcaneRadius.sm,
              'transition': ArcaneEffects.transitionFast,
              'font-size': ArcaneTypography.fontLg,
            }),
            events: {'click': (_) => onDismiss?.call()},
            [text('×')],
          ),
      ],
    );
  }
}
