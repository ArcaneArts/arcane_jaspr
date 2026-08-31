import 'package:arcane_jaspr/flutter.dart';
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
        FontWeight,
        FontStyle,
        StyleRule,
        Display,
        Position,
        Overflow,
        Cursor,
        Visibility,
        Radius;

import '../../core/theme_provider.dart';
import '../../util/style_types/index.dart';

/// A spacing component that provides consistent gaps between elements.
class Gutter extends StatelessWidget {
  final GutterSize size;
  final bool horizontal;

  const Gutter({
    this.size = GutterSize.medium,
    this.horizontal = false,
    super.key,
  });

  const Gutter.xsmall({this.horizontal = false, super.key})
    : size = GutterSize.xsmall;
  const Gutter.small({this.horizontal = false, super.key})
    : size = GutterSize.small;
  const Gutter.medium({this.horizontal = false, super.key})
    : size = GutterSize.medium;
  const Gutter.large({this.horizontal = false, super.key})
    : size = GutterSize.large;
  const Gutter.xlarge({this.horizontal = false, super.key})
    : size = GutterSize.xlarge;

  @override
  Widget build(BuildContext context) {
    return context.renderers.gutter(
      GutterProps(size: size, horizontal: horizontal),
    );
  }
}

/// A flexible gap component.
class ArcaneGap extends StatelessWidget {
  final double size;
  final bool horizontal;

  const ArcaneGap(this.size, {this.horizontal = false, super.key});

  const ArcaneGap.xs({super.key}) : size = 4, horizontal = false;
  const ArcaneGap.sm({super.key}) : size = 8, horizontal = false;
  const ArcaneGap.md({super.key}) : size = 16, horizontal = false;
  const ArcaneGap.lg({super.key}) : size = 24, horizontal = false;
  const ArcaneGap.xl({super.key}) : size = 32, horizontal = false;

  @override
  Widget build(BuildContext context) {
    return context.renderers.gap(GapProps(size, horizontal: horizontal));
  }
}

/// A container component with enum-based styling.
class ArcaneBox extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;
  final PaddingPreset? padding;
  final MarginPreset? margin;
  final Background? background;
  final BorderPreset? border;
  final Radius? borderRadius;
  final Shadow? shadow;
  final Size? width;
  final Size? height;
  final String? widthCustom;
  final String? heightCustom;
  final MaxWidth? maxWidth;
  final Overflow? overflow;
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
  }) : assert(
         child != null || children != null,
         'Either child or children must be provided',
       );

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
  }) : background = Background.card,
       border = BorderPreset.subtle,
       borderRadius = Radius.md;

  @override
  Widget build(BuildContext context) {
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

    final finalStyle = baseStyle.merge(style);

    return div(
      classes: 'arcane-box',
      styles: finalStyle.toStyles(),
      child != null ? [child!] : (children ?? []),
    );
  }
}

/// An Stack component for positioning children on top of each other.
class Stack extends StatelessWidget {
  final List<Widget> children;
  final ArcaneStyleData? style;

  const Stack({required this.children, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    const baseStyle = ArcaneStyleData(position: Position.relative);

    return div(
      classes: 'arcane-stack',
      styles: baseStyle.merge(style).toStyles(),
      children,
    );
  }
}

/// A positioned child for use within a Stack.
class Positioned extends StatelessWidget {
  final Widget child;
  final String? top;
  final String? right;
  final String? bottom;
  final String? left;
  final String? inset;
  final ArcaneStyleData? style;

  const Positioned({
    required this.child,
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.inset,
    this.style,
    super.key,
  });

  const Positioned.fill({required this.child, this.style, super.key})
    : top = '0',
      right = '0',
      bottom = '0',
      left = '0',
      inset = null;

  @override
  Widget build(BuildContext context) {
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
