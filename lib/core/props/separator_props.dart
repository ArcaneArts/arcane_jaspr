import 'package:arcane_jaspr/flutter.dart';

/// Separator visual style variants.
enum SeparatorVariant {
  /// Standard 1px border color
  standard,

  /// Subtle muted color
  subtle,

  /// Bold 2px border color
  bold,
}

/// Separator orientation.
enum SeparatorOrientation {
  horizontal,
  vertical,
}

/// Unified separator component properties.
///
/// Combines features from both Divider and Separator into a single component.
class SeparatorProps {
  /// Orientation of the separator.
  final SeparatorOrientation orientation;

  /// Visual style variant.
  final SeparatorVariant variant;

  /// Optional text label to display in the middle (horizontal only).
  final String? label;

  /// Optional icon to display in the middle (horizontal only).
  final Widget? icon;

  /// Custom color override (CSS color value).
  final String? color;

  /// Whether to render as dashed line.
  final bool dashed;

  /// Whether the separator is purely decorative (affects ARIA).
  final bool decorative;

  /// Margin around the separator in pixels.
  final double? margin;

  /// Height of vertical separator in pixels (null = stretch to fill).
  final double? height;

  const SeparatorProps({
    this.orientation = SeparatorOrientation.horizontal,
    this.variant = SeparatorVariant.standard,
    this.label,
    this.icon,
    this.color,
    this.dashed = false,
    this.decorative = true,
    this.margin,
    this.height,
  });

  SeparatorProps copyWith({
    SeparatorOrientation? orientation,
    SeparatorVariant? variant,
    String? label,
    Widget? icon,
    String? color,
    bool? dashed,
    bool? decorative,
    double? margin,
    double? height,
  }) {
    return SeparatorProps(
      orientation: orientation ?? this.orientation,
      variant: variant ?? this.variant,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      dashed: dashed ?? this.dashed,
      decorative: decorative ?? this.decorative,
      margin: margin ?? this.margin,
      height: height ?? this.height,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for separator components.
mixin SeparatorRendererContract {
  /// Renders a separator/divider component.
  Widget separator(SeparatorProps props);
}
