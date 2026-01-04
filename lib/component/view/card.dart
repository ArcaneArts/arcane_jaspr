import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/appearance/colors.dart';
import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';
import '../../util/tokens/common_styles.dart';

/// A card component with consistent styling.
///
/// Use style presets for cleaner code:
/// ```dart
/// // Using child:
/// ArcaneCard(
///   style: CardStyle.elevated,
///   child: Text('Content'),
/// )
///
/// // Using children: for multiple elements
/// ArcaneCard(
///   style: CardStyle.elevated,
///   children: [
///     ArcaneHeading.h3(text: 'Title'),
///     Text('Content'),
///   ],
/// )
///
/// // Using onClick (alias for onTap):
/// ArcaneCard(
///   child: Text('Clickable'),
///   onClick: () => print('clicked'),
/// )
/// ```
class ArcaneCard extends StatelessComponent {
  /// The child component (single)
  final Component? _child;

  /// The children components - convenience parameter
  final List<Component>? _children;

  /// Style preset (preferred)
  final CardStyle? style;

  /// Custom padding (overrides style)
  final EdgeInsets? padding;

  /// Border radius (overrides style)
  final double? radius;

  /// Whether to show a border (legacy, use CardStyle instead)
  final bool border;

  /// Elevation level (legacy, use CardStyle instead)
  final int elevation;

  /// Click handler
  final void Function()? _onTap;

  /// Custom background color (overrides style)
  final Color? color;

  /// Whether to fill width
  final bool fillWidth;

  /// Creates a card.
  ///
  /// Provide either [child] or [children].
  /// Use [onTap] or [onClick] for click handling.
  const ArcaneCard({
    Component? child,
    List<Component>? children,
    this.style,
    this.padding,
    this.radius,
    this.border = true,
    this.elevation = 0,
    void Function()? onTap,
    void Function()? onClick,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Elevated card with shadow
  const ArcaneCard.elevated({
    Component? child,
    List<Component>? children,
    this.padding,
    this.radius,
    void Function()? onTap,
    void Function()? onClick,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        style = CardStyle.elevated,
        border = true,
        elevation = 2,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Flat card without shadow
  const ArcaneCard.flat({
    Component? child,
    List<Component>? children,
    this.padding,
    this.radius,
    void Function()? onTap,
    void Function()? onClick,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        style = CardStyle.flat,
        border = true,
        elevation = 0,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Outlined card (border only)
  const ArcaneCard.outlined({
    Component? child,
    List<Component>? children,
    this.padding,
    this.radius,
    void Function()? onTap,
    void Function()? onClick,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        style = CardStyle.outlined,
        border = true,
        elevation = 0,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Ghost card (no border, no background)
  const ArcaneCard.ghost({
    Component? child,
    List<Component>? children,
    this.padding,
    this.radius,
    void Function()? onTap,
    void Function()? onClick,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        style = CardStyle.ghost,
        border = false,
        elevation = 0,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Glass/frosted card
  const ArcaneCard.glass({
    Component? child,
    List<Component>? children,
    this.padding,
    this.radius,
    void Function()? onTap,
    void Function()? onClick,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        style = CardStyle.glass,
        border = true,
        elevation = 0,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Interactive card (shows hover effect)
  const ArcaneCard.interactive({
    Component? child,
    List<Component>? children,
    this.padding,
    this.radius,
    void Function()? onTap,
    void Function()? onClick,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        style = CardStyle.interactive,
        border = true,
        elevation = 0,
        assert(child != null || children != null,
            'Either child or children must be provided');

  @override
  Component build(BuildContext context) {
    // Resolve content: children takes precedence over child
    final content = _children ?? [_child!];

    // Build card styles
    final Map<String, String> cardStyles = {
      // Start with style preset if provided
      if (style != null) ...style!.styles,

      // Or use legacy elevation-based approach
      if (style == null) ...{
        'background-color': color?.css ?? ArcaneColors.card,
        'color': ArcaneColors.cardForeground,
        'border-radius': radius != null ? '${radius}px' : ArcaneRadius.lg,
        if (border) 'border': '1px solid ${ArcaneColors.border}',
        'box-shadow': switch (elevation) {
          0 => ArcaneEffects.shadowNone,
          1 => ArcaneEffects.shadowSm,
          2 => ArcaneEffects.shadowMd,
          3 => ArcaneEffects.shadowLg,
          _ => ArcaneEffects.shadowXl,
        },
        'transition': ArcaneEffects.transitionNormal,
      },

      // Overrides
      if (color != null) 'background-color': color!.css,
      if (radius != null) 'border-radius': '${radius}px',
      if (padding != null) 'padding': padding!.padding,
      if (padding == null) 'padding': ArcaneSpacing.lg,
      if (fillWidth) 'width': '100%',
      if (_onTap != null) 'cursor': 'pointer',
    };

    if (_onTap != null) {
      return button(
        classes: 'arcane-card clickable',
        attributes: {'type': 'button'},
        styles: Styles(raw: cardStyles),
        events: {
          'click': (event) => _onTap!(),
        },
        content,
      );
    } else {
      return div(
        classes: 'arcane-card',
        styles: Styles(raw: cardStyles),
        content,
      );
    }
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-card.clickable:hover').styles(raw: {
      'border-color': ArcaneColors.outline,
      'transform': ArcaneEffects.hoverLift,
    }),
    css('.arcane-card.clickable:active').styles(raw: {
      'transform': 'translateY(0)',
    }),
  ];
}

/// A card with header, body, and footer sections
class ArcaneStructuredCard extends StatelessComponent {
  final Component? header;
  final Component body;
  final Component? footer;
  final CardStyle? style;
  final EdgeInsets? padding;
  final double? radius;
  final bool border;
  final int elevation;
  final void Function()? _onTap;

  /// Creates a structured card.
  ///
  /// Use [onTap] or [onClick] for click handling.
  const ArcaneStructuredCard({
    this.header,
    required this.body,
    this.footer,
    this.style,
    this.padding,
    this.radius,
    this.border = true,
    this.elevation = 0,
    void Function()? onTap,
    void Function()? onClick,
    super.key,
  }) : _onTap = onTap ?? onClick;

  @override
  Component build(BuildContext context) {
    // Generate shadow based on elevation
    final boxShadow = switch (elevation) {
      0 => ArcaneEffects.shadowNone,
      1 => ArcaneEffects.shadowSm,
      2 => ArcaneEffects.shadowMd,
      3 => ArcaneEffects.shadowLg,
      _ => ArcaneEffects.shadowXl,
    };

    return div(
      classes: 'arcane-structured-card',
      styles: Styles(raw: {
        // Start with style preset or defaults
        if (style != null) ...style!.styles else ...{
          'background-color': ArcaneColors.surface,
          'border-radius': radius != null ? '${radius}px' : ArcaneRadius.lg,
          if (border) 'border': '1px solid ${ArcaneColors.outlineVariant}',
          'box-shadow': boxShadow,
        },
        'overflow': 'hidden',
        if (_onTap != null) 'cursor': 'pointer',
        if (_onTap != null) 'transition': ArcaneEffects.transitionFast,
      }),
      events: _onTap != null
          ? {
              'click': (event) => _onTap!(),
            }
          : null,
      [
        if (header != null)
          div(
            classes: 'arcane-structured-card-header',
            styles: const Styles(raw: {
              'padding': ArcaneSpacing.md,
              'border-bottom': '1px solid ${ArcaneColors.outlineVariant}',
            }),
            [header!],
          ),
        div(
          classes: 'arcane-structured-card-body',
          styles: Styles(raw: {
            'padding': (padding ?? const EdgeInsets.all(16)).padding,
          }),
          [body],
        ),
        if (footer != null)
          div(
            classes: 'arcane-structured-card-footer',
            styles: const Styles(raw: {
              'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
              'border-top': '1px solid ${ArcaneColors.outlineVariant}',
              'background-color': ArcaneColors.surfaceVariant,
            }),
            [footer!],
          ),
      ],
    );
  }
}

/// An image card with overlay text
class ArcaneImageCard extends StatelessComponent {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final Component? overlay;
  final double? height;
  final double? radius;
  final void Function()? _onTap;
  final BoxFit fit;

  /// Creates an image card.
  ///
  /// Use [onTap] or [onClick] for click handling.
  const ArcaneImageCard({
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.overlay,
    this.height,
    this.radius,
    void Function()? onTap,
    void Function()? onClick,
    this.fit = BoxFit.cover,
    super.key,
  }) : _onTap = onTap ?? onClick;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-image-card ${_onTap != null ? 'clickable' : ''}',
      styles: Styles(raw: {
        'position': 'relative',
        'border-radius': radius != null ? '${radius}px' : ArcaneRadius.lg,
        'overflow': 'hidden',
        if (height != null) 'height': '${height}px',
        if (_onTap != null) 'cursor': 'pointer',
      }),
      events: _onTap != null
          ? {
              'click': (event) => _onTap!(),
            }
          : null,
      [
        // Image
        img(
          src: imageUrl,
          alt: title ?? '',
          styles: Styles(raw: {
            ...ArcaneCommonStyles.imageCover,
            'object-fit': fit.css,
          }),
        ),

        // Overlay gradient
        if (title != null || subtitle != null || overlay != null)
          div(
            classes: 'arcane-image-card-overlay',
            styles: const Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'left': '0',
              'right': '0',
              'padding': ArcaneSpacing.md,
              'background':
                  'linear-gradient(to top, rgba(${ArcaneColors.backgroundRgb}, 0.7), transparent)',
              'color': ArcaneColors.onBackground,
            }),
            [
              if (title != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontReg,
                    'font-weight': ArcaneTypography.weightSemibold,
                  }),
                  [text(title!)],
                ),
              if (subtitle != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
                    'opacity': '0.9',
                    'margin-top': ArcaneSpacing.xs,
                  }),
                  [text(subtitle!)],
                ),
              if (overlay != null) overlay!,
            ],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-image-card.clickable:hover').styles(raw: {
      'transform': ArcaneEffects.hoverScale,
      'transition': 'transform 200ms ease',
    }),
  ];
}
