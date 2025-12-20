import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// A navigation link item
class ArcaneNavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<ArcaneNavItem>? children;
  final bool isActive;

  const ArcaneNavItem({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.isActive = false,
  });
}

/// A website header/navbar component (Supabase-style)
class ArcaneHeader extends StatelessComponent {
  /// Logo component (usually an image or text)
  final Component logo;

  /// Navigation items
  final List<ArcaneNavItem> navItems;

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

  const ArcaneHeader({
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
        'padding': '0 ${ArcaneSpacing.lg}',
        'height': '64px',
        'background-color': transparent
            ? ArcaneColors.transparent
            : ArcaneColors.background,
        if (bordered) 'border-bottom': '1px solid ${ArcaneColors.border}',
        if (sticky) 'position': 'sticky',
        if (sticky) 'top': '0',
        if (sticky) 'z-index': '50',
        if (!transparent) 'backdrop-filter': 'blur(12px)',
      }),
      [
        // Left section: Logo + Nav
        div(
          classes: 'arcane-header-left',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.xl,
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
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': ArcaneSpacing.xs,
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
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.md,
          }),
          [
            // Search
            if (showSearch)
              div(
                classes: 'arcane-header-search',
                styles: const Styles(raw: {
                  'position': 'relative',
                }),
                [
                  input(
                    type: InputType.search,
                    attributes: {
                      'placeholder': searchPlaceholder,
                    },
                    styles: const Styles(raw: {
                      'padding': '8px 12px 8px 36px',
                      'font-size': ArcaneTypography.fontSm,
                      'background-color': ArcaneColors.surfaceVariant,
                      'border': '1px solid ${ArcaneColors.border}',
                      'border-radius': ArcaneRadius.md,
                      'color': ArcaneColors.onSurface,
                      'width': '200px',
                      'outline': 'none',
                      'transition': ArcaneEffects.transitionFast,
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
                    styles: const Styles(raw: {
                      'position': 'absolute',
                      'left': '12px',
                      'top': '50%',
                      'transform': 'translateY(-50%)',
                      'color': ArcaneColors.muted,
                      'font-size': ArcaneTypography.fontSm,
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

  Component _buildNavItem(ArcaneNavItem item) {
    final bool hasChildren = item.children != null && item.children!.isNotEmpty;

    return div(
      classes: 'arcane-nav-item ${hasChildren ? 'has-dropdown' : ''} ${item.isActive ? 'active' : ''}',
      styles: const Styles(raw: {
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
              'gap': ArcaneSpacing.xs,
              'padding': '8px 12px',
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': item.isActive ? ArcaneColors.onSurface : ArcaneColors.muted,
              'text-decoration': 'none',
              'border-radius': ArcaneRadius.md,
              'transition': ArcaneEffects.transitionFast,
            }),
            [
              text(item.label),
              if (hasChildren)
                span(
                  [text('▼')],
                  styles: const Styles(raw: {'font-size': ArcaneTypography.fontXs}),
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
              'gap': ArcaneSpacing.xs,
              'padding': '8px 12px',
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': item.isActive ? ArcaneColors.onSurface : ArcaneColors.muted,
              'background': 'none',
              'border': 'none',
              'border-radius': ArcaneRadius.md,
              'cursor': 'pointer',
              'transition': ArcaneEffects.transitionFast,
            }),
            events: {
              'click': (e) => item.onTap?.call(),
            },
            [
              text(item.label),
              if (hasChildren)
                span(
                  [text('▼')],
                  styles: const Styles(raw: {'font-size': ArcaneTypography.fontXs}),
                ),
            ],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-nav-link:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-nav-item.active .arcane-nav-link').styles(raw: {
      'color': ArcaneColors.accent,
    }),
    css('.arcane-header-search input:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'width': '280px',
    }),
  ];
}

/// A simple nav link component
class ArcaneNavLink extends StatelessComponent {
  final String label;
  final String? href;
  final void Function()? onTap;
  final bool isActive;
  final bool showArrow;

  const ArcaneNavLink({
    required this.label,
    this.href,
    this.onTap,
    this.isActive = false,
    this.showArrow = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final Styles linkStyles = Styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': ArcaneSpacing.xs,
      'font-size': ArcaneTypography.fontSm,
      'font-weight': ArcaneTypography.weightMedium,
      'color': isActive ? ArcaneColors.accent : ArcaneColors.muted,
      'text-decoration': 'none',
      'transition': ArcaneEffects.transitionFast,
    });

    final List<Component> content = [
      text(label),
      if (showArrow)
        span(
          [text('→')],
          classes: 'nav-link-arrow',
          styles: const Styles(raw: {
            'transition': ArcaneEffects.transitionFast,
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
        'gap': ArcaneSpacing.xs,
        'font-size': ArcaneTypography.fontSm,
        'font-weight': ArcaneTypography.weightMedium,
        'color': isActive ? ArcaneColors.accent : ArcaneColors.muted,
        'text-decoration': 'none',
        'transition': ArcaneEffects.transitionFast,
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
      'color': ArcaneColors.onSurface,
    }),
    css('.arcane-nav-link-standalone:hover .nav-link-arrow').styles(raw: {
      'transform': 'translateX(4px)',
    }),
  ];
}