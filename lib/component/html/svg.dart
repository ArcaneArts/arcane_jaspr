import 'package:jaspr/jaspr.dart';

/// SVG size presets
enum SvgSize {
  /// Extra small (12px)
  xs,

  /// Small (16px)
  sm,

  /// Medium (20px)
  md,

  /// Large (24px)
  lg,

  /// Extra large (32px)
  xl,

  /// Double extra large (48px)
  xxl,
}

extension SvgSizeExtension on SvgSize {
  String get css => switch (this) {
        SvgSize.xs => '12',
        SvgSize.sm => '16',
        SvgSize.md => '20',
        SvgSize.lg => '24',
        SvgSize.xl => '32',
        SvgSize.xxl => '48',
      };
}

/// SVG wrapper component for creating inline SVG elements
///
/// Provides a clean abstraction over raw SVG elements.
///
/// ```dart
/// ArcaneSvg(
///   viewBox: '0 0 24 24',
///   size: SvgSize.lg,
///   children: [
///     ArcaneSvgPath(d: 'M12 2L...'),
///   ],
/// )
/// ```
class ArcaneSvg extends StatelessComponent {
  /// SVG viewBox attribute
  final String viewBox;

  /// Width and height (if size not specified)
  final String? width;
  final String? height;

  /// Size preset
  final SvgSize? size;

  /// Fill color (default: currentColor)
  final String fill;

  /// Stroke color
  final String? stroke;

  /// Stroke width
  final String? strokeWidth;

  /// Additional attributes
  final Map<String, String>? attributes;

  /// SVG child elements (paths, circles, etc.)
  final List<Component> children;

  /// CSS class
  final String? className;

  const ArcaneSvg({
    this.viewBox = '0 0 24 24',
    this.width,
    this.height,
    this.size,
    this.fill = 'currentColor',
    this.stroke,
    this.strokeWidth,
    this.attributes,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveWidth = size?.css ?? width ?? '24';
    final effectiveHeight = size?.css ?? height ?? '24';

    return Component.element(
      tag: 'svg',
      classes: className,
      attributes: {
        'width': effectiveWidth,
        'height': effectiveHeight,
        'viewBox': viewBox,
        'fill': fill,
        if (stroke != null) 'stroke': stroke!,
        if (strokeWidth != null) 'stroke-width': strokeWidth!,
        ...?attributes,
      },
      children: children,
    );
  }
}

/// SVG path element
///
/// ```dart
/// ArcaneSvgPath(
///   d: 'M12 2L15.09 8.26L22 9.27L17 14.14L18.18 21.02L12 17.77L5.82 21.02L7 14.14L2 9.27L8.91 8.26L12 2Z',
///   fill: 'currentColor',
/// )
/// ```
class ArcaneSvgPath extends StatelessComponent {
  /// Path data
  final String d;

  /// Fill color
  final String? fill;

  /// Stroke color
  final String? stroke;

  /// Stroke width
  final String? strokeWidth;

  /// Fill rule
  final String? fillRule;

  /// Clip rule
  final String? clipRule;

  /// Stroke line cap
  final String? strokeLinecap;

  /// Stroke line join
  final String? strokeLinejoin;

  const ArcaneSvgPath({
    required this.d,
    this.fill,
    this.stroke,
    this.strokeWidth,
    this.fillRule,
    this.clipRule,
    this.strokeLinecap,
    this.strokeLinejoin,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'path',
      attributes: {
        'd': d,
        if (fill != null) 'fill': fill!,
        if (stroke != null) 'stroke': stroke!,
        if (strokeWidth != null) 'stroke-width': strokeWidth!,
        if (fillRule != null) 'fill-rule': fillRule!,
        if (clipRule != null) 'clip-rule': clipRule!,
        if (strokeLinecap != null) 'stroke-linecap': strokeLinecap!,
        if (strokeLinejoin != null) 'stroke-linejoin': strokeLinejoin!,
      },
      children: [],
    );
  }
}

/// SVG circle element
class ArcaneSvgCircle extends StatelessComponent {
  final String cx;
  final String cy;
  final String r;
  final String? fill;
  final String? stroke;
  final String? strokeWidth;

  const ArcaneSvgCircle({
    required this.cx,
    required this.cy,
    required this.r,
    this.fill,
    this.stroke,
    this.strokeWidth,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'circle',
      attributes: {
        'cx': cx,
        'cy': cy,
        'r': r,
        if (fill != null) 'fill': fill!,
        if (stroke != null) 'stroke': stroke!,
        if (strokeWidth != null) 'stroke-width': strokeWidth!,
      },
      children: [],
    );
  }
}

/// SVG rect element
class ArcaneSvgRect extends StatelessComponent {
  final String x;
  final String y;
  final String width;
  final String height;
  final String? rx;
  final String? ry;
  final String? fill;
  final String? stroke;
  final String? strokeWidth;

  const ArcaneSvgRect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.rx,
    this.ry,
    this.fill,
    this.stroke,
    this.strokeWidth,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'rect',
      attributes: {
        'x': x,
        'y': y,
        'width': width,
        'height': height,
        if (rx != null) 'rx': rx!,
        if (ry != null) 'ry': ry!,
        if (fill != null) 'fill': fill!,
        if (stroke != null) 'stroke': stroke!,
        if (strokeWidth != null) 'stroke-width': strokeWidth!,
      },
      children: [],
    );
  }
}

/// SVG line element
class ArcaneSvgLine extends StatelessComponent {
  final String x1;
  final String y1;
  final String x2;
  final String y2;
  final String? stroke;
  final String? strokeWidth;
  final String? strokeLinecap;

  const ArcaneSvgLine({
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    this.stroke,
    this.strokeWidth,
    this.strokeLinecap,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'line',
      attributes: {
        'x1': x1,
        'y1': y1,
        'x2': x2,
        'y2': y2,
        if (stroke != null) 'stroke': stroke!,
        if (strokeWidth != null) 'stroke-width': strokeWidth!,
        if (strokeLinecap != null) 'stroke-linecap': strokeLinecap!,
      },
      children: [],
    );
  }
}

/// SVG polyline element
class ArcaneSvgPolyline extends StatelessComponent {
  final String points;
  final String? fill;
  final String? stroke;
  final String? strokeWidth;
  final String? strokeLinecap;
  final String? strokeLinejoin;

  const ArcaneSvgPolyline({
    required this.points,
    this.fill,
    this.stroke,
    this.strokeWidth,
    this.strokeLinecap,
    this.strokeLinejoin,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'polyline',
      attributes: {
        'points': points,
        if (fill != null) 'fill': fill!,
        if (stroke != null) 'stroke': stroke!,
        if (strokeWidth != null) 'stroke-width': strokeWidth!,
        if (strokeLinecap != null) 'stroke-linecap': strokeLinecap!,
        if (strokeLinejoin != null) 'stroke-linejoin': strokeLinejoin!,
      },
      children: [],
    );
  }
}

/// SVG polygon element
class ArcaneSvgPolygon extends StatelessComponent {
  final String points;
  final String? fill;
  final String? stroke;
  final String? strokeWidth;

  const ArcaneSvgPolygon({
    required this.points,
    this.fill,
    this.stroke,
    this.strokeWidth,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'polygon',
      attributes: {
        'points': points,
        if (fill != null) 'fill': fill!,
        if (stroke != null) 'stroke': stroke!,
        if (strokeWidth != null) 'stroke-width': strokeWidth!,
      },
      children: [],
    );
  }
}

/// SVG group element
class ArcaneSvgGroup extends StatelessComponent {
  final List<Component> children;
  final String? fill;
  final String? stroke;
  final String? strokeWidth;
  final String? transform;

  const ArcaneSvgGroup({
    required this.children,
    this.fill,
    this.stroke,
    this.strokeWidth,
    this.transform,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'g',
      attributes: {
        if (fill != null) 'fill': fill!,
        if (stroke != null) 'stroke': stroke!,
        if (strokeWidth != null) 'stroke-width': strokeWidth!,
        if (transform != null) 'transform': transform!,
      },
      children: children,
    );
  }
}
