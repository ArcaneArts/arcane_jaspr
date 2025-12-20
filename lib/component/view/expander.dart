import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';

/// An expandable/collapsible component.
class ArcaneExpander extends StatefulComponent {
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

  const ArcaneExpander({
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
  State<ArcaneExpander> createState() => _ExpanderState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-expander-header:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

class _ExpanderState extends State<ArcaneExpander> {
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
    final EdgeInsets contentPadding =
        component.contentPadding ?? const EdgeInsets.all(16);

    return div(
      classes: 'arcane-expander ${_isExpanded ? 'expanded' : ''}',
      styles: const Styles(raw: {
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
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
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.md,
            'width': '100%',
            'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
            'background-color': ArcaneColors.surface,
            'border': 'none',
            'cursor': 'pointer',
            'transition': ArcaneEffects.transitionFast,
            'text-align': 'left',
          }),
          events: {
            'click': (event) => _toggleExpansion(),
          },
          [
            if (component.leading != null) component.leading!,
            div(
              styles: const Styles(raw: {
                'flex': '1',
                'min-width': '0',
              }),
              [component.header],
            ),
            if (component.showIcon)
              span(
                classes: 'arcane-expander-icon',
                styles: Styles(raw: {
                  'color': ArcaneColors.muted,
                  'transition': ArcaneEffects.transitionFast,
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
              'background-color': ArcaneColors.surface,
              'border-top': '1px solid ${ArcaneColors.border}',
              if (!_isExpanded) 'display': 'none',
            }),
            [component.child],
          ),
      ],
    );
  }
}

/// An accordion component (multiple expanders where only one can be open)
class ArcaneAccordion extends StatefulComponent {
  final List<ArcaneAccordionItem> items;
  final int? initialOpenIndex;
  final bool allowMultiple;
  final double gap;

  const ArcaneAccordion({
    required this.items,
    this.initialOpenIndex,
    this.allowMultiple = false,
    this.gap = 0,
    super.key,
  });

  @override
  State<ArcaneAccordion> createState() => _AccordionState();
}

class _AccordionState extends State<ArcaneAccordion> {
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
    return div(
      classes: 'arcane-accordion',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${component.gap}px',
      }),
      [
        for (var i = 0; i < component.items.length; i++)
          _buildItem(context, i, component.items[i]),
      ],
    );
  }

  Component _buildItem(BuildContext context, int index, ArcaneAccordionItem item) {
    final bool isExpanded = _expandedIndices.contains(index);

    return div(
      classes: 'arcane-accordion-item ${isExpanded ? 'expanded' : ''}',
      styles: const Styles(raw: {
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'overflow': 'hidden',
      }),
      [
        button(
          classes: 'arcane-accordion-header',
          attributes: {
            'type': 'button',
            'aria-expanded': '$isExpanded',
          },
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.md,
            'width': '100%',
            'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
            'background-color': ArcaneColors.surface,
            'border': 'none',
            'cursor': 'pointer',
            'transition': ArcaneEffects.transitionFast,
            'text-align': 'left',
          }),
          events: {
            'click': (event) => _toggleItem(index),
          },
          [
            if (item.icon != null) item.icon!,
            span(
              styles: const Styles(raw: {
                'flex': '1',
                'font-weight': ArcaneTypography.weightMedium,
                'color': ArcaneColors.onSurface,
              }),
              [text(item.title)],
            ),
            span(
              styles: Styles(raw: {
                'color': ArcaneColors.muted,
                'transition': ArcaneEffects.transitionFast,
                'transform': isExpanded ? 'rotate(180deg)' : 'rotate(0)',
              }),
              [text('▼')],
            ),
          ],
        ),
        if (isExpanded)
          div(
            classes: 'arcane-accordion-content',
            styles: const Styles(raw: {
              'padding': ArcaneSpacing.lg,
              'background-color': ArcaneColors.surface,
              'border-top': '1px solid ${ArcaneColors.border}',
            }),
            [item.content],
          ),
      ],
    );
  }
}

/// An accordion item
class ArcaneAccordionItem {
  final String title;
  final Component content;
  final Component? icon;

  const ArcaneAccordionItem({
    required this.title,
    required this.content,
    this.icon,
  });
}