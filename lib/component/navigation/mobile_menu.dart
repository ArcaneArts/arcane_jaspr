import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Mobile navigation item
class ArcaneMobileNavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<ArcaneMobileNavItem>? children;
  final Component? icon;

  const ArcaneMobileNavItem({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.icon,
  });
}

/// A mobile hamburger menu (Supabase-style)
class ArcaneMobileMenu extends StatefulComponent {
  /// Navigation items
  final List<ArcaneMobileNavItem> items;

  /// Optional logo
  final Component? logo;

  /// Optional CTA button
  final Component? cta;

  /// Close callback
  final void Function()? onClose;

  /// Whether the menu is open
  final bool isOpen;

  const ArcaneMobileMenu({
    required this.items,
    this.logo,
    this.cta,
    this.onClose,
    this.isOpen = false,
    super.key,
  });

  @override
  State<ArcaneMobileMenu> createState() => _ArcaneMobileMenuState();

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-mobile-menu-slide').styles(raw: {
      '0%': 'opacity: 0; transform: translateX(-100%)',
      '100%': 'opacity: 1; transform: translateX(0)',
    }),
    css('.arcane-mobile-menu-close:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
    }),
    css('.arcane-mobile-nav-button:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-mobile-nav-link:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-mobile-nav-children a:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
    }),
    css('.arcane-mobile-nav-children button:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
    }),
  ];
}

class _ArcaneMobileMenuState extends State<ArcaneMobileMenu> {
  final Set<int> _expandedItems = {};

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedItems.contains(index)) {
        _expandedItems.remove(index);
      } else {
        _expandedItems.add(index);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    if (!component.isOpen) {
      return const div([]);
    }

    return div(
      classes: 'arcane-mobile-menu',
      styles: const Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '1000',
        'display': 'flex',
        'flex-direction': 'column',
        'background-color': ArcaneColors.surface,
        'animation': 'arcane-mobile-menu-slide 0.2s ease-out',
      }),
      [
        // Header
        div(
          classes: 'arcane-mobile-menu-header',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'padding': '${ArcaneSpacing.md} 20px',
            'border-bottom': '1px solid ${ArcaneColors.border}',
          }),
          [
            if (component.logo != null) component.logo! else const div([]),
            button(
              classes: 'arcane-mobile-menu-close',
              attributes: {
                'type': 'button',
                'aria-label': 'Close menu',
              },
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '40px',
                'height': '40px',
                'font-size': '1.5rem',
                'color': ArcaneColors.muted,
                'background': 'none',
                'border': 'none',
                'cursor': 'pointer',
                'transition': ArcaneEffects.transitionFast,
              }),
              events: {
                'click': (e) => component.onClose?.call(),
              },
              [text('×')],
            ),
          ],
        ),

        // Navigation items
        div(
          classes: 'arcane-mobile-menu-nav',
          styles: const Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'padding': '${ArcaneSpacing.md} 0',
          }),
          [
            for (var i = 0; i < component.items.length; i++)
              _buildNavItem(i, component.items[i]),
          ],
        ),

        // Footer with CTA
        if (component.cta != null)
          div(
            classes: 'arcane-mobile-menu-footer',
            styles: const Styles(raw: {
              'padding': '20px',
              'border-top': '1px solid ${ArcaneColors.border}',
            }),
            [component.cta!],
          ),
      ],
    );
  }

  Component _buildNavItem(int index, ArcaneMobileNavItem item) {
    final bool hasChildren = item.children != null && item.children!.isNotEmpty;
    final bool isExpanded = _expandedItems.contains(index);

    return div(
      classes: 'arcane-mobile-nav-item',
      [
        // Main item
        if (hasChildren)
          button(
            classes: 'arcane-mobile-nav-button',
            attributes: {'type': 'button'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'width': '100%',
              'padding': '14px 20px',
              'font-size': ArcaneTypography.fontMd,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
              'background': 'none',
              'border': 'none',
              'cursor': 'pointer',
              'text-align': 'left',
              'transition': ArcaneEffects.transitionFast,
            }),
            events: {
              'click': (e) => _toggleExpand(index),
            },
            [
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': ArcaneSpacing.sm,
                }),
                [
                  if (item.icon != null) item.icon!,
                  text(item.label),
                ],
              ),
              span(
                [text('▼')],
                styles: Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                  'transform': isExpanded ? 'rotate(180deg)' : 'rotate(0deg)',
                  'transition': ArcaneEffects.transitionFast,
                }),
              ),
            ],
          )
        else if (item.href != null)
          a(
            href: item.href!,
            classes: 'arcane-mobile-nav-link',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.sm,
              'padding': '14px 20px',
              'font-size': ArcaneTypography.fontMd,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
              'text-decoration': 'none',
              'transition': ArcaneEffects.transitionFast,
            }),
            [
              if (item.icon != null) item.icon!,
              text(item.label),
            ],
          )
        else
          button(
            classes: 'arcane-mobile-nav-button',
            attributes: {'type': 'button'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.sm,
              'width': '100%',
              'padding': '14px 20px',
              'font-size': ArcaneTypography.fontMd,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
              'background': 'none',
              'border': 'none',
              'cursor': 'pointer',
              'text-align': 'left',
              'transition': ArcaneEffects.transitionFast,
            }),
            events: {
              if (item.onTap != null) 'click': (e) => item.onTap!(),
            },
            [
              if (item.icon != null) item.icon!,
              text(item.label),
            ],
          ),

        // Children
        if (hasChildren && isExpanded)
          div(
            classes: 'arcane-mobile-nav-children',
            styles: const Styles(raw: {
              'background-color': ArcaneColors.surfaceVariant,
              'padding': '${ArcaneSpacing.sm} 0',
            }),
            [
              for (final child in item.children!)
                if (child.href != null)
                  a(
                    href: child.href!,
                    styles: const Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': ArcaneSpacing.sm,
                      'padding': '${ArcaneSpacing.sm} 20px ${ArcaneSpacing.sm} 44px',
                      'font-size': ArcaneTypography.fontSm,
                      'color': ArcaneColors.muted,
                      'text-decoration': 'none',
                      'transition': ArcaneEffects.transitionFast,
                    }),
                    [
                      if (child.icon != null) child.icon!,
                      text(child.label),
                    ],
                  )
                else
                  button(
                    attributes: {'type': 'button'},
                    styles: const Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': ArcaneSpacing.sm,
                      'width': '100%',
                      'padding': '${ArcaneSpacing.sm} 20px ${ArcaneSpacing.sm} 44px',
                      'font-size': ArcaneTypography.fontSm,
                      'color': ArcaneColors.muted,
                      'background': 'none',
                      'border': 'none',
                      'cursor': 'pointer',
                      'text-align': 'left',
                      'transition': ArcaneEffects.transitionFast,
                    }),
                    events: {
                      if (child.onTap != null) 'click': (e) => child.onTap!(),
                    },
                    [
                      if (child.icon != null) child.icon!,
                      text(child.label),
                    ],
                  ),
            ],
          ),
      ],
    );
  }
}

/// Hamburger menu button
class ArcaneHamburgerButton extends StatelessComponent {
  /// Whether the menu is open
  final bool isOpen;

  /// Click handler
  final void Function()? onTap;

  /// Size
  final double size;

  const ArcaneHamburgerButton({
    this.isOpen = false,
    this.onTap,
    this.size = 24,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-hamburger ${isOpen ? 'open' : ''}',
      attributes: {
        'type': 'button',
        'aria-label': isOpen ? 'Close menu' : 'Open menu',
        'aria-expanded': isOpen.toString(),
      },
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'justify-content': 'center',
        'align-items': 'center',
        'gap': '5px',
        'width': '${size + 16}px',
        'height': '${size + 16}px',
        'padding': ArcaneSpacing.sm,
        'background': 'none',
        'border': 'none',
        'cursor': 'pointer',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        span(
          [],
          classes: 'arcane-hamburger-line',
          styles: Styles(raw: {
            'display': 'block',
            'width': '${size}px',
            'height': '2px',
            'background-color': ArcaneColors.onSurface,
            'border-radius': '1px',
            'transition': ArcaneEffects.transitionFast,
            if (isOpen) 'transform': 'translateY(7px) rotate(45deg)',
          }),
        ),
        span(
          [],
          classes: 'arcane-hamburger-line',
          styles: Styles(raw: {
            'display': 'block',
            'width': '${size}px',
            'height': '2px',
            'background-color': ArcaneColors.onSurface,
            'border-radius': '1px',
            'transition': ArcaneEffects.transitionFast,
            if (isOpen) 'opacity': '0',
          }),
        ),
        span(
          [],
          classes: 'arcane-hamburger-line',
          styles: Styles(raw: {
            'display': 'block',
            'width': '${size}px',
            'height': '2px',
            'background-color': ArcaneColors.onSurface,
            'border-radius': '1px',
            'transition': ArcaneEffects.transitionFast,
            if (isOpen) 'transform': 'translateY(-7px) rotate(-45deg)',
          }),
        ),
      ],
    );
  }
}