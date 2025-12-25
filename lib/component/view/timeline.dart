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
import 'icon.dart';

/// Timeline layout options
enum TimelineLayout {
  /// Vertical layout with content on the right
  vertical,

  /// Horizontal layout
  horizontal,

  /// Alternating layout - content alternates left and right
  alternating,
}

/// Timeline item status
enum TimelineStatus {
  /// Default/neutral state
  default_,

  /// Completed step
  complete,

  /// Current/active step
  current,

  /// Pending/upcoming step
  pending,

  /// Error state
  error,
}

/// Timeline item data
class ArcaneTimelineItem {
  /// Item title
  final String title;

  /// Optional subtitle (e.g., date, time)
  final String? subtitle;

  /// Optional description
  final String? description;

  /// Optional date/time string
  final String? date;

  /// Custom icon (if not provided, uses status-based default)
  final Component? icon;

  /// Item status
  final TimelineStatus status;

  /// Optional custom content (replaces description)
  final Component? content;

  const ArcaneTimelineItem({
    required this.title,
    this.subtitle,
    this.description,
    this.date,
    this.icon,
    this.status = TimelineStatus.default_,
    this.content,
  });
}

/// Timeline size options
enum TimelineSize {
  sm,
  md,
  lg,
}

/// A timeline component for displaying chronological events or process steps.
///
/// Supports vertical, horizontal, and alternating layouts.
///
/// ```dart
/// ArcaneTimeline(
///   items: [
///     ArcaneTimelineItem(
///       title: 'Step 1',
///       description: 'First step',
///       status: TimelineStatus.complete,
///     ),
///     ArcaneTimelineItem(
///       title: 'Step 2',
///       description: 'Current step',
///       status: TimelineStatus.current,
///     ),
///   ],
/// )
/// ```
class ArcaneTimeline extends StatelessComponent {
  /// Timeline items
  final List<ArcaneTimelineItem> items;

  /// Layout type
  final TimelineLayout layout;

  /// Size
  final TimelineSize size;

  /// Whether to show connector lines
  final bool showConnectors;

  const ArcaneTimeline({
    required this.items,
    this.layout = TimelineLayout.vertical,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  });

  /// Vertical layout timeline
  const ArcaneTimeline.vertical({
    required this.items,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  }) : layout = TimelineLayout.vertical;

  /// Horizontal layout timeline
  const ArcaneTimeline.horizontal({
    required this.items,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  }) : layout = TimelineLayout.horizontal;

  /// Alternating layout timeline
  const ArcaneTimeline.alternating({
    required this.items,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  }) : layout = TimelineLayout.alternating;

  String get _indicatorSize => switch (size) {
        TimelineSize.sm => '24px',
        TimelineSize.md => '32px',
        TimelineSize.lg => '40px',
      };

  String get _connectorWidth => switch (size) {
        TimelineSize.sm => '2px',
        TimelineSize.md => '2px',
        TimelineSize.lg => '3px',
      };

  String get _iconSize => switch (size) {
        TimelineSize.sm => ArcaneTypography.fontXs,
        TimelineSize.md => ArcaneTypography.fontSm,
        TimelineSize.lg => ArcaneTypography.fontMd,
      };

  @override
  Component build(BuildContext context) {
    return switch (layout) {
      TimelineLayout.vertical => _buildVertical(),
      TimelineLayout.horizontal => _buildHorizontal(),
      TimelineLayout.alternating => _buildAlternating(),
    };
  }

  Component _buildVertical() {
    return div(
      classes: 'arcane-timeline arcane-timeline-vertical',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'position': 'relative',
      }),
      [
        for (var i = 0; i < items.length; i++) _buildVerticalItem(items[i], i),
      ],
    );
  }

  Component _buildVerticalItem(ArcaneTimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final colors = _getStatusColors(item.status);

    return div(
      classes: 'arcane-timeline-item',
      styles: Styles(raw: {
        'display': 'flex',
        'gap': ArcaneSpacing.lg,
        'position': 'relative',
        'padding-bottom': isLast ? '0' : ArcaneSpacing.xl,
      }),
      [
        // Indicator and connector column
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            // Indicator
            _buildIndicator(item, colors),
            // Connector line
            if (showConnectors && !isLast)
              div(
                classes: 'arcane-timeline-connector',
                styles: Styles(raw: {
                  'width': _connectorWidth,
                  'flex': '1',
                  'min-height': ArcaneSpacing.lg,
                  'background': item.status == TimelineStatus.complete
                      ? colors['line']!
                      : ArcaneColors.border,
                  'position': 'absolute',
                  'top': _indicatorSize,
                  'bottom': '0',
                }),
                [],
              ),
          ],
        ),
        // Content column
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'padding-top': '4px',
          }),
          [
            _buildContent(item, colors),
          ],
        ),
      ],
    );
  }

  Component _buildHorizontal() {
    return div(
      classes: 'arcane-timeline arcane-timeline-horizontal',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
        'overflow-x': 'auto',
      }),
      [
        for (var i = 0; i < items.length; i++) _buildHorizontalItem(items[i], i),
      ],
    );
  }

  Component _buildHorizontalItem(ArcaneTimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final colors = _getStatusColors(item.status);

    return div(
      classes: 'arcane-timeline-item',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'flex': isLast ? '0 0 auto' : '1',
        'min-width': '120px',
      }),
      [
        // Indicator row with connectors
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'width': '100%',
          }),
          [
            _buildIndicator(item, colors),
            // Connector line
            if (showConnectors && !isLast)
              div(
                classes: 'arcane-timeline-connector',
                styles: Styles(raw: {
                  'flex': '1',
                  'height': _connectorWidth,
                  'background': item.status == TimelineStatus.complete
                      ? colors['line']!
                      : ArcaneColors.border,
                  'margin': '0 ${ArcaneSpacing.sm}',
                }),
                [],
              ),
          ],
        ),
        // Content below
        div(
          styles: const Styles(raw: {
            'margin-top': ArcaneSpacing.md,
            'text-align': 'center',
            'padding-right': ArcaneSpacing.md,
          }),
          [
            _buildContent(item, colors, centered: true),
          ],
        ),
      ],
    );
  }

  Component _buildAlternating() {
    return div(
      classes: 'arcane-timeline arcane-timeline-alternating',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'position': 'relative',
      }),
      [
        for (var i = 0; i < items.length; i++)
          _buildAlternatingItem(items[i], i),
      ],
    );
  }

  Component _buildAlternatingItem(ArcaneTimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final isEven = index % 2 == 0;
    final colors = _getStatusColors(item.status);

    return div(
      classes: 'arcane-timeline-item',
      styles: Styles(raw: {
        'display': 'grid',
        'grid-template-columns': '1fr auto 1fr',
        'gap': ArcaneSpacing.lg,
        'position': 'relative',
        'padding-bottom': isLast ? '0' : ArcaneSpacing.xl,
      }),
      [
        // Left content (shows on even indexes)
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'justify-content': 'flex-end',
            'padding-top': '4px',
            'visibility': isEven ? 'visible' : 'hidden',
          }),
          [
            if (isEven) _buildContent(item, colors, alignEnd: true),
          ],
        ),
        // Center indicator column
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            _buildIndicator(item, colors),
            if (showConnectors && !isLast)
              div(
                classes: 'arcane-timeline-connector',
                styles: Styles(raw: {
                  'width': _connectorWidth,
                  'flex': '1',
                  'min-height': ArcaneSpacing.lg,
                  'background': item.status == TimelineStatus.complete
                      ? colors['line']!
                      : ArcaneColors.border,
                  'position': 'absolute',
                  'top': _indicatorSize,
                  'bottom': '0',
                }),
                [],
              ),
          ],
        ),
        // Right content (shows on odd indexes)
        div(
          styles: Styles(raw: {
            'padding-top': '4px',
            'visibility': !isEven ? 'visible' : 'hidden',
          }),
          [
            if (!isEven) _buildContent(item, colors),
          ],
        ),
      ],
    );
  }

  Component _buildIndicator(
      ArcaneTimelineItem item, Map<String, String> colors) {
    final hasCustomIcon = item.icon != null;
    final isFilled =
        item.status == TimelineStatus.complete ||
        item.status == TimelineStatus.current;

    return div(
      classes: 'arcane-timeline-indicator arcane-timeline-indicator-${item.status.name}',
      styles: Styles(raw: {
        'width': _indicatorSize,
        'height': _indicatorSize,
        'border-radius': ArcaneRadius.full,
        'background': isFilled ? colors['bg']! : ArcaneColors.background,
        'border': '2px solid ${colors['border']!}',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'font-size': _iconSize,
        'font-weight': ArcaneTypography.weightSemibold,
        'color': isFilled ? colors['text']! : colors['border']!,
        'flex-shrink': '0',
        'z-index': '1',
        'transition': ArcaneEffects.transitionFast,
      }),
      [
        if (hasCustomIcon)
          item.icon!
        else if (item.status == TimelineStatus.complete)
          span([text('✓')])
        else if (item.status == TimelineStatus.error)
          span([text('✕')])
        else if (item.status == TimelineStatus.current)
          div(
            styles: Styles(raw: {
              'width': '8px',
              'height': '8px',
              'border-radius': ArcaneRadius.full,
              'background': colors['text']!,
            }),
            [],
          )
        else
          div(
            styles: Styles(raw: {
              'width': '8px',
              'height': '8px',
              'border-radius': ArcaneRadius.full,
              'background': ArcaneColors.border,
            }),
            [],
          ),
      ],
    );
  }

  Component _buildContent(
    ArcaneTimelineItem item,
    Map<String, String> colors, {
    bool centered = false,
    bool alignEnd = false,
  }) {
    final textAlign = centered
        ? 'center'
        : alignEnd
            ? 'right'
            : 'left';

    return div(
      classes: 'arcane-timeline-content',
      styles: Styles(raw: {
        'text-align': textAlign,
      }),
      [
        // Title row with date
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-wrap': 'wrap',
            'align-items': 'center',
            'gap': ArcaneSpacing.sm,
            'margin-bottom': ArcaneSpacing.xs,
          }),
          [
            span(
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontMd,
                'font-weight': ArcaneTypography.weightSemibold,
                'color': item.status == TimelineStatus.pending
                    ? ArcaneColors.muted
                    : ArcaneColors.onSurface,
              }),
              [text(item.title)],
            ),
            if (item.date != null)
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                }),
                [text(item.date!)],
              ),
          ],
        ),
        // Subtitle
        if (item.subtitle != null)
          div(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'margin-bottom': ArcaneSpacing.xs,
            }),
            [text(item.subtitle!)],
          ),
        // Description or custom content
        if (item.content != null)
          div(
            styles: const Styles(raw: {
              'margin-top': ArcaneSpacing.sm,
            }),
            [item.content!],
          )
        else if (item.description != null)
          div(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'line-height': ArcaneTypography.leadingRelaxed,
            }),
            [text(item.description!)],
          ),
      ],
    );
  }

  Map<String, String> _getStatusColors(TimelineStatus status) {
    return switch (status) {
      TimelineStatus.complete => {
          'bg': ArcaneColors.success,
          'border': ArcaneColors.success,
          'text': ArcaneColors.background,
          'line': ArcaneColors.success,
        },
      TimelineStatus.current => {
          'bg': ArcaneColors.accent,
          'border': ArcaneColors.accent,
          'text': ArcaneColors.background,
          'line': ArcaneColors.accent,
        },
      TimelineStatus.pending => {
          'bg': 'transparent',
          'border': ArcaneColors.border,
          'text': ArcaneColors.muted,
          'line': ArcaneColors.border,
        },
      TimelineStatus.error => {
          'bg': ArcaneColors.error,
          'border': ArcaneColors.error,
          'text': ArcaneColors.background,
          'line': ArcaneColors.error,
        },
      TimelineStatus.default_ => {
          'bg': 'transparent',
          'border': ArcaneColors.border,
          'text': ArcaneColors.muted,
          'line': ArcaneColors.border,
        },
    };
  }
}

/// Alias for ArcaneTimeline
typedef ATimeline = ArcaneTimeline;
