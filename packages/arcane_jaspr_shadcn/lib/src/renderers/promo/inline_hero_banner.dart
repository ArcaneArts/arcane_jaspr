import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// ShadCN Inline Hero Banner renderer.
///
/// An inline promotional banner that integrates with the hero section.
class ShadcnInlineHeroBanner extends StatefulComponent {
  final InlineHeroBannerProps props;

  const ShadcnInlineHeroBanner(this.props, {super.key});

  @override
  State<ShadcnInlineHeroBanner> createState() => _ShadcnInlineHeroBannerState();
}

class _ShadcnInlineHeroBannerState extends State<ShadcnInlineHeroBanner> {
  bool _isDismissed = false;

  void _handleDismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  Map<String, String> _getStyleVariantStyles() {
    return switch (component.props.style) {
      PromoInlineHeroBannerStyle.badge => {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '8px',
        'padding': '4px 12px',
        'background-color': 'var(--muted)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-full)',
      },
      PromoInlineHeroBannerStyle.ribbon => {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '8px',
        'padding': '6px 16px',
        'background-color': 'var(--primary)',
        'color': 'var(--primary-foreground)',
        'border-radius': '0',
      },
      PromoInlineHeroBannerStyle.pill => {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '8px',
        'padding': '6px 16px',
        'background-color': 'var(--muted)',
        'color': 'var(--foreground)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-full)',
      },
      PromoInlineHeroBannerStyle.card => {
        'display': 'flex',
        'align-items': 'center',
        'gap': '12px',
        'padding': '12px 16px',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-md)',
        'box-shadow': 'var(--shadow-lg)',
      },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div(styles: dom.Styles(raw: {'display': 'none'}), []);
    }

    final bool isRibbon =
        component.props.style == PromoInlineHeroBannerStyle.ribbon;

    return dom.div(
      classes:
          'arcane-inline-hero-banner arcane-inline-hero-banner-${component.props.style.name}',
      styles: dom.Styles(
        raw: {
          'font-size': 'var(--font-size-sm)',
          ..._getStyleVariantStyles(),
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Icon
        if (component.props.icon != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'width': '16px',
                'height': '16px',
                'flex-shrink': '0',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
              },
            ),
            [component.props.icon!],
          ),

        // Message
        dom.span(
          styles: dom.Styles(
            raw: {
              'font-weight': 'var(--font-weight-medium)',
              'color': isRibbon ? 'inherit' : 'var(--foreground)',
              'line-height': '1.5',
            },
          ),
          [Component.text(component.props.message)],
        ),

        // Promo code
        if (component.props.promoCode != null)
          dom.span(
            styles: dom.Styles(
              raw: {
                'padding': '2px 8px',
                'background-color': isRibbon
                    ? 'rgba(255, 255, 255, 0.2)'
                    : 'var(--background)',
                'border': isRibbon ? 'none' : '1px solid var(--border)',
                'border-radius': 'var(--radius-xs)',
                'font-family':
                    'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                'font-weight': 'var(--font-weight-semibold)',
                'font-size': 'var(--font-size-xs)',
                'color': isRibbon ? 'inherit' : 'var(--foreground)',
              },
            ),
            [Component.text(component.props.promoCode!)],
          ),

        // CTA
        if (component.props.ctaText != null)
          dom.a(
            href: component.props.ctaHref ?? '#',
            styles: dom.Styles(
              raw: {
                'display': 'inline-flex',
                'align-items': 'center',
                'gap': '4px',
                'font-weight': 'var(--font-weight-medium)',
                'text-decoration': 'none',
                'color': isRibbon ? 'inherit' : 'var(--primary)',
                'transition': 'opacity var(--transition)',
                if (isRibbon) 'text-decoration': 'underline',
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
            [
              Component.text(component.props.ctaText!),
              const Component.text('\u2192'),
            ],
          ),

        // Dismiss button
        if (component.props.dismissible)
          dom.button(
            attributes: {'type': 'button', 'aria-label': 'Dismiss'},
            styles: dom.Styles(
              raw: {
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '20px',
                'height': '20px',
                'margin-left': '4px',
                'padding': '0',
                'background': 'transparent',
                'border': 'none',
                'border-radius': 'var(--radius-xs)',
                'color': isRibbon ? 'inherit' : 'var(--muted-foreground)',
                'cursor': 'pointer',
                'transition': 'background-color var(--transition)',
              },
            ),
            events: {'click': (_) => _handleDismiss()},
            [const Component.text('\u00D7')],
          ),
      ],
    );
  }
}
