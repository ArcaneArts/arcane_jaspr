import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Toast notification variant
enum ToastVariant {
  info,
  success,
  warning,
  error,
}

/// Toast position
enum ToastPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// A toast notification component.
class Toast extends StatelessComponent {
  /// Toast message
  final String message;

  /// Toast title
  final String? title;

  /// Toast variant
  final ToastVariant variant;

  /// Close handler
  final void Function()? onClose;

  /// Whether to show close button
  final bool showCloseButton;

  /// Custom icon
  final Component? icon;

  /// Optional action button
  final Component? action;

  const Toast({
    required this.message,
    this.title,
    this.variant = ToastVariant.info,
    this.onClose,
    this.showCloseButton = true,
    this.icon,
    this.action,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (String bgColor, String textColor, String borderColor, String defaultIcon) = switch (variant) {
      ToastVariant.info => (
          ArcaneColors.surface,
          ArcaneColors.onSurface,
          ArcaneColors.border,
          'ℹ',
        ),
      ToastVariant.success => (
          ArcaneColors.surface,
          ArcaneColors.onSurface,
          ArcaneColors.success,
          '✓',
        ),
      ToastVariant.warning => (
          ArcaneColors.surface,
          ArcaneColors.onSurface,
          ArcaneColors.warning,
          '⚠',
        ),
      ToastVariant.error => (
          ArcaneColors.surface,
          ArcaneColors.onSurface,
          ArcaneColors.error,
          '✕',
        ),
    };

    return div(
      classes: 'arcane-toast arcane-toast-${variant.name}',
      attributes: {
        'role': 'alert',
        'aria-live': 'polite',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': ArcaneSpacing.sm,
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'background-color': bgColor,
        'border': '1px solid $borderColor',
        'border-left': '4px solid $borderColor',
        'border-radius': ArcaneRadius.md,
        'box-shadow': ArcaneEffects.shadowMd,
        'min-width': '300px',
        'max-width': '450px',
        'animation': 'arcane-toast-in 200ms ease',
      }),
      [
        // Icon
        div(
          classes: 'arcane-toast-icon',
          styles: Styles(raw: {
            'font-size': '1.25rem',
            'color': borderColor,
            'flex-shrink': '0',
          }),
          [icon ?? text(defaultIcon)],
        ),

        // Content
        div(
          classes: 'arcane-toast-content',
          styles: Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (title != null)
              div(
                classes: 'arcane-toast-title',
                styles: Styles(raw: {
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': textColor,
                  'margin-bottom': ArcaneSpacing.xs,
                }),
                [text(title!)],
              ),
            div(
              classes: 'arcane-toast-message',
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.muted,
                'line-height': '1.4',
              }),
              [text(message)],
            ),
            if (action != null)
              div(
                styles: Styles(raw: {
                  'margin-top': ArcaneSpacing.sm,
                }),
                [action!],
              ),
          ],
        ),

        // Close button
        if (showCloseButton && onClose != null)
          button(
            classes: 'arcane-toast-close',
            attributes: {'type': 'button', 'aria-label': 'Close notification'},
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '24px',
              'height': '24px',
              'border-radius': ArcaneRadius.full,
              'background': ArcaneColors.transparent,
              'border': 'none',
              'color': ArcaneColors.muted,
              'cursor': 'pointer',
              'transition': ArcaneEffects.transitionFast,
              'flex-shrink': '0',
            }),
            events: {
              'click': (event) => onClose!(),
            },
            [text('×')],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-toast-in').styles(raw: {
      'from': 'transform: translateY(-10px); opacity: 0',
      'to': 'transform: translateY(0); opacity: 1',
    }),
    css('.arcane-toast-close:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

/// A toast container that positions toasts on the screen.
class ToastContainer extends StatelessComponent {
  final List<Component> toasts;
  final ToastPosition position;
  final double spacing;

  const ToastContainer({
    required this.toasts,
    this.position = ToastPosition.topRight,
    this.spacing = 8,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final Map<String, String> positionStyles = switch (position) {
      ToastPosition.topLeft => {
          'top': ArcaneSpacing.lg,
          'left': ArcaneSpacing.lg,
          'align-items': 'flex-start',
        },
      ToastPosition.topCenter => {
          'top': ArcaneSpacing.lg,
          'left': '50%',
          'transform': 'translateX(-50%)',
          'align-items': 'center',
        },
      ToastPosition.topRight => {
          'top': ArcaneSpacing.lg,
          'right': ArcaneSpacing.lg,
          'align-items': 'flex-end',
        },
      ToastPosition.bottomLeft => {
          'bottom': ArcaneSpacing.lg,
          'left': ArcaneSpacing.lg,
          'align-items': 'flex-start',
        },
      ToastPosition.bottomCenter => {
          'bottom': ArcaneSpacing.lg,
          'left': '50%',
          'transform': 'translateX(-50%)',
          'align-items': 'center',
        },
      ToastPosition.bottomRight => {
          'bottom': ArcaneSpacing.lg,
          'right': ArcaneSpacing.lg,
          'align-items': 'flex-end',
        },
    };

    return div(
      classes: 'arcane-toast-container',
      styles: Styles(raw: {
        'position': 'fixed',
        'z-index': '2000',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${spacing}px',
        'pointer-events': 'none',
        ...positionStyles,
      }),
      [
        for (final toast in toasts)
          div(
            styles: Styles(raw: {
              'pointer-events': 'auto',
            }),
            [toast],
          ),
      ],
    );
  }
}
