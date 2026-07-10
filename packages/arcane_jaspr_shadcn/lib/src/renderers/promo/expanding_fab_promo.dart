import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Expanding FAB Promo renderer.
///
/// A floating action button that expands to reveal a promo.
class ShadcnExpandingFabPromo extends StatefulComponent {
  final ExpandingFabPromoProps props;

  const ShadcnExpandingFabPromo(this.props, {super.key});

  @override
  State<ShadcnExpandingFabPromo> createState() =>
      _ShadcnExpandingFabPromoState();
}

class _ShadcnExpandingFabPromoState extends State<ShadcnExpandingFabPromo> {
  bool _isExpanded = false;
  bool _isDismissed = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _handleDismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div(styles: dom.Styles(raw: {'display': 'none'}), []);
    }

    return dom.div(
      classes: 'arcane-expanding-fab-promo',
      styles: const dom.Styles(
        raw: {
          'position': 'fixed',
          'bottom': '24px',
          'right': '24px',
          'z-index': '50',
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'flex-end',
          'gap': '16px',
        },
      ),
      [
        // Expanded panel
        if (_isExpanded)
          dom.div(
            classes: 'arcane-fab-promo-panel',
            styles: dom.Styles(
              raw: {
                'position': 'relative',
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '16px',
                'padding': '24px',
                'background-color': 'var(--card)',
                'border': '1px solid var(--border)',
                'border-radius': 'var(--radius-md)',
                'box-shadow': 'var(--shadow-lg)',
                'max-width': '320px',
                'width': '320px',
                'animation': 'arcane-scale-in 0.2s ease-out',
                ...?component.props.decoration?.universalStyles(),
                ...?component.props.styles?.toMap(),
              },
            ),
            [
              // Close button
              dom.button(
                attributes: {'type': 'button', 'aria-label': 'Close'},
                styles: const dom.Styles(
                  raw: {
                    'position': 'absolute',
                    'top': '16px',
                    'right': '16px',
                    'display': 'inline-flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'width': '24px',
                    'height': '24px',
                    'padding': '0',
                    'background': 'transparent',
                    'border': 'none',
                    'border-radius': 'var(--radius-xs)',
                    'color': 'var(--muted-foreground)',
                    'cursor': 'pointer',
                    'transition': 'background-color var(--transition)',
                  },
                ),
                events: {'click': (_) => _handleDismiss()},
                [const Component.text('\u00D7')],
              ),

              // Discount badge
              if (component.props.discount != null)
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'display': 'inline-block',
                      'padding': '4px 12px',
                      'background-color': 'var(--primary)',
                      'color': 'var(--primary-foreground)',
                      'font-size': 'var(--font-size-lg)',
                      'font-weight': 'var(--font-weight-bold)',
                      'border-radius': 'var(--radius-sm)',
                      'align-self': 'flex-start',
                    },
                  ),
                  [Component.text(component.props.discount!)],
                ),

              // Content
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'flex-direction': 'column',
                    'gap': '8px',
                  },
                ),
                [
                  dom.span(
                    styles: const dom.Styles(
                      raw: {
                        'font-size': 'var(--font-size-lg)',
                        'font-weight': 'var(--font-weight-semibold)',
                        'color': 'var(--foreground)',
                        'line-height': '1.4',
                      },
                    ),
                    [Component.text(component.props.title)],
                  ),
                  dom.span(
                    styles: const dom.Styles(
                      raw: {
                        'font-size': 'var(--font-size-sm)',
                        'color': 'var(--muted-foreground)',
                        'line-height': '1.6',
                      },
                    ),
                    [Component.text(component.props.message)],
                  ),
                ],
              ),

              // Promo code
              if (component.props.promoCode != null)
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'padding': '8px 12px',
                      'background-color': 'var(--muted)',
                      'border': '1px dashed var(--border)',
                      'border-radius': 'var(--radius-sm)',
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-weight': 'var(--font-weight-bold)',
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--foreground)',
                      'text-align': 'center',
                    },
                  ),
                  [Component.text(component.props.promoCode!)],
                ),

              // CTA Button
              if (component.props.ctaText != null)
                dom.a(
                  href: component.props.ctaHref ?? '#',
                  styles: const dom.Styles(
                    raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'height': '40px',
                      'padding': '0 16px',
                      'background-color': 'var(--primary)',
                      'color': 'var(--primary-foreground)',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'text-decoration': 'none',
                      'border-radius': 'var(--radius-sm)',
                      'transition': 'opacity var(--transition)',
                      'width': '100%',
                    },
                  ),
                  events: {
                    'click': (e) {
                      if (component.props.onCtaClick != null) {
                        e.preventDefault();
                        component.props.onCtaClick!();
                      }
                    },
                  },
                  [Component.text(component.props.ctaText!)],
                ),
            ],
          ),

        // FAB button
        dom.button(
          attributes: {
            'type': 'button',
            'aria-label': _isExpanded ? 'Close promo' : 'View special offer',
          },
          styles: dom.Styles(
            raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '56px',
              'height': '56px',
              'padding': '0',
              'background-color': 'var(--primary)',
              'color': 'var(--primary-foreground)',
              'border': 'none',
              'border-radius': 'var(--radius-full)',
              'box-shadow': 'var(--shadow-lg)',
              'cursor': 'pointer',
              'transition': 'transform 0.2s ease-out',
              'transform': _isExpanded ? 'rotate(45deg)' : 'rotate(0deg)',
              ...?component.props.decoration?.universalStyles(),
              ...?component.props.styles?.toMap(),
            },
          ),
          events: {'click': (_) => _toggleExpand()},
          [
            if (component.props.icon != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'width': '24px',
                    'height': '24px',
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                  },
                ),
                [component.props.icon!],
              )
            else
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-size': '24px',
                    'font-weight': 'var(--font-weight-bold)',
                    'line-height': '1',
                  },
                ),
                [Component.text(_isExpanded ? '+' : '%')],
              ),
          ],
        ),
      ],
    );
  }
}
