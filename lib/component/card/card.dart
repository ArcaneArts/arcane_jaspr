import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart'
    hide
        BuildContext,
        InheritedComponent,
        Key,
        State,
        StatefulComponent,
        StatelessComponent,
        UniqueKey,
        ValueKey,
        runApp;
import 'package:jaspr/dom.dart' as dom;

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/arcane.dart';
import '../../util/style_types/arcane_style_data.dart';

/// Card component with consistent styling and multiple variants.
///
/// The root is a native `<a>` when [href] is provided, a native `<button>`
/// when [onTap] is provided, and a `<div>` otherwise. [href] and [onTap] are
/// mutually exclusive so navigation and callback semantics cannot conflict.
class Card extends StatelessWidget {
  final Widget? _child;
  final List<Widget>? _children;
  final CardVariant variant;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final void Function()? _onTap;

  /// Navigation destination. When set, the whole card is a native anchor.
  final String? href;

  /// Optional anchor browsing context, such as `_blank`.
  ///
  /// When this is `_blank`, the renderer adds any missing `noopener` and
  /// `noreferrer` tokens to [rel].
  final String? target;

  /// Optional anchor relationship tokens.
  final String? rel;

  /// Additional CSS classes appended after the theme's card classes.
  final String? classes;

  /// Additional root attributes. Structural attributes owned by Card, such as
  /// `href`, `target`, `rel`, `type`, `class`, and `style`, cannot be
  /// overridden here.
  final Map<String, String>? attributes;

  /// Accessible name for the card's root element. This is most useful when its
  /// visible descendants do not already provide a meaningful name.
  final String? ariaLabel;

  final String? backgroundColor;
  final bool fillWidth;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const Card({
    Widget? child,
    List<Widget>? children,
    this.variant = CardVariant.elevated,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    this.href,
    this.target,
    this.rel,
    this.classes,
    this.attributes,
    this.ariaLabel,
    this.backgroundColor,
    this.fillWidth = false,
    this.styles,
    this.decoration,
    super.key,
  }) : _child = child,
       _children = children,
       _onTap = onTap,
       assert(
         child != null || children != null,
         'Either child or children must be provided',
       ),
       assert(
         href == null || onTap == null,
         'Card href and onTap are mutually exclusive',
       );

  const Card.elevated({
    Widget? child,
    List<Widget>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    this.href,
    this.target,
    this.rel,
    this.classes,
    this.attributes,
    this.ariaLabel,
    this.backgroundColor,
    this.fillWidth = false,
    this.styles,
    this.decoration,
    super.key,
  }) : _child = child,
       _children = children,
       _onTap = onTap,
       variant = CardVariant.elevated,
       assert(
         child != null || children != null,
         'Either child or children must be provided',
       ),
       assert(
         href == null || onTap == null,
         'Card href and onTap are mutually exclusive',
       );

  const Card.flat({
    Widget? child,
    List<Widget>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    this.href,
    this.target,
    this.rel,
    this.classes,
    this.attributes,
    this.ariaLabel,
    this.backgroundColor,
    this.fillWidth = false,
    this.styles,
    this.decoration,
    super.key,
  }) : _child = child,
       _children = children,
       _onTap = onTap,
       variant = CardVariant.flat,
       assert(
         child != null || children != null,
         'Either child or children must be provided',
       ),
       assert(
         href == null || onTap == null,
         'Card href and onTap are mutually exclusive',
       );

  const Card.outlined({
    Widget? child,
    List<Widget>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    this.href,
    this.target,
    this.rel,
    this.classes,
    this.attributes,
    this.ariaLabel,
    this.backgroundColor,
    this.fillWidth = false,
    this.styles,
    this.decoration,
    super.key,
  }) : _child = child,
       _children = children,
       _onTap = onTap,
       variant = CardVariant.outlined,
       assert(
         child != null || children != null,
         'Either child or children must be provided',
       ),
       assert(
         href == null || onTap == null,
         'Card href and onTap are mutually exclusive',
       );

  const Card.ghost({
    Widget? child,
    List<Widget>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    this.href,
    this.target,
    this.rel,
    this.classes,
    this.attributes,
    this.ariaLabel,
    this.backgroundColor,
    this.fillWidth = false,
    this.styles,
    this.decoration,
    super.key,
  }) : _child = child,
       _children = children,
       _onTap = onTap,
       variant = CardVariant.ghost,
       assert(
         child != null || children != null,
         'Either child or children must be provided',
       ),
       assert(
         href == null || onTap == null,
         'Card href and onTap are mutually exclusive',
       );

  const Card.glass({
    Widget? child,
    List<Widget>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    this.href,
    this.target,
    this.rel,
    this.classes,
    this.attributes,
    this.ariaLabel,
    this.backgroundColor,
    this.fillWidth = false,
    this.styles,
    this.decoration,
    super.key,
  }) : _child = child,
       _children = children,
       _onTap = onTap,
       variant = CardVariant.glass,
       assert(
         child != null || children != null,
         'Either child or children must be provided',
       ),
       assert(
         href == null || onTap == null,
         'Card href and onTap are mutually exclusive',
       );

  const Card.interactive({
    Widget? child,
    List<Widget>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    this.href,
    this.target,
    this.rel,
    this.classes,
    this.attributes,
    this.ariaLabel,
    this.backgroundColor,
    this.fillWidth = false,
    this.styles,
    this.decoration,
    super.key,
  }) : _child = child,
       _children = children,
       _onTap = onTap,
       variant = CardVariant.interactive,
       assert(
         child != null || children != null,
         'Either child or children must be provided',
       ),
       assert(
         href == null || onTap == null,
         'Card href and onTap are mutually exclusive',
       );

  @override
  Widget build(BuildContext context) {
    return context.renderers.card(
      CardProps(
        child: _child,
        children: _children,
        variant: variant,
        padding: padding,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        fillWidth: fillWidth,
        onTap: _onTap,
        href: href,
        target: target,
        rel: rel,
        classes: classes,
        attributes: attributes,
        ariaLabel: ariaLabel,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}

/// Card with header, body, and footer sections.
class ArcaneStructuredCard extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? footer;
  final EdgeInsets? padding;
  final double? radius;
  final bool border;
  final int elevation;
  final void Function()? _onTap;

  const ArcaneStructuredCard({
    this.header,
    required this.body,
    this.footer,
    this.padding,
    this.radius,
    this.border = true,
    this.elevation = 0,
    void Function()? onTap,
    super.key,
  }) : _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    final boxShadow = switch (elevation) {
      0 => 'none',
      1 => '0 1px 2px 0 rgb(0 0 0 / 0.05)',
      2 => '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
      3 => '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
      _ => '0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)',
    };

    return dom.div(
      classes: 'arcane-structured-card',
      styles: dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border-radius': radius != null ? '${radius}px' : '0.75rem',
        if (border) 'border': '1px solid var(--border)',
        'box-shadow': boxShadow,
        'overflow': 'hidden',
        if (_onTap != null) 'cursor': 'pointer',
        if (_onTap != null) 'transition': 'all 150ms ease',
      }),
      events: _onTap != null
          ? {
              'click': (event) => _onTap(),
            }
          : null,
      [
        if (header != null)
          dom.div(
            classes: 'arcane-structured-card-header',
            styles: const dom.Styles(raw: {
              'padding': '1rem',
              'border-bottom': '1px solid var(--border)',
            }),
            [header!],
          ),
        dom.div(
          classes: 'arcane-structured-card-body',
          styles: dom.Styles(raw: {
            'padding': (padding ?? const EdgeInsets.all(16)).padding,
          }),
          [body],
        ),
        if (footer != null)
          dom.div(
            classes: 'arcane-structured-card-footer',
            styles: const dom.Styles(raw: {
              'padding': '0.5rem 1rem',
              'border-top': '1px solid var(--border)',
              'background-color': 'var(--muted)',
            }),
            [footer!],
          ),
      ],
    );
  }
}

/// Image card with overlay text.
class ArcaneImageCard extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final Widget? overlay;
  final double? height;
  final double? radius;
  final void Function()? _onTap;
  final BoxFit fit;

  const ArcaneImageCard({
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.overlay,
    this.height,
    this.radius,
    void Function()? onTap,
    this.fit = BoxFit.cover,
    super.key,
  }) : _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return dom.div(
      classes: 'arcane-image-card ${_onTap != null ? 'clickable' : ''}',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'border-radius': radius != null ? '${radius}px' : '0.75rem',
        'overflow': 'hidden',
        if (height != null) 'height': '${height}px',
        if (_onTap != null) 'cursor': 'pointer',
      }),
      events: _onTap != null
          ? {
              'click': (event) => _onTap(),
            }
          : null,
      [
        dom.img(
          src: imageUrl,
          alt: title ?? '',
          styles: dom.Styles(raw: {
            'width': '100%',
            'height': '100%',
            'object-fit': fit.css,
          }),
        ),

        if (title != null || subtitle != null || overlay != null)
          dom.div(
            classes: 'arcane-image-card-overlay',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'left': '0',
              'right': '0',
              'padding': '1rem',
              'background':
                  'linear-gradient(to top, color-mix(in srgb, var(--background) 80%, transparent), transparent)',
              'color': 'var(--foreground)',
            }),
            [
              if (title != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '1rem',
                    'font-weight': '600',
                  }),
                  [Component.text(title!)],
                ),
              if (subtitle != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem',
                    'opacity': '0.9',
                    'margin-top': '0.25rem',
                  }),
                  [Component.text(subtitle!)],
                ),
              ?overlay,
            ],
          ),
      ],
    );
  }
}
