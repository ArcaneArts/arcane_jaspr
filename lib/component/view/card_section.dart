import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// A card with section-style content organization.
class CardSection extends StatelessComponent {
  /// Section header
  final String? header;

  /// Header component (overrides header string)
  final Component? headerComponent;

  /// The child components
  final List<Component> children;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Gap between children
  final double gap;

  /// Trailing actions for the header
  final List<Component>? trailing;

  const CardSection({
    this.header,
    this.headerComponent,
    required this.children,
    this.padding,
    this.radius,
    this.gap = 12,
    this.trailing,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final effectiveRadius = radius ?? theme.borderRadiusPx;
    final effectivePadding = padding ?? const EdgeInsets.all(16);

    final headerWidget = headerComponent ??
        (header != null
            ? div(
                classes: 'arcane-card-section-header',
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'gap': '12px',
                  'margin-bottom': '${gap}px',
                }),
                [
                  span(
                    styles: Styles(raw: {
                      'font-size': '0.875rem',
                      'font-weight': '600',
                      'color': 'var(--arcane-on-surface-variant)',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.05em',
                    }),
                    [text(header!)],
                  ),
                  if (trailing != null && trailing!.isNotEmpty)
                    div(
                      styles: Styles(raw: {
                        'display': 'flex',
                        'gap': '8px',
                      }),
                      trailing!,
                    ),
                ],
              )
            : null);

    return div(
      classes: 'arcane-card-section',
      styles: Styles(raw: {
        'background-color': 'var(--arcane-surface)',
        'border-radius': '${effectiveRadius}px',
        'border': '1px solid var(--arcane-outline-variant)',
        'padding': effectivePadding.padding,
      }),
      [
        if (headerWidget != null) headerWidget,
        div(
          classes: 'arcane-card-section-content',
          styles: Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '${gap}px',
          }),
          children,
        ),
      ],
    );
  }
}

/// A list card that contains list items
class ListCard extends StatelessComponent {
  final String? header;
  final List<Component> children;
  final double? radius;
  final bool divided;

  const ListCard({
    this.header,
    required this.children,
    this.radius,
    this.divided = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final effectiveRadius = radius ?? theme.borderRadiusPx;

    return div(
      classes: 'arcane-list-card',
      styles: Styles(raw: {
        'background-color': 'var(--arcane-surface)',
        'border-radius': '${effectiveRadius}px',
        'border': '1px solid var(--arcane-outline-variant)',
        'overflow': 'hidden',
      }),
      [
        if (header != null)
          div(
            classes: 'arcane-list-card-header',
            styles: Styles(raw: {
              'padding': '12px 16px',
              'font-size': '0.875rem',
              'font-weight': '600',
              'color': 'var(--arcane-on-surface-variant)',
              'border-bottom': '1px solid var(--arcane-outline-variant)',
              'background-color': 'var(--arcane-surface-variant)',
            }),
            [text(header!)],
          ),
        for (var i = 0; i < children.length; i++) ...[
          children[i],
          if (divided && i < children.length - 1)
            div(
              styles: Styles(raw: {
                'height': '1px',
                'background-color': 'var(--arcane-outline-variant)',
                'margin': '0 16px',
              }),
              [],
            ),
        ],
      ],
    );
  }
}
