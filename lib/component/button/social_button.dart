import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Base social sign-in button
///
/// Provides consistent styling for OAuth provider buttons.
class SocialSignInButton extends StatelessComponent {
  /// Button label text
  final String label;

  /// Icon component (SVG or emoji)
  final Component? icon;

  /// Click handler
  final void Function()? onPressed;

  /// Button size
  final ButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is loading
  final bool loading;

  /// Whether to expand to full width
  final bool fullWidth;

  /// Background color (optional, defaults to outline style)
  final String? backgroundColor;

  /// Text/icon color (optional)
  final String? foregroundColor;

  /// Border color (optional)
  final String? borderColor;

  /// Hover background color (optional)
  final String? hoverBackgroundColor;

  const SocialSignInButton({
    required this.label,
    this.icon,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.hoverBackgroundColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final bool isDisabled = disabled || loading;

    // Size-based styles
    final Map<String, String> sizeStyles = switch (size) {
      ButtonSize.small => <String, String>{
          'padding': '8px 12px',
          'font-size': ArcaneTypography.fontXs,
          'gap': ArcaneSpacing.xs,
        },
      ButtonSize.medium => <String, String>{
          'padding': '10px 16px',
          'font-size': ArcaneTypography.fontSizeSm,
          'gap': ArcaneSpacing.xs,
        },
      ButtonSize.large => <String, String>{
          'padding': '12px 20px',
          'font-size': ArcaneTypography.fontSizeBase,
          'gap': ArcaneSpacing.sm,
        },
    };

    return button(
      classes: 'social-signin-button',
      attributes: <String, String>{
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
      },
      styles: Styles(raw: <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        ...sizeStyles,
        'font-weight': '500',
        'font-family': 'inherit',
        'background': backgroundColor ?? 'transparent',
        'color': foregroundColor ?? ArcaneColors.onBackground,
        'border': '1px solid ${borderColor ?? ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'white-space': 'nowrap',
        'user-select': 'none',
        if (fullWidth) 'width': '100%',
      }),
      events: {
        'click': (_) {
          if (!isDisabled && onPressed != null) {
            onPressed!();
          }
        },
        'mouseenter': (event) {
          if (!isDisabled) {
            final dynamic target = event.target;
            if (target != null) {
              (target as dynamic).style.background =
                  hoverBackgroundColor ?? ArcaneColors.backgroundSecondary;
            }
          }
        },
        'mouseleave': (event) {
          final dynamic target = event.target;
          if (target != null) {
            (target as dynamic).style.background =
                backgroundColor ?? 'transparent';
          }
        },
      },
      <Component>[
        if (loading)
          _buildSpinner()
        else if (icon != null)
          icon!,
        Component.text(label),
      ],
    );
  }

  Component _buildSpinner() {
    return span(
      styles: Styles(raw: <String, String>{
        'display': 'inline-block',
        'width': '16px',
        'height': '16px',
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': ArcaneRadius.full,
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      <Component>[],
    );
  }
}
