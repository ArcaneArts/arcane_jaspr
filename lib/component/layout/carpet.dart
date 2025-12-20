import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/arcane.dart';
import '../../util/appearance/colors.dart';
import '../../util/tokens/tokens.dart';

/// A background container component that provides a subtle surface layer.
///
/// Useful for creating visual hierarchy in layouts.
class ArcaneCarpet extends StatelessComponent {
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

  const ArcaneCarpet({
    required this.child,
    this.padding,
    this.radius,
    this.color,
    this.border = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final EdgeInsets effectivePadding = padding ?? const EdgeInsets.all(16);
    final String effectiveRadius = radius != null ? '${radius}px' : ArcaneRadius.md;

    return div(
      classes: 'arcane-carpet',
      styles: Styles(raw: {
        'background-color': color?.css ?? ArcaneColors.surfaceVariant,
        'border-radius': effectiveRadius,
        'padding': effectivePadding.padding,
        if (border) 'border': '1px solid ${ArcaneColors.border}',
      }),
      [child],
    );
  }
}

/// A surface component with customizable elevation and appearance
class ArcaneSurface extends StatelessComponent {
  final Component child;
  final EdgeInsets? padding;
  final double? radius;
  final int elevation;
  final Color? color;
  final bool border;

  const ArcaneSurface({
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
    final String effectiveRadius = radius != null ? '${radius}px' : ArcaneRadius.md;

    // Generate shadow based on elevation
    String boxShadow;
    switch (elevation) {
      case 0:
        boxShadow = 'none';
        break;
      case 1:
        boxShadow = ArcaneEffects.shadowXs;
        break;
      case 2:
        boxShadow = ArcaneEffects.shadowSm;
        break;
      case 3:
        boxShadow = ArcaneEffects.shadowMd;
        break;
      case 4:
        boxShadow = ArcaneEffects.shadowLg;
        break;
      default:
        boxShadow = ArcaneEffects.shadowXl;
    }

    return div(
      classes: 'arcane-surface',
      styles: Styles(raw: {
        'background-color': color?.css ?? ArcaneColors.surface,
        'border-radius': effectiveRadius,
        if (padding != null) 'padding': padding!.padding,
        if (border) 'border': '1px solid ${ArcaneColors.border}',
        'box-shadow': boxShadow,
      }),
      [child],
    );
  }
}

/// A divider component
class ArcaneDivider extends StatelessComponent {
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
  final bool vertical;

  const ArcaneDivider({
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
          'background-color': color?.css ?? ArcaneColors.border,
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
          'background-color': color?.css ?? ArcaneColors.border,
          'width': '100%',
          if (indent != null) 'margin-left': '${indent}px',
          if (endIndent != null) 'margin-right': '${endIndent}px',
        }),
        [],
      );
    }
  }
}
