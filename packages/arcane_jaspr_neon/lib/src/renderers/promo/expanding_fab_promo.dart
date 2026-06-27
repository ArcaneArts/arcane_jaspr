import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neon Expanding FAB Promo renderer (neutral placeholder skeleton).
///
/// A floating action button that expands into a full promo panel when tapped.
class NeonExpandingFabPromo extends StatefulComponent {
  final ExpandingFabPromoProps props;

  const NeonExpandingFabPromo(this.props, {super.key});

  @override
  State<NeonExpandingFabPromo> createState() => _NeonExpandingFabPromoState();
}

class _NeonExpandingFabPromoState extends State<NeonExpandingFabPromo> {
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
        classes: 'neon-expanding-fab-promo collapsed',
        styles: const dom.Styles(
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
            'background': 'var(--primary)',
            'border': '1px solid var(--border)',
            'border-radius': '50%',
            'color': 'var(--primary-foreground)',
            'cursor': 'pointer',
            'box-shadow': '0 4px 12px rgba(0, 0, 0, 0.15)',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
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

    // Expanded panel state
    return dom.div(
      classes: 'neon-expanding-fab-promo expanded',
      styles: const dom.Styles(
        raw: {
          'position': 'fixed',
          'bottom': '2rem',
          'right': '2rem',
          'z-index': '100',
          'width': '320px',
          'max-width': 'calc(100vw - 4rem)',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-xl)',
          'box-shadow': '0 8px 24px rgba(0, 0, 0, 0.15)',
          'padding': '1.5rem',
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
                    'background': 'var(--primary)',
                    'border-radius': 'var(--radius)',
                    'font-size': 'var(--font-size-lg)',
                    'font-weight': 'var(--font-weight-bold)',
                    'color': 'var(--primary-foreground)',
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
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius-sm)',
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
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius-sm)',
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
                'background': 'var(--muted)',
                'border': '1px dashed var(--border)',
                'border-radius': 'var(--radius)',
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
                    'color': 'var(--foreground)',
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
                'background': 'var(--primary)',
                'border': 'none',
                'border-radius': 'var(--radius)',
                'color': 'var(--primary-foreground)',
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'text-align': 'center',
                'text-decoration': 'none',
                'cursor': 'pointer',
                'transition': 'all var(--transition)',
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
