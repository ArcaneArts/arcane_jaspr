import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neubrutalism Sliding Sidebar Banner renderer.
///
/// A vertical sidebar banner that slides in from the edge.
class NeubrutalismSlidingSidebarBanner extends StatefulComponent {
  final SlidingSidebarBannerProps props;

  const NeubrutalismSlidingSidebarBanner(this.props, {super.key});

  @override
  State<NeubrutalismSlidingSidebarBanner> createState() =>
      _NeubrutalismSlidingSidebarBannerState();
}

class _NeubrutalismSlidingSidebarBannerState extends State<NeubrutalismSlidingSidebarBanner> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _delayTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }

  void _dismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed || !_isVisible) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final bool isLeft = component.props.position == PromoSidebarPosition.left;

    return dom.div(
      classes: 'neubrutalism-sliding-sidebar-banner',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'top': '50%',
          'transform': 'translateY(-50%)',
          if (isLeft) 'left': '1.5rem' else 'right': '1.5rem',
          'z-index': '100',
          'width': '320px',
          'max-width': 'calc(100vw - 3rem)',
          // Neubrutalism: glass effect
          'background': 'var(--nb-paper, var(--card))',
          'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          // Neubrutalism: accent glow
          'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
          'padding': '1.5rem',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Dismiss button
        dom.button(
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'top': '0.75rem',
              'right': '0.75rem',
              'width': '28px',
              'height': '28px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'background': 'transparent',
              'border': 'none',
              'border-radius': 'var(--nb-radius-soft, 4px)',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'transition': 'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
            },
          ),
          events: {'click': (_) => _dismiss()},
          [const Component.text('\u2715')],
        ),

        // Discount badge
        if (component.props.discount != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'inline-block',
                'padding': '0.5rem 1rem',
                'background': 'var(--nb-accent, var(--primary))',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'font-size': 'var(--font-size-xl)',
                'font-weight': 'var(--font-weight-bold)',
                'color': 'var(--nb-on-accent, #000)',
                'margin-bottom': '1rem',
                'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
              },
            ),
            [Component.text(component.props.discount!)],
          ),

        // Subtitle
        if (component.props.subtitle != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-xs)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--nb-accent, var(--primary))',
                'text-transform': 'uppercase',
                'letter-spacing': '0',
                'margin-bottom': '0.375rem',
              },
            ),
            [Component.text(component.props.subtitle!)],
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

        // Features list
        if (component.props.features != null &&
            component.props.features!.isNotEmpty)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '0.5rem',
                'margin-bottom': '1.25rem',
              },
            ),
            [
              for (final String feature in component.props.features!)
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': '0.5rem',
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--foreground)',
                    },
                  ),
                  [
                    const dom.span(
                      styles: dom.Styles(
                        raw: {
                          'color': 'var(--success)',
                          'font-weight': 'var(--font-weight-bold)',
                        },
                      ),
                      [Component.text('\u2713')],
                    ),
                    Component.text(feature),
                  ],
                ),
            ],
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
