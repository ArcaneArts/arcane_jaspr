import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neubrutalism Minimizable Promo renderer.
///
/// A promo drawer that slides in from the right edge.
/// When minimized, only a slim tab is visible.
class NeubrutalismMinimizablePromo extends StatefulComponent {
  final MinimizablePromoProps props;

  const NeubrutalismMinimizablePromo(this.props, {super.key});

  @override
  State<NeubrutalismMinimizablePromo> createState() => _NeubrutalismMinimizablePromoState();
}

class _NeubrutalismMinimizablePromoState extends State<NeubrutalismMinimizablePromo> {
  bool _isVisible = false;
  bool _isExpanded = true;
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

  void _toggleExpanded() {
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
    if (_isDismissed || !_isVisible) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    if (!_isExpanded) {
      // Minimized tab
      return dom.button(
        classes: 'neubrutalism-minimizable-promo-tab',
        styles: dom.Styles(
          raw: {
            'position': 'fixed',
            'top': '50%',
            'right': '0',
            'transform': 'translateY(-50%)',
            'z-index': '100',
            'padding': '1rem 0.5rem',
            'writing-mode': 'vertical-rl',
            'text-orientation': 'mixed',
            // Neubrutalism: glass effect
            'background': 'var(--nb-paper, var(--card))',
            'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
            'border-right': 'none',
            'border-radius': 'var(--nb-radius-soft, 4px) 0 0 var(--nb-radius-soft, 4px)',
            'color': 'var(--nb-accent, var(--primary))',
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-bold)',
            'letter-spacing': '0',
            'cursor': 'pointer',
            // Neubrutalism: accent glow
            'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
            ...?component.props.decoration?.universalStyles(),
            ...?component.props.styles?.toMap(),
          },
        ),
        events: {'click': (_) => _toggleExpanded()},
        [Component.text(component.props.tabLabel)],
      );
    }

    // Expanded panel
    return dom.div(
      classes: 'neubrutalism-minimizable-promo-panel',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'top': '50%',
          'right': '0',
          'transform': 'translateY(-50%)',
          'z-index': '100',
          'width': '320px',
          'max-width': '90vw',
          // Neubrutalism: glass effect
          'background': 'var(--nb-paper, var(--card))',
          'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
          'border-right': 'none',
          'border-radius': 'var(--nb-radius-soft, 4px) 0 0 var(--nb-radius-soft, 4px)',
          // Neubrutalism: accent glow
          'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
          'padding': '1.5rem',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Header with minimize and close buttons
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

            dom.div(
              styles: const dom.Styles(
                raw: {'display': 'flex', 'gap': '0.5rem'},
              ),
              [
                // Minimize button
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
                  events: {'click': (_) => _toggleExpanded()},
                  [const Component.text('\u2192')],
                ),
                // Close button
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
