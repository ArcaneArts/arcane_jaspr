import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

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
    final theme = ArcaneTheme.of(context);
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: 16,
          vertical: dense ? 8 : 12,
        );

    return div(
      classes: 'arcane-tile ${selected ? 'selected' : ''} ${disabled ? 'disabled' : ''} ${onTap != null ? 'clickable' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '12px',
        'padding': effectivePadding.padding,
        'background-color': selected
            ? 'var(--arcane-primary-container)'
            : 'transparent',
        'cursor': disabled
            ? 'not-allowed'
            : (onTap != null ? 'pointer' : 'default'),
        'opacity': disabled ? '0.5' : '1',
        'transition': 'background-color 150ms ease',
        'border-radius': '${theme.borderRadiusPx * 0.5}px',
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
              'color': selected
                  ? 'var(--arcane-on-primary-container)'
                  : 'var(--arcane-on-surface-variant)',
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
            'gap': dense ? '2px' : '4px',
          }),
          [
            // Title
            if (titleWidget != null)
              titleWidget!
            else if (title != null)
              span(
                classes: 'arcane-tile-title',
                styles: Styles(raw: {
                  'font-size': dense ? '0.875rem' : '0.9375rem',
                  'font-weight': '500',
                  'color': selected
                      ? 'var(--arcane-on-primary-container)'
                      : 'var(--arcane-on-surface)',
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
                  'font-size': dense ? '0.75rem' : '0.8125rem',
                  'color': selected
                      ? 'var(--arcane-on-primary-container)'
                      : 'var(--arcane-on-surface-variant)',
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
              'color': selected
                  ? 'var(--arcane-on-primary-container)'
                  : 'var(--arcane-on-surface-variant)',
            }),
            [trailing!],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-tile.clickable:hover:not(.disabled)').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
    css('.arcane-tile.clickable.selected:hover:not(.disabled)').styles(raw: {
      'background-color': 'var(--arcane-primary-container)',
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
    final theme = ArcaneTheme.of(context);

    return button(
      classes: 'arcane-nav-tile ${selected ? 'selected' : ''} ${disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (disabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '12px',
        'width': '100%',
        'padding': '10px 12px',
        'background-color': selected
            ? 'var(--arcane-primary-container)'
            : 'transparent',
        'color': selected
            ? 'var(--arcane-on-primary-container)'
            : 'var(--arcane-on-surface)',
        'border-radius': '${theme.borderRadiusPx}px',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'text-align': 'left',
        'font-size': '0.875rem',
        'font-weight': selected ? '600' : '500',
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
            styles: Styles(raw: {
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
          styles: Styles(raw: {
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
            styles: Styles(raw: {
              'background-color': 'var(--arcane-primary)',
              'color': 'var(--arcane-on-primary)',
              'font-size': '0.75rem',
              'padding': '2px 6px',
              'border-radius': '9999px',
              'font-weight': '500',
            }),
            [text(badge!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-nav-tile:hover:not(:disabled):not(.selected)').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}
