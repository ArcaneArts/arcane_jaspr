import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';

/// Icon size presets
enum IconSize {
  /// 12px
  xs('12'),

  /// 14px
  sm('14'),

  /// 16px - default
  md('16'),

  /// 20px
  lg('20'),

  /// 24px
  xl('24'),

  /// 32px
  xl2('32');

  final String px;
  const IconSize(this.px);
}

/// A component for rendering SVG icons with consistent styling.
///
/// Use [ArcaneIcon] for custom SVG paths, or use the named constructors
/// for built-in icons like [ArcaneIcon.search], [ArcaneIcon.sun], etc.
///
/// Example:
/// ```dart
/// ArcaneIcon.search(size: IconSize.lg)
/// ArcaneIcon.sun(color: 'var(--arcane-accent)')
/// ArcaneIcon(
///   viewBox: '0 0 24 24',
///   children: [
///     ArcaneIconPath(d: 'M12 2L2 7l10 5 10-5-10-5z'),
///   ],
/// )
/// ```
class ArcaneIcon extends StatelessComponent {
  /// The viewBox attribute for the SVG
  final String viewBox;

  /// Icon size preset
  final IconSize size;

  /// Custom size override (px)
  final String? sizeCustom;

  /// Stroke color (defaults to currentColor)
  final String? color;

  /// Stroke width
  final String strokeWidth;

  /// Fill color
  final String fill;

  /// Stroke linecap
  final String strokeLinecap;

  /// Stroke linejoin
  final String strokeLinejoin;

  /// Additional styling
  final ArcaneStyleData? styles;

  /// SVG child elements (paths, circles, lines, etc.)
  final List<Component> children;

  /// Optional CSS classes
  final String? classes;

  const ArcaneIcon({
    this.viewBox = '0 0 24 24',
    this.size = IconSize.md,
    this.sizeCustom,
    this.color,
    this.strokeWidth = '2',
    this.fill = 'none',
    this.strokeLinecap = 'round',
    this.strokeLinejoin = 'round',
    this.styles,
    required this.children,
    this.classes,
    super.key,
  });

  // ---------------------------------------------------------------------------
  // Built-in icons
  // ---------------------------------------------------------------------------

  /// Search/magnifying glass icon
  factory ArcaneIcon.search({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'circle', attributes: const {'cx': '11', 'cy': '11', 'r': '8'}),
        Component.element(
            tag: 'path', attributes: const {'d': 'm21 21-4.35-4.35'}),
      ],
    );
  }

  /// Sun icon (for light mode toggle)
  factory ArcaneIcon.sun({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'circle', attributes: const {'cx': '12', 'cy': '12', 'r': '5'}),
        Component.element(tag: 'line', attributes: const {
          'x1': '12',
          'y1': '1',
          'x2': '12',
          'y2': '3'
        }),
        Component.element(tag: 'line', attributes: const {
          'x1': '12',
          'y1': '21',
          'x2': '12',
          'y2': '23'
        }),
        Component.element(tag: 'line', attributes: const {
          'x1': '4.22',
          'y1': '4.22',
          'x2': '5.64',
          'y2': '5.64'
        }),
        Component.element(tag: 'line', attributes: const {
          'x1': '18.36',
          'y1': '18.36',
          'x2': '19.78',
          'y2': '19.78'
        }),
        Component.element(
            tag: 'line',
            attributes: const {'x1': '1', 'y1': '12', 'x2': '3', 'y2': '12'}),
        Component.element(
            tag: 'line',
            attributes: const {'x1': '21', 'y1': '12', 'x2': '23', 'y2': '12'}),
        Component.element(tag: 'line', attributes: const {
          'x1': '4.22',
          'y1': '19.78',
          'x2': '5.64',
          'y2': '18.36'
        }),
        Component.element(tag: 'line', attributes: const {
          'x1': '18.36',
          'y1': '5.64',
          'x2': '19.78',
          'y2': '4.22'
        }),
      ],
    );
  }

  /// Moon icon (for dark mode toggle)
  factory ArcaneIcon.moon({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(tag: 'path', attributes: const {
          'd': 'M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z'
        }),
      ],
    );
  }

  /// X/close icon
  factory ArcaneIcon.close({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'path', attributes: const {'d': 'M18 6 6 18'}),
        Component.element(
            tag: 'path', attributes: const {'d': 'm6 6 12 12'}),
      ],
    );
  }

  /// Menu/hamburger icon
  factory ArcaneIcon.menu({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'line',
            attributes: const {'x1': '4', 'y1': '6', 'x2': '20', 'y2': '6'}),
        Component.element(
            tag: 'line',
            attributes: const {'x1': '4', 'y1': '12', 'x2': '20', 'y2': '12'}),
        Component.element(
            tag: 'line',
            attributes: const {'x1': '4', 'y1': '18', 'x2': '20', 'y2': '18'}),
      ],
    );
  }

  /// Chevron down icon
  factory ArcaneIcon.chevronDown({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'polyline', attributes: const {'points': '6 9 12 15 18 9'}),
      ],
    );
  }

  /// Chevron right icon
  factory ArcaneIcon.chevronRight({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'polyline', attributes: const {'points': '9 18 15 12 9 6'}),
      ],
    );
  }

  /// Check/checkmark icon
  factory ArcaneIcon.check({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'polyline', attributes: const {'points': '20 6 9 17 4 12'}),
      ],
    );
  }

  /// External link icon
  factory ArcaneIcon.externalLink({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(tag: 'path', attributes: const {
          'd': 'M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6'
        }),
        Component.element(
            tag: 'polyline', attributes: const {'points': '15 3 21 3 21 9'}),
        Component.element(
            tag: 'line',
            attributes: const {'x1': '10', 'y1': '14', 'x2': '21', 'y2': '3'}),
      ],
    );
  }

  /// Copy icon
  factory ArcaneIcon.copy({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(tag: 'rect', attributes: const {
          'x': '9',
          'y': '9',
          'width': '13',
          'height': '13',
          'rx': '2',
          'ry': '2'
        }),
        Component.element(tag: 'path', attributes: const {
          'd': 'M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1'
        }),
      ],
    );
  }

  /// Settings/gear icon
  factory ArcaneIcon.settings({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'circle', attributes: const {'cx': '12', 'cy': '12', 'r': '3'}),
        Component.element(tag: 'path', attributes: const {
          'd':
              'M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z'
        }),
      ],
    );
  }

  /// GitHub icon
  factory ArcaneIcon.github({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(tag: 'path', attributes: const {
          'd':
              'M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22'
        }),
      ],
    );
  }

  /// Arrow left icon
  factory ArcaneIcon.arrowLeft({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(
            tag: 'line',
            attributes: const {'x1': '19', 'y1': '12', 'x2': '5', 'y2': '12'}),
        Component.element(
            tag: 'polyline', attributes: const {'points': '12 19 5 12 12 5'}),
      ],
    );
  }

  /// Home icon
  factory ArcaneIcon.home({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(tag: 'path', attributes: const {
          'd': 'm3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z'
        }),
        Component.element(
            tag: 'polyline', attributes: const {'points': '9 22 9 12 15 12 15 22'}),
      ],
    );
  }

  /// Book/documentation icon
  factory ArcaneIcon.book({
    IconSize size = IconSize.md,
    String? sizeCustom,
    String? color,
    String strokeWidth = '2',
    ArcaneStyleData? styles,
    Key? key,
  }) {
    return ArcaneIcon(
      size: size,
      sizeCustom: sizeCustom,
      color: color,
      strokeWidth: strokeWidth,
      styles: styles,
      key: key,
      children: [
        Component.element(tag: 'path', attributes: const {
          'd': 'M4 19.5A2.5 2.5 0 0 1 6.5 17H20'
        }),
        Component.element(tag: 'path', attributes: const {
          'd':
              'M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z'
        }),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    final effectiveSize = sizeCustom ?? size.px;
    final effectiveColor = color ?? 'currentColor';

    return Component.element(
      tag: 'svg',
      classes: classes,
      attributes: {
        'width': effectiveSize,
        'height': effectiveSize,
        'viewBox': viewBox,
        'fill': fill,
        'stroke': effectiveColor,
        'stroke-width': strokeWidth,
        'stroke-linecap': strokeLinecap,
        'stroke-linejoin': strokeLinejoin,
      },
      styles: styles?.toStyles(),
      children: children,
    );
  }
}

/// A helper for creating SVG path elements within [ArcaneIcon]
class ArcaneIconPath extends StatelessComponent {
  final String d;
  final String? fill;
  final String? stroke;

  const ArcaneIconPath({
    required this.d,
    this.fill,
    this.stroke,
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
      },
    );
  }
}
