import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// An accordion item data model
class ArcaneAccordionItem {
  final String title;
  final String content;
  final Component? customContent;
  final bool defaultOpen;

  const ArcaneAccordionItem({
    required this.title,
    this.content = '',
    this.customContent,
    this.defaultOpen = false,
  });
}

/// An accordion/collapsible component (Supabase-style)
class ArcaneAccordion extends StatefulComponent {
  /// Accordion items
  final List<ArcaneAccordionItem> items;

  /// Whether multiple items can be open at once
  final bool allowMultiple;

  /// Whether to show borders between items
  final bool bordered;

  const ArcaneAccordion({
    required this.items,
    this.allowMultiple = false,
    this.bordered = true,
    super.key,
  });

  @override
  State<ArcaneAccordion> createState() => _ArcaneAccordionState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-accordion-trigger:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

class _ArcaneAccordionState extends State<ArcaneAccordion> {
  late Set<int> _openItems;

  @override
  void initState() {
    super.initState();
    _openItems = {};
    for (int i = 0; i < component.items.length; i++) {
      if (component.items[i].defaultOpen) {
        _openItems.add(i);
      }
    }
  }

  void _toggleItem(int index) {
    setState(() {
      if (_openItems.contains(index)) {
        _openItems.remove(index);
      } else {
        if (!component.allowMultiple) {
          _openItems.clear();
        }
        _openItems.add(index);
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
        if (component.bordered) 'border': '1px solid ${ArcaneColors.border}',
        if (component.bordered) 'border-radius': ArcaneRadius.md,
        'overflow': 'hidden',
      }),
      [
        for (int i = 0; i < component.items.length; i++)
          _buildItem(i, component.items[i]),
      ],
    );
  }

  Component _buildItem(int index, ArcaneAccordionItem item) {
    final bool isOpen = _openItems.contains(index);
    final bool isFirst = index == 0;

    return div(
      classes: 'arcane-accordion-item ${isOpen ? 'open' : ''}',
      styles: Styles(raw: {
        if (!isFirst && component.bordered)
          'border-top': '1px solid ${ArcaneColors.border}',
      }),
      [
        // Header/trigger
        button(
          classes: 'arcane-accordion-trigger',
          attributes: {
            'type': 'button',
            'aria-expanded': isOpen.toString(),
          },
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'width': '100%',
            'padding': '${ArcaneSpacing.lg} 20px',
            'background': 'none',
            'border': 'none',
            'text-align': 'left',
            'font-size': ArcaneTypography.fontBase,
            'font-weight': ArcaneTypography.weightMedium,
            'color': ArcaneColors.onSurface,
            'cursor': 'pointer',
            'transition': ArcaneEffects.transitionFast,
          }),
          events: {
            'click': (e) => _toggleItem(index),
          },
          [
            span([text(item.title)]),
            span(
              classes: 'arcane-accordion-icon',
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontXs,
                'color': ArcaneColors.muted,
                'transform': isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                'transition': ArcaneEffects.transitionFast,
              }),
              [text('▼')],
            ),
          ],
        ),

        // Content panel
        div(
          classes: 'arcane-accordion-panel',
          styles: Styles(raw: {
            'display': isOpen ? 'block' : 'none',
            'padding': '0 20px ${ArcaneSpacing.lg}',
          }),
          [
            div(
              classes: 'arcane-accordion-content',
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'line-height': ArcaneTypography.lineHeightRelaxed,
                'color': ArcaneColors.muted,
              }),
              [
                if (item.customContent != null)
                  item.customContent!
                else
                  text(item.content),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// A simple FAQ accordion
class ArcaneFaqAccordion extends StatelessComponent {
  /// FAQ items as question/answer pairs
  final List<({String question, String answer})> faqs;

  const ArcaneFaqAccordion({
    required this.faqs,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneAccordion(
      items: faqs
          .map((faq) => ArcaneAccordionItem(
                title: faq.question,
                content: faq.answer,
              ))
          .toList(),
      allowMultiple: true,
    );
  }
}