import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Minimizable Promo renderer.
///
/// A promo drawer that slides in from the right edge.
class ShadcnMinimizablePromo extends StatefulComponent {
  final MinimizablePromoProps props;

  const ShadcnMinimizablePromo(this.props, {super.key});

  @override
  State<ShadcnMinimizablePromo> createState() => _ShadcnMinimizablePromoState();
}

class _ShadcnMinimizablePromoState extends State<ShadcnMinimizablePromo> {
  bool _isVisible = false;
  bool _isExpanded = true;
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

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _handleDismiss() {
    setState(() {
      _isDismissed = true;
      _isVisible = false;
    });
    component.props.onDismiss?.call();
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div(styles: dom.Styles(raw: {'display': 'none'}), []);
    }

    return dom.div(
      classes: 'arcane-minimizable-promo',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'right': '0',
          'top': '50%',
          'transform': _isVisible
              ? 'translateY(-50%) translateX(${_isExpanded ? '0' : 'calc(100% - 44px)'})'
              : 'translateY(-50%) translateX(100%)',
          'z-index': '50',
          'display': 'flex',
          'transition': 'transform 400ms cubic-bezier(0.4, 0, 0.2, 1)',
        },
      ),
      [
        // Tab (minimized state handle)
        dom.button(
          attributes: {
            'type': 'button',
            'aria-label': _isExpanded ? 'Minimize promo' : 'Expand promo',
          },
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'min-height': '120px',
              'width': '44px',
              'padding': '16px 0',
              'background-color': 'var(--primary)',
              'color': 'var(--primary-foreground)',
              'border': '1px solid var(--border)',
              'border-right': 'none',
              'border-radius': 'var(--radius-md) 0 0 var(--radius-md)',
              'cursor': 'pointer',
              'writing-mode': 'vertical-rl',
              'text-orientation': 'mixed',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.05em',
              'text-transform': 'uppercase',
              'transition': 'background-color var(--transition)',
              'box-shadow': '-2px 0 8px rgba(0, 0, 0, 0.1)',
              ...?component.props.decoration?.universalStyles(),
              ...?component.props.styles?.toMap(),
            },
          ),
          events: {'click': (_) => _toggleExpand()},
          [Component.text(component.props.tabLabel)],
        ),

        // Expanded panel
        dom.div(
          classes: 'arcane-minimizable-promo-panel',
          styles: dom.Styles(
            raw: {
              'position': 'relative',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '16px',
              'padding': '24px',
              'background-color': 'var(--card)',
              'border': '1px solid var(--border)',
              'border-right': 'none',
              'box-shadow': 'var(--shadow-lg)',
              'width': '280px',
              'max-width': 'calc(100vw - 48px)',
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
                  'top': '12px',
                  'right': '12px',
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
                  'font-size': '20px',
                  'line-height': '1',
                },
              ),
              events: {'click': (_) => _handleDismiss()},
              [const Component.text('\u00D7')],
            ),

            // Discount badge
            if (component.props.discount != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'display': 'inline-flex',
                    'padding': '6px 12px',
                    'background-color': 'var(--primary)',
                    'color': 'var(--primary-foreground)',
                    'font-size': 'var(--font-size-xl)',
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
                dom.h3(
                  styles: const dom.Styles(
                    raw: {
                      'margin': '0',
                      'font-size': 'var(--font-size-lg)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--foreground)',
                      'line-height': '1.4',
                    },
                  ),
                  [Component.text(component.props.title)],
                ),
                dom.p(
                  styles: const dom.Styles(
                    raw: {
                      'margin': '0',
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'line-height': '1.5',
                    },
                  ),
                  [Component.text(component.props.message)],
                ),
              ],
            ),

            // Promo code
            if (component.props.promoCode != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'padding': '10px 12px',
                    'background-color': 'var(--muted)',
                    'border': '1px dashed var(--border)',
                    'border-radius': 'var(--radius-sm)',
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'font-weight': 'var(--font-weight-semibold)',
                    'font-size': 'var(--font-size-base)',
                    'color': 'var(--foreground)',
                    'letter-spacing': '0.05em',
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
                    'font-weight': 'var(--font-weight-medium)',
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
      ],
    );
  }
}
