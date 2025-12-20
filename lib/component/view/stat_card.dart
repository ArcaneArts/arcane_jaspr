import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Stat card for displaying metrics with optional trend indicator
class StatCard extends StatelessComponent {
  /// Label text
  final String label;

  /// Value to display
  final String value;

  /// Optional icon
  final String? icon;

  /// Trend value (e.g., "+12.5%")
  final String? trend;

  /// Whether the trend is positive
  final bool trendPositive;

  /// Additional description
  final String? description;

  /// Custom icon background
  final String? iconBackground;

  const StatCard({
    required this.label,
    required this.value,
    this.icon,
    this.trend,
    this.trendPositive = true,
    this.description,
    this.iconBackground,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-stat-card',
      styles: const Styles(raw: {
        'background': ArcaneColors.card,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'padding': ArcaneSpacing.xl,
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.lg,
      }),
      [
        // Header with icon and trend
        div(
          styles: const Styles(raw: {
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
                  'border-radius': ArcaneRadius.md,
                  'background': iconBackground ??
                      'linear-gradient(135deg, ${ArcaneColors.accentContainer} 0%, ${ArcaneColors.accent}20 100%)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': ArcaneTypography.fontXl,
                }),
                [text(icon!)],
              ),
            if (trend != null)
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': ArcaneSpacing.xs,
                  'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                  'border-radius': ArcaneRadius.sm,
                  'background': trendPositive
                      ? '${ArcaneColors.success}15'
                      : '${ArcaneColors.error}15',
                  'color': trendPositive
                      ? ArcaneColors.success
                      : ArcaneColors.error,
                  'font-size': ArcaneTypography.fontSm,
                  'font-weight': ArcaneTypography.weightMedium,
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
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.font3xl,
              'font-weight': ArcaneTypography.weightBold,
              'color': ArcaneColors.onSurface,
              'line-height': '1.2',
            }),
            [text(value)],
          ),
          div(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'margin-top': ArcaneSpacing.xs,
            }),
            [text(label)],
          ),
        ]),
        if (description != null)
          div(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'padding-top': ArcaneSpacing.md,
              'border-top': '1px solid ${ArcaneColors.border}',
            }),
            [text(description!)],
          ),
      ],
    );
  }
}

/// A row of stat cards
class StatCardRow extends StatelessComponent {
  /// Stat cards to display
  final List<StatCard> cards;

  /// Number of columns
  final int columns;

  /// Gap between cards
  final double gap;

  const StatCardRow({
    required this.cards,
    this.columns = 4,
    this.gap = 24,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-stat-card-row',
      styles: Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat($columns, 1fr)',
        'gap': '${gap}px',
      }),
      cards,
    );
  }
}