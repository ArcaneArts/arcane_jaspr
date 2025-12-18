import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// An expandable/collapsible component.
class Expander extends StatefulComponent {
  /// Header content (always visible)
  final Component header;

  /// Expandable content
  final Component child;

  /// Whether initially expanded
  final bool initiallyExpanded;

  /// Callback when expansion changes
  final void Function(bool expanded)? onExpansionChanged;

  /// Custom leading icon
  final Component? leading;

  /// Whether to show the expansion icon
  final bool showIcon;

  /// Custom padding for the content
  final EdgeInsets? contentPadding;

  /// Whether to maintain child state when collapsed
  final bool maintainState;

  const Expander({
    required this.header,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.leading,
    this.showIcon = true,
    this.contentPadding,
    this.maintainState = true,
    super.key,
  });

  @override
  State<Expander> createState() => _ExpanderState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-expander-header:hover').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}

class _ExpanderState extends State<Expander> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = component.initiallyExpanded;
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    component.onExpansionChanged?.call(_isExpanded);
  }

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final contentPadding =
        component.contentPadding ?? const EdgeInsets.all(16);

    return div(
      classes: 'arcane-expander ${_isExpanded ? 'expanded' : ''}',
      styles: Styles(raw: {
        'border': '1px solid var(--arcane-outline-variant)',
        'border-radius': theme.borderRadiusCss,
        'overflow': 'hidden',
      }),
      [
        // Header (clickable)
        button(
          classes: 'arcane-expander-header',
          attributes: {
            'type': 'button',
            'aria-expanded': '$_isExpanded',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '12px',
            'width': '100%',
            'padding': '12px 16px',
            'background-color': 'var(--arcane-surface)',
            'cursor': 'pointer',
            'transition': 'background-color 150ms ease',
            'text-align': 'left',
          }),
          events: {
            'click': (event) => _toggleExpansion(),
          },
          [
            if (component.leading != null) component.leading!,
            div(
              styles: Styles(raw: {
                'flex': '1',
                'min-width': '0',
              }),
              [component.header],
            ),
            if (component.showIcon)
              span(
                classes: 'arcane-expander-icon',
                styles: Styles(raw: {
                  'color': 'var(--arcane-on-surface-variant)',
                  'transition': 'transform 200ms ease',
                  'transform': _isExpanded ? 'rotate(180deg)' : 'rotate(0)',
                }),
                [text('▼')],
              ),
          ],
        ),

        // Content
        if (_isExpanded || component.maintainState)
          div(
            classes: 'arcane-expander-content',
            styles: Styles(raw: {
              'padding': contentPadding.padding,
              'background-color': 'var(--arcane-surface)',
              'border-top': '1px solid var(--arcane-outline-variant)',
              if (!_isExpanded) 'display': 'none',
            }),
            [component.child],
          ),
      ],
    );
  }
}

/// An accordion component (multiple expanders where only one can be open)
class Accordion extends StatefulComponent {
  final List<AccordionItem> items;
  final int? initialOpenIndex;
  final bool allowMultiple;
  final double gap;

  const Accordion({
    required this.items,
    this.initialOpenIndex,
    this.allowMultiple = false,
    this.gap = 0,
    super.key,
  });

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  late Set<int> _expandedIndices;

  @override
  void initState() {
    super.initState();
    _expandedIndices = component.initialOpenIndex != null
        ? {component.initialOpenIndex!}
        : {};
  }

  void _toggleItem(int index) {
    setState(() {
      if (component.allowMultiple) {
        if (_expandedIndices.contains(index)) {
          _expandedIndices.remove(index);
        } else {
          _expandedIndices.add(index);
        }
      } else {
        if (_expandedIndices.contains(index)) {
          _expandedIndices.clear();
        } else {
          _expandedIndices = {index};
        }
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return div(
      classes: 'arcane-accordion',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${component.gap}px',
      }),
      [
        for (var i = 0; i < component.items.length; i++)
          _buildItem(context, theme, i, component.items[i]),
      ],
    );
  }

  Component _buildItem(
      BuildContext context, ArcaneTheme theme, int index, AccordionItem item) {
    final isExpanded = _expandedIndices.contains(index);

    return div(
      classes: 'arcane-accordion-item ${isExpanded ? 'expanded' : ''}',
      styles: Styles(raw: {
        'border': '1px solid var(--arcane-outline-variant)',
        'border-radius': theme.borderRadiusCss,
        'overflow': 'hidden',
      }),
      [
        button(
          classes: 'arcane-accordion-header',
          attributes: {
            'type': 'button',
            'aria-expanded': '$isExpanded',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '12px',
            'width': '100%',
            'padding': '12px 16px',
            'background-color': 'var(--arcane-surface)',
            'cursor': 'pointer',
            'transition': 'background-color 150ms ease',
            'text-align': 'left',
          }),
          events: {
            'click': (event) => _toggleItem(index),
          },
          [
            if (item.icon != null) item.icon!,
            span(
              styles: Styles(raw: {
                'flex': '1',
                'font-weight': '500',
              }),
              [text(item.title)],
            ),
            span(
              styles: Styles(raw: {
                'color': 'var(--arcane-on-surface-variant)',
                'transition': 'transform 200ms ease',
                'transform': isExpanded ? 'rotate(180deg)' : 'rotate(0)',
              }),
              [text('▼')],
            ),
          ],
        ),
        if (isExpanded)
          div(
            classes: 'arcane-accordion-content',
            styles: Styles(raw: {
              'padding': '16px',
              'background-color': 'var(--arcane-surface)',
              'border-top': '1px solid var(--arcane-outline-variant)',
            }),
            [item.content],
          ),
      ],
    );
  }
}

/// An accordion item
class AccordionItem {
  final String title;
  final Component content;
  final Component? icon;

  const AccordionItem({
    required this.title,
    required this.content,
    this.icon,
  });
}
