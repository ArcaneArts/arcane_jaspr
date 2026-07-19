import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neubrutalism Expanding FAB Promo renderer.
///
/// A floating action button that expands into a full promo panel when tapped.
class NeubrutalismExpandingFabPromo extends StatefulComponent {
  final ExpandingFabPromoProps props;

  const NeubrutalismExpandingFabPromo(this.props, {super.key});

  @override
  State<NeubrutalismExpandingFabPromo> createState() => _NeubrutalismExpandingFabPromoState();
}

class _NeubrutalismExpandingFabPromoState extends State<NeubrutalismExpandingFabPromo> {
  bool _isExpanded = false;
  bool _isDismissed = false;

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _dismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    if (!_isExpanded) {
      // Collapsed FAB state
      return dom.button(
        classes: 'neubrutalism-expanding-fab-promo collapsed',
        styles: dom.Styles(
          raw: {
            'position': 'fixed',
            'bottom': '2rem',
            'right': '2rem',
            'z-index': '100',
            'width': '64px',
            'height': '64px',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'background': 'var(--nb-accent, var(--primary))',
            'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
            'border-radius': '0',
            'color': 'var(--nb-ink, #000)',
            'cursor': 'pointer',
            // Neubrutalism: hard offset shadow
            'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
            'transition': 'translate 120ms ease, box-shadow 120ms ease',
            ...?component.props.decoration?.universalStyles(),
            ...?component.props.styles?.toMap(),
          },
        ),
        events: {'click': (_) => _toggle()},
        [
          component.props.icon ??
              const dom.span(styles: dom.Styles(raw: {'font-size': '1.5rem'}), [
                Component.text('%'),
              ]),
        ],
      );
    }

    return dom.div(
      classes: 'neubrutalism-expanding-fab-promo expanded',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'bottom': '2rem',
          'right': '2rem',
          'z-index': '100',
          'width': '320px',
          'max-width': 'calc(100vw - 4rem)',
          // Neubrutalism: paper surface with thick border
          'background': 'var(--nb-paper, var(--card))',
          'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
          'border-radius': '0',
          'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
          'padding': '1.5rem',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Header with collapse button
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'margin-bottom': '1rem',
            },
          ),
          [
            // Discount badge
            if (component.props.discount != null)
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'padding': '0.5rem 1rem',
                    'background': 'var(--nb-accent, var(--primary))',
                    'border-radius': 'var(--nb-radius-soft, 4px)',
                    'font-size': 'var(--font-size-lg)',
                    'font-weight': 'var(--font-weight-bold)',
                    'color': 'var(--nb-on-accent, #000)',
                    'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
                  },
                ),
                [Component.text(component.props.discount!)],
              )
            else
              const dom.div([], styles: dom.Styles(raw: {})),

            // Buttons
            dom.div(
              styles: const dom.Styles(
                raw: {'display': 'flex', 'gap': '0.5rem'},
              ),
              [
                // Collapse button
                dom.button(
                  styles: const dom.Styles(
                    raw: {
                      'width': '28px',
                      'height': '28px',
                      'display': 'flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'background': 'transparent',
                      'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                      'border-radius': 'var(--nb-radius-soft, 4px)',
                      'color': 'var(--muted-foreground)',
                      'cursor': 'pointer',
                    },
                  ),
                  events: {'click': (_) => _toggle()},
                  [const Component.text('\u2212')],
                ),
                // Dismiss button
                dom.button(
                  styles: const dom.Styles(
                    raw: {
                      'width': '28px',
                      'height': '28px',
                      'display': 'flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'background': 'transparent',
                      'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                      'border-radius': 'var(--nb-radius-soft, 4px)',
                      'color': 'var(--muted-foreground)',
                      'cursor': 'pointer',
                    },
                  ),
                  events: {'click': (_) => _dismiss()},
                  [const Component.text('\u2715')],
                ),
              ],
            ),
          ],
        ),

        // Title
        dom.div(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-lg)',
              'font-weight': 'var(--font-weight-bold)',
              'color': 'var(--foreground)',
              'margin-bottom': '0.5rem',
            },
          ),
          [Component.text(component.props.title)],
        ),

        // Message
        dom.div(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'line-height': '1.6',
              'margin-bottom': '1rem',
            },
          ),
          [Component.text(component.props.message)],
        ),

        // Promo code
        if (component.props.promoCode != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'padding': '0.75rem',
                'background': 'var(--nb-paper-soft, var(--card))',
                'border': 'var(--nb-border-thin, 2px) dashed var(--nb-line, #000)',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'margin-bottom': '1rem',
                'text-align': 'center',
              },
            ),
            [
              const dom.div(
                styles: dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                    'margin-bottom': '0.25rem',
                  },
                ),
                [Component.text('Use code')],
              ),
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'font-size': 'var(--font-size-base)',
                    'font-weight': 'var(--font-weight-bold)',
                    'color': 'var(--nb-accent, var(--primary))',
                    'letter-spacing': '0',
                  },
                ),
                [Component.text(component.props.promoCode!)],
              ),
            ],
          ),

        // CTA Button
        if (component.props.ctaText != null)
          dom.a(
            href: component.props.ctaHref ?? '#',
            styles: const dom.Styles(
              raw: {
                'display': 'block',
                'width': '100%',
                'padding': '0.875rem',
                'background': 'var(--nb-accent, var(--primary))',
                'border': 'none',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'color': 'var(--nb-on-accent, #000)',
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'text-align': 'center',
                'text-decoration': 'none',
                'cursor': 'pointer',
                'transition': 'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
                'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
              },
            ),
            events: component.props.onCtaClick != null
                ? {
                    'click': (e) {
                      e.preventDefault();
                      component.props.onCtaClick!();
                    },
                  }
                : null,
            [Component.text(component.props.ctaText!)],
          ),
      ],
    );
  }
}
