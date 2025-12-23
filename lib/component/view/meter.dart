import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Meter style variants
enum MeterStyle {
  /// Standard horizontal bar
  bar,

  /// Gradient bar
  gradient,

  /// Segmented/stepped meter
  segmented,

  /// Circular/radial meter
  circular,
}

/// Meter color variants
enum MeterColor {
  /// Primary accent color
  primary,

  /// Success/green
  success,

  /// Warning/amber
  warning,

  /// Error/red
  error,

  /// Gradient based on value (green->yellow->red)
  adaptive,
}

/// Meter size variants
enum MeterSize {
  sm,
  md,
  lg,
}

/// Progress meter/gauge component
///
/// Displays a visual representation of a value within a range.
///
/// ```dart
/// ArcaneMeter(
///   value: 75,
///   max: 100,
///   label: 'Storage Used',
///   showValue: true,
/// )
/// ```
class ArcaneMeter extends StatelessComponent {
  /// Current value
  final double value;

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  /// Optimal minimum (for adaptive coloring)
  final double? low;

  /// Optimal maximum (for adaptive coloring)
  final double? high;

  /// Optimal value (for adaptive coloring)
  final double? optimum;

  /// Label text
  final String? label;

  /// Whether to show the value
  final bool showValue;

  /// Value format (e.g., "%", "GB", etc.)
  final String? valueSuffix;

  /// Style variant
  final MeterStyle style;

  /// Color variant
  final MeterColor color;

  /// Size variant
  final MeterSize size;

  /// Number of segments (for segmented style)
  final int segments;

  const ArcaneMeter({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.low,
    this.high,
    this.optimum,
    this.label,
    this.showValue = true,
    this.valueSuffix,
    this.style = MeterStyle.bar,
    this.color = MeterColor.primary,
    this.size = MeterSize.md,
    this.segments = 10,
    super.key,
  });

  /// Storage/disk usage meter
  const ArcaneMeter.storage({
    required this.value,
    this.max = 100,
    this.label = 'Storage',
    this.showValue = true,
    this.size = MeterSize.md,
    super.key,
  })  : min = 0,
        low = null,
        high = 80,
        optimum = null,
        valueSuffix = '%',
        style = MeterStyle.bar,
        color = MeterColor.adaptive,
        segments = 10;

  /// Battery level meter
  const ArcaneMeter.battery({
    required this.value,
    this.label,
    this.showValue = true,
    this.size = MeterSize.md,
    super.key,
  })  : min = 0,
        max = 100,
        low = 20,
        high = null,
        optimum = null,
        valueSuffix = '%',
        style = MeterStyle.segmented,
        color = MeterColor.adaptive,
        segments = 5;

  double get _percentage => ((value - min) / (max - min) * 100).clamp(0, 100);

  String get _adaptiveColor {
    final pct = _percentage;
    if (high != null && pct >= high!) {
      return ArcaneColors.error;
    }
    if (low != null && pct <= low!) {
      return ArcaneColors.error;
    }
    if (pct >= 80) {
      return ArcaneColors.warning;
    }
    return ArcaneColors.success;
  }

  String get _barColor => switch (color) {
        MeterColor.primary => ArcaneColors.accent,
        MeterColor.success => ArcaneColors.success,
        MeterColor.warning => ArcaneColors.warning,
        MeterColor.error => ArcaneColors.error,
        MeterColor.adaptive => _adaptiveColor,
      };

  (String height, String fontSize) get _sizeStyles => switch (size) {
        MeterSize.sm => ('6px', ArcaneTypography.fontXs),
        MeterSize.md => ('10px', ArcaneTypography.fontSm),
        MeterSize.lg => ('16px', ArcaneTypography.fontMd),
      };

  @override
  Component build(BuildContext context) {
    final (height, fontSize) = _sizeStyles;

    if (style == MeterStyle.circular) {
      return _buildCircularMeter(fontSize);
    }

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
        'width': '100%',
      }),
      [
        // Header with label and value
        if (label != null || showValue)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'font-size': fontSize,
            }),
            [
              if (label != null)
                span(
                  styles: const Styles(raw: {
                    'color': ArcaneColors.onSurface,
                    'font-weight': ArcaneTypography.weightMedium,
                  }),
                  [text(label!)],
                ),
              if (showValue)
                span(
                  styles: Styles(raw: {
                    'color': _barColor,
                    'font-weight': ArcaneTypography.weightSemibold,
                  }),
                  [text('${value.toStringAsFixed(0)}${valueSuffix ?? ''}')],
                ),
            ],
          ),

        // Meter bar
        if (style == MeterStyle.segmented)
          _buildSegmentedMeter(height)
        else
          _buildBarMeter(height),
      ],
    );
  }

  Component _buildBarMeter(String height) {
    final isGradient = style == MeterStyle.gradient;

    return div(
      styles: Styles(raw: {
        'width': '100%',
        'height': height,
        'background': ArcaneColors.surfaceVariant,
        'border-radius': ArcaneRadius.full,
        'overflow': 'hidden',
      }),
      [
        div(
          styles: Styles(raw: {
            'width': '$_percentage%',
            'height': '100%',
            'background': isGradient
                ? 'linear-gradient(90deg, ${ArcaneColors.success} 0%, ${ArcaneColors.warning} 50%, ${ArcaneColors.error} 100%)'
                : _barColor,
            'border-radius': ArcaneRadius.full,
            'transition': 'width 0.3s ease',
          }),
          [],
        ),
      ],
    );
  }

  Component _buildSegmentedMeter(String height) {
    final activeSegments = (_percentage / 100 * segments).ceil();

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'gap': '3px',
        'width': '100%',
      }),
      [
        for (var i = 0; i < segments; i++)
          div(
            styles: Styles(raw: {
              'flex': '1',
              'height': height,
              'background': i < activeSegments ? _barColor : ArcaneColors.surfaceVariant,
              'border-radius': ArcaneRadius.xs,
              'transition': 'background 0.3s ease',
            }),
            [],
          ),
      ],
    );
  }

  Component _buildCircularMeter(String fontSize) {
    const circleSize = 80;
    const strokeWidth = 8;
    final circumference = 2 * 3.14159 * ((circleSize - strokeWidth) / 2);
    final dashOffset = circumference * (1 - _percentage / 100);

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
      }),
      [
        div(
          styles: const Styles(raw: {
            'position': 'relative',
            'width': '${circleSize}px',
            'height': '${circleSize}px',
          }),
          [
            // SVG circle
            Component.element(
              tag: 'svg',
              attributes: {
                'width': '$circleSize',
                'height': '$circleSize',
                'viewBox': '0 0 $circleSize $circleSize',
              },
              styles: const Styles(raw: {
                'transform': 'rotate(-90deg)',
              }),
              children: [
                // Background circle
                const Component.element(
                  tag: 'circle',
                  attributes: {
                    'cx': '${circleSize / 2}',
                    'cy': '${circleSize / 2}',
                    'r': '${(circleSize - strokeWidth) / 2}',
                    'fill': 'none',
                    'stroke': ArcaneColors.surfaceVariant,
                    'stroke-width': '$strokeWidth',
                  },
                  children: [],
                ),
                // Progress circle
                Component.element(
                  tag: 'circle',
                  attributes: {
                    'cx': '${circleSize / 2}',
                    'cy': '${circleSize / 2}',
                    'r': '${(circleSize - strokeWidth) / 2}',
                    'fill': 'none',
                    'stroke': _barColor,
                    'stroke-width': '$strokeWidth',
                    'stroke-linecap': 'round',
                    'stroke-dasharray': '$circumference',
                    'stroke-dashoffset': '$dashOffset',
                  },
                  styles: const Styles(raw: {
                    'transition': 'stroke-dashoffset 0.3s ease',
                  }),
                  children: [],
                ),
              ],
            ),
            // Center value
            if (showValue)
              div(
                styles: Styles(raw: {
                  'position': 'absolute',
                  'top': '50%',
                  'left': '50%',
                  'transform': 'translate(-50%, -50%)',
                  'font-size': fontSize,
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': ArcaneColors.onSurface,
                }),
                [text('${value.toStringAsFixed(0)}${valueSuffix ?? ''}')],
              ),
          ],
        ),
        if (label != null)
          span(
            styles: Styles(raw: {
              'font-size': fontSize,
              'color': ArcaneColors.muted,
            }),
            [text(label!)],
          ),
      ],
    );
  }
}