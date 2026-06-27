import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

export '../../core/props/separator_props.dart'
    show SeparatorOrientation, SeparatorVariant, SeparatorProps;

/// A visual separator/divider component.
///
/// Combines features from the previous ArcaneDivider and ArcaneSeparator
/// into a single unified component with support for:
/// - Horizontal and vertical orientations
/// - Visual variants (standard, subtle, bold)
/// - Dashed line style
/// - Labels and icons in the middle
/// - Custom colors
class ArcaneSeparator extends StatelessWidget {
  final SeparatorOrientation orientation;
  final SeparatorVariant variant;
  final String? label;
  final Widget? icon;
  final String? color;
  final bool dashed;
  final bool decorative;
  final double? margin;
  final double? height;

  const ArcaneSeparator({
    this.orientation = SeparatorOrientation.horizontal,
    this.variant = SeparatorVariant.standard,
    this.label,
    this.icon,
    this.color,
    this.dashed = false,
    this.decorative = true,
    this.margin,
    this.height,
    super.key,
  });

  /// Creates a vertical separator.
  const ArcaneSeparator.vertical({
    this.variant = SeparatorVariant.standard,
    this.color,
    this.dashed = false,
    this.decorative = true,
    this.margin,
    this.height,
    super.key,
  })  : orientation = SeparatorOrientation.vertical,
        label = null,
        icon = null;

  /// Creates a separator with a text label in the middle.
  const ArcaneSeparator.withLabel({
    required String this.label,
    this.variant = SeparatorVariant.standard,
    this.color,
    this.dashed = false,
    this.margin,
    super.key,
  })  : orientation = SeparatorOrientation.horizontal,
        icon = null,
        decorative = false,
        height = null;

  /// Creates a separator with an icon in the middle.
  const ArcaneSeparator.withIcon({
    required Widget this.icon,
    this.variant = SeparatorVariant.standard,
    this.color,
    this.dashed = false,
    this.margin,
    super.key,
  })  : orientation = SeparatorOrientation.horizontal,
        label = null,
        decorative = false,
        height = null;

  /// Creates a dashed separator.
  const ArcaneSeparator.dashed({
    this.orientation = SeparatorOrientation.horizontal,
    this.variant = SeparatorVariant.standard,
    this.label,
    this.icon,
    this.color,
    this.margin,
    this.height,
    super.key,
  })  : dashed = true,
        decorative = true;

  /// Creates a subtle (muted) separator.
  const ArcaneSeparator.subtle({
    this.orientation = SeparatorOrientation.horizontal,
    this.label,
    this.icon,
    this.color,
    this.dashed = false,
    this.margin,
    this.height,
    super.key,
  })  : variant = SeparatorVariant.subtle,
        decorative = true;

  /// Creates a bold (thicker) separator.
  const ArcaneSeparator.bold({
    this.orientation = SeparatorOrientation.horizontal,
    this.label,
    this.icon,
    this.color,
    this.dashed = false,
    this.margin,
    this.height,
    super.key,
  })  : variant = SeparatorVariant.bold,
        decorative = true;

  @override
  Widget build(BuildContext context) {
    return context.renderers.separator(SeparatorProps(
      orientation: orientation,
      variant: variant,
      label: label,
      icon: icon,
      color: color,
      dashed: dashed,
      decorative: decorative,
      margin: margin,
      height: height,
    ));
  }
}
