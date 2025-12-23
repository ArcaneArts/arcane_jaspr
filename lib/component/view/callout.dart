import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Callout style variants
enum CalloutStyle {
  /// Informational callout
  info,

  /// Success/positive callout
  success,

  /// Warning callout
  warning,

  /// Error/danger callout
  error,

  /// Neutral/default callout
  neutral,

  /// Tip/hint callout
  tip,

  /// Note callout
  note,
}

/// Inline callout/notice component
///
/// Use for highlighting important information inline with content.
///
/// ```dart
/// ArcaneCallout(
///   title: 'Pro Tip',
///   content: 'You can use keyboard shortcuts to speed up your workflow.',
///   style: CalloutStyle.tip,
/// )
/// ```
class ArcaneCallout extends StatelessComponent {
  /// Optional title
  final String? title;

  /// Content text
  final String? content;

  /// Child component (alternative to content)
  final Component? child;

  /// Style variant
  final CalloutStyle style;

  /// Optional icon override
  final Component? icon;

  /// Whether to show the default icon
  final bool showIcon;

  /// Whether the callout is dismissible
  final bool dismissible;

  /// Callback when dismissed
  final VoidCallback? onDismiss;

  const ArcaneCallout({
    this.title,
    this.content,
    this.child,
    this.style = CalloutStyle.info,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  });

  /// Info callout constructor
  const ArcaneCallout.info({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.info;

  /// Success callout constructor
  const ArcaneCallout.success({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.success;

  /// Warning callout constructor
  const ArcaneCallout.warning({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.warning;

  /// Error callout constructor
  const ArcaneCallout.error({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.error;

  /// Tip callout constructor
  const ArcaneCallout.tip({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.tip;

  String get _defaultIcon => switch (style) {
        CalloutStyle.info => 'ℹ️',
        CalloutStyle.success => '✓',
        CalloutStyle.warning => '⚠',
        CalloutStyle.error => '✕',
        CalloutStyle.neutral => '•',
        CalloutStyle.tip => '💡',
        CalloutStyle.note => '📝',
      };

  (String background, String border, String iconColor) get _styleColors =>
      switch (style) {
        CalloutStyle.info => (
            ArcaneColors.infoAlpha10,
            ArcaneColors.info,
            ArcaneColors.info
          ),
        CalloutStyle.success => (
            ArcaneColors.successAlpha10,
            ArcaneColors.success,
            ArcaneColors.success
          ),
        CalloutStyle.warning => (
            ArcaneColors.warningAlpha10,
            ArcaneColors.warning,
            ArcaneColors.warning
          ),
        CalloutStyle.error => (
            ArcaneColors.errorAlpha10,
            ArcaneColors.error,
            ArcaneColors.error
          ),
        CalloutStyle.neutral => (
            ArcaneColors.surfaceVariant,
            ArcaneColors.border,
            ArcaneColors.muted
          ),
        CalloutStyle.tip => (
            ArcaneColors.accentAlpha10,
            ArcaneColors.accent,
            ArcaneColors.accent
          ),
        CalloutStyle.note => (
            ArcaneColors.primaryAlpha10,
            ArcaneColors.primary,
            ArcaneColors.primary
          ),
      };

  @override
  Component build(BuildContext context) {
    final (background, borderColor, iconColor) = _styleColors;

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'gap': ArcaneSpacing.md,
        'padding': ArcaneSpacing.md,
        'background': background,
        'border-left': '4px solid $borderColor',
        'border-radius': ArcaneRadius.md,
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
              'color': iconColor,
              'font-size': ArcaneTypography.fontMd,
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
                styles: const Styles(raw: {
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': ArcaneColors.onSurface,
                  'margin-bottom': ArcaneSpacing.xs,
                }),
                [text(title!)],
              ),
            if (content != null)
              div(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.onSurface,
                  'line-height': ArcaneTypography.lineHeightRelaxed,
                }),
                [text(content!)],
              ),
            if (child != null) child!,
          ],
        ),

        // Dismiss button
        if (dismissible)
          button(
            type: ButtonType.button,
            styles: const Styles(raw: {
              'flex-shrink': '0',
              'width': '24px',
              'height': '24px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'color': ArcaneColors.muted,
              'cursor': 'pointer',
              'border-radius': ArcaneRadius.sm,
              'transition': ArcaneEffects.transitionFast,
            }),
            events: {'click': (_) => onDismiss?.call()},
            [text('×')],
          ),
      ],
    );
  }
}
