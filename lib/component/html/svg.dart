import 'package:jaspr/jaspr.dart';

enum SvgSize { xs, sm, md, lg, xl, xxl }

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

/// SVG container wrapper.
class ArcaneSvg extends StatelessComponent {
  final String viewBox;
  final String? width;
  final String? height;
  final SvgSize? size;
  final String fill;
  final String? stroke;
  final String? strokeWidth;
  final Map<String, String>? attributes;
  final List<Component> children;
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
        'stroke': ?stroke,
        'stroke-width': ?strokeWidth,
        ...?attributes,
      },
      children: children,
    );
  }
}

/// SVG path element wrapper.
class ArcaneSvgPath extends StatelessComponent {
  final String d;
  final String? fill;
  final String? stroke;
  final String? strokeWidth;
  final String? fillRule;
  final String? clipRule;
  final String? strokeLinecap;
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
        'fill': ?fill,
        'stroke': ?stroke,
        'stroke-width': ?strokeWidth,
        'fill-rule': ?fillRule,
        'clip-rule': ?clipRule,
        'stroke-linecap': ?strokeLinecap,
        'stroke-linejoin': ?strokeLinejoin,
      },
      children: [],
    );
  }
}

/// SVG circle element wrapper.
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
        'fill': ?fill,
        'stroke': ?stroke,
        'stroke-width': ?strokeWidth,
      },
      children: [],
    );
  }
}

/// SVG rect element wrapper.
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
        'rx': ?rx,
        'ry': ?ry,
        'fill': ?fill,
        'stroke': ?stroke,
        'stroke-width': ?strokeWidth,
      },
      children: [],
    );
  }
}

/// SVG line element wrapper.
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
        'stroke': ?stroke,
        'stroke-width': ?strokeWidth,
        'stroke-linecap': ?strokeLinecap,
      },
      children: [],
    );
  }
}

/// SVG polyline element wrapper.
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
        'fill': ?fill,
        'stroke': ?stroke,
        'stroke-width': ?strokeWidth,
        'stroke-linecap': ?strokeLinecap,
        'stroke-linejoin': ?strokeLinejoin,
      },
      children: [],
    );
  }
}

/// SVG polygon element wrapper.
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
        'fill': ?fill,
        'stroke': ?stroke,
        'stroke-width': ?strokeWidth,
      },
      children: [],
    );
  }
}

/// SVG group element wrapper.
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
        'fill': ?fill,
        'stroke': ?stroke,
        'stroke-width': ?strokeWidth,
        'transform': ?transform,
      },
      children: children,
    );
  }
}
