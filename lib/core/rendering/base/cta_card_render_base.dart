import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/cta_card_props.dart';
import 'package:arcane_jaspr/core/rendering/base/style_layering.dart';

/// Shared structural base for themed CTA-card renderers.
///
/// A CTA (call-to-action) card is a dashed-border, centered surface: an
/// optional icon in an accent circle, a bold title, a muted description, and a
/// prominent call-to-action control (an `<a>` when [CTACardProps.href] is set,
/// otherwise a `<button>` wired to [CTACardProps.onTap]). The DOM and its inline
/// chrome (built from theme CSS variables, so it adapts to the active palette)
/// are identical across themes; a concrete theme renderer supplies only the
/// root [cssClass] and may override [decorationStyles].
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class CtaCardRenderBase extends StatelessComponent {
  const CtaCardRenderBase(this.props, {super.key});

  final CTACardProps props;

  /// Root CSS class (e.g. `'arcane-cta-card'`).
  String get cssClass;

  /// Per-instance decoration overrides. Default: none.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final Map<String, String> rootStyles = layerStyles(
      <String, String>{
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '1rem',
        'padding': '2rem',
        'text-align': 'center',
        'background-color': 'var(--card)',
        'color': 'var(--card-foreground)',
        'border': '1px dashed var(--border)',
        'border-radius': 'var(--radius, 0.5rem)',
        'width': '100%',
        'min-height': props.height,
        'box-sizing': 'border-box',
        if (props.showHoverEffects)
          'transition': 'transform 0.2s ease, box-shadow 0.2s ease',
        if (props.animationDelayMs != null) 'opacity': '0',
        if (props.animationDelayMs != null)
          'animation': 'arcane-fade-in 0.4s ease ${props.animationDelayMs}ms both',
      },
      <Map<String, String>?>[
        props.decoration?.universalStyles(),
        decorationStyles(props.decoration),
        props.styles?.toMap(),
      ],
    );

    return dom.div(
      classes: cssClass,
      styles: dom.Styles(raw: rootStyles),
      <Component>[
        if (props.icon != null)
          dom.div(
            classes: '$cssClass-icon',
            styles: const dom.Styles(
              raw: <String, String>{
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '3.5rem',
                'height': '3.5rem',
                'border-radius': '9999px',
                'background-color':
                    'color-mix(in srgb, var(--primary) 12%, transparent)',
                'color': 'var(--primary)',
                'font-size': '1.5rem',
              },
            ),
            <Component>[props.icon!],
          ),
        dom.h3(
          styles: const dom.Styles(
            raw: <String, String>{
              'margin': '0',
              'font-size': '1.25rem',
              'font-weight': '700',
              'line-height': '1.2',
              'color': 'var(--foreground)',
            },
          ),
          <Component>[Component.text(props.title)],
        ),
        if (props.description != null)
          dom.p(
            styles: const dom.Styles(
              raw: <String, String>{
                'margin': '0',
                'font-size': '0.9rem',
                'line-height': '1.5',
                'max-width': '32ch',
                'color': 'var(--muted-foreground)',
              },
            ),
            <Component>[Component.text(props.description!)],
          ),
        _ctaControl(),
      ],
    );
  }

  /// The call-to-action control: an anchor when [CTACardProps.href] is set,
  /// otherwise a button wired to [CTACardProps.onTap].
  Component _ctaControl() {
    final Map<String, String> ctaStyles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': '0.5rem',
      'margin-top': '0.5rem',
      'padding': '0.6rem 1.25rem',
      'font-size': '0.9rem',
      'font-weight': '600',
      'line-height': '1',
      'border': 'none',
      'border-radius': 'var(--radius, 0.5rem)',
      'background-color': 'var(--primary)',
      'color': 'var(--primary-foreground)',
      'cursor': 'pointer',
      'text-decoration': 'none',
      if (props.showHoverEffects) 'transition': 'opacity 0.2s ease',
    };

    if (props.href != null) {
      return dom.a(
        classes: '$cssClass-button',
        href: props.href!,
        styles: dom.Styles(raw: ctaStyles),
        <Component>[Component.text(props.ctaText)],
      );
    }

    return dom.button(
      classes: '$cssClass-button',
      attributes: const <String, String>{'type': 'button'},
      styles: dom.Styles(raw: ctaStyles),
      events: <String, EventCallback>{
        'click': (_) => props.onTap?.call(),
      },
      <Component>[Component.text(props.ctaText)],
    );
  }
}
