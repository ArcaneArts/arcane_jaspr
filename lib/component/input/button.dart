import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// Button style variants
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

  /// Button variant
  final ButtonVariant variant;

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
    this.variant = ButtonVariant.primary,
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
  }) : variant = ButtonVariant.primary;

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
  }) : variant = ButtonVariant.secondary;

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
  }) : variant = ButtonVariant.outline;

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
  }) : variant = ButtonVariant.ghost;

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
  }) : variant = ButtonVariant.destructive;

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
  }) : variant = ButtonVariant.link;

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final isDisabled = disabled || loading;

    // Get size-specific styles (Supabase-style sizing)
    final (paddingH, paddingV, fontSize, minHeight, gap) = switch (size) {
      ButtonSize.small => (12.0, 6.0, 0.8125, 32.0, 6.0),
      ButtonSize.medium => (16.0, 10.0, 0.875, 40.0, 8.0),
      ButtonSize.large => (24.0, 12.0, 1.0, 48.0, 10.0),
    };

    // Get variant-specific styles (Supabase-inspired)
    final (bgColor, textColor, borderColor) = switch (variant) {
      ButtonVariant.primary => (
          'var(--arcane-accent)',
          'var(--arcane-accent-foreground)',
          'transparent',
        ),
      ButtonVariant.secondary => (
          'var(--arcane-surface-variant)',
          'var(--arcane-on-surface)',
          'var(--arcane-border)',
        ),
      ButtonVariant.outline => (
          'transparent',
          'var(--arcane-on-surface)',
          'var(--arcane-border)',
        ),
      ButtonVariant.ghost => (
          'transparent',
          'var(--arcane-on-surface)',
          'transparent',
        ),
      ButtonVariant.destructive => (
          'var(--arcane-destructive)',
          'var(--arcane-destructive-foreground)',
          'transparent',
        ),
      ButtonVariant.success => (
          'var(--arcane-success)',
          'var(--arcane-success-foreground)',
          'transparent',
        ),
      ButtonVariant.warning => (
          'var(--arcane-warning)',
          'var(--arcane-warning-foreground)',
          'transparent',
        ),
      ButtonVariant.link => (
          'transparent',
          'var(--arcane-accent)',
          'transparent',
        ),
    };

    return button(
      classes: 'arcane-button arcane-button-${variant.name} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '${gap}px',
        'padding': '${paddingV}px ${paddingH}px',
        'min-height': '${minHeight}px',
        'font-size': '${fontSize}rem',
        'font-weight': '500',
        'letter-spacing': '-0.01em',
        'line-height': '1.5',
        'border-radius': 'var(--arcane-radius)',
        'background-color': bgColor,
        'color': textColor,
        'border': borderColor == 'transparent'
            ? 'none'
            : '1px solid $borderColor',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'var(--arcane-transition-fast)',
        'white-space': 'nowrap',
        'user-select': 'none',
        '-webkit-user-select': 'none',
        if (fullWidth) 'width': '100%',
        if (variant == ButtonVariant.link) 'text-decoration': 'underline',
        if (variant == ButtonVariant.link) 'padding': '0',
        if (variant == ButtonVariant.link) 'min-height': 'auto',
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
