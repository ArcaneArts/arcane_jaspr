import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// FAB size variants
enum FABSize {
  small,
  regular,
  large,
}

/// FAB position variants
enum FABPosition {
  bottomRight,
  bottomLeft,
  bottomCenter,
  topRight,
  topLeft,
  relative,
}

/// A floating action button component.
///
/// Use style presets for cleaner code:
/// ```dart
/// FAB(
///   icon: Icon(Icons.add),
///   style: FABStyle.primary,
/// )
/// ```
class ArcaneFAB extends StatelessComponent {
  /// The icon to display
  final Component icon;

  /// Optional label for extended FAB
  final String? label;

  /// Click handler
  final void Function()? onPressed;

  /// Style preset (preferred)
  final FABStyle? style;

  /// FAB size
  final FABSize size;

  /// Whether the FAB is disabled
  final bool disabled;

  /// Position of the FAB
  final FABPosition position;

  /// Tooltip text
  final String? tooltip;

  const ArcaneFAB({
    required this.icon,
    this.label,
    this.onPressed,
    this.style,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    super.key,
  });

  /// Primary FAB
  const ArcaneFAB.primary({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    super.key,
  }) : style = FABStyle.primary;

  /// Surface FAB
  const ArcaneFAB.surface({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    super.key,
  }) : style = FABStyle.surface;

  /// Success FAB
  const ArcaneFAB.success({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    super.key,
  }) : style = FABStyle.success;

  /// Destructive FAB
  const ArcaneFAB.destructive({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    super.key,
  }) : style = FABStyle.destructive;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? FABStyle.primary;
    final isExtended = label != null;

    // Get size-specific dimensions
    final (dimension, iconSize) = switch (size) {
      FABSize.small => (40.0, 18.0),
      FABSize.regular => (56.0, 24.0),
      FABSize.large => (72.0, 32.0),
    };

    // Get position styles
    final Map<String, String> positionStyles = switch (position) {
      FABPosition.bottomRight => {
          'position': 'fixed',
          'bottom': ArcaneSpacing.lg,
          'right': ArcaneSpacing.lg,
        },
      FABPosition.bottomLeft => {
          'position': 'fixed',
          'bottom': ArcaneSpacing.lg,
          'left': ArcaneSpacing.lg,
        },
      FABPosition.bottomCenter => {
          'position': 'fixed',
          'bottom': ArcaneSpacing.lg,
          'left': '50%',
          'transform': 'translateX(-50%)',
        },
      FABPosition.topRight => {
          'position': 'fixed',
          'top': ArcaneSpacing.lg,
          'right': ArcaneSpacing.lg,
        },
      FABPosition.topLeft => {
          'position': 'fixed',
          'top': ArcaneSpacing.lg,
          'left': ArcaneSpacing.lg,
        },
      FABPosition.relative => {},
    };

    return button(
      classes: 'arcane-fab ${disabled ? 'disabled' : ''} ${isExtended ? 'extended' : ''}',
      attributes: {
        if (disabled) 'disabled': 'true',
        'type': 'button',
        if (tooltip != null) 'title': tooltip!,
        if (tooltip != null) 'aria-label': tooltip!,
      },
      styles: Styles(raw: {
        ...positionStyles,
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': isExtended ? ArcaneSpacing.sm : '0',
        if (!isExtended) 'width': '${dimension}px',
        if (isExtended) 'padding': '0 ${ArcaneSpacing.lg}',
        'height': '${dimension}px',
        'border-radius': isExtended ? '${dimension / 2}px' : ArcaneRadius.lg,
        'border': 'none',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'box-shadow': ArcaneEffects.shadowLg,
        'transition': ArcaneEffects.transitionNormal,
        'z-index': '${ArcaneZIndex.fab}',
        ...effectiveStyle.base,
      }),
      events: {
        'click': (event) {
          if (!disabled && onPressed != null) {
            onPressed!();
          }
        },
      },
      [
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
        if (label != null)
          span(
            styles: const Styles(raw: {
              'font-weight': ArcaneTypography.weightMedium,
              'font-size': ArcaneTypography.fontMd,
              'white-space': 'nowrap',
            }),
            [text(label!)],
          ),
      ],
    );
  }
}