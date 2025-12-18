import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';
import 'button.dart';

/// A floating action button component.
class FAB extends StatelessComponent {
  /// The icon to display
  final Component icon;

  /// Optional label for extended FAB
  final String? label;

  /// Click handler
  final void Function()? onPressed;

  /// FAB variant
  final FABVariant variant;

  /// FAB size
  final FABSize size;

  /// Whether the FAB is disabled
  final bool disabled;

  /// Position of the FAB
  final FABPosition position;

  /// Tooltip text
  final String? tooltip;

  const FAB({
    required this.icon,
    this.label,
    this.onPressed,
    this.variant = FABVariant.primary,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final isExtended = label != null;

    // Get size-specific dimensions
    final (dimension, iconSize) = switch (size) {
      FABSize.small => (40.0, 18.0),
      FABSize.regular => (56.0, 24.0),
      FABSize.large => (72.0, 32.0),
    };

    // Get variant-specific colors
    final (bgColor, textColor, hoverBg) = switch (variant) {
      FABVariant.primary => (
          'var(--arcane-primary)',
          'var(--arcane-on-primary)',
          'var(--arcane-primary)',
        ),
      FABVariant.secondary => (
          'var(--arcane-secondary-container)',
          'var(--arcane-on-secondary-container)',
          'var(--arcane-secondary-container)',
        ),
      FABVariant.tertiary => (
          'var(--arcane-tertiary-container)',
          'var(--arcane-on-tertiary-container)',
          'var(--arcane-tertiary-container)',
        ),
      FABVariant.surface => (
          'var(--arcane-surface)',
          'var(--arcane-on-surface)',
          'var(--arcane-surface)',
        ),
    };

    // Get position styles
    final positionStyles = switch (position) {
      FABPosition.bottomRight => {
          'position': 'fixed',
          'bottom': '24px',
          'right': '24px',
        },
      FABPosition.bottomLeft => {
          'position': 'fixed',
          'bottom': '24px',
          'left': '24px',
        },
      FABPosition.bottomCenter => {
          'position': 'fixed',
          'bottom': '24px',
          'left': '50%',
          'transform': 'translateX(-50%)',
        },
      FABPosition.topRight => {
          'position': 'fixed',
          'top': '24px',
          'right': '24px',
        },
      FABPosition.topLeft => {
          'position': 'fixed',
          'top': '24px',
          'left': '24px',
        },
      FABPosition.relative => <String, String>{},
    };

    return button(
      classes: 'arcane-fab arcane-fab-${variant.name} ${disabled ? 'disabled' : ''} ${isExtended ? 'extended' : ''}',
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
        'gap': isExtended ? '12px' : '0',
        if (!isExtended) 'width': '${dimension}px',
        if (isExtended) 'padding': '0 20px',
        'height': '${dimension}px',
        'border-radius': isExtended ? '${dimension / 2}px' : '${dimension * 0.3}px',
        'background-color': bgColor,
        'color': textColor,
        'border': 'none',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'box-shadow':
            '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
        'transition': 'all 200ms ease',
        'z-index': '50',
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
            styles: Styles(raw: {
              'font-weight': '500',
              'font-size': '0.875rem',
              'white-space': 'nowrap',
            }),
            [text(label!)],
          ),
      ],
    );
  }

  // TODO: Fix @css section for Jaspr 0.22.0
  // @css
  // static final List<StyleRule> styles = [...];
}

/// FAB variant
enum FABVariant {
  primary,
  secondary,
  tertiary,
  surface,
}

/// FAB size
enum FABSize {
  small,
  regular,
  large,
}

/// FAB position
enum FABPosition {
  bottomRight,
  bottomLeft,
  bottomCenter,
  topRight,
  topLeft,
  relative,
}
