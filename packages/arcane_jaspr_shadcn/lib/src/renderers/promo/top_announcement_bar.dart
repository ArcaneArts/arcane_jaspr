import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Top Announcement Bar renderer.
///
/// A thin sticky announcement bar at the top of the page.
/// Shows promo message with optional CTA button and dismiss functionality.
class ShadcnTopAnnouncementBar extends StatefulComponent {
  final TopAnnouncementBarProps props;

  const ShadcnTopAnnouncementBar(this.props, {super.key});

  @override
  State<ShadcnTopAnnouncementBar> createState() =>
      _ShadcnTopAnnouncementBarState();
}

class _ShadcnTopAnnouncementBarState extends State<ShadcnTopAnnouncementBar> {
  bool _isVisible = true;
  bool _copied = false;

  void _handleDismiss() {
    setState(() {
      _isVisible = false;
    });
    component.props.onDismiss?.call();
  }

  void _handleCopy() {
    // Note: Clipboard API would need JS interop in real implementation
    setState(() {
      _copied = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _copied = false;
        });
      }
    });
  }

  void _handleCtaClick() {
    component.props.onCtaClick?.call();
  }

  @override
  Component build(BuildContext context) {
    if (!_isVisible) {
      return const dom.div(styles: dom.Styles(raw: {'display': 'none'}), []);
    }

    return dom.div(
      classes: 'arcane-top-announcement-bar',
      styles: dom.Styles(
        raw: {
          'position': 'sticky',
          'top': '0',
          'left': '0',
          'right': '0',
          'z-index': '50',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '8px',
          'padding': '8px 16px',
          'background-color': 'var(--primary)',
          'color': 'var(--primary-foreground)',
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-medium)',
          'border-bottom': '1px solid rgba(255, 255, 255, 0.1)',
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Message with promo code
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '8px',
              'flex': '1',
              'justify-content': 'center',
            },
          ),
          [
            dom.span(styles: const dom.Styles(raw: {'line-height': '1.5'}), [
              Component.text(component.props.message),
            ]),
            // Promo code
            if (component.props.promoCode != null)
              dom.code(
                styles: const dom.Styles(
                  raw: {
                    'display': 'inline-flex',
                    'align-items': 'center',
                    'gap': '4px',
                    'padding': '2px 6px',
                    'background-color': 'rgba(255, 255, 255, 0.2)',
                    'border-radius': 'var(--radius-xs)',
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'font-size': 'var(--font-size-xs)',
                    'font-weight': 'var(--font-weight-semibold)',
                  },
                ),
                [
                  Component.text(component.props.promoCode!),
                  if (component.props.showCopyButton)
                    dom.button(
                      attributes: {
                        'type': 'button',
                        'aria-label': 'Copy promo code',
                      },
                      styles: const dom.Styles(
                        raw: {
                          'display': 'inline-flex',
                          'align-items': 'center',
                          'justify-content': 'center',
                          'width': '16px',
                          'height': '16px',
                          'padding': '0',
                          'background': 'transparent',
                          'border': 'none',
                          'color': 'inherit',
                          'cursor': 'pointer',
                          'opacity': '0.8',
                          'transition': 'opacity var(--transition)',
                          'font-size': '12px',
                        },
                      ),
                      events: {'click': (_) => _handleCopy()},
                      [Component.text(_copied ? '\u2713' : '\u2398')],
                    ),
                ],
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
                'gap': '4px',
                'padding': '4px 10px',
                'background-color': 'var(--background)',
                'color': 'var(--foreground)',
                'font-size': 'var(--font-size-xs)',
                'font-weight': 'var(--font-weight-medium)',
                'text-decoration': 'none',
                'border-radius': 'var(--radius-xs)',
                'transition': 'all var(--transition)',
                'white-space': 'nowrap',
              },
            ),
            events: {
              'click': (e) {
                if (component.props.onCtaClick != null) {
                  e.preventDefault();
                  _handleCtaClick();
                }
              },
            },
            [
              Component.text(component.props.ctaText!),
              const Component.text('\u2192'),
            ],
          ),

        // Dismiss button
        if (component.props.onDismiss != null)
          dom.button(
            attributes: {
              'type': 'button',
              'aria-label': 'Dismiss announcement',
            },
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
                'color': 'inherit',
                'cursor': 'pointer',
                'opacity': '0.7',
                'transition': 'opacity var(--transition)',
                'margin-left': 'auto',
              },
            ),
            events: {'click': (_) => _handleDismiss()},
            [const Component.text('\u00D7')],
          ),
      ],
    );
  }
}
