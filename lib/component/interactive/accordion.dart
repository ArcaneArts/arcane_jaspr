import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// An accordion item data model
class AccordionItem {
  final String title;
  final String content;
  final Component? customContent;
  final bool defaultOpen;

  const AccordionItem({
    required this.title,
    this.content = '',
    this.customContent,
    this.defaultOpen = false,
  });
}

/// An accordion/collapsible component (Supabase-style)
class Accordion extends StatefulComponent {
  /// Accordion items
  final List<AccordionItem> items;

  /// Whether multiple items can be open at once
  final bool allowMultiple;

  /// Whether to show borders between items
  final bool bordered;

  const Accordion({
    required this.items,
    this.allowMultiple = false,
    this.bordered = true,
    super.key,
  });

  @override
  State<Accordion> createState() => _AccordionState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-accordion-trigger:hover').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}

class _AccordionState extends State<Accordion> {
  late Set<int> _openItems;

  @override
  void initState() {
    super.initState();
    _openItems = {};
    for (var i = 0; i < component.items.length; i++) {
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
        if (component.bordered) 'border': '1px solid var(--arcane-border)',
        if (component.bordered) 'border-radius': 'var(--arcane-radius)',
        'overflow': 'hidden',
      }),
      [
        for (var i = 0; i < component.items.length; i++)
          _buildItem(i, component.items[i]),
      ],
    );
  }

  Component _buildItem(int index, AccordionItem item) {
    final isOpen = _openItems.contains(index);
    final isFirst = index == 0;
    final isLast = index == component.items.length - 1;

    return div(
      classes: 'arcane-accordion-item ${isOpen ? 'open' : ''}',
      styles: Styles(raw: {
        if (!isFirst && component.bordered)
          'border-top': '1px solid var(--arcane-border)',
      }),
      [
        // Header/trigger
        button(
          classes: 'arcane-accordion-trigger',
          attributes: {
            'type': 'button',
            'aria-expanded': isOpen.toString(),
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'width': '100%',
            'padding': '16px 20px',
            'background': 'none',
            'border': 'none',
            'text-align': 'left',
            'font-size': '0.9375rem',
            'font-weight': '500',
            'color': 'var(--arcane-on-surface)',
            'cursor': 'pointer',
            'transition': 'background-color var(--arcane-transition-fast)',
          }),
          events: {
            'click': (e) => _toggleItem(index),
          },
          [
            span([text(item.title)]),
            span(
              classes: 'arcane-accordion-icon',
              styles: Styles(raw: {
                'font-size': '0.75rem',
                'color': 'var(--arcane-muted)',
                'transform': isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                'transition': 'transform var(--arcane-transition-fast)',
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
            'padding': '0 20px 16px',
          }),
          [
            div(
              classes: 'arcane-accordion-content',
              styles: Styles(raw: {
                'font-size': '0.875rem',
                'line-height': '1.6',
                'color': 'var(--arcane-muted)',
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
class FaqAccordion extends StatelessComponent {
  /// FAQ items as question/answer pairs
  final List<({String question, String answer})> faqs;

  const FaqAccordion({
    required this.faqs,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Accordion(
      items: faqs
          .map((faq) => AccordionItem(
                title: faq.question,
                content: faq.answer,
              ))
          .toList(),
      allowMultiple: true,
    );
  }
}
