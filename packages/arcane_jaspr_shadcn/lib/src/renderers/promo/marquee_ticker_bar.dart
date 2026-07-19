import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Marquee Ticker Bar renderer.
///
/// A scrolling marquee-style announcement bar.
class ShadcnMarqueeTickerBar extends StatefulComponent {
  final MarqueeTickerBarProps props;

  const ShadcnMarqueeTickerBar(this.props, {super.key});

  @override
  State<ShadcnMarqueeTickerBar> createState() => _ShadcnMarqueeTickerBarState();
}

class _ShadcnMarqueeTickerBarState extends State<ShadcnMarqueeTickerBar> {
  bool _isDismissed = false;

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

    // Build message items with separators
    final List<Component> marqueeItems = [];
    for (int i = 0; i < 3; i++) {
      for (final message in component.props.messages) {
        marqueeItems.add(
          dom.span(
            styles: const dom.Styles(
              raw: {'white-space': 'nowrap', 'padding': '0 32px'},
            ),
            [Component.text(message)],
          ),
        );
        marqueeItems.add(
          const dom.span(
            styles: dom.Styles(
              raw: {'color': 'var(--border)', 'opacity': '0.6'},
            ),
            [Component.text('\u2022')],
          ),
        );
      }
    }

    return dom.div(
      classes: 'arcane-marquee-ticker-bar',
      styles: dom.Styles(
        raw: {
          'position': component.props.showAtBottom ? 'fixed' : 'sticky',
          if (component.props.showAtBottom) 'bottom': '0' else 'top': '0',
          'left': '0',
          'right': '0',
          'z-index': '50',
          'display': 'flex',
          'align-items': 'center',
          'height': '40px',
          'background-color': 'var(--muted)',
          'border-bottom': component.props.showAtBottom
              ? 'none'
              : '1px solid var(--border)',
          'border-top': component.props.showAtBottom
              ? '1px solid var(--border)'
              : 'none',
          'overflow': 'hidden',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Marquee content
        dom.div(
          classes: 'arcane-marquee-content',
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'animation': 'arcane-marquee 30s linear infinite',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
              'line-height': '1.5',
            },
          ),
          marqueeItems,
        ),

        // Fixed right section with promo code and CTA
        if (component.props.promoCode != null ||
            component.props.ctaText != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'right': '48px',
                'display': 'flex',
                'align-items': 'center',
                'gap': '8px',
                'padding-left': '32px',
                'background':
                    'linear-gradient(to right, transparent, var(--muted) 10%, var(--muted))',
              },
            ),
            [
              if (component.props.promoCode != null)
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'padding': '4px 10px',
                      'background-color': 'var(--background)',
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius-sm)',
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-weight': 'var(--font-weight-semibold)',
                      'font-size': 'var(--font-size-xs)',
                      'color': 'var(--foreground)',
                    },
                  ),
                  [Component.text(component.props.promoCode!)],
                ),
              if (component.props.ctaText != null)
                dom.a(
                  href: component.props.ctaHref ?? '#',
                  styles: const dom.Styles(
                    raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'height': '28px',
                      'padding': '0 12px',
                      'background-color': 'var(--primary)',
                      'color': 'var(--primary-foreground)',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'text-decoration': 'none',
                      'border-radius': 'var(--radius-sm)',
                      'transition': 'opacity var(--transition)',
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

        // Dismiss button
        if (component.props.onDismiss != null)
          dom.button(
            attributes: {'type': 'button', 'aria-label': 'Dismiss'},
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'right': '8px',
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '28px',
                'height': '28px',
                'padding': '0',
                'background': 'transparent',
                'border': 'none',
                'border-radius': 'var(--radius-sm)',
                'color': 'var(--muted-foreground)',
                'cursor': 'pointer',
                'transition': 'background-color var(--transition)',
              },
            ),
            events: {'click': (_) => _handleDismiss()},
            [const Component.text('\u00D7')],
          ),
      ],
    );
  }
}
