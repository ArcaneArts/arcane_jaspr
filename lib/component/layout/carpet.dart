import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// A background container component that provides a subtle surface layer.
///
/// Useful for creating visual hierarchy in layouts.
class Carpet extends StatelessComponent {
  /// The child component
  final Component child;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Background color override
  final Color? color;

  /// Whether to add a border
  final bool border;

  const Carpet({
    required this.child,
    this.padding,
    this.radius,
    this.color,
    this.border = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final effectivePadding = padding ?? const EdgeInsets.all(16);
    final effectiveRadius = radius ?? theme.borderRadiusPx;

    return div(
      classes: 'arcane-carpet',
      styles: Styles(raw: {
        'background-color': color?.css ?? 'var(--arcane-surface-variant)',
        'border-radius': '${effectiveRadius}px',
        'padding': effectivePadding.padding,
        if (border) 'border': '1px solid var(--arcane-outline-variant)',
      }),
      [child],
    );
  }
}

/// A surface component with customizable elevation and appearance
class Surface extends StatelessComponent {
  final Component child;
  final EdgeInsets? padding;
  final double? radius;
  final int elevation;
  final Color? color;
  final bool border;

  const Surface({
    required this.child,
    this.padding,
    this.radius,
    this.elevation = 1,
    this.color,
    this.border = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final effectiveRadius = radius ?? theme.borderRadiusPx;

    // Generate shadow based on elevation
    String boxShadow;
    switch (elevation) {
      case 0:
        boxShadow = 'none';
        break;
      case 1:
        boxShadow = '0 1px 2px rgba(0, 0, 0, 0.05)';
        break;
      case 2:
        boxShadow = '0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06)';
        break;
      case 3:
        boxShadow =
            '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)';
        break;
      case 4:
        boxShadow =
            '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)';
        break;
      default:
        boxShadow =
            '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)';
    }

    return div(
      classes: 'arcane-surface',
      styles: Styles(raw: {
        'background-color': color?.css ?? 'var(--arcane-surface)',
        'border-radius': '${effectiveRadius}px',
        if (padding != null) 'padding': padding!.padding,
        if (border) 'border': '1px solid var(--arcane-outline-variant)',
        'box-shadow': boxShadow,
      }),
      [child],
    );
  }
}

/// A divider component
class Divider extends StatelessComponent {
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
  final bool vertical;

  const Divider({
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.vertical = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (vertical) {
      return div(
        classes: 'arcane-divider-vertical',
        styles: Styles(raw: {
          'width': '${thickness ?? 1}px',
          'background-color': color?.css ?? 'var(--arcane-outline-variant)',
          'align-self': 'stretch',
          if (indent != null) 'margin-top': '${indent}px',
          if (endIndent != null) 'margin-bottom': '${endIndent}px',
        }),
        [],
      );
    } else {
      return div(
        classes: 'arcane-divider',
        styles: Styles(raw: {
          'height': '${thickness ?? 1}px',
          'background-color': color?.css ?? 'var(--arcane-outline-variant)',
          'width': '100%',
          if (indent != null) 'margin-left': '${indent}px',
          if (endIndent != null) 'margin-right': '${endIndent}px',
        }),
        [],
      );
    }
  }
}
