import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

class NeubrutalismInlineHeroBanner extends StatefulComponent {
  final InlineHeroBannerProps props;

  const NeubrutalismInlineHeroBanner(this.props, {super.key});

  @override
  State<NeubrutalismInlineHeroBanner> createState() =>
      _NeubrutalismInlineHeroBannerState();
}

class _NeubrutalismInlineHeroBannerState
    extends State<NeubrutalismInlineHeroBanner> {
  bool _isDismissed = false;

  void _dismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  Map<String, String> _getStyleVariantStyles() {
    return switch (component.props.style) {
      PromoInlineHeroBannerStyle.badge => <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.75rem',
        'padding': '0.5rem 1rem',
        'background': 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'border-radius': '9999px',
        'box-shadow':
            'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
      },
      PromoInlineHeroBannerStyle.ribbon => <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': '1rem',
        'padding': '0.875rem 1.5rem',
        'background': 'var(--nb-accent, var(--primary))',
        'border': 'none',
        'border-top': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'border-bottom':
            'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'border-radius': '0',
        'color': 'var(--nb-on-accent, #000)',
      },
      PromoInlineHeroBannerStyle.pill => <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.875rem',
        'padding': '0.75rem 1.25rem',
        'background': 'var(--nb-accent, var(--primary))',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'border-radius': '9999px',
        'box-shadow':
            'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
        'color': 'var(--nb-on-accent, #000)',
      },
      PromoInlineHeroBannerStyle.card => <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': '1rem',
        'padding': '1.25rem 1.75rem',
        'background': 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow':
            'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final Map<String, String> variantStyles = _getStyleVariantStyles();
    final bool isFilled =
        component.props.style == PromoInlineHeroBannerStyle.ribbon ||
            component.props.style == PromoInlineHeroBannerStyle.pill;
    final String foregroundColor =
        isFilled ? 'var(--nb-on-accent, #000)' : 'var(--foreground)';
    final String accentColor =
        isFilled ? 'var(--nb-on-accent, #000)' : 'var(--nb-accent, var(--primary))';

    return dom.div(
      classes: 'neubrutalism-inline-hero-banner ${component.props.style.name}',
      styles: dom.Styles(
        raw: {
          ...variantStyles,
          ...?component.props.decoration?.universalStyles(),
          ...?component.props.styles?.toMap(),
        },
      ),
      <Component>[
        if (component.props.icon != null)
          dom.div(
            styles: dom.Styles(
              raw: <String, String>{
                'flex-shrink': '0',
                'color': accentColor,
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
              },
            ),
            <Component>[component.props.icon!],
          ),
        dom.span(
          styles: dom.Styles(
            raw: <String, String>{
              'font-size': 'var(--font-size-sm)',
              'font-weight': '700',
              'color': foregroundColor,
            },
          ),
          <Component>[Component.text(component.props.message)],
        ),
        if (component.props.promoCode != null)
          dom.span(
            classes: 'neubrutalism-inline-hero-banner-code',
            styles: dom.Styles(
              raw: <String, String>{
                'padding': '0.25rem 0.625rem',
                'background': isFilled
                    ? 'var(--nb-paper, #fff)'
                    : 'var(--nb-accent, var(--primary))',
                'color': isFilled
                    ? 'var(--foreground)'
                    : 'var(--nb-on-accent, #000)',
                'border':
                    'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'font-family':
                    'var(--font-mono, ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace)',
                'font-size': 'var(--font-size-sm)',
                'font-weight': '800',
              },
            ),
            <Component>[Component.text(component.props.promoCode!)],
          ),
        if (component.props.ctaText != null)
          dom.a(
            href: component.props.ctaHref ?? '#',
            classes: 'neubrutalism-inline-hero-banner-cta',
            styles: dom.Styles(
              raw: <String, String>{
                'padding': '0.5rem 1rem',
                'background': isFilled
                    ? 'var(--nb-paper, #fff)'
                    : 'var(--nb-accent, var(--primary))',
                'color': isFilled
                    ? 'var(--foreground)'
                    : 'var(--nb-on-accent, #000)',
                'border':
                    'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'box-shadow':
                    'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
                'font-family': 'var(--font-heading)',
                'font-size': 'var(--font-size-sm)',
                'font-weight': '800',
                'text-decoration': 'none',
                'cursor': 'pointer',
                'transition':
                    'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
              },
            ),
            events: component.props.onCtaClick != null
                ? <String, EventCallback>{
                    'click': (dynamic e) {
                      (e as dynamic).preventDefault();
                      component.props.onCtaClick!();
                    },
                  }
                : null,
            <Component>[Component.text(component.props.ctaText!)],
          ),
        if (component.props.dismissible)
          dom.button(
            classes: 'neubrutalism-promo-dismiss',
            styles: dom.Styles(
              raw: <String, String>{
                'flex-shrink': '0',
                'margin-left': '0.5rem',
                'padding': '0.25rem 0.5rem',
                'background': 'transparent',
                'border':
                    'var(--nb-border-thin, 2px) solid transparent',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'color': foregroundColor,
                'cursor': 'pointer',
                'font-weight': '900',
                'font-size': '1rem',
                'line-height': '1',
              },
            ),
            events: <String, EventCallback>{
              'click': (dynamic _) => _dismiss(),
            },
            <Component>[const Component.text('\u2715')],
          ),
      ],
    );
  }
}
