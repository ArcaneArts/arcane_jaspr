import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';
import 'button.dart';

/// An icon-only button component.
class ArcaneIconButton extends StatelessComponent {
  /// The icon to display
  final Component icon;

  /// Click handler
  final void Function()? onPressed;

  /// Button variant
  final ButtonVariant variant;

  /// Button size
  final ButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is loading
  final bool loading;

  /// Optional tooltip text
  final String? tooltip;

  const ArcaneIconButton({
    required this.icon,
    this.onPressed,
    this.variant = ButtonVariant.ghost,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final isDisabled = disabled || loading;

    // Get size-specific dimensions
    final dimension = switch (size) {
      ButtonSize.small => 28.0,
      ButtonSize.medium => 36.0,
      ButtonSize.large => 44.0,
    };

    final iconSize = switch (size) {
      ButtonSize.small => 14.0,
      ButtonSize.medium => 18.0,
      ButtonSize.large => 22.0,
    };

    // Get variant-specific styles
    final (bgColor, textColor, borderColor) = switch (variant) {
      ButtonVariant.primary => (
          'var(--arcane-primary)',
          'var(--arcane-on-primary)',
          'transparent',
        ),
      ButtonVariant.secondary => (
          'var(--arcane-secondary)',
          'var(--arcane-on-secondary)',
          'transparent',
        ),
      ButtonVariant.outline => (
          'transparent',
          'var(--arcane-on-surface)',
          'var(--arcane-outline)',
        ),
      ButtonVariant.ghost => (
          'transparent',
          'var(--arcane-on-surface-variant)',
          'transparent',
        ),
      ButtonVariant.destructive => (
          'var(--arcane-error)',
          'var(--arcane-on-error)',
          'transparent',
        ),
      ButtonVariant.link => (
          'transparent',
          'var(--arcane-primary)',
          'transparent',
        ),
      ButtonVariant.success => (
          'rgb(34, 197, 94)',
          'rgb(255, 255, 255)',
          'transparent',
        ),
      ButtonVariant.warning => (
          'rgb(251, 191, 36)',
          'rgb(0, 0, 0)',
          'transparent',
        ),
    };

    return button(
      classes: 'arcane-icon-button arcane-icon-button-${variant.name} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        if (tooltip != null) 'title': tooltip!,
        if (tooltip != null) 'aria-label': tooltip!,
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '${dimension}px',
        'height': '${dimension}px',
        'border-radius': theme.borderRadiusCss,
        'background-color': bgColor,
        'color': textColor,
        'border': borderColor == 'transparent'
            ? 'none'
            : '1px solid $borderColor',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'flex-shrink': '0',
      }),
      events: {
        'click': (event) {
          if (!isDisabled && onPressed != null) {
            onPressed!();
          }
        },
      },
      [
        if (loading)
          _buildSpinner(iconSize)
        else
          div(
            styles: Styles(raw: {
              'width': '${iconSize}px',
              'height': '${iconSize}px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            }),
            [icon],
          ),
      ],
    );
  }

  Component _buildSpinner(double size) {
    return span(
      classes: 'arcane-icon-button-spinner',
      styles: Styles(raw: {
        'display': 'inline-block',
        'width': '${size}px',
        'height': '${size}px',
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': '50%',
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }

  // TODO: Fix @css section for Jaspr 0.22.0
  // @css
  // static final List<StyleRule> styles = [...];
}

/// A close button (X icon)
class CloseButton extends StatelessComponent {
  final void Function()? onPressed;
  final ButtonSize size;

  const CloseButton({
    this.onPressed,
    this.size = ButtonSize.medium,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneIconButton(
      icon: _buildCloseIcon(),
      onPressed: onPressed,
      variant: ButtonVariant.ghost,
      size: size,
      tooltip: 'Close',
    );
  }

  Component _buildCloseIcon() {
    return span(
      styles: Styles(raw: {
        'font-size': '1.25em',
        'line-height': '1',
      }),
      [text('×')],
    );
  }
}
