import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Promo Modal renderer.
///
/// Full-screen modal popup for high-priority promotions.
class ShadcnPromoModal extends StatefulComponent {
  final PromoModalProps props;

  const ShadcnPromoModal(this.props, {super.key});

  @override
  State<ShadcnPromoModal> createState() => _ShadcnPromoModalState();
}

class _ShadcnPromoModalState extends State<ShadcnPromoModal> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Timer? _showTimer;
  Timer? _countdownTimer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _showTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted && !_isDismissed) {
        setState(() {
          _isVisible = true;
        });
        _startCountdown();
      }
    });
  }

  void _startCountdown() {
    if (component.props.countdownDuration != null) {
      _remainingTime = component.props.countdownDuration!;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingTime.inSeconds > 0) {
          setState(() {
            _remainingTime = _remainingTime - const Duration(seconds: 1);
          });
        } else {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _showTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _handleDismiss() {
    setState(() {
      _isDismissed = true;
      _isVisible = false;
    });
    component.props.onDismiss?.call();
  }

  String _formatCountdown(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Component build(BuildContext context) {
    if (!_isVisible || _isDismissed) {
      return const dom.div(styles: dom.Styles(raw: {'display': 'none'}), []);
    }

    return dom.div(
      classes: 'arcane-promo-modal-overlay',
      styles: const dom.Styles(
        raw: {
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'padding': '16px',
          'background-color': 'rgba(0, 0, 0, 0.8)',
          'backdrop-filter': 'blur(2px)',
        },
      ),
      events: {
        'click': (event) {
          if (event.target == event.currentTarget) {
            _handleDismiss();
          }
        },
      },
      [
        dom.div(
          classes: 'arcane-promo-modal',
          styles: dom.Styles(
            raw: {
              'position': 'relative',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '20px',
              'padding': '24px',
              'background-color': 'var(--card)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius-md)',
              'box-shadow': '0 10px 40px rgba(0, 0, 0, 0.3)',
              'max-width': '448px',
              'width': '100%',
              ...?component.props.decoration?.universalStyles(),
              ...?component.props.styles?.toMap(),
            },
          ),
          events: {'click': (event) => event.stopPropagation()},
          [
            // Close button
            dom.button(
              attributes: {'type': 'button', 'aria-label': 'Close modal'},
              styles: const dom.Styles(
                raw: {
                  'position': 'absolute',
                  'top': '12px',
                  'right': '12px',
                  'display': 'inline-flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '24px',
                  'height': '24px',
                  'padding': '0',
                  'background': 'transparent',
                  'border': 'none',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'opacity': '0.7',
                  'transition': 'opacity var(--transition)',
                  'border-radius': 'var(--radius-xs)',
                },
              ),
              events: {'click': (_) => _handleDismiss()},
              [const Component.text('\u00D7')],
            ),

            // Hero image
            if (component.props.heroImage != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'width': '100%',
                    'max-height': '180px',
                    'overflow': 'hidden',
                    'border-radius': 'var(--radius-sm)',
                    'margin': '-4px 0 0 0',
                  },
                ),
                [component.props.heroImage!],
              ),

            // Content section
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': '16px',
                },
              ),
              [
                // Discount badge
                if (component.props.discount != null)
                  dom.div(
                    styles: const dom.Styles(
                      raw: {
                        'display': 'inline-flex',
                        'align-items': 'center',
                        'justify-content': 'center',
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

                // Text content
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'display': 'flex',
                      'flex-direction': 'column',
                      'gap': '8px',
                    },
                  ),
                  [
                    if (component.props.subtitle.isNotEmpty)
                      dom.div(
                        styles: const dom.Styles(
                          raw: {
                            'font-size': 'var(--font-size-xs)',
                            'font-weight': 'var(--font-weight-semibold)',
                            'text-transform': 'uppercase',
                            'letter-spacing': '0.1em',
                            'color': 'var(--muted-foreground)',
                          },
                        ),
                        [Component.text(component.props.subtitle)],
                      ),
                    dom.h2(
                      styles: const dom.Styles(
                        raw: {
                          'font-size': 'var(--font-size-xl)',
                          'font-weight': 'var(--font-weight-bold)',
                          'color': 'var(--foreground)',
                          'line-height': '1.3',
                          'margin': '0',
                        },
                      ),
                      [Component.text(component.props.title)],
                    ),
                    if (component.props.description != null)
                      dom.p(
                        styles: const dom.Styles(
                          raw: {
                            'font-size': 'var(--font-size-sm)',
                            'color': 'var(--muted-foreground)',
                            'line-height': '1.5',
                            'margin': '0',
                          },
                        ),
                        [Component.text(component.props.description!)],
                      ),
                  ],
                ),

                // Countdown
                if (_remainingTime.inSeconds > 0)
                  dom.div(
                    styles: const dom.Styles(
                      raw: {
                        'display': 'flex',
                        'flex-direction': 'column',
                        'align-items': 'center',
                        'gap': '6px',
                        'padding': '12px',
                        'background-color': 'var(--muted)',
                        'border-radius': 'var(--radius-sm)',
                      },
                    ),
                    [
                      const dom.div(
                        styles: dom.Styles(
                          raw: {
                            'font-size': 'var(--font-size-xs)',
                            'color': 'var(--muted-foreground)',
                            'text-transform': 'uppercase',
                            'letter-spacing': '0.05em',
                            'font-weight': 'var(--font-weight-medium)',
                          },
                        ),
                        [Component.text('Offer expires in')],
                      ),
                      dom.div(
                        styles: const dom.Styles(
                          raw: {
                            'font-size': 'var(--font-size-lg)',
                            'font-weight': 'var(--font-weight-bold)',
                            'font-family':
                                'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                            'color': 'var(--foreground)',
                          },
                        ),
                        [Component.text(_formatCountdown(_remainingTime))],
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
                      const dom.div(
                        styles: dom.Styles(
                          raw: {
                            'font-size': 'var(--font-size-xs)',
                            'color': 'var(--muted-foreground)',
                            'font-weight': 'var(--font-weight-medium)',
                            'text-align': 'center',
                          },
                        ),
                        [Component.text('Use code')],
                      ),
                      dom.code(
                        styles: const dom.Styles(
                          raw: {
                            'padding': '10px 16px',
                            'background-color': 'var(--muted)',
                            'border': '2px dashed var(--border)',
                            'border-radius': 'var(--radius-sm)',
                            'font-family':
                                'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                            'font-weight': 'var(--font-weight-bold)',
                            'font-size': 'var(--font-size-base)',
                            'color': 'var(--foreground)',
                            'letter-spacing': '0.05em',
                            'text-align': 'center',
                            'display': 'block',
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
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'height': '40px',
                        'padding': '0 24px',
                        'background-color': 'var(--primary)',
                        'color': 'var(--primary-foreground)',
                        'font-size': 'var(--font-size-sm)',
                        'font-weight': 'var(--font-weight-semibold)',
                        'text-decoration': 'none',
                        'border-radius': 'var(--radius-sm)',
                        'transition': 'all var(--transition)',
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
        ),
      ],
    );
  }
}
