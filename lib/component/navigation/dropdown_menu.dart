import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A dropdown menu item
class DropdownItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final Component? icon;
  final String? description;
  final bool disabled;
  final bool divider;

  const DropdownItem({
    required this.label,
    this.href,
    this.onTap,
    this.icon,
    this.description,
    this.disabled = false,
    this.divider = false,
  });

  /// Create a divider item
  const DropdownItem.divider()
      : label = '',
        href = null,
        onTap = null,
        icon = null,
        description = null,
        disabled = false,
        divider = true;
}

/// A dropdown menu component (Supabase-style)
class DropdownMenu extends StatefulComponent {
  /// Trigger element
  final Component trigger;

  /// Menu items
  final List<DropdownItem> items;

  /// Alignment
  final DropdownAlignment alignment;

  /// Width
  final double? width;

  const DropdownMenu({
    required this.trigger,
    required this.items,
    this.alignment = DropdownAlignment.left,
    this.width,
    super.key,
  });

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-dropdown-fade').styles(raw: {
      '0%': 'opacity: 0; transform: translateY(-8px)',
      '100%': 'opacity: 1; transform: translateY(0)',
    }),
    css('.arcane-dropdown-item:hover:not(:disabled)').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}

/// Dropdown alignment
enum DropdownAlignment {
  left,
  right,
  center,
}

class _DropdownMenuState extends State<DropdownMenu> {
  bool _isOpen = false;

  void _toggle() {
    setState(() => _isOpen = !_isOpen);
  }

  void _close() {
    setState(() => _isOpen = false);
  }

  @override
  Component build(BuildContext context) {
    final (left, right, transform) = switch (component.alignment) {
      DropdownAlignment.left => ('0', 'auto', 'none'),
      DropdownAlignment.right => ('auto', '0', 'none'),
      DropdownAlignment.center => ('50%', 'auto', 'translateX(-50%)'),
    };

    return div(
      classes: 'arcane-dropdown ${_isOpen ? 'open' : ''}',
      styles: Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
      [
        // Trigger
        div(
          classes: 'arcane-dropdown-trigger',
          events: {
            'click': (e) => _toggle(),
          },
          [component.trigger],
        ),

        // Backdrop to close on click outside
        if (_isOpen)
          div(
            classes: 'arcane-dropdown-backdrop',
            styles: Styles(raw: {
              'position': 'fixed',
              'inset': '0',
              'z-index': '99',
            }),
            events: {
              'click': (e) => _close(),
            },
            [],
          ),

        // Menu
        if (_isOpen)
          div(
            classes: 'arcane-dropdown-menu',
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': left,
              'right': right,
              'transform': transform,
              'z-index': '100',
              'margin-top': '8px',
              if (component.width != null) 'width': '${component.width}px' else 'min-width': '200px',
              'padding': '8px',
              'background-color': 'var(--arcane-surface)',
              'border': '1px solid var(--arcane-border)',
              'border-radius': 'var(--arcane-radius)',
              'box-shadow': 'var(--arcane-shadow-lg)',
              'animation': 'arcane-dropdown-fade 0.15s ease-out',
            }),
            [
              for (final item in component.items)
                if (item.divider)
                  div(
                    classes: 'arcane-dropdown-divider',
                    styles: Styles(raw: {
                      'height': '1px',
                      'margin': '8px 0',
                      'background-color': 'var(--arcane-border)',
                    }),
                    [],
                  )
                else
                  _buildItem(item),
            ],
          ),
      ],
    );
  }

  Component _buildItem(DropdownItem item) {
    final itemStyles = Styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'gap': '12px',
      'padding': '10px 12px',
      'font-size': '0.875rem',
      'color': item.disabled ? 'var(--arcane-muted)' : 'var(--arcane-on-surface)',
      'text-decoration': 'none',
      'border-radius': 'var(--arcane-radius-sm)',
      'cursor': item.disabled ? 'not-allowed' : 'pointer',
      'transition': 'background-color var(--arcane-transition-fast)',
      'background': 'none',
      'border': 'none',
      'width': '100%',
      'text-align': 'left',
    });

    final content = [
      if (item.icon != null)
        span(
          styles: Styles(raw: {
            'flex-shrink': '0',
            'opacity': item.disabled ? '0.5' : '1',
          }),
          [item.icon!],
        ),
      div(
        styles: Styles(raw: {
          'flex': '1',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '2px',
        }),
        [
          span([text(item.label)]),
          if (item.description != null)
            span(
              styles: Styles(raw: {
                'font-size': '0.75rem',
                'color': 'var(--arcane-muted)',
              }),
              [text(item.description!)],
            ),
        ],
      ),
    ];

    if (item.href != null && !item.disabled) {
      return a(
        href: item.href!,
        classes: 'arcane-dropdown-item',
        styles: itemStyles,
        events: {
          'click': (e) => _close(),
        },
        content,
      );
    }

    return button(
      classes: 'arcane-dropdown-item',
      attributes: {
        'type': 'button',
        if (item.disabled) 'disabled': 'true',
      },
      styles: itemStyles,
      events: {
        if (!item.disabled && item.onTap != null)
          'click': (e) {
            _close();
            item.onTap!();
          },
      },
      content,
    );
  }
}

/// A navigation dropdown with mega-menu style
class MegaMenu extends StatefulComponent {
  /// Trigger label
  final String label;

  /// Menu sections
  final List<MegaMenuSection> sections;

  /// Footer content
  final Component? footer;

  const MegaMenu({
    required this.label,
    required this.sections,
    this.footer,
    super.key,
  });

  @override
  State<MegaMenu> createState() => _MegaMenuState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-mega-menu-trigger:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
    }),
    css('.arcane-mega-menu-item:hover').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}

/// A section in a mega menu
class MegaMenuSection {
  final String? title;
  final List<DropdownItem> items;

  const MegaMenuSection({
    this.title,
    required this.items,
  });
}

class _MegaMenuState extends State<MegaMenu> {
  bool _isOpen = false;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-mega-menu ${_isOpen ? 'open' : ''}',
      styles: Styles(raw: {
        'position': 'relative',
      }),
      events: {
        'mouseenter': (e) => setState(() => _isOpen = true),
        'mouseleave': (e) => setState(() => _isOpen = false),
      },
      [
        // Trigger
        button(
          classes: 'arcane-mega-menu-trigger',
          attributes: {'type': 'button'},
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '4px',
            'padding': '8px 12px',
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': _isOpen ? 'var(--arcane-on-surface)' : 'var(--arcane-muted)',
            'background': 'none',
            'border': 'none',
            'cursor': 'pointer',
            'transition': 'color var(--arcane-transition-fast)',
          }),
          [
            text(component.label),
            span(
              styles: Styles(raw: {
                'font-size': '0.75rem',
                'transform': _isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                'transition': 'transform var(--arcane-transition-fast)',
              }),
              [text('▼')],
            ),
          ],
        ),

        // Menu panel
        if (_isOpen)
          div(
            classes: 'arcane-mega-menu-panel',
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '50%',
              'transform': 'translateX(-50%)',
              'z-index': '100',
              'margin-top': '8px',
              'padding': '24px',
              'background-color': 'var(--arcane-surface)',
              'border': '1px solid var(--arcane-border)',
              'border-radius': 'var(--arcane-radius)',
              'box-shadow': 'var(--arcane-shadow-xl)',
              'display': 'flex',
              'gap': '48px',
              'animation': 'arcane-dropdown-fade 0.15s ease-out',
            }),
            [
              for (final section in component.sections)
                div(
                  classes: 'arcane-mega-menu-section',
                  styles: Styles(raw: {
                    'min-width': '180px',
                  }),
                  [
                    if (section.title != null)
                      div(
                        styles: Styles(raw: {
                          'font-size': '0.75rem',
                          'font-weight': '600',
                          'text-transform': 'uppercase',
                          'letter-spacing': '0.05em',
                          'color': 'var(--arcane-muted)',
                          'margin-bottom': '12px',
                        }),
                        [text(section.title!)],
                      ),
                    div(
                      styles: Styles(raw: {
                        'display': 'flex',
                        'flex-direction': 'column',
                        'gap': '4px',
                      }),
                      [
                        for (final item in section.items)
                          _buildMegaItem(item),
                      ],
                    ),
                  ],
                ),
              if (component.footer != null)
                div(
                  classes: 'arcane-mega-menu-footer',
                  styles: Styles(raw: {
                    'padding-left': '24px',
                    'border-left': '1px solid var(--arcane-border)',
                  }),
                  [component.footer!],
                ),
            ],
          ),
      ],
    );
  }

  Component _buildMegaItem(DropdownItem item) {
    final itemContent = div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '12px',
      }),
      [
        if (item.icon != null)
          span(
            styles: Styles(raw: {
              'flex-shrink': '0',
              'margin-top': '2px',
            }),
            [item.icon!],
          ),
        div([
          div(
            styles: Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--arcane-on-surface)',
            }),
            [text(item.label)],
          ),
          if (item.description != null)
            div(
              styles: Styles(raw: {
                'font-size': '0.8125rem',
                'color': 'var(--arcane-muted)',
                'margin-top': '2px',
              }),
              [text(item.description!)],
            ),
        ]),
      ],
    );

    if (item.href != null) {
      return a(
        href: item.href!,
        classes: 'arcane-mega-menu-item',
        styles: Styles(raw: {
          'display': 'block',
          'padding': '10px 12px',
          'text-decoration': 'none',
          'border-radius': 'var(--arcane-radius-sm)',
          'transition': 'background-color var(--arcane-transition-fast)',
        }),
        [itemContent],
      );
    }

    return button(
      classes: 'arcane-mega-menu-item',
      attributes: {'type': 'button'},
      styles: Styles(raw: {
        'display': 'block',
        'width': '100%',
        'padding': '10px 12px',
        'text-align': 'left',
        'background': 'none',
        'border': 'none',
        'border-radius': 'var(--arcane-radius-sm)',
        'cursor': 'pointer',
        'transition': 'background-color var(--arcane-transition-fast)',
      }),
      events: {
        if (item.onTap != null) 'click': (e) => item.onTap!(),
      },
      [itemContent],
    );
  }
}
