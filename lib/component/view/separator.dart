import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// Separator orientation
enum SeparatorOrientation {
  /// Horizontal line (full width)
  horizontal,

  /// Vertical line (full height)
  vertical,
}

/// Separator visual style
enum SeparatorStyle {
  /// Solid line
  solid,

  /// Dashed line
  dashed,

  /// Dotted line
  dotted,

  /// Gradient fade
  gradient,

  /// Double line
  double_,
}

/// Separator thickness
enum SeparatorThickness {
  /// Thin (1px)
  thin,

  /// Normal (1px but more visible)
  normal,

  /// Medium (2px)
  medium,

  /// Thick (3px)
  thick,
}

/// A visual separator/divider component.
/// Creates a horizontal or vertical line to separate content.
///
/// Similar to shadcn's Separator component.
///
/// Usage:
/// ```dart
/// ArcaneSeparator()
/// ArcaneSeparator.vertical()
/// ArcaneSeparator(label: 'OR')
/// ```
class ArcaneSeparator extends StatelessComponent {
  /// Orientation of the separator
  final SeparatorOrientation orientation;

  /// Visual style
  final SeparatorStyle style;

  /// Line thickness
  final SeparatorThickness thickness;

  /// Optional label text in the middle
  final String? label;

  /// Optional icon in the middle
  final Component? icon;

  /// Custom color (overrides default)
  final String? color;

  /// Margin around the separator
  final String margin;

  /// Whether to use decorative role (no semantic meaning)
  final bool decorative;

  const ArcaneSeparator({
    this.orientation = SeparatorOrientation.horizontal,
    this.style = SeparatorStyle.solid,
    this.thickness = SeparatorThickness.thin,
    this.label,
    this.icon,
    this.color,
    this.margin = '0',
    this.decorative = true,
    super.key,
  });

  /// Creates a vertical separator
  const ArcaneSeparator.vertical({
    this.style = SeparatorStyle.solid,
    this.thickness = SeparatorThickness.thin,
    this.color,
    this.margin = '0',
    this.decorative = true,
    super.key,
  })  : orientation = SeparatorOrientation.vertical,
        label = null,
        icon = null;

  /// Creates a separator with a label
  const ArcaneSeparator.withLabel({
    required String this.label,
    this.style = SeparatorStyle.solid,
    this.thickness = SeparatorThickness.thin,
    this.color,
    this.margin = '0',
    this.decorative = false,
    super.key,
  })  : orientation = SeparatorOrientation.horizontal,
        icon = null;

  /// Creates a separator with an icon
  const ArcaneSeparator.withIcon({
    required Component this.icon,
    this.style = SeparatorStyle.solid,
    this.thickness = SeparatorThickness.thin,
    this.color,
    this.margin = '0',
    this.decorative = false,
    super.key,
  })  : orientation = SeparatorOrientation.horizontal,
        label = null;

  @override
  Component build(BuildContext context) {
    final effectiveColor = color ?? ArcaneColors.border;
    final thicknessValue = switch (thickness) {
      SeparatorThickness.thin => '1px',
      SeparatorThickness.normal => '1px',
      SeparatorThickness.medium => '2px',
      SeparatorThickness.thick => '3px',
    };

    // Handle label/icon case (horizontal only)
    if ((label != null || icon != null) &&
        orientation == SeparatorOrientation.horizontal) {
      return _buildLabeledSeparator(effectiveColor, thicknessValue);
    }

    // Simple line
    return _buildSimpleSeparator(effectiveColor, thicknessValue);
  }

  Component _buildSimpleSeparator(String effectiveColor, String thicknessValue) {
    final isHorizontal = orientation == SeparatorOrientation.horizontal;

    final Map<String, String> lineStyles = switch (style) {
      SeparatorStyle.solid => {
          if (isHorizontal)
            'border-top': '$thicknessValue solid $effectiveColor'
          else
            'border-left': '$thicknessValue solid $effectiveColor',
        },
      SeparatorStyle.dashed => {
          if (isHorizontal)
            'border-top': '$thicknessValue dashed $effectiveColor'
          else
            'border-left': '$thicknessValue dashed $effectiveColor',
        },
      SeparatorStyle.dotted => {
          if (isHorizontal)
            'border-top': '$thicknessValue dotted $effectiveColor'
          else
            'border-left': '$thicknessValue dotted $effectiveColor',
        },
      SeparatorStyle.gradient => {
          'background': isHorizontal
              ? 'linear-gradient(to right, transparent, $effectiveColor, transparent)'
              : 'linear-gradient(to bottom, transparent, $effectiveColor, transparent)',
          'height': isHorizontal ? thicknessValue : '100%',
          'width': isHorizontal ? '100%' : thicknessValue,
        },
      SeparatorStyle.double_ => {
          if (isHorizontal)
            'border-top': '$thicknessValue double $effectiveColor'
          else
            'border-left': '$thicknessValue double $effectiveColor',
        },
    };

    return Component.element(
      tag: 'hr',
      classes: 'arcane-separator',
      attributes: {
        'role': decorative ? 'none' : 'separator',
        if (!decorative) 'aria-orientation': orientation.name,
      },
      styles: Styles(raw: {
        if (isHorizontal) 'width': '100%',
        if (!isHorizontal) 'height': '100%',
        if (!isHorizontal) 'min-height': '20px',
        'margin': margin,
        'border': 'none',
        ...lineStyles,
      }),
      children: [],
    );
  }

  Component _buildLabeledSeparator(String effectiveColor, String thicknessValue) {
    final lineStyle = switch (style) {
      SeparatorStyle.solid => 'solid',
      SeparatorStyle.dashed => 'dashed',
      SeparatorStyle.dotted => 'dotted',
      SeparatorStyle.gradient => 'solid', // Fallback for gradient
      SeparatorStyle.double_ => 'double',
    };

    return div(
      classes: 'arcane-separator-labeled',
      attributes: {
        'role': decorative ? 'none' : 'separator',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.md,
        'margin': margin,
        'width': '100%',
      }),
      [
        // Left line
        div(
          styles: Styles(raw: {
            'flex': '1',
            'height': '0',
            'border-top': '$thicknessValue $lineStyle $effectiveColor',
          }),
          [],
        ),

        // Label or icon
        if (label != null)
          span(
            [text(label!)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'white-space': 'nowrap',
              'padding': '0 ${ArcaneSpacing.xs}',
            }),
          )
        else if (icon != null)
          span(
            [icon!],
            styles: const Styles(raw: {
              'color': ArcaneColors.muted,
            }),
          ),

        // Right line
        div(
          styles: Styles(raw: {
            'flex': '1',
            'height': '0',
            'border-top': '$thicknessValue $lineStyle $effectiveColor',
          }),
          [],
        ),
      ],
    );
  }
}
