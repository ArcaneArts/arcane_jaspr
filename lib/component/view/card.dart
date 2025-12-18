import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// A card component with consistent styling.
class ArcaneCard extends StatelessComponent {
  /// The child component
  final Component child;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Whether to show a border
  final bool border;

  /// Elevation level (0-5)
  final int elevation;

  /// Click handler
  final void Function()? onTap;

  /// Custom background color
  final Color? color;

  /// Whether to fill width
  final bool fillWidth;

  const ArcaneCard({
    required this.child,
    this.padding,
    this.radius,
    this.border = true,
    this.elevation = 0,
    this.onTap,
    this.color,
    this.fillWidth = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final effectiveRadius = radius ?? theme.borderRadiusPx;
    final effectivePadding = padding ?? const EdgeInsets.all(16);

    // Generate shadow based on elevation (Supabase-style)
    final boxShadow = switch (elevation) {
      0 => 'var(--arcane-shadow-sm)',
      1 => 'var(--arcane-shadow-sm)',
      2 => 'var(--arcane-shadow)',
      3 => 'var(--arcane-shadow)',
      4 => 'var(--arcane-shadow-lg)',
      _ => 'var(--arcane-shadow-xl)',
    };

    final cardStyles = <String, String>{
      'background-color': color?.css ?? 'var(--arcane-card)',
      'color': 'var(--arcane-card-foreground)',
      'border-radius': '${effectiveRadius}px',
      'padding': effectivePadding.padding,
      if (border) 'border': '1px solid var(--arcane-border)',
      'box-shadow': elevation > 0 ? boxShadow : 'none',
      if (fillWidth) 'width': '100%',
      if (onTap != null) 'cursor': 'pointer',
      'transition': 'var(--arcane-transition)',
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
      'border-color': 'var(--arcane-outline)',
      'transform': 'translateY(-2px)',
    }),
    css('.arcane-card.clickable:active').styles(raw: {
      'transform': 'translateY(0)',
    }),
  ];
}

/// A card with header, body, and footer sections
class StructuredCard extends StatelessComponent {
  final Component? header;
  final Component body;
  final Component? footer;
  final EdgeInsets? padding;
  final double? radius;
  final bool border;
  final int elevation;
  final void Function()? onTap;

  const StructuredCard({
    this.header,
    required this.body,
    this.footer,
    this.padding,
    this.radius,
    this.border = true,
    this.elevation = 0,
    this.onTap,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final effectiveRadius = radius ?? theme.borderRadiusPx;

    // Generate shadow based on elevation
    final boxShadow = switch (elevation) {
      0 => 'none',
      1 => '0 1px 2px rgba(0, 0, 0, 0.05)',
      2 => '0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06)',
      3 =>
        '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
      _ =>
        '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
    };

    return div(
      classes: 'arcane-structured-card',
      styles: Styles(raw: {
        'background-color': 'var(--arcane-surface)',
        'border-radius': '${effectiveRadius}px',
        if (border) 'border': '1px solid var(--arcane-outline-variant)',
        'box-shadow': boxShadow,
        'overflow': 'hidden',
        if (onTap != null) 'cursor': 'pointer',
        if (onTap != null) 'transition': 'all 150ms ease',
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
            styles: Styles(raw: {
              'padding': '16px',
              'border-bottom': '1px solid var(--arcane-outline-variant)',
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
            styles: Styles(raw: {
              'padding': '12px 16px',
              'border-top': '1px solid var(--arcane-outline-variant)',
              'background-color': 'var(--arcane-surface-variant)',
            }),
            [footer!],
          ),
      ],
    );
  }
}

/// An image card with overlay text
class ImageCard extends StatelessComponent {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final Component? overlay;
  final double? height;
  final double? radius;
  final void Function()? onTap;
  final BoxFit fit;

  const ImageCard({
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
    final theme = ArcaneTheme.of(context);
    final effectiveRadius = radius ?? theme.borderRadiusPx;

    return div(
      classes: 'arcane-image-card ${onTap != null ? 'clickable' : ''}',
      styles: Styles(raw: {
        'position': 'relative',
        'border-radius': '${effectiveRadius}px',
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
            'width': '100%',
            'height': '100%',
            'object-fit': fit.css,
          }),
        ),

        // Overlay gradient
        if (title != null || subtitle != null || overlay != null)
          div(
            classes: 'arcane-image-card-overlay',
            styles: Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'left': '0',
              'right': '0',
              'padding': '16px',
              'background': 'linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent)',
              'color': 'white',
            }),
            [
              if (title != null)
                div(
                  styles: Styles(raw: {
                    'font-size': '1rem',
                    'font-weight': '600',
                  }),
                  [text(title!)],
                ),
              if (subtitle != null)
                div(
                  styles: Styles(raw: {
                    'font-size': '0.875rem',
                    'opacity': '0.9',
                    'margin-top': '4px',
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
      'transform': 'scale(1.02)',
      'transition': 'transform 200ms ease',
    }),
  ];
}
