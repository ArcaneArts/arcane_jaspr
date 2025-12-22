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
        const Component.element(
            tag: 'circle', attributes: {'cx': '11', 'cy': '11', 'r': '8'}),
        const Component.element(
            tag: 'path', attributes: {'d': 'm21 21-4.35-4.35'}),
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
        const Component.element(
            tag: 'circle', attributes: {'cx': '12', 'cy': '12', 'r': '5'}),
        const Component.element(tag: 'line', attributes: {
          'x1': '12',
          'y1': '1',
          'x2': '12',
          'y2': '3'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '12',
          'y1': '21',
          'x2': '12',
          'y2': '23'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '4.22',
          'y1': '4.22',
          'x2': '5.64',
          'y2': '5.64'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '18.36',
          'y1': '18.36',
          'x2': '19.78',
          'y2': '19.78'
        }),
        const Component.element(
            tag: 'line',
            attributes: {'x1': '1', 'y1': '12', 'x2': '3', 'y2': '12'}),
        const Component.element(
            tag: 'line',
            attributes: {'x1': '21', 'y1': '12', 'x2': '23', 'y2': '12'}),
        const Component.element(tag: 'line', attributes: {
          'x1': '4.22',
          'y1': '19.78',
          'x2': '5.64',
          'y2': '18.36'
        }),
        const Component.element(tag: 'line', attributes: {
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
        const Component.element(tag: 'path', attributes: {
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
        const Component.element(
            tag: 'path', attributes: {'d': 'M18 6 6 18'}),
        const Component.element(
            tag: 'path', attributes: {'d': 'm6 6 12 12'}),
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
        const Component.element(
            tag: 'line',
            attributes: {'x1': '4', 'y1': '6', 'x2': '20', 'y2': '6'}),
        const Component.element(
            tag: 'line',
            attributes: {'x1': '4', 'y1': '12', 'x2': '20', 'y2': '12'}),
        const Component.element(
            tag: 'line',
            attributes: {'x1': '4', 'y1': '18', 'x2': '20', 'y2': '18'}),
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
        const Component.element(
            tag: 'polyline', attributes: {'points': '6 9 12 15 18 9'}),
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
        const Component.element(
            tag: 'polyline', attributes: {'points': '9 18 15 12 9 6'}),
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
        const Component.element(
            tag: 'polyline', attributes: {'points': '20 6 9 17 4 12'}),
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6'
        }),
        const Component.element(
            tag: 'polyline', attributes: {'points': '15 3 21 3 21 9'}),
        const Component.element(
            tag: 'line',
            attributes: {'x1': '10', 'y1': '14', 'x2': '21', 'y2': '3'}),
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
        const Component.element(tag: 'rect', attributes: {
          'x': '9',
          'y': '9',
          'width': '13',
          'height': '13',
          'rx': '2',
          'ry': '2'
        }),
        const Component.element(tag: 'path', attributes: {
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
        const Component.element(
            tag: 'circle', attributes: {'cx': '12', 'cy': '12', 'r': '3'}),
        const Component.element(tag: 'path', attributes: {
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
        const Component.element(tag: 'path', attributes: {
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
        const Component.element(
            tag: 'line',
            attributes: {'x1': '19', 'y1': '12', 'x2': '5', 'y2': '12'}),
        const Component.element(
            tag: 'polyline', attributes: {'points': '12 19 5 12 12 5'}),
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
        const Component.element(tag: 'path', attributes: {
          'd': 'm3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z'
        }),
        const Component.element(
            tag: 'polyline', attributes: {'points': '9 22 9 12 15 12 15 22'}),
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M4 19.5A2.5 2.5 0 0 1 6.5 17H20'
        }),
        const Component.element(tag: 'path', attributes: {
          'd':
              'M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z'
        }),
      ],
    );
  }

  /// Plus icon
  factory ArcaneIcon.plus({
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
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '5', 'x2': '12', 'y2': '19'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '5', 'y1': '12', 'x2': '19', 'y2': '12'
        }),
      ],
    );
  }

  /// Minus icon
  factory ArcaneIcon.minus({
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
        const Component.element(tag: 'line', attributes: {
          'x1': '5', 'y1': '12', 'x2': '19', 'y2': '12'
        }),
      ],
    );
  }

  /// Trash/delete icon
  factory ArcaneIcon.trash({
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
        const Component.element(tag: 'polyline', attributes: {'points': '3 6 5 6 21 6'}),
        const Component.element(tag: 'path', attributes: {
          'd': 'M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2'
        }),
      ],
    );
  }

  /// Edit/pencil icon
  factory ArcaneIcon.edit({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7'
        }),
        const Component.element(tag: 'path', attributes: {
          'd': 'M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z'
        }),
      ],
    );
  }

  /// Download icon
  factory ArcaneIcon.download({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4'
        }),
        const Component.element(tag: 'polyline', attributes: {'points': '7 10 12 15 17 10'}),
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '15', 'x2': '12', 'y2': '3'
        }),
      ],
    );
  }

  /// Upload icon
  factory ArcaneIcon.upload({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4'
        }),
        const Component.element(tag: 'polyline', attributes: {'points': '17 8 12 3 7 8'}),
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '3', 'x2': '12', 'y2': '15'
        }),
      ],
    );
  }

  /// User icon
  factory ArcaneIcon.user({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2'
        }),
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '7', 'r': '4'
        }),
      ],
    );
  }

  /// Mail/email icon
  factory ArcaneIcon.mail({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z'
        }),
        const Component.element(tag: 'polyline', attributes: {'points': '22,6 12,13 2,6'}),
      ],
    );
  }

  /// Heart icon
  factory ArcaneIcon.heart({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z'
        }),
      ],
    );
  }

  /// Star icon
  factory ArcaneIcon.star({
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
        const Component.element(tag: 'polygon', attributes: {
          'points': '12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2'
        }),
      ],
    );
  }

  /// Lock icon
  factory ArcaneIcon.lock({
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
        const Component.element(tag: 'rect', attributes: {
          'x': '3', 'y': '11', 'width': '18', 'height': '11', 'rx': '2', 'ry': '2'
        }),
        const Component.element(tag: 'path', attributes: {
          'd': 'M7 11V7a5 5 0 0 1 10 0v4'
        }),
      ],
    );
  }

  /// Bell/notification icon
  factory ArcaneIcon.bell({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9'
        }),
        const Component.element(tag: 'path', attributes: {
          'd': 'M13.73 21a2 2 0 0 1-3.46 0'
        }),
      ],
    );
  }

  /// Calendar icon
  factory ArcaneIcon.calendar({
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
        const Component.element(tag: 'rect', attributes: {
          'x': '3', 'y': '4', 'width': '18', 'height': '18', 'rx': '2', 'ry': '2'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '16', 'y1': '2', 'x2': '16', 'y2': '6'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '8', 'y1': '2', 'x2': '8', 'y2': '6'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '3', 'y1': '10', 'x2': '21', 'y2': '10'
        }),
      ],
    );
  }

  /// Folder icon
  factory ArcaneIcon.folder({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z'
        }),
      ],
    );
  }

  /// File icon
  factory ArcaneIcon.file({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z'
        }),
        const Component.element(tag: 'polyline', attributes: {'points': '13 2 13 9 20 9'}),
      ],
    );
  }

  /// Image icon
  factory ArcaneIcon.image({
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
        const Component.element(tag: 'rect', attributes: {
          'x': '3', 'y': '3', 'width': '18', 'height': '18', 'rx': '2', 'ry': '2'
        }),
        const Component.element(tag: 'circle', attributes: {
          'cx': '8.5', 'cy': '8.5', 'r': '1.5'
        }),
        const Component.element(tag: 'polyline', attributes: {
          'points': '21 15 16 10 5 21'
        }),
      ],
    );
  }

  /// Code icon
  factory ArcaneIcon.code({
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
        const Component.element(tag: 'polyline', attributes: {'points': '16 18 22 12 16 6'}),
        const Component.element(tag: 'polyline', attributes: {'points': '8 6 2 12 8 18'}),
      ],
    );
  }

  /// Terminal icon
  factory ArcaneIcon.terminal({
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
        const Component.element(tag: 'polyline', attributes: {'points': '4 17 10 11 4 5'}),
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '19', 'x2': '20', 'y2': '19'
        }),
      ],
    );
  }

  /// Link icon
  factory ArcaneIcon.link({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71'
        }),
        const Component.element(tag: 'path', attributes: {
          'd': 'M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71'
        }),
      ],
    );
  }

  /// Globe/world icon
  factory ArcaneIcon.globe({
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
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '12', 'r': '10'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '2', 'y1': '12', 'x2': '22', 'y2': '12'
        }),
        const Component.element(tag: 'path', attributes: {
          'd': 'M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z'
        }),
      ],
    );
  }

  /// Info icon
  factory ArcaneIcon.info({
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
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '12', 'r': '10'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '16', 'x2': '12', 'y2': '12'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '8', 'x2': '12.01', 'y2': '8'
        }),
      ],
    );
  }

  /// Warning/alert triangle icon
  factory ArcaneIcon.warning({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '9', 'x2': '12', 'y2': '13'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '17', 'x2': '12.01', 'y2': '17'
        }),
      ],
    );
  }

  /// Error/X circle icon
  factory ArcaneIcon.error({
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
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '12', 'r': '10'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '15', 'y1': '9', 'x2': '9', 'y2': '15'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '9', 'y1': '9', 'x2': '15', 'y2': '15'
        }),
      ],
    );
  }

  /// Success/check circle icon
  factory ArcaneIcon.success({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M22 11.08V12a10 10 0 1 1-5.93-9.14'
        }),
        const Component.element(tag: 'polyline', attributes: {
          'points': '22 4 12 14.01 9 11.01'
        }),
      ],
    );
  }

  /// Refresh icon
  factory ArcaneIcon.refresh({
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
        const Component.element(tag: 'polyline', attributes: {
          'points': '23 4 23 10 17 10'
        }),
        const Component.element(tag: 'polyline', attributes: {
          'points': '1 20 1 14 7 14'
        }),
        const Component.element(tag: 'path', attributes: {
          'd': 'M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15'
        }),
      ],
    );
  }

  /// Filter icon
  factory ArcaneIcon.filter({
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
        const Component.element(tag: 'polygon', attributes: {
          'points': '22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3'
        }),
      ],
    );
  }

  /// More horizontal (three dots) icon
  factory ArcaneIcon.moreHorizontal({
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
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '12', 'r': '1'
        }),
        const Component.element(tag: 'circle', attributes: {
          'cx': '19', 'cy': '12', 'r': '1'
        }),
        const Component.element(tag: 'circle', attributes: {
          'cx': '5', 'cy': '12', 'r': '1'
        }),
      ],
    );
  }

  /// More vertical (three dots) icon
  factory ArcaneIcon.moreVertical({
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
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '12', 'r': '1'
        }),
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '5', 'r': '1'
        }),
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '19', 'r': '1'
        }),
      ],
    );
  }

  /// Eye icon
  factory ArcaneIcon.eye({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z'
        }),
        const Component.element(tag: 'circle', attributes: {
          'cx': '12', 'cy': '12', 'r': '3'
        }),
      ],
    );
  }

  /// Eye off icon
  factory ArcaneIcon.eyeOff({
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
        const Component.element(tag: 'path', attributes: {
          'd': 'M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '1', 'y1': '1', 'x2': '23', 'y2': '23'
        }),
      ],
    );
  }

  /// Send icon
  factory ArcaneIcon.send({
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
        const Component.element(tag: 'line', attributes: {
          'x1': '22', 'y1': '2', 'x2': '11', 'y2': '13'
        }),
        const Component.element(tag: 'polygon', attributes: {
          'points': '22 2 15 22 11 13 2 9 22 2'
        }),
      ],
    );
  }

  /// Loading spinner icon
  factory ArcaneIcon.loader({
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
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '2', 'x2': '12', 'y2': '6'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '12', 'y1': '18', 'x2': '12', 'y2': '22'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '4.93', 'y1': '4.93', 'x2': '7.76', 'y2': '7.76'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '16.24', 'y1': '16.24', 'x2': '19.07', 'y2': '19.07'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '2', 'y1': '12', 'x2': '6', 'y2': '12'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '18', 'y1': '12', 'x2': '22', 'y2': '12'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '4.93', 'y1': '19.07', 'x2': '7.76', 'y2': '16.24'
        }),
        const Component.element(tag: 'line', attributes: {
          'x1': '16.24', 'y1': '7.76', 'x2': '19.07', 'y2': '4.93'
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