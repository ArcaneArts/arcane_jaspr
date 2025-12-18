import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// Mobile navigation item
class MobileNavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<MobileNavItem>? children;
  final Component? icon;

  const MobileNavItem({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.icon,
  });
}

/// A mobile hamburger menu (Supabase-style)
class MobileMenu extends StatefulComponent {
  /// Navigation items
  final List<MobileNavItem> items;

  /// Optional logo
  final Component? logo;

  /// Optional CTA button
  final Component? cta;

  /// Close callback
  final void Function()? onClose;

  /// Whether the menu is open
  final bool isOpen;

  const MobileMenu({
    required this.items,
    this.logo,
    this.cta,
    this.onClose,
    this.isOpen = false,
    super.key,
  });

  @override
  State<MobileMenu> createState() => _MobileMenuState();

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-mobile-menu-slide').styles(raw: {
      '0%': 'opacity: 0; transform: translateX(-100%)',
      '100%': 'opacity: 1; transform: translateX(0)',
    }),
    css('.arcane-mobile-menu-close:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
    }),
    css('.arcane-mobile-nav-button:hover').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
    css('.arcane-mobile-nav-link:hover').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
    css('.arcane-mobile-nav-children a:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
    }),
    css('.arcane-mobile-nav-children button:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
    }),
  ];
}

class _MobileMenuState extends State<MobileMenu> {
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
      return div([]);
    }

    return div(
      classes: 'arcane-mobile-menu',
      styles: Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '1000',
        'display': 'flex',
        'flex-direction': 'column',
        'background-color': 'var(--arcane-surface)',
        'animation': 'arcane-mobile-menu-slide 0.2s ease-out',
      }),
      [
        // Header
        div(
          classes: 'arcane-mobile-menu-header',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'padding': '16px 20px',
            'border-bottom': '1px solid var(--arcane-border)',
          }),
          [
            if (component.logo != null) component.logo! else div([]),
            button(
              classes: 'arcane-mobile-menu-close',
              attributes: {
                'type': 'button',
                'aria-label': 'Close menu',
              },
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '40px',
                'height': '40px',
                'font-size': '1.5rem',
                'color': 'var(--arcane-muted)',
                'background': 'none',
                'border': 'none',
                'cursor': 'pointer',
                'transition': 'color var(--arcane-transition-fast)',
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
          styles: Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'padding': '16px 0',
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
            styles: Styles(raw: {
              'padding': '20px',
              'border-top': '1px solid var(--arcane-border)',
            }),
            [component.cta!],
          ),
      ],
    );
  }

  Component _buildNavItem(int index, MobileNavItem item) {
    final hasChildren = item.children != null && item.children!.isNotEmpty;
    final isExpanded = _expandedItems.contains(index);

    return div(
      classes: 'arcane-mobile-nav-item',
      [
        // Main item
        if (hasChildren)
          button(
            classes: 'arcane-mobile-nav-button',
            attributes: {'type': 'button'},
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'width': '100%',
              'padding': '14px 20px',
              'font-size': '1rem',
              'font-weight': '500',
              'color': 'var(--arcane-on-surface)',
              'background': 'none',
              'border': 'none',
              'cursor': 'pointer',
              'text-align': 'left',
              'transition': 'background-color var(--arcane-transition-fast)',
            }),
            events: {
              'click': (e) => _toggleExpand(index),
            },
            [
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '12px',
                }),
                [
                  if (item.icon != null) item.icon!,
                  text(item.label),
                ],
              ),
              span(
                [text('▼')],
                styles: Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--arcane-muted)',
                  'transform': isExpanded ? 'rotate(180deg)' : 'rotate(0deg)',
                  'transition': 'transform var(--arcane-transition-fast)',
                }),
              ),
            ],
          )
        else if (item.href != null)
          a(
            href: item.href!,
            classes: 'arcane-mobile-nav-link',
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '12px',
              'padding': '14px 20px',
              'font-size': '1rem',
              'font-weight': '500',
              'color': 'var(--arcane-on-surface)',
              'text-decoration': 'none',
              'transition': 'background-color var(--arcane-transition-fast)',
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
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '12px',
              'width': '100%',
              'padding': '14px 20px',
              'font-size': '1rem',
              'font-weight': '500',
              'color': 'var(--arcane-on-surface)',
              'background': 'none',
              'border': 'none',
              'cursor': 'pointer',
              'text-align': 'left',
              'transition': 'background-color var(--arcane-transition-fast)',
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
            styles: Styles(raw: {
              'background-color': 'var(--arcane-surface-variant)',
              'padding': '8px 0',
            }),
            [
              for (final child in item.children!)
                if (child.href != null)
                  a(
                    href: child.href!,
                    styles: Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': '12px',
                      'padding': '12px 20px 12px 44px',
                      'font-size': '0.9375rem',
                      'color': 'var(--arcane-muted)',
                      'text-decoration': 'none',
                      'transition': 'color var(--arcane-transition-fast)',
                    }),
                    [
                      if (child.icon != null) child.icon!,
                      text(child.label),
                    ],
                  )
                else
                  button(
                    attributes: {'type': 'button'},
                    styles: Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': '12px',
                      'width': '100%',
                      'padding': '12px 20px 12px 44px',
                      'font-size': '0.9375rem',
                      'color': 'var(--arcane-muted)',
                      'background': 'none',
                      'border': 'none',
                      'cursor': 'pointer',
                      'text-align': 'left',
                      'transition': 'color var(--arcane-transition-fast)',
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
class HamburgerButton extends StatelessComponent {
  /// Whether the menu is open
  final bool isOpen;

  /// Click handler
  final void Function()? onTap;

  /// Size
  final double size;

  const HamburgerButton({
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
        'padding': '8px',
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
            'background-color': 'var(--arcane-on-surface)',
            'border-radius': '1px',
            'transition': 'transform var(--arcane-transition-fast), opacity var(--arcane-transition-fast)',
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
            'background-color': 'var(--arcane-on-surface)',
            'border-radius': '1px',
            'transition': 'opacity var(--arcane-transition-fast)',
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
            'background-color': 'var(--arcane-on-surface)',
            'border-radius': '1px',
            'transition': 'transform var(--arcane-transition-fast), opacity var(--arcane-transition-fast)',
            if (isOpen) 'transform': 'translateY(-7px) rotate(-45deg)',
          }),
        ),
      ],
    );
  }
}
