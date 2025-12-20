import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// A feature card component (Supabase-style)
/// Used for showcasing product features with icon, title, and description
class FeatureCard extends StatelessComponent {
  /// The feature title
  final String title;

  /// The feature description
  final String description;

  /// Optional icon component
  final Component? icon;

  /// Optional link URL
  final String? href;

  /// Click handler (alternative to href)
  final void Function()? onTap;

  /// Whether to show an arrow indicator
  final bool showArrow;

  /// Card orientation (vertical or horizontal)
  final bool horizontal;

  const FeatureCard({
    required this.title,
    required this.description,
    this.icon,
    this.href,
    this.onTap,
    this.showArrow = false,
    this.horizontal = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final bool isClickable = href != null || onTap != null;

    final List<Component> content = [
      // Icon
      if (icon != null)
        div(
          classes: 'arcane-feature-card-icon',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '48px',
            'height': '48px',
            'border-radius': ArcaneRadius.md,
            'background-color': ArcaneColors.accentContainer,
            'color': ArcaneColors.accent,
            'flex-shrink': '0',
            if (!horizontal) 'margin-bottom': ArcaneSpacing.lg,
          }),
          [icon!],
        ),

      // Content
      div(
        classes: 'arcane-feature-card-content',
        styles: const Styles(raw: {
          'flex': '1',
        }),
        [
          // Title with optional arrow
          div(
            classes: 'arcane-feature-card-title',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.sm,
              'font-size': ArcaneTypography.fontLg,
              'font-weight': ArcaneTypography.weightSemibold,
              'color': ArcaneColors.onSurface,
              'margin-bottom': ArcaneSpacing.sm,
            }),
            [
              text(title),
              if (showArrow && isClickable)
                span(
                  classes: 'arcane-feature-card-arrow',
                  styles: const Styles(raw: {
                    'transition': ArcaneEffects.transitionFast,
                  }),
                  [text('→')],
                ),
            ],
          ),

          // Description
          p(
            classes: 'arcane-feature-card-description',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontMd,
              'line-height': ArcaneTypography.leadingRelaxed,
              'color': ArcaneColors.muted,
              'margin': '0',
            }),
            [text(description)],
          ),
        ],
      ),
    ];

    final Map<String, String> cardStyles = {
      'display': 'flex',
      'flex-direction': horizontal ? 'row' : 'column',
      'gap': horizontal ? ArcaneSpacing.lg : '0',
      'padding': ArcaneSpacing.xl,
      'background-color': ArcaneColors.card,
      'border': '1px solid ${ArcaneColors.border}',
      'border-radius': ArcaneRadius.xl,
      'transition': ArcaneEffects.transition,
      if (isClickable) 'cursor': 'pointer',
    };

    if (href != null) {
      return a(
        classes: 'arcane-feature-card',
        href: href!,
        styles: Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        content,
      );
    }

    if (onTap != null) {
      return button(
        classes: 'arcane-feature-card',
        attributes: {'type': 'button'},
        styles: Styles(raw: {
          ...cardStyles,
          'text-align': 'left',
          'border': '1px solid ${ArcaneColors.border}',
        }),
        events: {'click': (e) => onTap!()},
        content,
      );
    }

    return div(
      classes: 'arcane-feature-card',
      styles: Styles(raw: cardStyles),
      content,
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-feature-card:hover').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
    css('.arcane-feature-card:hover .arcane-feature-card-arrow').styles(raw: {
      'transform': 'translateX(4px)',
    }),
  ];
}

/// A simple icon card for feature grids
class IconCard extends StatelessComponent {
  /// The card title
  final String title;

  /// Optional subtitle
  final String? subtitle;

  /// Icon component
  final Component icon;

  /// Click handler
  final void Function()? onTap;

  /// Optional link
  final String? href;

  const IconCard({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final bool isClickable = href != null || onTap != null;

    final List<Component> content = [
      div(
        classes: 'arcane-icon-card-icon',
        styles: const Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '40px',
          'height': '40px',
          'border-radius': ArcaneRadius.md,
          'background-color': ArcaneColors.surfaceVariant,
          'color': ArcaneColors.accent,
          'margin-bottom': ArcaneSpacing.md,
        }),
        [icon],
      ),
      span(
        classes: 'arcane-icon-card-title',
        styles: const Styles(raw: {
          'font-size': ArcaneTypography.fontMd,
          'font-weight': ArcaneTypography.weightMedium,
          'color': ArcaneColors.onSurface,
        }),
        [text(title)],
      ),
      if (subtitle != null)
        span(
          classes: 'arcane-icon-card-subtitle',
          styles: const Styles(raw: {
            'font-size': ArcaneTypography.fontSm,
            'color': ArcaneColors.muted,
            'margin-top': ArcaneSpacing.xs,
          }),
          [text(subtitle!)],
        ),
    ];

    final Map<String, String> cardStyles = {
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'center',
      'text-align': 'center',
      'padding': ArcaneSpacing.lg,
      'background-color': ArcaneColors.card,
      'border': '1px solid ${ArcaneColors.border}',
      'border-radius': ArcaneRadius.md,
      'transition': ArcaneEffects.transition,
      if (isClickable) 'cursor': 'pointer',
    };

    if (href != null) {
      return a(
        classes: 'arcane-icon-card',
        href: href!,
        styles: Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        content,
      );
    }

    if (onTap != null) {
      return button(
        classes: 'arcane-icon-card',
        attributes: {'type': 'button'},
        styles: Styles(raw: {
          ...cardStyles,
          'border': '1px solid ${ArcaneColors.border}',
        }),
        events: {'click': (e) => onTap!()},
        content,
      );
    }

    return div(
      classes: 'arcane-icon-card',
      styles: Styles(raw: cardStyles),
      content,
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-icon-card:hover').styles(raw: {
      'border-color': ArcaneColors.accent,
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}