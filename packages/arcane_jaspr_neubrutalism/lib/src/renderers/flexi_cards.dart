import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/flexi_cards_props.dart';

/// Neubrutalism FlexiCards renderer with restrained dark styling.
///
/// Uses CSS Grid with `grid-template-rows` for smooth height animations.
class NeubrutalismFlexiCards extends StatefulComponent {
  final FlexiCardsProps props;

  const NeubrutalismFlexiCards(this.props, {super.key});

  @override
  State<NeubrutalismFlexiCards> createState() => _NeubrutalismFlexiCardsState();
}

class _NeubrutalismFlexiCardsState extends State<NeubrutalismFlexiCards> {
  int? _hoveredIndex;

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-flexi-cards',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'gap': component.props.gap,
          'align-items': 'stretch',
        },
      ),
      [
        for (int i = 0; i < component.props.items.length; i++)
          _buildCard(component.props.items[i], i),
      ],
    );
  }

  Component _buildCard(FlexiCardItem item, int index) {
    final bool isHovered = _hoveredIndex == index;
    final bool hasHoveredCard = _hoveredIndex != null;
    final int duration = component.props.transitionDuration;

    // Calculate flex - shrink others when one is hovered
    final double flex = isHovered
        ? component.props.expandedFlex
        : (hasHoveredCard
              ? component.props.collapsedFlex * 0.8
              : component.props.collapsedFlex);

    // Whether to show expanded content

    final List<Component> cardContent = [
      // Header
      if (item.header != null)
        dom.div(
          classes: 'neubrutalism-flexi-card-header',
          styles: const dom.Styles(
            raw: {
              'margin': '-1.5rem -1.5rem 1rem -1.5rem',
              'padding': '0.75rem 1rem',
              'border-bottom':
                  'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
            },
          ),
          [item.header!],
        ),

      dom.div(
        classes: 'neubrutalism-flexi-card-icon',
        styles: dom.Styles(
          raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '52px',
            'height': '52px',
            'background': 'var(--nb-accent, var(--primary))',
            'color': 'var(--nb-on-accent, #000)',
            'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
            'border-radius': 'var(--nb-radius-soft, 4px)',
            'box-shadow':
                'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
            'margin-bottom': '1.125rem',
            'transition': 'all ${duration}ms ease',
          },
        ),
        [item.icon],
      ),

      dom.h3(
        classes: 'neubrutalism-flexi-card-title',
        styles: dom.Styles(
          raw: {
            'font-family': 'var(--font-heading)',
            'font-size': 'var(--font-size-lg, 1.125rem)',
            'font-weight': '900',
            'color': 'var(--foreground)',
            'margin': '0 0 0.5rem 0',
            'letter-spacing': '-0.01em',
            'transition': 'color ${duration}ms ease',
          },
        ),
        [Component.text(item.shortText)],
      ),

      // Long text is always present and visible.
      dom.div(
        classes: 'neubrutalism-flexi-card-long-text-wrapper',
        styles: dom.Styles(
          raw: {'display': 'grid', 'grid-template-rows': '1fr'},
        ),
        [
          dom.div(
            classes: 'neubrutalism-flexi-card-long-text-inner',
            styles: const dom.Styles(
              raw: {'overflow': 'hidden', 'min-height': '0'},
            ),
            [
              dom.p(
                classes: 'neubrutalism-flexi-card-description',
                styles: dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-sm, 0.875rem)',
                    'color': 'var(--muted-foreground)',
                    'margin': '0',
                    'padding-bottom': '1rem',
                    'line-height': '1.6',
                    'opacity': '1',
                  },
                ),
                [Component.text(item.longText)],
              ),
            ],
          ),
        ],
      ),

      // Spacer
      const dom.div(styles: dom.Styles(raw: {'flex': '1'}), []),

      // Footer is always present when supplied.
      if (item.footer != null)
        dom.div(
          classes: 'neubrutalism-flexi-card-footer-wrapper',
          styles: dom.Styles(
            raw: {'display': 'grid', 'grid-template-rows': '1fr'},
          ),
          [
            dom.div(
              classes: 'neubrutalism-flexi-card-footer-inner',
              styles: const dom.Styles(
                raw: {'overflow': 'hidden', 'min-height': '0'},
              ),
              [
                dom.div(
                  classes: 'neubrutalism-flexi-card-footer',
                  styles: dom.Styles(
                    raw: {
                      'padding-top': '1rem',
                      'border-top':
                          'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                      'opacity': '1',
                    },
                  ),
                  [item.footer!],
                ),
              ],
            ),
          ],
        ),
    ];

    // Calculate dimensions
    final bool useLockedWidth =
        component.props.widthPreLock != null ||
        component.props.widthPostLock != null;
    final bool useLockedHeight =
        component.props.heightPreLock != null ||
        component.props.heightPostLock != null;

    final Map<String, String> cardStyles = {
      if (!useLockedWidth) 'flex': '$flex',
      if (useLockedWidth && !isHovered && component.props.widthPreLock != null)
        'width': component.props.widthPreLock!,
      if (useLockedWidth && isHovered && component.props.widthPostLock != null)
        'width': component.props.widthPostLock!,
      if (useLockedHeight &&
          !isHovered &&
          component.props.heightPreLock != null)
        'height': component.props.heightPreLock!,
      if (useLockedHeight &&
          isHovered &&
          component.props.heightPostLock != null)
        'height': component.props.heightPostLock!,
      'min-width': component.props.minCardWidth,
      'display': 'flex',
      'flex-direction': 'column',
      'padding': '1.5rem',
      'background': 'var(--nb-paper, var(--card))',
      'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'transition':
          'flex ${duration}ms cubic-bezier(0.4, 0, 0.2, 1), '
          'width ${duration}ms cubic-bezier(0.4, 0, 0.2, 1), '
          'transform ${duration}ms ease, '
          'box-shadow ${duration}ms ease',
      'overflow': 'hidden',
      'box-shadow': isHovered
          ? 'var(--nb-shadow-lg, 7px 7px 0 0 var(--nb-shadow-color, #000))'
          : 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      if (isHovered) 'transform': 'translate(-2px, -2px)',
      if (item.onTap != null || item.href != null) 'cursor': 'pointer',
    };

    Component card = dom.div(
      classes: 'neubrutalism-flexi-card${isHovered ? ' hovered' : ''}',
      attributes: const <String, String>{
        'data-arcane-surface': 'flexi-card',
      },
      styles: dom.Styles(raw: cardStyles),
      events: {
        'mouseenter': (_) => setState(() => _hoveredIndex = index),
        'mouseleave': (_) => setState(() => _hoveredIndex = null),
        if (item.onTap != null) 'click': (_) => item.onTap!(),
      },
      cardContent,
    );

    if (item.href != null) {
      return dom.a(
        href: item.href!,
        styles: const dom.Styles(
          raw: {
            'text-decoration': 'none',
            'color': 'inherit',
            'display': 'flex',
          },
        ),
        [card],
      );
    }

    return card;
  }
}

/// Neubrutalism FlexiCardsSimple renderer.
class NeubrutalismFlexiCardsSimple extends StatelessComponent {
  final FlexiCardsSimpleProps props;

  const NeubrutalismFlexiCardsSimple(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-flexi-cards-simple',
      styles: dom.Styles(
        raw: {
          'display': 'grid',
          'grid-template-columns': 'repeat(auto-fit, minmax(250px, 1fr))',
          'gap': props.gap,
        },
      ),
      [for (final item in props.items) _buildCard(item)],
    );
  }

  Component _buildCard(FlexiCardItem item) {
    Component card = dom.div(
      classes: 'neubrutalism-flexi-card-simple',
      attributes: const <String, String>{
        'data-arcane-surface': 'flexi-card',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'padding': '1.5rem',
          'background-color': 'var(--nb-paper, var(--card))',
          'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'transition': 'all var(--nb-transition, 120ms ease)',
          if (item.onTap != null || item.href != null) 'cursor': 'pointer',
        },
      ),
      events: item.onTap != null ? {'click': (_) => item.onTap!()} : null,
      [
        // Header
        if (item.header != null) item.header!,

        // Icon
        dom.div(styles: const dom.Styles(raw: {'margin-bottom': '1rem'}), [
          item.icon,
        ]),

        // Title
        dom.h3(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-base)',
              'font-weight': 'var(--font-weight-semibold)',
              'color': 'var(--foreground)',
              'margin': '0 0 0.5rem 0',
            },
          ),
          [Component.text(item.shortText)],
        ),

        // Description
        dom.p(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin': '0',
              'line-height': '1.5',
            },
          ),
          [Component.text(item.longText)],
        ),

        // Footer
        if (item.footer != null) ...[
          const dom.div(
            styles: dom.Styles(raw: {'flex': '1', 'min-height': '1rem'}),
            [],
          ),
          item.footer!,
        ],
      ],
    );

    if (item.href != null) {
      return dom.a(
        href: item.href!,
        styles: const dom.Styles(
          raw: {'text-decoration': 'none', 'color': 'inherit'},
        ),
        [card],
      );
    }

    return card;
  }
}
