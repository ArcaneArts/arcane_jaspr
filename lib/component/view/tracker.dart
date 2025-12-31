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

/// Severity level for tracker cells
enum TrackerLevel {
  /// All fine / healthy
  fine,

  /// Warning state
  warning,

  /// Critical / error state
  critical,

  /// Unknown / no data
  unknown,
}

/// Data for a single tracker cell
class TrackerData {
  /// Tooltip text to show on hover
  final String? tooltip;

  /// Severity level
  final TrackerLevel level;

  /// Optional value for the cell
  final double? value;

  /// Optional label
  final String? label;

  const TrackerData({
    this.tooltip,
    required this.level,
    this.value,
    this.label,
  });
}

/// A dense status grid for time-series or health indicators.
///
/// Similar to GitHub's contribution graph or uptime status grids.
///
/// ```dart
/// ArcaneTracker(
///   data: List.generate(90, (i) => TrackerData(
///     level: TrackerLevel.fine,
///     tooltip: 'Day ${i + 1}: 100% uptime',
///   )),
/// )
/// ```
class ArcaneTracker extends StatelessComponent {
  /// List of tracker data points
  final List<TrackerData> data;

  /// Number of columns (items per row)
  final int columns;

  /// Cell size in pixels
  final int cellSize;

  /// Gap between cells in pixels
  final int gap;

  /// Whether to show tooltips on hover
  final bool showTooltips;

  /// Whether to show a legend
  final bool showLegend;

  /// Custom colors for levels
  final Map<TrackerLevel, String>? levelColors;

  /// Callback when a cell is clicked
  final void Function(int index, TrackerData data)? onCellTap;

  const ArcaneTracker({
    required this.data,
    this.columns = 12,
    this.cellSize = 12,
    this.gap = 3,
    this.showTooltips = true,
    this.showLegend = false,
    this.levelColors,
    this.onCellTap,
    super.key,
  });

  /// Creates a week-based tracker (7 columns)
  const ArcaneTracker.weekly({
    required this.data,
    this.cellSize = 14,
    this.gap = 3,
    this.showTooltips = true,
    this.showLegend = true,
    this.levelColors,
    this.onCellTap,
    super.key,
  }) : columns = 7;

  /// Creates a month-based tracker
  const ArcaneTracker.monthly({
    required this.data,
    this.cellSize = 12,
    this.gap = 2,
    this.showTooltips = true,
    this.showLegend = true,
    this.levelColors,
    this.onCellTap,
    super.key,
  }) : columns = 31;

  String _getColor(TrackerLevel level) {
    if (levelColors != null && levelColors!.containsKey(level)) {
      return levelColors![level]!;
    }
    return switch (level) {
      TrackerLevel.fine => ArcaneColors.success,
      TrackerLevel.warning => ArcaneColors.warning,
      TrackerLevel.critical => ArcaneColors.error,
      TrackerLevel.unknown => ArcaneColors.surfaceVariant,
    };
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-tracker',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.md,
      }),
      [
        // Grid
        div(
          classes: 'arcane-tracker-grid',
          styles: Styles(raw: {
            'display': 'grid',
            'grid-template-columns': 'repeat($columns, ${cellSize}px)',
            'gap': '${gap}px',
          }),
          [
            for (var i = 0; i < data.length; i++)
              _buildCell(i, data[i]),
          ],
        ),

        // Legend
        if (showLegend)
          div(
            classes: 'arcane-tracker-legend',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.md,
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.muted,
            }),
            [
              span([text('Less')]),
              for (final level in TrackerLevel.values)
                div(
                  styles: Styles(raw: {
                    'width': '${cellSize}px',
                    'height': '${cellSize}px',
                    'border-radius': ArcaneRadius.sm,
                    'background': _getColor(level),
                  }),
                  [],
                ),
              span([text('More')]),
            ],
          ),
      ],
    );
  }

  Component _buildCell(int index, TrackerData cellData) {
    final hasTooltip = showTooltips && cellData.tooltip != null;

    return div(
      classes: 'arcane-tracker-cell',
      attributes: {
        if (hasTooltip) 'title': cellData.tooltip!,
        'data-level': cellData.level.name,
        'data-index': '$index',
      },
      styles: Styles(raw: {
        'width': '${cellSize}px',
        'height': '${cellSize}px',
        'border-radius': ArcaneRadius.sm,
        'background': _getColor(cellData.level),
        'cursor': onCellTap != null ? 'pointer' : 'default',
        'transition': ArcaneEffects.transitionFast,
      }),
      events: onCellTap != null
          ? {'click': (_) => onCellTap!(index, cellData)}
          : null,
      [],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-tracker-cell:hover').styles(raw: {
      'transform': 'scale(1.2)',
      'z-index': '1',
    }),
  ];
}

/// Uptime tracker showing percentage bars
///
/// ```dart
/// ArcaneUptimeTracker(
///   days: [
///     UptimeDay(date: DateTime.now(), uptime: 100),
///     UptimeDay(date: DateTime.now().subtract(Duration(days: 1)), uptime: 99.5),
///   ],
/// )
/// ```
class ArcaneUptimeTracker extends StatelessComponent {
  /// List of uptime data by day
  final List<UptimeDay> days;

  /// Height of bars in pixels
  final int barHeight;

  /// Width of each bar in pixels
  final int barWidth;

  /// Gap between bars
  final int gap;

  /// Whether to show date labels
  final bool showDates;

  /// Whether to show percentage on hover
  final bool showPercentage;

  const ArcaneUptimeTracker({
    required this.days,
    this.barHeight = 32,
    this.barWidth = 4,
    this.gap = 2,
    this.showDates = false,
    this.showPercentage = true,
    super.key,
  });

  String _getBarColor(double uptime) {
    if (uptime >= 99.9) return ArcaneColors.success;
    if (uptime >= 99.0) return ArcaneColors.successContainer;
    if (uptime >= 95.0) return ArcaneColors.warning;
    return ArcaneColors.error;
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-uptime-tracker',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Bars
        div(
          classes: 'arcane-uptime-bars',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-end',
            'gap': '${gap}px',
            'height': '${barHeight}px',
          }),
          [
            for (final day in days)
              div(
                classes: 'arcane-uptime-bar',
                attributes: {
                  if (showPercentage)
                    'title': '${day.date.month}/${day.date.day}: ${day.uptime.toStringAsFixed(2)}%',
                },
                styles: Styles(raw: {
                  'width': '${barWidth}px',
                  'height': '${(day.uptime / 100 * barHeight).round()}px',
                  'min-height': '2px',
                  'background': _getBarColor(day.uptime),
                  'border-radius': '${barWidth / 2}px ${barWidth / 2}px 0 0',
                  'transition': ArcaneEffects.transitionFast,
                }),
                [],
              ),
          ],
        ),

        // Percentage summary
        if (days.isNotEmpty)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
            }),
            [
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                }),
                [text('${days.length} days')],
              ),
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': ArcaneColors.success,
                }),
                [
                  text(
                    '${_calculateAverageUptime().toStringAsFixed(2)}% uptime',
                  )
                ],
              ),
            ],
          ),
      ],
    );
  }

  double _calculateAverageUptime() {
    if (days.isEmpty) return 0;
    return days.map((d) => d.uptime).reduce((a, b) => a + b) / days.length;
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-uptime-bar:hover').styles(raw: {
      'opacity': '0.8',
    }),
  ];
}

/// Data for a single day in uptime tracker
class UptimeDay {
  /// The date
  final DateTime date;

  /// Uptime percentage (0-100)
  final double uptime;

  /// Optional incidents for this day
  final int incidents;

  const UptimeDay({
    required this.date,
    required this.uptime,
    this.incidents = 0,
  });
}
