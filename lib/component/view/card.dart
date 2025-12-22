import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/colors.dart';
import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';
import '../../util/tokens/common_styles.dart';

/// A card component with consistent styling.
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneCard(
///   style: CardStyle.elevated,
///   child: Text('Content'),
/// )
/// ```
class ArcaneCard extends StatelessComponent {
  /// The child component
  final Component child;

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
  final void Function()? onTap;

  /// Custom background color (overrides style)
  final Color? color;

  /// Whether to fill width
  final bool fillWidth;

  const ArcaneCard({
    required this.child,
    this.style,
    this.padding,
    this.radius,
    this.border = true,
    this.elevation = 0,
    this.onTap,
    this.color,
    this.fillWidth = false,
    super.key,
  });

  /// Elevated card with shadow
  const ArcaneCard.elevated({
    required this.child,
    this.padding,
    this.radius,
    this.onTap,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : style = CardStyle.elevated,
        border = true,
        elevation = 2;

  /// Flat card without shadow
  const ArcaneCard.flat({
    required this.child,
    this.padding,
    this.radius,
    this.onTap,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : style = CardStyle.flat,
        border = true,
        elevation = 0;

  /// Outlined card (border only)
  const ArcaneCard.outlined({
    required this.child,
    this.padding,
    this.radius,
    this.onTap,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : style = CardStyle.outlined,
        border = true,
        elevation = 0;

  /// Ghost card (no border, no background)
  const ArcaneCard.ghost({
    required this.child,
    this.padding,
    this.radius,
    this.onTap,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : style = CardStyle.ghost,
        border = false,
        elevation = 0;

  /// Glass/frosted card
  const ArcaneCard.glass({
    required this.child,
    this.padding,
    this.radius,
    this.onTap,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : style = CardStyle.glass,
        border = true,
        elevation = 0;

  /// Interactive card (shows hover effect)
  const ArcaneCard.interactive({
    required this.child,
    this.padding,
    this.radius,
    this.onTap,
    this.color,
    this.fillWidth = false,
    super.key,
  })  : style = CardStyle.interactive,
        border = true,
        elevation = 0;

  @override
  Component build(BuildContext context) {
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
      if (onTap != null) 'cursor': 'pointer',
    };

    if (onTap != null) {
      return button(
        classes: 'arcane-card clickable',
        attributes: {'type': 'button'},
        styles: Styles(raw: cardStyles),
        events: {
          'click': (event) => onTap!(),
        },
        [child],
      );
    } else {
      return div(
        classes: 'arcane-card',
        styles: Styles(raw: cardStyles),
        [child],
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
  final void Function()? onTap;

  const ArcaneStructuredCard({
    this.header,
    required this.body,
    this.footer,
    this.style,
    this.padding,
    this.radius,
    this.border = true,
    this.elevation = 0,
    this.onTap,
    super.key,
  });

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
        if (onTap != null) 'cursor': 'pointer',
        if (onTap != null) 'transition': ArcaneEffects.transitionFast,
      }),
      events: onTap != null
          ? {
              'click': (event) => onTap!(),
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
  final void Function()? onTap;
  final BoxFit fit;

  const ArcaneImageCard({
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.overlay,
    this.height,
    this.radius,
    this.onTap,
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-image-card ${onTap != null ? 'clickable' : ''}',
      styles: Styles(raw: {
        'position': 'relative',
        'border-radius': radius != null ? '${radius}px' : ArcaneRadius.lg,
        'overflow': 'hidden',
        if (height != null) 'height': '${height}px',
        if (onTap != null) 'cursor': 'pointer',
      }),
      events: onTap != null
          ? {
              'click': (event) => onTap!(),
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
              'background': 'linear-gradient(to top, rgba(${ArcaneColors.backgroundRgb}, 0.7), transparent)',
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
