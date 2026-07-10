import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Bottom Floating Banner renderer.
///
/// Bottom floating banner that slides up with optional countdown timer.
class ShadcnBottomFloatingBanner extends StatefulComponent {
  final BottomFloatingBannerProps props;

  const ShadcnBottomFloatingBanner(this.props, {super.key});

  @override
  State<ShadcnBottomFloatingBanner> createState() =>
      _ShadcnBottomFloatingBannerState();
}

class _ShadcnBottomFloatingBannerState
    extends State<ShadcnBottomFloatingBanner> {
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
    } else if (component.props.expiresAt != null) {
      _updateExpiresAtCountdown();
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateExpiresAtCountdown();
      });
    }
  }

  void _updateExpiresAtCountdown() {
    final DateTime now = DateTime.now();
    final Duration diff = component.props.expiresAt!.difference(now);
    if (diff.isNegative) {
      _countdownTimer?.cancel();
      setState(() {
        _remainingTime = Duration.zero;
      });
    } else {
      setState(() {
        _remainingTime = diff;
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
    if (_isDismissed) {
      return const dom.div(styles: dom.Styles(raw: {'display': 'none'}), []);
    }

    return dom.div(
      classes: 'arcane-bottom-floating-banner',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'bottom': '16px',
          'left': '50%',
          'transform': _isVisible
              ? 'translateX(-50%) translateY(0)'
              : 'translateX(-50%) translateY(calc(100% + 32px))',
          'z-index': '50',
          'display': 'flex',
          'align-items': 'center',
          'gap': '12px',
          'padding': '12px 16px',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-md)',
          'box-shadow': '0 4px 12px rgba(0, 0, 0, 0.15)',
          'transition': 'transform 350ms cubic-bezier(0.4, 0, 0.2, 1)',
          'max-width': 'calc(100vw - 32px)',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Content
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '2px',
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

        // Countdown
        if (_remainingTime.inSeconds > 0)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center',
                'gap': '2px',
                'padding': '8px 10px',
                'background-color': 'var(--muted)',
                'border-radius': 'var(--radius-sm)',
              },
            ),
            [
              const dom.div(
                styles: dom.Styles(
                  raw: {
                    'font-size': '10px',
                    'color': 'var(--muted-foreground)',
                    'text-transform': 'uppercase',
                    'letter-spacing': '0.05em',
                    'font-weight': 'var(--font-weight-medium)',
                  },
                ),
                [Component.text('Ends in')],
              ),
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-base)',
                    'font-weight': 'var(--font-weight-bold)',
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'color': 'var(--foreground)',
                    'line-height': '1',
                  },
                ),
                [Component.text(_formatCountdown(_remainingTime))],
              ),
            ],
          ),

        // Promo code
        if (component.props.promoCode != null)
          dom.code(
            styles: const dom.Styles(
              raw: {
                'padding': '6px 10px',
                'background-color': 'var(--muted)',
                'border': '1px solid var(--border)',
                'border-radius': 'var(--radius-sm)',
                'font-family':
                    'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                'font-weight': 'var(--font-weight-semibold)',
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--foreground)',
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
                'height': '32px',
                'padding': '0 12px',
                'background-color': 'var(--primary)',
                'color': 'var(--primary-foreground)',
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'text-decoration': 'none',
                'border-radius': 'var(--radius-sm)',
                'transition': 'all var(--transition)',
                'white-space': 'nowrap',
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

        // Dismiss button
        dom.button(
          attributes: {'type': 'button', 'aria-label': 'Dismiss banner'},
          styles: const dom.Styles(
            raw: {
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
              'border-radius': 'var(--radius-xs)',
              'transition': 'all var(--transition)',
              'opacity': '0.7',
            },
          ),
          events: {'click': (_) => _handleDismiss()},
          [const Component.text('\u00D7')],
        ),
      ],
    );
  }
}
