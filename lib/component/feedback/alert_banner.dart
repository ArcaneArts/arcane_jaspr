import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Alert/banner variants
enum AlertVariant {
  info,
  success,
  warning,
  error,
  neutral,
}

/// An alert/banner component (Supabase-style)
class AlertBanner extends StatelessComponent {
  /// Alert message
  final String message;

  /// Optional title
  final String? title;

  /// Alert variant
  final AlertVariant variant;

  /// Optional icon
  final Component? icon;

  /// Optional action button
  final Component? action;

  /// Whether the alert is dismissible
  final bool dismissible;

  /// Callback when dismissed
  final void Function()? onDismiss;

  /// Whether to use filled style
  final bool filled;

  const AlertBanner({
    required this.message,
    this.title,
    this.variant = AlertVariant.info,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  });

  /// Info alert
  const AlertBanner.info({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertVariant.info;

  /// Success alert
  const AlertBanner.success({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertVariant.success;

  /// Warning alert
  const AlertBanner.warning({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertVariant.warning;

  /// Error alert
  const AlertBanner.error({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertVariant.error;

  @override
  Component build(BuildContext context) {
    final (String bgColor, String borderColor, String textColor, String iconColor) = switch (variant) {
      AlertVariant.info => filled
          ? (
              ArcaneColors.info,
              ArcaneColors.info,
              ArcaneColors.infoForeground,
              ArcaneColors.infoForeground,
            )
          : (
              ArcaneColors.transparent,
              ArcaneColors.info,
              ArcaneColors.onSurface,
              ArcaneColors.info,
            ),
      AlertVariant.success => filled
          ? (
              ArcaneColors.success,
              ArcaneColors.success,
              ArcaneColors.successForeground,
              ArcaneColors.successForeground,
            )
          : (
              ArcaneColors.transparent,
              ArcaneColors.success,
              ArcaneColors.onSurface,
              ArcaneColors.success,
            ),
      AlertVariant.warning => filled
          ? (
              ArcaneColors.warning,
              ArcaneColors.warning,
              ArcaneColors.warningForeground,
              ArcaneColors.warningForeground,
            )
          : (
              ArcaneColors.transparent,
              ArcaneColors.warning,
              ArcaneColors.onSurface,
              ArcaneColors.warning,
            ),
      AlertVariant.error => filled
          ? (
              ArcaneColors.error,
              ArcaneColors.error,
              ArcaneColors.errorForeground,
              ArcaneColors.errorForeground,
            )
          : (
              ArcaneColors.transparent,
              ArcaneColors.error,
              ArcaneColors.onSurface,
              ArcaneColors.error,
            ),
      AlertVariant.neutral => (
          ArcaneColors.surfaceVariant,
          ArcaneColors.border,
          ArcaneColors.onSurface,
          ArcaneColors.muted,
        ),
    };

    final String defaultIcon = switch (variant) {
      AlertVariant.info => 'ℹ',
      AlertVariant.success => '✓',
      AlertVariant.warning => '⚠',
      AlertVariant.error => '✕',
      AlertVariant.neutral => '•',
    };

    return div(
      classes: 'arcane-alert arcane-alert-${variant.name} ${filled ? 'filled' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': ArcaneSpacing.md,
        'padding': ArcaneSpacing.lg,
        'background-color': bgColor,
        'border': '1px solid $borderColor',
        'border-radius': ArcaneRadius.md,
        'color': textColor,
      }),
      [
        // Icon
        span(
          classes: 'arcane-alert-icon',
          styles: Styles(raw: {
            'flex-shrink': '0',
            'font-size': '1.125rem',
            'color': iconColor,
          }),
          [icon ?? text(defaultIcon)],
        ),

        // Content
        div(
          classes: 'arcane-alert-content',
          styles: Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (title != null)
              div(
                classes: 'arcane-alert-title',
                styles: Styles(raw: {
                  'font-weight': ArcaneTypography.weightSemibold,
                  'font-size': ArcaneTypography.fontBase,
                  'margin-bottom': ArcaneSpacing.xs,
                }),
                [text(title!)],
              ),
            div(
              classes: 'arcane-alert-message',
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'line-height': ArcaneTypography.lineHeightRelaxed,
              }),
              [text(message)],
            ),
          ],
        ),

        // Action
        if (action != null) action!,

        // Dismiss button
        if (dismissible)
          button(
            classes: 'arcane-alert-dismiss',
            attributes: {
              'type': 'button',
              'aria-label': 'Dismiss',
            },
            styles: Styles(raw: {
              'flex-shrink': '0',
              'padding': ArcaneSpacing.xs,
              'background': 'none',
              'border': 'none',
              'color': 'inherit',
              'opacity': '0.7',
              'cursor': 'pointer',
              'font-size': '1rem',
              'line-height': '1',
              'transition': ArcaneEffects.transitionFast,
            }),
            events: {
              'click': (e) => onDismiss?.call(),
            },
            [text('×')],
          ),
      ],
    );
  }
}

/// A progress bar component
class ProgressBar extends StatelessComponent {
  /// Progress value (0-100)
  final double value;

  /// Whether to show indeterminate animation
  final bool indeterminate;

  /// Bar height
  final double height;

  /// Show percentage label
  final bool showLabel;

  /// Custom color
  final String? color;

  const ProgressBar({
    this.value = 0,
    this.indeterminate = false,
    this.height = 8,
    this.showLabel = false,
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-progress ${indeterminate ? 'indeterminate' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.md,
      }),
      [
        div(
          classes: 'arcane-progress-track',
          styles: Styles(raw: {
            'flex': '1',
            'height': '${height}px',
            'background-color': ArcaneColors.surfaceVariant,
            'border-radius': ArcaneRadius.full,
            'overflow': 'hidden',
          }),
          [
            div(
              classes: 'arcane-progress-bar',
              styles: Styles(raw: {
                'height': '100%',
                'width': indeterminate ? '50%' : '${value.clamp(0, 100)}%',
                'background-color': color ?? ArcaneColors.accent,
                'border-radius': ArcaneRadius.full,
                'transition': indeterminate
                    ? 'none'
                    : ArcaneEffects.transition,
                if (indeterminate) 'animation': 'arcane-progress-indeterminate 1.5s ease-in-out infinite',
              }),
              [],
            ),
          ],
        ),
        if (showLabel && !indeterminate)
          span(
            classes: 'arcane-progress-label',
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.muted,
              'min-width': '40px',
              'text-align': 'right',
            }),
            [text('${value.round()}%')],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-progress-indeterminate').styles(raw: {
      '0%': 'transform: translateX(-100%)',
      '100%': 'transform: translateX(200%)',
    }),
  ];
}

/// A loading spinner component
class Loader extends StatelessComponent {
  /// Spinner size
  final double size;

  /// Custom color
  final String? color;

  /// Loading text
  final String? label;

  const Loader({
    this.size = 24,
    this.color,
    this.label,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-loader',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.md,
      }),
      [
        div(
          classes: 'arcane-loader-spinner',
          styles: Styles(raw: {
            'width': '${size}px',
            'height': '${size}px',
            'border': '2px solid ${ArcaneColors.border}',
            'border-top-color': color ?? ArcaneColors.accent,
            'border-radius': ArcaneRadius.full,
            'animation': 'arcane-spin 0.8s linear infinite',
          }),
          [],
        ),
        if (label != null)
          span(
            classes: 'arcane-loader-text',
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
            }),
            [text(label!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-spin').styles(raw: {
      '0%': 'transform: rotate(0deg)',
      '100%': 'transform: rotate(360deg)',
    }),
  ];
}
