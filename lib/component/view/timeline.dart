import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Timeline item data class
class TimelineItem {
  /// Item title
  final String title;

  /// Subtitle (e.g., date, time)
  final String? subtitle;

  /// Description text
  final String? description;

  /// Icon to display
  final String? icon;

  /// Custom icon color
  final String? iconColor;

  /// Whether this item is completed
  final bool completed;

  const TimelineItem({
    required this.title,
    this.subtitle,
    this.description,
    this.icon,
    this.iconColor,
    this.completed = false,
  });
}

/// Timeline component for showing progression or history
class Timeline extends StatelessComponent {
  /// Timeline items
  final List<TimelineItem> items;

  /// Line color
  final String? lineColor;

  /// Active/completed item color
  final String? activeColor;

  const Timeline({
    required this.items,
    this.lineColor,
    this.activeColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String effectiveLineColor = lineColor ?? ArcaneColors.border;
    final String effectiveActiveColor = activeColor ?? ArcaneColors.success;

    return div(
      classes: 'arcane-timeline',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'position': 'relative',
      }),
      [
        for (var i = 0; i < items.length; i++)
          _buildItem(items[i], i, effectiveLineColor, effectiveActiveColor),
      ],
    );
  }

  Component _buildItem(TimelineItem item, int index, String lineColor, String activeColor) {
    final bool isLast = index == items.length - 1;
    final String dotColor = item.completed ? activeColor : lineColor;

    return div(
      classes: 'arcane-timeline-item',
      styles: Styles(raw: {
        'display': 'flex',
        'gap': ArcaneSpacing.lg,
        'position': 'relative',
        'padding-bottom': isLast ? '0' : ArcaneSpacing.xxl,
      }),
      [
        // Timeline dot and line
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            // Dot
            div(
              styles: Styles(raw: {
                'width': '16px',
                'height': '16px',
                'border-radius': ArcaneRadius.full,
                'background': item.completed ? dotColor : ArcaneColors.background,
                'border': '2px solid $dotColor',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'z-index': '1',
              }),
              [
                if (item.completed)
                  span(
                    styles: const Styles(raw: {
                      'color': ArcaneColors.background,
                      'font-size': ArcaneTypography.fontXs,
                      'font-weight': ArcaneTypography.weightBold,
                    }),
                    [text('✓')],
                  ),
              ],
            ),
            // Line
            if (!isLast)
              div(
                styles: Styles(raw: {
                  'width': '2px',
                  'flex': '1',
                  'background': lineColor,
                  'position': 'absolute',
                  'top': '20px',
                  'bottom': '0',
                }),
                [],
              ),
          ],
        ),
        // Content
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'padding-top': '0',
          }),
          [
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': ArcaneSpacing.md,
                'margin-bottom': ArcaneSpacing.xs,
              }),
              [
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
                    'font-weight': ArcaneTypography.weightSemibold,
                    'color': ArcaneColors.onSurface,
                  }),
                  [text(item.title)],
                ),
                if (item.subtitle != null)
                  span(
                    styles: const Styles(raw: {
                      'font-size': ArcaneTypography.fontSm,
                      'color': ArcaneColors.muted,
                    }),
                    [text(item.subtitle!)],
                  ),
              ],
            ),
            if (item.description != null)
              div(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                  'line-height': ArcaneTypography.leadingRelaxed,
                }),
                [text(item.description!)],
              ),
          ],
        ),
      ],
    );
  }
}