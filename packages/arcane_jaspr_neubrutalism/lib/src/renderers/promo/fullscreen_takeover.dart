import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neubrutalism Fullscreen Takeover renderer.
///
/// A dramatic full-screen takeover for major promotions.
class NeubrutalismFullscreenTakeover extends StatefulComponent {
  final FullscreenTakeoverProps props;

  const NeubrutalismFullscreenTakeover(this.props, {super.key});

  @override
  State<NeubrutalismFullscreenTakeover> createState() =>
      _NeubrutalismFullscreenTakeoverState();
}

class _NeubrutalismFullscreenTakeoverState extends State<NeubrutalismFullscreenTakeover> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Duration? _remainingTime;
  Timer? _countdownTimer;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _delayTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
        _startCountdown();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _delayTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    if (component.props.countdownDuration != null) {
      _remainingTime = component.props.countdownDuration;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          if (_remainingTime != null && _remainingTime!.inSeconds > 0) {
            _remainingTime = _remainingTime! - const Duration(seconds: 1);
          } else {
            timer.cancel();
          }
        });
      });
    }
  }

  void _dismiss() {
    setState(() {
      _isDismissed = true;
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
    if (_isDismissed || !_isVisible) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    return dom.div(
      classes: 'neubrutalism-fullscreen-takeover',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'inset': '0',
          'z-index': '200',
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'justify-content': 'center',
          'padding': '2rem',
          // Neubrutalism: dramatic dark background with gradient
          'background': 'var(--nb-paper, var(--card))',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Close button
        dom.button(
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'top': '2rem',
              'right': '2rem',
              'width': '48px',
              'height': '48px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'background': 'var(--nb-paper, #fff)',
              'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
              'color': 'var(--nb-ink, var(--foreground))',
              'font-size': 'var(--font-size-xl)',
              'font-weight': '700',
              'box-shadow':
                  'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
              'cursor': 'pointer',
              'transition': 'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
            },
          ),
          events: {'click': (_) => _dismiss()},
          [const Component.text('\u2715')],
        ),

        // Content container
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'text-align': 'center',
              'max-width': '640px',
            },
          ),
          [
            // Subheadline
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'font-size': 'var(--font-size-lg)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--nb-accent, var(--primary))',
                  'text-transform': 'uppercase',
                  'letter-spacing': '0',
                  'margin-bottom': '1rem',
                  // Neubrutalism: text glow
                },
              ),
              [Component.text(component.props.subheadline)],
            ),

            // Discount badge
            if (component.props.discount != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'display': 'inline-block',
                    'padding': '1rem 2.5rem',
                    'background': 'var(--nb-accent, var(--primary))',
                    'border-radius': 'var(--nb-radius-soft, 4px)',
                    'font-size': '4rem',
                    'font-weight': 'var(--font-weight-bold)',
                    'color': 'var(--nb-on-accent, #000)',
                    'margin-bottom': '1.5rem',
                    // Neubrutalism: intense glow
                    'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
                  },
                ),
                [Component.text(component.props.discount!)],
              ),

            // Headline
            dom.h1(
              styles: const dom.Styles(
                raw: {
                  'font-size': '3.5rem',
                  'font-weight': 'var(--font-weight-bold)',
                  'color': 'var(--foreground)',
                  'margin': '0 0 1.5rem 0',
                  'line-height': '1.1',
                },
              ),
              [Component.text(component.props.headline)],
            ),

            // Description
            if (component.props.description != null)
              dom.p(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xl)',
                    'color': 'var(--muted-foreground)',
                    'line-height': '1.6',
                    'margin': '0 0 2rem 0',
                    'max-width': '500px',
                  },
                ),
                [Component.text(component.props.description!)],
              ),

            // Countdown
            if (_remainingTime != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'flex-direction': 'column',
                    'align-items': 'center',
                    'gap': '0.5rem',
                    'margin-bottom': '2rem',
                  },
                ),
                [
                  const dom.span(
                    styles: dom.Styles(
                      raw: {
                        'font-size': 'var(--font-size-sm)',
                        'color': 'var(--muted-foreground)',
                        'text-transform': 'uppercase',
                        'letter-spacing': '0',
                      },
                    ),
                    [Component.text('Offer ends in')],
                  ),
                  dom.span(
                    styles: const dom.Styles(
                      raw: {
                        'font-family':
                            'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                        'font-size': 'var(--font-size-3xl)',
                        'font-weight': 'var(--font-weight-bold)',
                        'color': 'var(--nb-accent, var(--primary))',
                        'letter-spacing': '0',
                      },
                    ),
                    [Component.text(_formatCountdown(_remainingTime!))],
                  ),
                ],
              ),

            // Promo code
            if (component.props.promoCode != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'padding': '1.25rem 2rem',
                    'background': 'var(--nb-paper-soft, var(--card))',
                    'border': '2px dashed var(--nb-accent, var(--primary))',
                    'border-radius': 'var(--nb-radius-soft, 4px)',
                    'margin-bottom': '2rem',
                  },
                ),
                [
                  const dom.div(
                    styles: dom.Styles(
                      raw: {
                        'font-size': 'var(--font-size-sm)',
                        'color': 'var(--muted-foreground)',
                        'text-transform': 'uppercase',
                        'letter-spacing': '0',
                        'margin-bottom': '0.5rem',
                      },
                    ),
                    [Component.text('Use code')],
                  ),
                  dom.div(
                    styles: const dom.Styles(
                      raw: {
                        'font-family':
                            'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                        'font-size': 'var(--font-size-2xl)',
                        'font-weight': 'var(--font-weight-bold)',
                        'color': 'var(--nb-accent, var(--primary))',
                        'letter-spacing': '0',
                      },
                    ),
                    [Component.text(component.props.promoCode!)],
                  ),
                ],
              ),

            // CTA Buttons
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'justify-content': 'center',
                  'gap': '1rem',
                },
              ),
              [
                // Primary CTA
                if (component.props.ctaText != null)
                  dom.a(
                    href: component.props.ctaHref ?? '#',
                    styles: const dom.Styles(
                      raw: {
                        'display': 'inline-block',
                        'padding': '1.25rem 3rem',
                        'background': 'var(--nb-accent, var(--primary))',
                        'border': 'none',
                        'border-radius': 'var(--nb-radius-soft, 4px)',
                        'color': 'var(--nb-on-accent, #000)',
                        'font-size': 'var(--font-size-lg)',
                        'font-weight': 'var(--font-weight-bold)',
                        'text-decoration': 'none',
                        'cursor': 'pointer',
                        'transition': 'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
                        // Neubrutalism: intense glow
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

                // Secondary CTA (dismiss)
                if (component.props.secondaryCtaText != null)
                  dom.button(
                    styles: const dom.Styles(
                      raw: {
                        'padding': '1.25rem 2rem',
                        'background': 'transparent',
                        'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                        'border-radius': 'var(--nb-radius-soft, 4px)',
                        'color': 'var(--muted-foreground)',
                        'font-size': 'var(--font-size-base)',
                        'font-weight': 'var(--font-weight-medium)',
                        'cursor': 'pointer',
                        'transition': 'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
                      },
                    ),
                    events: {'click': (_) => _dismiss()},
                    [Component.text(component.props.secondaryCtaText!)],
                  ),
              ],
            ),
          ],
        ),

        // Decorative glow elements
        const dom.div(
          styles: dom.Styles(
            raw: {
              'position': 'absolute',
              'top': '20%',
              'left': '10%',
              'width': '300px',
              'height': '300px',
              'background': 'transparent',
              'pointer-events': 'none',
            },
          ),
          [],
        ),
        const dom.div(
          styles: dom.Styles(
            raw: {
              'position': 'absolute',
              'bottom': '20%',
              'right': '10%',
              'width': '400px',
              'height': '400px',
              'background': 'transparent',
              'pointer-events': 'none',
            },
          ),
          [],
        ),
      ],
    );
  }
}
