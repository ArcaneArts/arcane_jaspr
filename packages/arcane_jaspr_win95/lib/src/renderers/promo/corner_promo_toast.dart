import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Win95 Corner Promo Toast renderer (neutral placeholder skeleton).
///
/// A corner toast-style promo notification that slides in from a corner.
class Win95CornerPromoToast extends StatefulComponent {
  final CornerPromoToastProps props;

  const Win95CornerPromoToast(this.props, {super.key});

  @override
  State<Win95CornerPromoToast> createState() => _Win95CornerPromoToastState();
}

class _Win95CornerPromoToastState extends State<Win95CornerPromoToast> {
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

  Map<String, String> _getPositionStyles() {
    return switch (component.props.position) {
      PromoCornerPosition.topLeft => {'top': '1.5rem', 'left': '1.5rem'},
      PromoCornerPosition.topRight => {'top': '1.5rem', 'right': '1.5rem'},
      PromoCornerPosition.bottomLeft => {'bottom': '1.5rem', 'left': '1.5rem'},
      PromoCornerPosition.bottomRight => {
        'bottom': '1.5rem',
        'right': '1.5rem',
      },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed || !_isVisible) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final Map<String, String> positionStyles = _getPositionStyles();

    return dom.div(
      classes: 'win95-corner-promo-toast',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          ...positionStyles,
          'z-index': '100',
          'width': '340px',
          'max-width': 'calc(100vw - 3rem)',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-lg)',
          'box-shadow': '0 8px 24px rgba(0, 0, 0, 0.15)',
          'padding': '1.25rem',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Header with icon and dismiss
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'flex-start',
              'gap': '0.75rem',
              'margin-bottom': '0.75rem',
            },
          ),
          [
            // Icon
            if (component.props.icon != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'flex-shrink': '0',
                    'width': '40px',
                    'height': '40px',
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'background': 'var(--muted)',
                    'border-radius': 'var(--radius)',
                    'color': 'var(--foreground)',
                  },
                ),
                [component.props.icon!],
              ),

            // Title and message
            dom.div(
              styles: const dom.Styles(raw: {'flex': '1', 'min-width': '0'}),
              [
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-base)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--foreground)',
                      'margin-bottom': '0.25rem',
                    },
                  ),
                  [Component.text(component.props.title)],
                ),
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'line-height': '1.5',
                    },
                  ),
                  [Component.text(component.props.message)],
                ),
              ],
            ),

            // Dismiss button
            dom.button(
              styles: const dom.Styles(
                raw: {
                  'flex-shrink': '0',
                  'width': '24px',
                  'height': '24px',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'background': 'transparent',
                  'border': 'none',
                  'border-radius': 'var(--radius-sm)',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'opacity': '0.7',
                },
              ),
              events: {'click': (_) => _dismiss()},
              [const Component.text('\u2715')],
            ),
          ],
        ),

        // Promo code
        if (component.props.promoCode != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'padding': '0.625rem',
                'background': 'var(--muted)',
                'border': '1px dashed var(--border)',
                'border-radius': 'var(--radius-sm)',
                'margin-bottom': '0.875rem',
                'text-align': 'center',
              },
            ),
            [
              dom.span(
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
                'padding': '0.75rem',
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
