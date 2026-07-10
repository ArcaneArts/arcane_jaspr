import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Sliding Sidebar Banner renderer.
///
/// A vertical sidebar banner that slides in from the edge of the screen.
class ShadcnSlidingSidebarBanner extends StatefulComponent {
  final SlidingSidebarBannerProps props;

  const ShadcnSlidingSidebarBanner(this.props, {super.key});

  @override
  State<ShadcnSlidingSidebarBanner> createState() =>
      _ShadcnSlidingSidebarBannerState();
}

class _ShadcnSlidingSidebarBannerState
    extends State<ShadcnSlidingSidebarBanner> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Timer? _showTimer;

  @override
  void initState() {
    super.initState();
    _showTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted && !_isDismissed) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _showTimer?.cancel();
    super.dispose();
  }

  void _handleDismiss() {
    setState(() {
      _isDismissed = true;
      _isVisible = false;
    });
    component.props.onDismiss?.call();
  }

  Map<String, String> _getPositionStyles() {
    return switch (component.props.position) {
      PromoSidebarPosition.left => {
        'left': '0',
        'top': '50%',
        'transform': _isVisible
            ? 'translateY(-50%) translateX(0)'
            : 'translateY(-50%) translateX(-100%)',
        'border-radius': '0 var(--radius-md) var(--radius-md) 0',
      },
      PromoSidebarPosition.right => {
        'right': '0',
        'top': '50%',
        'transform': _isVisible
            ? 'translateY(-50%) translateX(0)'
            : 'translateY(-50%) translateX(100%)',
        'border-radius': 'var(--radius-md) 0 0 var(--radius-md)',
      },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div(styles: dom.Styles(raw: {'display': 'none'}), []);
    }

    return dom.div(
      classes: 'arcane-sliding-sidebar-banner',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'z-index': '50',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '16px',
          'padding': '24px',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'box-shadow': 'var(--shadow-lg)',
          'transition': 'transform 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
          'max-width': '320px',
          'width': '320px',
          ..._getPositionStyles(),
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Close button
        dom.button(
          attributes: {'type': 'button', 'aria-label': 'Dismiss'},
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

        // Text content
        dom.div(
          styles: const dom.Styles(
            raw: {'display': 'flex', 'flex-direction': 'column', 'gap': '8px'},
          ),
          [
            if (component.props.subtitle != null)
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'text-transform': 'uppercase',
                    'letter-spacing': '0.05em',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text(component.props.subtitle!)],
              ),
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

        // Features list
        if (component.props.features != null &&
            component.props.features!.isNotEmpty)
          dom.ul(
            styles: const dom.Styles(
              raw: {
                'list-style': 'none',
                'padding': '0',
                'margin': '0',
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '8px',
              },
            ),
            [
              for (final feature in component.props.features!)
                dom.li(
                  styles: const dom.Styles(
                    raw: {
                      'display': 'flex',
                      'align-items': 'flex-start',
                      'gap': '8px',
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--foreground)',
                      'line-height': '1.5',
                    },
                  ),
                  [
                    const dom.span(
                      styles: dom.Styles(
                        raw: {
                          'color': 'var(--primary)',
                          'flex-shrink': '0',
                          'margin-top': '2px',
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
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '6px',
              },
            ),
            [
              const dom.span(
                styles: dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text('Use code')],
              ),
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
            ],
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
    );
  }
}
