import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neon Top Announcement Bar renderer (neutral placeholder skeleton).
///
/// A thin sticky announcement bar at the top of the page.
class NeonTopAnnouncementBar extends StatefulComponent {
  final TopAnnouncementBarProps props;

  const NeonTopAnnouncementBar(this.props, {super.key});

  @override
  State<NeonTopAnnouncementBar> createState() =>
      _NeonTopAnnouncementBarState();
}

class _NeonTopAnnouncementBarState extends State<NeonTopAnnouncementBar> {
  bool _isDismissed = false;
  bool _codeCopied = false;

  void _dismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  void _copyCode() {
    setState(() {
      _codeCopied = true;
    });
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _codeCopied = false;
        });
      }
    });
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    return dom.div(
      classes: 'neon-top-announcement-bar',
      styles: const dom.Styles(
        raw: {
          'position': 'sticky',
          'top': '0',
          'left': '0',
          'right': '0',
          'z-index': '100',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '1rem',
          'padding': '0.5rem 1.5rem',
          'background-color': 'var(--card)',
          'border-bottom': '1px solid var(--border)',
        },
      ),
      [
        dom.span(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--foreground)',
            },
          ),
          [Component.text(component.props.message)],
        ),
        if (component.props.promoCode != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '0.5rem',
              },
            ),
            [
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'padding': '0.375rem 0.75rem',
                    'background': 'var(--muted)',
                    'border': '1px solid var(--border)',
                    'border-radius': 'var(--radius-sm)',
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--foreground)',
                  },
                ),
                [Component.text(component.props.promoCode!)],
              ),
              if (component.props.showCopyButton)
                dom.button(
                  styles: dom.Styles(
                    raw: {
                      'padding': '0.375rem 0.625rem',
                      'background': 'transparent',
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius-sm)',
                      'color': _codeCopied
                          ? 'var(--success)'
                          : 'var(--muted-foreground)',
                      'cursor': 'pointer',
                      'font-size': 'var(--font-size-xs)',
                      'transition': 'all var(--transition)',
                    },
                  ),
                  events: {'click': (_) => _copyCode()},
                  [Component.text(_codeCopied ? 'Copied!' : 'Copy')],
                ),
            ],
          ),
        if (component.props.ctaText != null)
          dom.a(
            href: component.props.ctaHref ?? '#',
            styles: const dom.Styles(
              raw: {
                'padding': '0.5rem 1rem',
                'background': 'var(--primary)',
                'border': 'none',
                'border-radius': 'var(--radius-sm)',
                'color': 'var(--primary-foreground)',
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
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
        dom.button(
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'right': '1rem',
              'padding': '0.25rem',
              'background': 'transparent',
              'border': 'none',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'opacity': '0.7',
              'transition': 'opacity var(--transition)',
            },
          ),
          events: {'click': (_) => _dismiss()},
          [const Component.text('\u2715')],
        ),
      ],
    );
  }
}
