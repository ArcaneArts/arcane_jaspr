import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';
import '../input/button.dart';

/// A navigation link item
class NavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<NavItem>? children;
  final bool isActive;

  const NavItem({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.isActive = false,
  });
}

/// A website header/navbar component (Supabase-style)
class Header extends StatelessComponent {
  /// Logo component (usually an image or text)
  final Component logo;

  /// Navigation items
  final List<NavItem> navItems;

  /// Right-side actions (buttons, etc.)
  final List<Component>? actions;

  /// Whether to show a search bar
  final bool showSearch;

  /// Search placeholder text
  final String searchPlaceholder;

  /// Search callback
  final void Function(String)? onSearch;

  /// Whether the header is fixed/sticky
  final bool sticky;

  /// Whether to use transparent background
  final bool transparent;

  /// Whether to add border bottom
  final bool bordered;

  const Header({
    required this.logo,
    required this.navItems,
    this.actions,
    this.showSearch = false,
    this.searchPlaceholder = 'Search...',
    this.onSearch,
    this.sticky = true,
    this.transparent = false,
    this.bordered = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return header(
      classes: 'arcane-header ${sticky ? 'sticky' : ''} ${transparent ? 'transparent' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'padding': '0 24px',
        'height': '64px',
        'background-color': transparent
            ? 'transparent'
            : 'var(--arcane-background)',
        if (bordered) 'border-bottom': '1px solid var(--arcane-border)',
        if (sticky) 'position': 'sticky',
        if (sticky) 'top': '0',
        if (sticky) 'z-index': '50',
        if (!transparent) 'backdrop-filter': 'blur(12px)',
      }),
      [
        // Left section: Logo + Nav
        div(
          classes: 'arcane-header-left',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '32px',
          }),
          [
            // Logo
            div(
              classes: 'arcane-header-logo',
              [logo],
            ),

            // Navigation
            nav(
              classes: 'arcane-header-nav',
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '4px',
              }),
              [
                for (final item in navItems) _buildNavItem(item),
              ],
            ),
          ],
        ),

        // Right section: Search + Actions
        div(
          classes: 'arcane-header-right',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '16px',
          }),
          [
            // Search
            if (showSearch)
              div(
                classes: 'arcane-header-search',
                styles: Styles(raw: {
                  'position': 'relative',
                }),
                [
                  input(
                    type: InputType.search,
                    attributes: {
                      'placeholder': searchPlaceholder,
                    },
                    styles: Styles(raw: {
                      'padding': '8px 12px 8px 36px',
                      'font-size': '0.875rem',
                      'background-color': 'var(--arcane-surface-variant)',
                      'border': '1px solid var(--arcane-border)',
                      'border-radius': 'var(--arcane-radius)',
                      'color': 'var(--arcane-on-surface)',
                      'width': '200px',
                      'outline': 'none',
                      'transition': 'var(--arcane-transition-fast)',
                    }),
                    events: {
                      'input': (e) {
                        // Handle search input
                      },
                    },
                  ),
                  // Search icon
                  span(
                    [text('🔍')],
                    styles: Styles(raw: {
                      'position': 'absolute',
                      'left': '12px',
                      'top': '50%',
                      'transform': 'translateY(-50%)',
                      'color': 'var(--arcane-muted)',
                      'font-size': '0.875rem',
                    }),
                  ),
                ],
              ),

            // Actions
            if (actions != null) ...actions!,
          ],
        ),
      ],
    );
  }

  Component _buildNavItem(NavItem item) {
    final hasChildren = item.children != null && item.children!.isNotEmpty;

    return div(
      classes: 'arcane-nav-item ${hasChildren ? 'has-dropdown' : ''} ${item.isActive ? 'active' : ''}',
      styles: Styles(raw: {
        'position': 'relative',
      }),
      [
        if (item.href != null)
          a(
            href: item.href!,
            classes: 'arcane-nav-link',
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '4px',
              'padding': '8px 12px',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': item.isActive
                  ? 'var(--arcane-on-surface)'
                  : 'var(--arcane-muted)',
              'text-decoration': 'none',
              'border-radius': 'var(--arcane-radius)',
              'transition': 'var(--arcane-transition-fast)',
            }),
            [
              text(item.label),
              if (hasChildren)
                span(
                  [text('▼')],
                  styles: Styles(raw: {'font-size': '0.75rem'}),
                ),
            ],
          )
        else
          button(
            classes: 'arcane-nav-link',
            attributes: {'type': 'button'},
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '4px',
              'padding': '8px 12px',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': item.isActive
                  ? 'var(--arcane-on-surface)'
                  : 'var(--arcane-muted)',
              'background': 'none',
              'border': 'none',
              'border-radius': 'var(--arcane-radius)',
              'cursor': 'pointer',
              'transition': 'var(--arcane-transition-fast)',
            }),
            events: {
              'click': (e) => item.onTap?.call(),
            },
            [
              text(item.label),
              if (hasChildren)
                span(
                  [text('▼')],
                  styles: Styles(raw: {'font-size': '0.75rem'}),
                ),
            ],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-nav-link:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
      'background-color': 'var(--arcane-surface-variant)',
    }),
    css('.arcane-nav-item.active .arcane-nav-link').styles(raw: {
      'color': 'var(--arcane-accent)',
    }),
    css('.arcane-header-search input:focus').styles(raw: {
      'border-color': 'var(--arcane-accent)',
      'width': '280px',
    }),
  ];
}

/// A simple nav link component
class NavLink extends StatelessComponent {
  final String label;
  final String? href;
  final void Function()? onTap;
  final bool isActive;
  final bool showArrow;

  const NavLink({
    required this.label,
    this.href,
    this.onTap,
    this.isActive = false,
    this.showArrow = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final linkStyles = Styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '4px',
      'font-size': '0.875rem',
      'font-weight': '500',
      'color': isActive ? 'var(--arcane-accent)' : 'var(--arcane-muted)',
      'text-decoration': 'none',
      'transition': 'color var(--arcane-transition-fast)',
    });

    final content = [
      text(label),
      if (showArrow)
        span(
          [text('→')],
          classes: 'nav-link-arrow',
          styles: Styles(raw: {
            'transition': 'transform var(--arcane-transition-fast)',
          }),
        ),
    ];

    if (href != null) {
      return a(
        href: href!,
        classes: 'arcane-nav-link-standalone',
        styles: linkStyles,
        content,
      );
    }

    return button(
      classes: 'arcane-nav-link-standalone',
      attributes: {'type': 'button'},
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '4px',
        'font-size': '0.875rem',
        'font-weight': '500',
        'color': isActive ? 'var(--arcane-accent)' : 'var(--arcane-muted)',
        'text-decoration': 'none',
        'transition': 'color var(--arcane-transition-fast)',
        'background': 'none',
        'border': 'none',
        'padding': '0',
        'cursor': 'pointer',
      }),
      events: {'click': (e) => onTap?.call()},
      content,
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-nav-link-standalone:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
    }),
    css('.arcane-nav-link-standalone:hover .nav-link-arrow').styles(raw: {
      'transform': 'translateX(4px)',
    }),
  ];
}
