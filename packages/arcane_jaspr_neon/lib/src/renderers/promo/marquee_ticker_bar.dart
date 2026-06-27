import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neon Marquee Ticker Bar renderer (neutral placeholder skeleton).
///
/// A scrolling marquee-style announcement bar.
class NeonMarqueeTickerBar extends StatefulComponent {
  final MarqueeTickerBarProps props;

  const NeonMarqueeTickerBar(this.props, {super.key});

  @override
  State<NeonMarqueeTickerBar> createState() => _NeonMarqueeTickerBarState();
}

class _NeonMarqueeTickerBarState extends State<NeonMarqueeTickerBar> {
  bool _isDismissed = false;

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

    final String marqueeId = 'neon-marquee-ticker-$hashCode';
    final String animationName = 'neon-marquee-scroll-$marqueeId';

    // Build repeated message string with separator
    final String messageText = component.props.messages
        .map((String m) => '  $m  ')
        .join(' | ');

    return dom.div(
      classes: 'neon-marquee-ticker-bar',
      styles: dom.Styles(
        raw: {
          'position': component.props.showAtBottom ? 'fixed' : 'sticky',
          if (component.props.showAtBottom) 'bottom': '0' else 'top': '0',
          'left': '0',
          'right': '0',
          'z-index': '100',
          'display': 'flex',
          'align-items': 'center',
          'overflow': 'hidden',
          'background-color': 'var(--card)',
          'border-bottom': component.props.showAtBottom
              ? 'none'
              : '1px solid var(--border)',
          'border-top': component.props.showAtBottom
              ? '1px solid var(--border)'
              : 'none',
        },
      ),
      [
        // Scrolling content
        dom.div(
          classes: marqueeId,
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'width': 'max-content',
              'animation': '$animationName 30s linear infinite',
              'padding': '0.75rem 0',
            },
          ),
          [
            // First copy
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '2rem',
                  'white-space': 'nowrap',
                },
              ),
              [
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'color': 'var(--foreground)',
                    },
                  ),
                  [Component.text(messageText)],
                ),
                if (component.props.promoCode != null)
                  dom.span(
                    styles: const dom.Styles(
                      raw: {
                        'padding': '0.25rem 0.75rem',
                        'background': 'var(--muted)',
                        'border': '1px solid var(--border)',
                        'border-radius': 'var(--radius-sm)',
                        'font-family':
                            'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                        'font-size': 'var(--font-size-sm)',
                        'font-weight': 'var(--font-weight-bold)',
                        'color': 'var(--foreground)',
                      },
                    ),
                    [Component.text(component.props.promoCode!)],
                  ),
              ],
            ),
            // Second copy for seamless loop
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '2rem',
                  'white-space': 'nowrap',
                  'padding-left': '2rem',
                },
              ),
              [
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'color': 'var(--foreground)',
                    },
                  ),
                  [Component.text(messageText)],
                ),
                if (component.props.promoCode != null)
                  dom.span(
                    styles: const dom.Styles(
                      raw: {
                        'padding': '0.25rem 0.75rem',
                        'background': 'var(--muted)',
                        'border': '1px solid var(--border)',
                        'border-radius': 'var(--radius-sm)',
                        'font-family':
                            'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                        'font-size': 'var(--font-size-sm)',
                        'font-weight': 'var(--font-weight-bold)',
                        'color': 'var(--foreground)',
                      },
                    ),
                    [Component.text(component.props.promoCode!)],
                  ),
              ],
            ),
          ],
        ),

        // Static CTA section
        if (component.props.ctaText != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'right': '3rem',
                'display': 'flex',
                'align-items': 'center',
                'gap': '1rem',
                'padding': '0 1rem',
                'background': 'var(--card)',
              },
            ),
            [
              dom.a(
                href: component.props.ctaHref ?? '#',
                styles: const dom.Styles(
                  raw: {
                    'padding': '0.5rem 1rem',
                    'background': 'var(--primary)',
                    'border': 'none',
                    'border-radius': 'var(--radius-sm)',
                    'color': 'var(--primary-foreground)',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'text-decoration': 'none',
                    'cursor': 'pointer',
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
          ),

        // Dismiss button
        dom.button(
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'right': '0.75rem',
              'padding': '0.25rem',
              'background': 'transparent',
              'border': 'none',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'opacity': '0.7',
            },
          ),
          events: {'click': (_) => _dismiss()},
          [const Component.text('\u2715')],
        ),

        // Inject animation keyframes
        Component.element(
          tag: 'style',
          children: [
            Component.text('''
@keyframes $animationName {
  from { transform: translateX(0); }
  to { transform: translateX(-50%); }
}
'''),
          ],
        ),
      ],
    );
  }
}
