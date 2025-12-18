import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Timeline item data class
class TimelineItem {
  final String title;
  final String? subtitle;
  final String? description;
  final String? icon;
  final String? iconColor;
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
  final List<TimelineItem> items;
  final String lineColor;
  final String activeColor;

  const Timeline({
    required this.items,
    this.lineColor = '#3F3F46',
    this.activeColor = '#10B981',
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'position': 'relative',
      }),
      [
        for (var i = 0; i < items.length; i++) _buildItem(items[i], i),
      ],
    );
  }

  Component _buildItem(TimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final dotColor = item.completed ? activeColor : lineColor;

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'gap': '20px',
        'position': 'relative',
        'padding-bottom': isLast ? '0' : '32px',
      }),
      [
        // Timeline dot and line
        div(
          styles: Styles(raw: {
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
                'border-radius': '50%',
                'background': item.completed ? dotColor : '#0A0A0B',
                'border': '2px solid $dotColor',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'z-index': '1',
              }),
              [
                if (item.completed)
                  span(
                    styles: Styles(raw: {
                      'color': '#0A0A0B',
                      'font-size': '10px',
                      'font-weight': '700',
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
          styles: Styles(raw: {
            'flex': '1',
            'padding-top': '0',
          }),
          [
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '12px',
                'margin-bottom': '4px',
              }),
              [
                span(
                  styles: Styles(raw: {
                    'font-size': '16px',
                    'font-weight': '600',
                    'color': '#FAFAFA',
                  }),
                  [text(item.title)],
                ),
                if (item.subtitle != null)
                  span(
                    styles: Styles(raw: {
                      'font-size': '13px',
                      'color': '#71717A',
                    }),
                    [text(item.subtitle!)],
                  ),
              ],
            ),
            if (item.description != null)
              div(
                styles: Styles(raw: {
                  'font-size': '14px',
                  'color': '#A1A1AA',
                  'line-height': '1.6',
                }),
                [text(item.description!)],
              ),
          ],
        ),
      ],
    );
  }
}
