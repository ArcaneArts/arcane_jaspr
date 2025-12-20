import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';

/// A list tile component for displaying items in a list.
class Tile extends StatelessComponent {
  /// Title text
  final String? title;

  /// Title component (overrides title string)
  final Component? titleWidget;

  /// Subtitle text
  final String? subtitle;

  /// Subtitle component (overrides subtitle string)
  final Component? subtitleWidget;

  /// Leading component (usually an icon or avatar)
  final Component? leading;

  /// Trailing component (usually an action button or info)
  final Component? trailing;

  /// Click handler
  final void Function()? onTap;

  /// Whether the tile is selected
  final bool selected;

  /// Whether the tile is disabled
  final bool disabled;

  /// Custom padding
  final EdgeInsets? padding;

  /// Whether to use dense layout
  final bool dense;

  const Tile({
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    this.padding,
    this.dense = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: 16,
          vertical: dense ? 8 : 12,
        );

    return div(
      classes:
          'arcane-tile ${selected ? 'selected' : ''} ${disabled ? 'disabled' : ''} ${onTap != null ? 'clickable' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': effectivePadding.padding,
        'background-color':
            selected ? ArcaneColors.accentContainer : ArcaneColors.transparent,
        'cursor': disabled
            ? 'not-allowed'
            : (onTap != null ? 'pointer' : 'default'),
        'opacity': disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'border-radius': ArcaneRadius.md,
      }),
      events: onTap != null && !disabled
          ? {
              'click': (event) => onTap!(),
            }
          : null,
      [
        // Leading
        if (leading != null)
          div(
            classes: 'arcane-tile-leading',
            styles: Styles(raw: {
              'flex-shrink': '0',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': selected ? ArcaneColors.accent : ArcaneColors.muted,
            }),
            [leading!],
          ),

        // Content
        div(
          classes: 'arcane-tile-content',
          styles: Styles(raw: {
            'flex': '1',
            'min-width': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': dense ? '2px' : ArcaneSpacing.xs,
          }),
          [
            // Title
            if (titleWidget != null)
              titleWidget!
            else if (title != null)
              span(
                classes: 'arcane-tile-title',
                styles: Styles(raw: {
                  'font-size': dense ? ArcaneTypography.fontSm : ArcaneTypography.fontMd,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': selected ? ArcaneColors.accent : ArcaneColors.onSurface,
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [text(title!)],
              ),

            // Subtitle
            if (subtitleWidget != null)
              subtitleWidget!
            else if (subtitle != null)
              span(
                classes: 'arcane-tile-subtitle',
                styles: Styles(raw: {
                  'font-size': dense ? ArcaneTypography.fontXs : ArcaneTypography.fontSm,
                  'color': selected ? ArcaneColors.accent : ArcaneColors.muted,
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [text(subtitle!)],
              ),
          ],
        ),

        // Trailing
        if (trailing != null)
          div(
            classes: 'arcane-tile-trailing',
            styles: Styles(raw: {
              'flex-shrink': '0',
              'display': 'flex',
              'align-items': 'center',
              'color': selected ? ArcaneColors.accent : ArcaneColors.muted,
            }),
            [trailing!],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-tile.clickable:hover:not(.disabled)').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-tile.clickable.selected:hover:not(.disabled)').styles(raw: {
      'background-color': ArcaneColors.accentContainer,
    }),
  ];
}

/// A navigation tile for sidebar or list navigation
class NavTile extends StatelessComponent {
  final String label;
  final Component? icon;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;
  final String? badge;

  const NavTile({
    required this.label,
    this.icon,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    this.badge,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes:
          'arcane-nav-tile ${selected ? 'selected' : ''} ${disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (disabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'width': '100%',
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'background-color':
            selected ? ArcaneColors.accentContainer : ArcaneColors.transparent,
        'color': selected ? ArcaneColors.accent : ArcaneColors.onSurface,
        'border-radius': ArcaneRadius.md,
        'border': 'none',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'text-align': 'left',
        'font-size': ArcaneTypography.fontMd,
        'font-weight': selected
            ? ArcaneTypography.weightSemibold
            : ArcaneTypography.weightMedium,
      }),
      events: {
        'click': (event) {
          if (!disabled && onTap != null) {
            onTap!();
          }
        },
      },
      [
        if (icon != null)
          div(
            styles: const Styles(raw: {
              'flex-shrink': '0',
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            }),
            [icon!],
          ),
        span(
          styles: const Styles(raw: {
            'flex': '1',
            'overflow': 'hidden',
            'text-overflow': 'ellipsis',
            'white-space': 'nowrap',
          }),
          [text(label)],
        ),
        if (badge != null)
          span(
            classes: 'arcane-nav-tile-badge',
            styles: const Styles(raw: {
              'background-color': ArcaneColors.accent,
              'color': ArcaneColors.accentForeground,
              'font-size': ArcaneTypography.fontXs,
              'padding': '2px 6px',
              'border-radius': ArcaneRadius.full,
              'font-weight': ArcaneTypography.weightMedium,
            }),
            [text(badge!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-nav-tile:hover:not(:disabled):not(.selected)').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}