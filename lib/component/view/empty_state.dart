import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/style_types/index.dart' hide BorderRadius;

/// Empty state style variants
enum EmptyStateStyle {
  /// Default centered style
  centered,

  /// Compact inline style
  compact,

  /// Card-wrapped style
  card,
}

/// Empty state size variants
enum EmptyStateSize {
  sm,
  md,
  lg,
}

/// Empty state placeholder component
///
/// Displays a friendly message when there's no content to show.
///
/// ```dart
/// ArcaneEmptyState(
///   icon: '📭',
///   title: 'No messages',
///   description: 'Your inbox is empty.',
///   action: ArcaneButton(label: 'Compose', onPressed: () {}),
/// )
/// ```
class ArcaneEmptyState extends StatelessComponent {
  /// Icon or illustration (can be emoji, icon component, or image)
  final Component? icon;

  /// Emoji shortcut (alternative to icon)
  final String? emoji;

  /// Title text
  final String title;

  /// Description text
  final String? description;

  /// Primary action button
  final Component? action;

  /// Secondary action button
  final Component? secondaryAction;

  /// Style variant
  final EmptyStateStyle style;

  /// Size variant
  final EmptyStateSize size;

  const ArcaneEmptyState({
    required this.title,
    this.icon,
    this.emoji,
    this.description,
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  });

  /// No results variant
  const ArcaneEmptyState.noResults({
    this.title = 'No results found',
    this.description = 'Try adjusting your search or filter criteria.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  })  : icon = null,
        emoji = '🔍';

  /// No data variant
  const ArcaneEmptyState.noData({
    this.title = 'No data yet',
    this.description = 'Start by adding your first item.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  })  : icon = null,
        emoji = '📊';

  /// Error variant
  const ArcaneEmptyState.error({
    this.title = 'Something went wrong',
    this.description = 'An error occurred while loading the content.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  })  : icon = null,
        emoji = '⚠️';

  /// Offline variant
  const ArcaneEmptyState.offline({
    this.title = 'You\'re offline',
    this.description = 'Check your internet connection and try again.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  })  : icon = null,
        emoji = '📡';

  (String iconSize, String titleSize, String descSize, String padding, String gap) get _sizeStyles =>
      switch (size) {
        EmptyStateSize.sm => ('32px', ArcaneTypography.fontMd, ArcaneTypography.fontSm, ArcaneSpacing.md, ArcaneSpacing.sm),
        EmptyStateSize.md => ('48px', ArcaneTypography.fontLg, ArcaneTypography.fontMd, ArcaneSpacing.xl, ArcaneSpacing.md),
        EmptyStateSize.lg => ('64px', ArcaneTypography.fontXl, ArcaneTypography.fontLg, ArcaneSpacing.xxl, ArcaneSpacing.lg),
      };

  @override
  Component build(BuildContext context) {
    final (iconSize, titleSize, descSize, padding, gap) = _sizeStyles;

    final content = div(
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'text-align': 'center',
        'padding': padding,
        'gap': gap,
      }),
      [
        // Icon/Emoji
        if (icon != null || emoji != null)
          div(
            styles: Styles(raw: {
              'font-size': iconSize,
              'line-height': '1',
              'opacity': '0.6',
            }),
            [
              if (icon != null) icon!,
              if (icon == null && emoji != null) text(emoji!),
            ],
          ),

        // Title
        div(
          styles: Styles(raw: {
            'font-size': titleSize,
            'font-weight': ArcaneTypography.weightSemibold,
            'color': ArcaneColors.onSurface,
          }),
          [text(title)],
        ),

        // Description
        if (description != null)
          div(
            styles: Styles(raw: {
              'font-size': descSize,
              'color': ArcaneColors.muted,
              'max-width': '360px',
            }),
            [text(description!)],
          ),

        // Actions
        if (action != null || secondaryAction != null)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'gap': ArcaneSpacing.sm,
              'margin-top': ArcaneSpacing.sm,
            }),
            [
              if (action != null) action!,
              if (secondaryAction != null) secondaryAction!,
            ],
          ),
      ],
    );

    if (style == EmptyStateStyle.card) {
      return div(
        styles: const Styles(raw: {
          'background': ArcaneColors.surface,
          'border': '1px solid ${ArcaneColors.border}',
          'border-radius': ArcaneRadius.lg,
        }),
        [content],
      );
    }

    return content;
  }
}