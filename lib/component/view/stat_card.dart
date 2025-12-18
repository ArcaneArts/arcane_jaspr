import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Stat card for displaying metrics with optional trend indicator
class StatCard extends StatelessComponent {
  final String label;
  final String value;
  final String? icon;
  final String? trend; // e.g., "+12.5%"
  final bool trendPositive;
  final String? description;
  final String? iconBackground;

  const StatCard({
    required this.label,
    required this.value,
    this.icon,
    this.trend,
    this.trendPositive = true,
    this.description,
    this.iconBackground,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'background': '#18181B',
        'border': '1px solid rgba(63, 63, 70, 0.5)',
        'border-radius': '16px',
        'padding': '24px',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '16px',
      }),
      [
        // Header with icon and trend
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'justify-content': 'space-between',
            'align-items': 'flex-start',
          }),
          [
            if (icon != null)
              div(
                styles: Styles(raw: {
                  'width': '48px',
                  'height': '48px',
                  'border-radius': '12px',
                  'background': iconBackground ??
                      'linear-gradient(135deg, rgba(16, 185, 129, 0.2) 0%, rgba(5, 150, 105, 0.2) 100%)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': '24px',
                }),
                [text(icon!)],
              ),
            if (trend != null)
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '4px',
                  'padding': '4px 8px',
                  'border-radius': '6px',
                  'background': trendPositive
                      ? 'rgba(16, 185, 129, 0.1)'
                      : 'rgba(239, 68, 68, 0.1)',
                  'color': trendPositive ? '#10B981' : '#EF4444',
                  'font-size': '13px',
                  'font-weight': '500',
                }),
                [
                  text(trendPositive ? '↑' : '↓'),
                  text(trend!),
                ],
              ),
          ],
        ),
        // Value and label
        div([
          div(
            styles: Styles(raw: {
              'font-size': '32px',
              'font-weight': '700',
              'color': '#FAFAFA',
              'line-height': '1.2',
            }),
            [text(value)],
          ),
          div(
            styles: Styles(raw: {
              'font-size': '14px',
              'color': '#A1A1AA',
              'margin-top': '4px',
            }),
            [text(label)],
          ),
        ]),
        if (description != null)
          div(
            styles: Styles(raw: {
              'font-size': '13px',
              'color': '#71717A',
              'padding-top': '12px',
              'border-top': '1px solid rgba(63, 63, 70, 0.5)',
            }),
            [text(description!)],
          ),
      ],
    );
  }
}
