import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/flexi_cards_props.dart';

/// Win95 FlexiCards renderer (neutral placeholder skeleton).
///
/// Uses CSS Grid with `grid-template-rows` to expand and collapse. The grid
/// technique is only a layout mechanism here: `FlexiCardsProps.transitionDuration`
/// is deliberately not honoured, because a Windows 95 pane changed size in a
/// single repaint and nothing about it eased.
class Win95FlexiCards extends StatefulComponent {
  final FlexiCardsProps props;

  const Win95FlexiCards(this.props, {super.key});

  @override
  State<Win95FlexiCards> createState() => _Win95FlexiCardsState();
}

class _Win95FlexiCardsState extends State<Win95FlexiCards> {
  int? _hoveredIndex;

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'win95-flexi-cards',
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
          classes: 'win95-flexi-card-header',
          styles: const dom.Styles(
            raw: {
              'margin': '-1.5rem -1.5rem 1rem -1.5rem',
              'padding': '0.75rem 1rem',
              'border-bottom': '1px solid var(--border)',
            },
          ),
          [item.header!],
        ),

      // Icon treatment
      dom.div(
        classes: 'win95-flexi-card-icon',
        styles: const dom.Styles(
          raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '52px',
            'height': '52px',
            'border-radius': 'var(--radius-md)',
            'background': 'var(--muted)',
            'border': '1px solid var(--border)',
            'color': 'var(--foreground)',
            'margin-bottom': '1.125rem',
            'transition': 'none',
          },
        ),
        [item.icon],
      ),

      // Short text (title)
      dom.h3(
        classes: 'win95-flexi-card-title',
        styles: const dom.Styles(
          raw: {
            'font-size': 'var(--font-size-lg, 1.125rem)',
            'font-weight': 'var(--font-weight-semibold, 600)',
            'color': 'var(--foreground)',
            'margin': '0 0 0.5rem 0',
            'transition': 'none',
          },
        ),
        [Component.text(item.shortText)],
      ),

      // Long text is always present and visible.
      dom.div(
        classes: 'win95-flexi-card-long-text-wrapper',
        styles: dom.Styles(
          raw: {
            'display': 'grid',
            'grid-template-rows': '1fr',
            'transition': 'none',
          },
        ),
        [
          dom.div(
            classes: 'win95-flexi-card-long-text-inner',
            styles: const dom.Styles(
              raw: {'overflow': 'hidden', 'min-height': '0'},
            ),
            [
              dom.p(
                classes: 'win95-flexi-card-description',
                styles: dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-sm, 0.875rem)',
                    'color': 'var(--muted-foreground)',
                    'margin': '0',
                    'padding-bottom': '1rem',
                    'line-height': '1.6',
                    'opacity': '1',
                    'transition': 'none',
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
          classes: 'win95-flexi-card-footer-wrapper',
          styles: dom.Styles(
            raw: {
              'display': 'grid',
              'grid-template-rows': '1fr',
              'transition': 'none',
            },
          ),
          [
            dom.div(
              classes: 'win95-flexi-card-footer-inner',
              styles: const dom.Styles(
                raw: {'overflow': 'hidden', 'min-height': '0'},
              ),
              [
                dom.div(
                  classes: 'win95-flexi-card-footer',
                  styles: dom.Styles(
                    raw: {
                      'padding-top': '1rem',
                      'border-top': '1px solid var(--border)',
                      'opacity': '1',
                      'transition': 'none',
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
      'background': isHovered ? 'var(--muted)' : 'var(--card)',
      'border': '1px solid var(--border)',
      'border-radius': 'var(--radius-md)',
      'transition': 'none',
      'overflow': 'hidden',
    };

    Component card = dom.div(
      classes: 'win95-flexi-card${isHovered ? ' hovered' : ''}',
      attributes: const <String, String>{'data-arcane-surface': 'flexi-card'},
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

/// Win95 FlexiCardsSimple renderer (neutral placeholder skeleton).
class Win95FlexiCardsSimple extends StatelessComponent {
  final FlexiCardsSimpleProps props;

  const Win95FlexiCardsSimple(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'win95-flexi-cards-simple',
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
      classes: 'win95-flexi-card-simple',
      attributes: const <String, String>{'data-arcane-surface': 'flexi-card'},
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'padding': '1.5rem',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-md)',
          'transition': 'none',
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
