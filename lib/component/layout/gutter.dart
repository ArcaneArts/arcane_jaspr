import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, FontStyle, StyleRule, Display, Position, Overflow, Cursor, Visibility, Radius;

import '../../util/tokens/tokens.dart';
import '../../util/style_types/index.dart' hide BorderRadius;

/// Gutter size options
enum ArcaneGutterSize {
  xsmall(4),
  small(8),
  medium(16),
  large(24),
  xlarge(32);

  final double pixels;
  const ArcaneGutterSize(this.pixels);
}

/// A spacing component that provides consistent gaps between elements.
class ArcaneGutter extends StatelessComponent {
  /// The size of the gutter
  final ArcaneGutterSize size;

  /// Whether to render as a horizontal gutter
  final bool horizontal;

  const ArcaneGutter({
    this.size = ArcaneGutterSize.medium,
    this.horizontal = false,
    super.key,
  });

  const ArcaneGutter.xsmall({this.horizontal = false, super.key}) : size = ArcaneGutterSize.xsmall;
  const ArcaneGutter.small({this.horizontal = false, super.key}) : size = ArcaneGutterSize.small;
  const ArcaneGutter.medium({this.horizontal = false, super.key}) : size = ArcaneGutterSize.medium;
  const ArcaneGutter.large({this.horizontal = false, super.key}) : size = ArcaneGutterSize.large;
  const ArcaneGutter.xlarge({this.horizontal = false, super.key}) : size = ArcaneGutterSize.xlarge;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-gutter',
      styles: Styles(raw: {
        if (horizontal) 'width': '${size.pixels}px' else 'height': '${size.pixels}px',
        'flex-shrink': '0',
      }),
      [],
    );
  }
}

/// A flexible gap component
class ArcaneGap extends StatelessComponent {
  final double size;
  final bool horizontal;

  const ArcaneGap(this.size, {this.horizontal = false, super.key});

  const ArcaneGap.xs({super.key}) : size = 4, horizontal = false;
  const ArcaneGap.sm({super.key}) : size = 8, horizontal = false;
  const ArcaneGap.md({super.key}) : size = 16, horizontal = false;
  const ArcaneGap.lg({super.key}) : size = 24, horizontal = false;
  const ArcaneGap.xl({super.key}) : size = 32, horizontal = false;

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        if (horizontal) 'width': '${size}px' else 'height': '${size}px',
        'flex-shrink': '0',
      }),
      [],
    );
  }
}

/// A container component with enum-based styling.
///
/// ArcaneBox is the primary building block for creating styled containers.
/// It supports all ArcaneStyleData properties through a clean, Flutter-like API.
///
/// Example:
/// ```dart
/// // Simple box with padding and background
/// ArcaneBox(
///   padding: PaddingPreset.md,
///   background: Background.card,
///   borderRadius: Radius.lg,
///   child: ArcaneText('Hello'),
/// )
///
/// // Card-like box
/// ArcaneBox(
///   padding: PaddingPreset.lg,
///   background: Background.card,
///   border: BorderPreset.subtle,
///   borderRadius: Radius.xl,
///   shadow: Shadow.md,
///   child: content,
/// )
///
/// // Full custom styling
/// ArcaneBox(
///   style: ArcaneStyleData(
///     display: Display.flex,
///     padding: PaddingPreset.mdLg,
///     background: Background.surface,
///   ),
///   child: content,
/// )
/// ```
class ArcaneBox extends StatelessComponent {
  /// The child component
  final Component? child;

  /// Multiple children (alternative to child)
  final List<Component>? children;

  /// Padding preset
  final PaddingPreset? padding;

  /// Margin preset
  final MarginPreset? margin;

  /// Background color
  final Background? background;

  /// Border preset
  final BorderPreset? border;

  /// Border radius
  final Radius? borderRadius;

  /// Box shadow
  final Shadow? shadow;

  /// Width
  final Size? width;

  /// Height
  final Size? height;

  /// Custom width (pixels, percentages, etc.)
  final String? widthCustom;

  /// Custom height (pixels, percentages, etc.)
  final String? heightCustom;

  /// Max width preset
  final MaxWidth? maxWidth;

  /// Overflow behavior
  final Overflow? overflow;

  /// Full ArcaneStyleData for complete customization
  /// (takes precedence over individual properties)
  final ArcaneStyleData? style;

  const ArcaneBox({
    this.child,
    this.children,
    this.padding,
    this.margin,
    this.background,
    this.border,
    this.borderRadius,
    this.shadow,
    this.width,
    this.height,
    this.widthCustom,
    this.heightCustom,
    this.maxWidth,
    this.overflow,
    this.style,
    super.key,
  }) : assert(child != null || children != null,
            'Either child or children must be provided');

  /// Create an ArcaneBox with card styling
  const ArcaneBox.card({
    this.child,
    this.children,
    this.padding = PaddingPreset.lg,
    this.margin,
    this.shadow = Shadow.md,
    this.width,
    this.height,
    this.widthCustom,
    this.heightCustom,
    this.maxWidth,
    this.overflow,
    this.style,
    super.key,
  })  : background = Background.card,
        border = BorderPreset.subtle,
        borderRadius = Radius.lg;

  /// Create an ArcaneBox with glass styling
  const ArcaneBox.glass({
    this.child,
    this.children,
    this.padding = PaddingPreset.lg,
    this.margin,
    this.shadow,
    this.width,
    this.height,
    this.widthCustom,
    this.heightCustom,
    this.maxWidth,
    this.overflow,
    this.style,
    super.key,
  })  : background = Background.surfaceVariant,
        border = BorderPreset.subtle,
        borderRadius = Radius.lg;

  @override
  Component build(BuildContext context) {
    // Build base style from individual properties
    final baseStyle = ArcaneStyleData(
      padding: padding,
      margin: margin,
      background: background,
      border: border,
      borderRadius: borderRadius,
      shadow: shadow,
      width: width,
      height: height,
      widthCustom: widthCustom,
      heightCustom: heightCustom,
      maxWidth: maxWidth,
      overflow: overflow,
    );

    // Merge with custom style (custom takes precedence)
    final finalStyle = baseStyle.merge(style);

    return div(
      classes: 'arcane-box',
      styles: finalStyle.toStyles(),
      child != null ? [child!] : (children ?? []),
    );
  }
}

/// An ArcaneStack component for positioning children on top of each other.
///
/// Children can use absolute positioning to overlay each other.
///
/// Example:
/// ```dart
/// ArcaneStack(
///   children: [
///     Image(...),
///     ArcanePositioned(
///       bottom: '16px',
///       right: '16px',
///       child: ArcaneBadge(...),
///     ),
///   ],
/// )
/// ```
class ArcaneStack extends StatelessComponent {
  /// The child components
  final List<Component> children;

  /// Full ArcaneStyleData for customization
  final ArcaneStyleData? style;

  const ArcaneStack({
    required this.children,
    this.style,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final baseStyle = const ArcaneStyleData(
      position: Position.relative,
    );

    return div(
      classes: 'arcane-stack',
      styles: baseStyle.merge(style).toStyles(),
      children,
    );
  }
}

/// A positioned child for use within an ArcaneStack.
class ArcanePositioned extends StatelessComponent {
  /// The child component
  final Component child;

  /// Top offset
  final String? top;

  /// Right offset
  final String? right;

  /// Bottom offset
  final String? bottom;

  /// Left offset
  final String? left;

  /// Inset (shorthand for all)
  final String? inset;

  /// Additional style
  final ArcaneStyleData? style;

  const ArcanePositioned({
    required this.child,
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.inset,
    this.style,
    super.key,
  });

  /// Fill the entire parent
  const ArcanePositioned.fill({
    required this.child,
    this.style,
    super.key,
  })  : top = '0',
        right = '0',
        bottom = '0',
        left = '0',
        inset = null;

  @override
  Component build(BuildContext context) {
    final baseStyle = ArcaneStyleData(
      position: Position.absolute,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      inset: inset,
    );

    return div(
      classes: 'arcane-positioned',
      styles: baseStyle.merge(style).toStyles(),
      [child],
    );
  }
}
