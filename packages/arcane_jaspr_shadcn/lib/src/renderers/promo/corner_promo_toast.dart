import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Corner Promo Toast renderer.
///
/// A corner toast-style promo notification that slides in from a corner.
class ShadcnCornerPromoToast extends StatefulComponent {
  final CornerPromoToastProps props;

  const ShadcnCornerPromoToast(this.props, {super.key});

  @override
  State<ShadcnCornerPromoToast> createState() => _ShadcnCornerPromoToastState();
}

class _ShadcnCornerPromoToastState extends State<ShadcnCornerPromoToast> {
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
      PromoCornerPosition.topLeft => {
        'top': '24px',
        'left': '24px',
        'transform': _isVisible ? 'translateX(0)' : 'translateX(-120%)',
      },
      PromoCornerPosition.topRight => {
        'top': '24px',
        'right': '24px',
        'transform': _isVisible ? 'translateX(0)' : 'translateX(120%)',
      },
      PromoCornerPosition.bottomLeft => {
        'bottom': '24px',
        'left': '24px',
        'transform': _isVisible ? 'translateX(0)' : 'translateX(-120%)',
      },
      PromoCornerPosition.bottomRight => {
        'bottom': '24px',
        'right': '24px',
        'transform': _isVisible ? 'translateX(0)' : 'translateX(120%)',
      },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div(styles: dom.Styles(raw: {'display': 'none'}), []);
    }

    return dom.div(
      classes: 'arcane-corner-promo-toast',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'z-index': '50',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '8px',
          'padding': '12px',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-md)',
          'box-shadow': '0 4px 12px rgba(0, 0, 0, 0.15)',
          'transition': 'transform 300ms cubic-bezier(0.4, 0, 0.2, 1)',
          'max-width': '356px',
          'width': '100%',
          ..._getPositionStyles(),
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Header with dismiss
        dom.div(
          styles: const dom.Styles(raw: {'display': 'flex', 'gap': '8px'}),
          [
            // Icon and content
            if (component.props.icon != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'width': '20px',
                    'height': '20px',
                    'flex-shrink': '0',
                    'color': 'var(--foreground)',
                    'margin-top': '2px',
                  },
                ),
                [component.props.icon!],
              ),
            // Text content
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': '4px',
                  'flex': '1',
                  'min-width': '0',
                },
              ),
              [
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--foreground)',
                      'line-height': '1.4',
                    },
                  ),
                  [Component.text(component.props.title)],
                ),
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'line-height': '1.4',
                    },
                  ),
                  [Component.text(component.props.message)],
                ),
              ],
            ),
            // Dismiss button
            dom.button(
              attributes: {'type': 'button', 'aria-label': 'Dismiss'},
              styles: const dom.Styles(
                raw: {
                  'display': 'inline-flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '20px',
                  'height': '20px',
                  'padding': '0',
                  'background': 'transparent',
                  'border': 'none',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'opacity': '0.7',
                  'transition': 'opacity var(--transition)',
                  'flex-shrink': '0',
                },
              ),
              events: {'click': (_) => _handleDismiss()},
              [const Component.text('\u00D7')],
            ),
          ],
        ),

        // Actions section
        if (component.props.promoCode != null ||
            component.props.ctaText != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '8px',
                'padding-top': '4px',
              },
            ),
            [
              if (component.props.promoCode != null)
                dom.code(
                  styles: const dom.Styles(
                    raw: {
                      'flex': '1',
                      'padding': '6px 8px',
                      'background-color': 'var(--muted)',
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius-sm)',
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-weight': 'var(--font-weight-semibold)',
                      'font-size': 'var(--font-size-xs)',
                      'color': 'var(--foreground)',
                      'text-align': 'center',
                    },
                  ),
                  [Component.text(component.props.promoCode!)],
                ),
              if (component.props.ctaText != null)
                dom.a(
                  href: component.props.ctaHref ?? '#',
                  styles: dom.Styles(
                    raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'height': '28px',
                      'padding': '0 10px',
                      'background-color': 'var(--primary)',
                      'color': 'var(--primary-foreground)',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'text-decoration': 'none',
                      'border-radius': 'var(--radius-sm)',
                      'transition': 'all var(--transition)',
                      'white-space': 'nowrap',
                      if (component.props.promoCode == null) 'flex': '1',
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
      ],
    );
  }
}
