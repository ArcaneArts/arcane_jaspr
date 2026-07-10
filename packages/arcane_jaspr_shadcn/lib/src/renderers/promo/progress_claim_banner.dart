import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Progress Claim Banner renderer.
///
/// A banner showing how many people have claimed an offer.
class ShadcnProgressClaimBanner extends StatefulComponent {
  final ProgressClaimBannerProps props;

  const ShadcnProgressClaimBanner(this.props, {super.key});

  @override
  State<ShadcnProgressClaimBanner> createState() =>
      _ShadcnProgressClaimBannerState();
}

class _ShadcnProgressClaimBannerState extends State<ShadcnProgressClaimBanner> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Timer? _showTimer;
  Timer? _progressTimer;
  int _currentClaimed = 0;

  @override
  void initState() {
    super.initState();
    _currentClaimed = component.props.claimedCount;

    _showTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted && !_isDismissed) {
        setState(() {
          _isVisible = true;
        });
        _startProgressSimulation();
      }
    });
  }

  void _startProgressSimulation() {
    if (!component.props.simulateProgress) return;

    _progressTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentClaimed < component.props.totalCount && mounted) {
        setState(() {
          _currentClaimed = (_currentClaimed + 1).clamp(
            0,
            component.props.totalCount,
          );
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _showTimer?.cancel();
    _progressTimer?.cancel();
    super.dispose();
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

    final double progress = _currentClaimed / component.props.totalCount;
    final int remaining = component.props.totalCount - _currentClaimed;

    return dom.div(
      classes: 'arcane-progress-claim-banner',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'bottom': '24px',
          'left': '50%',
          'transform': _isVisible
              ? 'translateX(-50%) translateY(0)'
              : 'translateX(-50%) translateY(calc(100% + 48px))',
          'z-index': '50',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '16px',
          'padding': '16px',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-md)',
          'box-shadow': 'var(--shadow-lg)',
          'transition': 'transform 400ms cubic-bezier(0.4, 0, 0.2, 1)',
          'max-width': '380px',
          'width': 'calc(100vw - 48px)',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Header
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'flex-start',
              'justify-content': 'space-between',
              'gap': '12px',
            },
          ),
          [
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': '4px',
                },
              ),
              [
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-base)',
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
                      'line-height': '1.4',
                    },
                  ),
                  [Component.text(component.props.message)],
                ),
              ],
            ),
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
                  'font-size': '20px',
                  'line-height': '1',
                  'flex-shrink': '0',
                },
              ),
              events: {'click': (_) => _handleDismiss()},
              [const Component.text('\u00D7')],
            ),
          ],
        ),

        // Progress bar
        dom.div(
          styles: const dom.Styles(
            raw: {'display': 'flex', 'flex-direction': 'column', 'gap': '8px'},
          ),
          [
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'width': '100%',
                  'height': '6px',
                  'background-color': 'var(--muted)',
                  'border-radius': 'var(--radius-full)',
                  'overflow': 'hidden',
                },
              ),
              [
                dom.div(
                  styles: dom.Styles(
                    raw: {
                      'width': '${(progress * 100).toStringAsFixed(1)}%',
                      'height': '100%',
                      'background-color': 'var(--primary)',
                      'transition': 'width 600ms cubic-bezier(0.4, 0, 0.2, 1)',
                    },
                  ),
                  [],
                ),
              ],
            ),
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'justify-content': 'space-between',
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                },
              ),
              [
                dom.span(
                  styles: const dom.Styles(
                    raw: {'font-weight': 'var(--font-weight-medium)'},
                  ),
                  [Component.text('$_currentClaimed claimed')],
                ),
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--destructive)',
                    },
                  ),
                  [Component.text('Only $remaining left')],
                ),
              ],
            ),
          ],
        ),

        // Promo code and CTA
        dom.div(
          styles: const dom.Styles(
            raw: {'display': 'flex', 'align-items': 'center', 'gap': '8px'},
          ),
          [
            if (component.props.promoCode != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'padding': '8px 12px',
                    'background-color': 'var(--muted)',
                    'border': '1px solid var(--border)',
                    'border-radius': 'var(--radius-sm)',
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'font-weight': 'var(--font-weight-semibold)',
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--foreground)',
                    'letter-spacing': '0.025em',
                  },
                ),
                [Component.text(component.props.promoCode!)],
              ),
            if (component.props.ctaText != null)
              dom.a(
                href: component.props.ctaHref ?? '#',
                styles: const dom.Styles(
                  raw: {
                    'flex': '1',
                    'display': 'inline-flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'height': '36px',
                    'padding': '0 16px',
                    'background-color': 'var(--primary)',
                    'color': 'var(--primary-foreground)',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
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
      ],
    );
  }
}
