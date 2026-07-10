import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neon Inline Hero Banner renderer (neutral placeholder skeleton).
///
/// An inline promotional banner with multiple style variants.
class NeonInlineHeroBanner extends StatefulComponent {
  final InlineHeroBannerProps props;

  const NeonInlineHeroBanner(this.props, {super.key});

  @override
  State<NeonInlineHeroBanner> createState() => _NeonInlineHeroBannerState();
}

class _NeonInlineHeroBannerState extends State<NeonInlineHeroBanner> {
  bool _isDismissed = false;

  void _dismiss() {
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
        'gap': '0.75rem',
        'padding': '0.5rem 1rem',
        'background': 'var(--muted)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-full)',
      },
      PromoInlineHeroBannerStyle.ribbon => {
        'display': 'flex',
        'align-items': 'center',
        'gap': '1rem',
        'padding': '0.75rem 1.5rem',
        'background': 'var(--primary)',
        'border-radius': '0',
        'color': 'var(--primary-foreground)',
      },
      PromoInlineHeroBannerStyle.pill => {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.875rem',
        'padding': '0.875rem 1.5rem',
        'background': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-full)',
      },
      PromoInlineHeroBannerStyle.card => {
        'display': 'flex',
        'align-items': 'center',
        'gap': '1rem',
        'padding': '1.25rem 1.75rem',
        'background': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-lg)',
        'box-shadow': '0 4px 12px rgba(0, 0, 0, 0.15)',
      },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final Map<String, String> variantStyles = _getStyleVariantStyles();
    final bool isRibbon =
        component.props.style == PromoInlineHeroBannerStyle.ribbon;

    return dom.div(
      classes: 'neon-inline-hero-banner ${component.props.style.name}',
      styles: dom.Styles(
        raw: {
          ...variantStyles,
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      [
        // Icon
        if (component.props.icon != null)
          dom.div(
            styles: dom.Styles(
              raw: {
                'flex-shrink': '0',
                'color': isRibbon
                    ? 'var(--primary-foreground)'
                    : 'var(--foreground)',
              },
            ),
            [component.props.icon!],
          ),

        // Message
        dom.span(
          styles: dom.Styles(
            raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': isRibbon
                  ? 'var(--primary-foreground)'
                  : 'var(--foreground)',
            },
          ),
          [Component.text(component.props.message)],
        ),

        // Promo code
        if (component.props.promoCode != null)
          dom.span(
            styles: dom.Styles(
              raw: {
                'padding': '0.25rem 0.625rem',
                'background': isRibbon
                    ? 'rgba(255, 255, 255, 0.2)'
                    : 'var(--muted)',
                'border-radius': 'var(--radius-sm)',
                'font-family':
                    'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-bold)',
                'color': isRibbon
                    ? 'var(--primary-foreground)'
                    : 'var(--foreground)',
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
                'padding': '0.5rem 1rem',
                'background': isRibbon
                    ? 'rgba(255, 255, 255, 0.15)'
                    : 'var(--primary)',
                'border': isRibbon
                    ? '1px solid rgba(255, 255, 255, 0.3)'
                    : 'none',
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

        // Dismiss
        if (component.props.dismissible)
          dom.button(
            styles: dom.Styles(
              raw: {
                'flex-shrink': '0',
                'margin-left': '0.5rem',
                'padding': '0.25rem',
                'background': 'transparent',
                'border': 'none',
                'color': isRibbon
                    ? 'rgba(255, 255, 255, 0.7)'
                    : 'var(--muted-foreground)',
                'cursor': 'pointer',
                'opacity': '0.7',
              },
            ),
            events: {'click': (_) => _dismiss()},
            [const Component.text('\u2715')],
          ),
      ],
    );
  }
}
