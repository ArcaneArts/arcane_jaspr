import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';
import 'button.dart';

/// Icon button size variants
enum IconButtonSize {
  small,
  medium,
  large,
}

/// An icon-only button component.
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneIconButton(
///   icon: Icon(Icons.close),
///   style: IconButtonStyle.ghost,
/// )
/// ```
class ArcaneIconButton extends StatelessComponent {
  /// The icon to display
  final Component icon;

  /// Click handler
  final void Function()? onPressed;

  /// Style preset (preferred)
  final IconButtonStyle? style;

  /// Button variant (legacy - use style instead)
  @Deprecated('Use style parameter with IconButtonStyle presets instead')
  final ButtonVariant? variant;

  /// Button size
  final IconButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is loading
  final bool loading;

  /// Optional tooltip text
  final String? tooltip;

  const ArcaneIconButton({
    required this.icon,
    this.onPressed,
    this.style,
    @Deprecated('Use style parameter instead') this.variant,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  });

  /// Primary icon button
  const ArcaneIconButton.primary({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : style = IconButtonStyle.primary,
        variant = null;

  /// Ghost icon button (default minimal style)
  const ArcaneIconButton.ghost({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : style = IconButtonStyle.ghost,
        variant = null;

  /// Outline icon button
  const ArcaneIconButton.outline({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : style = IconButtonStyle.outline,
        variant = null;

  /// Destructive icon button
  const ArcaneIconButton.destructive({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : style = IconButtonStyle.destructive,
        variant = null;

  /// Convert legacy variant to style preset
  IconButtonStyle _variantToStyle(ButtonVariant v) {
    return switch (v) {
      ButtonVariant.primary => IconButtonStyle.primary,
      ButtonVariant.secondary => IconButtonStyle.secondary,
      ButtonVariant.outline => IconButtonStyle.outline,
      ButtonVariant.ghost => IconButtonStyle.ghost,
      ButtonVariant.destructive => IconButtonStyle.destructive,
      ButtonVariant.success => IconButtonStyle.success,
      ButtonVariant.warning => IconButtonStyle.warning,
      ButtonVariant.link => IconButtonStyle.ghost,
    };
  }

  @override
  Component build(BuildContext context) {
    final isDisabled = disabled || loading;

    // Resolve effective style
    final effectiveStyle = style ??
        (variant != null ? _variantToStyle(variant!) : IconButtonStyle.ghost);

    // Get size-specific dimensions
    final (dimension, iconSize) = switch (size) {
      IconButtonSize.small => (28.0, 14.0),
      IconButtonSize.medium => (36.0, 18.0),
      IconButtonSize.large => (44.0, 22.0),
    };

    return button(
      classes: 'arcane-icon-button ${isDisabled ? 'disabled' : ''}',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        if (tooltip != null) 'title': tooltip!,
        if (tooltip != null) 'aria-label': tooltip!,
      },
      styles: Styles(raw: {
        // Layout
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '${dimension}px',
        'height': '${dimension}px',
        'flex-shrink': '0',

        // Appearance from style preset
        ...effectiveStyle.base,

        // Shape
        'border-radius': ArcaneRadius.md,

        // Interaction
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
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
        'border-right-color': ArcaneColors.transparent,
        'border-radius': ArcaneRadius.full,
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}

/// A close button (X icon)
class CloseButton extends StatelessComponent {
  final void Function()? onPressed;
  final IconButtonSize size;
  final IconButtonStyle? style;

  const CloseButton({
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.style,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneIconButton(
      icon: _buildCloseIcon(),
      onPressed: onPressed,
      style: style ?? IconButtonStyle.ghost,
      size: size,
      tooltip: 'Close',
    );
  }

  Component _buildCloseIcon() {
    return span(
      styles: const Styles(raw: {
        'font-size': '1.25em',
        'line-height': '1',
      }),
      [text('×')],
    );
  }
}