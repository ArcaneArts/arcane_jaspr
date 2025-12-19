import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Button style variants (legacy - prefer using ButtonStyle presets)
@Deprecated('Use style parameter with ButtonStyle presets instead')
enum ButtonVariant {
  /// Primary action button with accent color
  primary,
  /// Secondary/muted button
  secondary,
  /// Outline button with border
  outline,
  /// Ghost button (transparent background)
  ghost,
  /// Destructive/danger button
  destructive,
  /// Link-style button
  link,
  /// Success button (green)
  success,
  /// Warning button (amber)
  warning,
}

/// Button size variants
enum ButtonSize {
  small,
  medium,
  large,
}

/// A styled button component.
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneButton(
///   label: 'Delete',
///   style: ButtonStyle.destructive,
/// )
/// ```
class ArcaneButton extends StatelessComponent {
  /// Button label text
  final String? label;

  /// Child component (alternative to label)
  final Component? child;

  /// Leading icon
  final Component? icon;

  /// Trailing icon
  final Component? trailing;

  /// Click handler
  final void Function()? onPressed;

  /// Style preset (preferred over variant)
  final ButtonStyle? style;

  /// Button variant (legacy - use style instead)
  @Deprecated('Use style parameter with ButtonStyle presets instead')
  final ButtonVariant? variant;

  /// Button size
  final ButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is loading
  final bool loading;

  /// Whether to expand to full width
  final bool fullWidth;

  const ArcaneButton({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.style,
    @Deprecated('Use style parameter instead') this.variant,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  });

  /// Primary button constructor
  const ArcaneButton.primary({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  })  : style = ButtonStyle.primary,
        variant = null;

  /// Secondary button constructor
  const ArcaneButton.secondary({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  })  : style = ButtonStyle.secondary,
        variant = null;

  /// Outline button constructor
  const ArcaneButton.outline({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  })  : style = ButtonStyle.outline,
        variant = null;

  /// Ghost button constructor
  const ArcaneButton.ghost({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  })  : style = ButtonStyle.ghost,
        variant = null;

  /// Destructive button constructor
  const ArcaneButton.destructive({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  })  : style = ButtonStyle.destructive,
        variant = null;

  /// Warning button constructor
  const ArcaneButton.warning({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  })  : style = ButtonStyle.warning,
        variant = null;

  /// Success button constructor
  const ArcaneButton.success({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  })  : style = ButtonStyle.success,
        variant = null;

  /// Link button constructor
  const ArcaneButton.link({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    super.key,
  })  : style = ButtonStyle.link,
        variant = null;

  /// Convert legacy variant to style preset
  ButtonStyle _variantToStyle(ButtonVariant v) {
    return switch (v) {
      ButtonVariant.primary => ButtonStyle.primary,
      ButtonVariant.secondary => ButtonStyle.secondary,
      ButtonVariant.outline => ButtonStyle.outline,
      ButtonVariant.ghost => ButtonStyle.ghost,
      ButtonVariant.destructive => ButtonStyle.destructive,
      ButtonVariant.success => ButtonStyle.success,
      ButtonVariant.warning => ButtonStyle.warning,
      ButtonVariant.link => ButtonStyle.link,
    };
  }

  @override
  Component build(BuildContext context) {
    final isDisabled = disabled || loading;

    // Resolve effective style (prefer style, fall back to variant, default to primary)
    final effectiveStyle = style ??
        (variant != null ? _variantToStyle(variant!) : ButtonStyle.primary);

    // Get size-specific values using tokens
    final sizeStyle = switch (size) {
      ButtonSize.small => ButtonSizeStyle.sm,
      ButtonSize.medium => ButtonSizeStyle.md,
      ButtonSize.large => ButtonSizeStyle.lg,
    };

    // Check if this is a link style
    final isLink = effectiveStyle == ButtonStyle.link;

    // Build the complete style map using tokens
    final Map<String, String> buttonStyles = {
      // Layout
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',

      // Size
      ...sizeStyle.styles,

      // Typography
      'font-weight': ArcaneTypography.weightMedium,
      'letter-spacing': ArcaneTypography.letterSpacingTight,
      'line-height': ArcaneTypography.lineHeightNormal,

      // Appearance from style preset
      ...effectiveStyle.base,

      // Border radius
      'border-radius': ArcaneRadius.md,

      // Interaction
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'opacity': isDisabled ? '0.5' : '1',
      'transition': ArcaneEffects.transitionFast,
      'white-space': 'nowrap',
      'user-select': 'none',
      '-webkit-user-select': 'none',

      // Conditional styles
      if (fullWidth) 'width': '100%',

      // Link-specific overrides
      if (isLink) 'padding': '0',
      if (isLink) 'min-height': 'auto',
      if (isLink) 'border-radius': '0',
    };

    return button(
      classes: 'arcane-button ${isDisabled ? 'disabled' : ''}',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
      },
      styles: Styles(raw: buttonStyles),
      events: {
        'click': (event) {
          if (!isDisabled && onPressed != null) {
            onPressed!();
          }
        },
      },
      [
        if (loading)
          _buildSpinner()
        else if (icon != null)
          icon!,
        if (label != null) text(label!),
        if (child != null) child!,
        if (trailing != null && !loading) trailing!,
      ],
    );
  }

  Component _buildSpinner() {
    return span(
      classes: 'arcane-button-spinner',
      styles: Styles(raw: {
        'display': 'inline-block',
        'width': '16px',
        'height': '16px',
        'border': '2px solid currentColor',
        'border-right-color': ArcaneColors.transparent,
        'border-radius': ArcaneRadius.full,
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}
