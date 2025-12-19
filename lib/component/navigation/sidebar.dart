import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// A sidebar navigation component.
class Sidebar extends StatefulComponent {
  /// The sidebar content
  final List<Component> children;

  /// Header component
  final Component? header;

  /// Footer component
  final Component? footer;

  /// Whether the sidebar is collapsed
  final bool collapsed;

  /// Callback when collapse state changes
  final void Function(bool collapsed)? onCollapseChanged;

  /// Width of the sidebar
  final double width;

  /// Width when collapsed
  final double collapsedWidth;

  /// Whether to show the collapse toggle
  final bool showCollapseToggle;

  /// Whether the sidebar is on the right side
  final bool rightSide;

  const Sidebar({
    required this.children,
    this.header,
    this.footer,
    this.collapsed = false,
    this.onCollapseChanged,
    this.width = 280,
    this.collapsedWidth = 64,
    this.showCollapseToggle = true,
    this.rightSide = false,
    super.key,
  });

  @override
  State<Sidebar> createState() => _SidebarState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-sidebar-toggle:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

class _SidebarState extends State<Sidebar> {
  late bool _isCollapsed;

  @override
  void initState() {
    super.initState();
    _isCollapsed = component.collapsed;
  }

  @override
  void didUpdateComponent(Sidebar oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.collapsed != component.collapsed) {
      _isCollapsed = component.collapsed;
    }
  }

  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
    component.onCollapseChanged?.call(_isCollapsed);
  }

  @override
  Component build(BuildContext context) {
    final double currentWidth = _isCollapsed ? component.collapsedWidth : component.width;

    return aside(
      classes: 'arcane-sidebar ${_isCollapsed ? 'collapsed' : ''} ${component.rightSide ? 'right' : 'left'}',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'width': '${currentWidth}px',
        'height': '100%',
        'background-color': ArcaneColors.surface,
        'border-${component.rightSide ? 'left' : 'right'}': '1px solid ${ArcaneColors.border}',
        'transition': 'width 200ms ease',
        'flex-shrink': '0',
        'overflow': 'hidden',
      }),
      [
        // Header
        if (component.header != null)
          div(
            classes: 'arcane-sidebar-header',
            styles: Styles(raw: {
              'padding': _isCollapsed ? '${ArcaneSpacing.md} ${ArcaneSpacing.sm}' : ArcaneSpacing.md,
              'border-bottom': '1px solid ${ArcaneColors.border}',
              'flex-shrink': '0',
            }),
            [component.header!],
          ),

        // Content
        div(
          classes: 'arcane-sidebar-content',
          styles: Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'overflow-x': 'hidden',
            'padding': _isCollapsed ? ArcaneSpacing.sm : '${ArcaneSpacing.sm} ${ArcaneSpacing.sm}',
          }),
          component.children,
        ),

        // Footer with collapse toggle
        div(
          classes: 'arcane-sidebar-footer',
          styles: Styles(raw: {
            'padding': _isCollapsed ? ArcaneSpacing.sm : '${ArcaneSpacing.sm} ${ArcaneSpacing.sm}',
            'border-top': '1px solid ${ArcaneColors.border}',
            'flex-shrink': '0',
          }),
          [
            if (component.footer != null && !_isCollapsed) component.footer!,
            if (component.showCollapseToggle)
              button(
                classes: 'arcane-sidebar-toggle',
                attributes: {
                  'type': 'button',
                  'aria-label': _isCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
                },
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': _isCollapsed ? '40px' : '100%',
                  'height': '40px',
                  'margin': _isCollapsed ? '0 auto' : '0',
                  'margin-top': component.footer != null && !_isCollapsed ? ArcaneSpacing.sm : '0',
                  'border-radius': ArcaneRadius.md,
                  'background': ArcaneColors.transparent,
                  'border': 'none',
                  'color': ArcaneColors.muted,
                  'cursor': 'pointer',
                  'transition': ArcaneEffects.transitionFast,
                }),
                events: {
                  'click': (event) => _toggleCollapse(),
                },
                [
                  span(
                    styles: Styles(raw: {
                      'transition': 'transform 200ms ease',
                      'transform': component.rightSide
                          ? (_isCollapsed ? 'rotate(180deg)' : 'rotate(0)')
                          : (_isCollapsed ? 'rotate(0)' : 'rotate(180deg)'),
                    }),
                    [text('◀')],
                  ),
                  if (!_isCollapsed)
                    span(
                      styles: Styles(raw: {
                        'margin-left': ArcaneSpacing.sm,
                        'font-size': ArcaneTypography.fontSm,
                      }),
                      [text('Collapse')],
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// A sidebar item group with optional label
class SidebarGroup extends StatelessComponent {
  final String? label;
  final List<Component> children;
  final bool collapsed;

  const SidebarGroup({
    this.label,
    required this.children,
    this.collapsed = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-sidebar-group',
      styles: Styles(raw: {
        'margin-bottom': ArcaneSpacing.md,
      }),
      [
        if (label != null && !collapsed)
          div(
            classes: 'arcane-sidebar-group-label',
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'font-weight': ArcaneTypography.weightSemibold,
              'color': ArcaneColors.muted,
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
              'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.sm}',
            }),
            [text(label!)],
          ),
        div(
          classes: 'arcane-sidebar-group-items',
          styles: Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': ArcaneSpacing.xs,
          }),
          children,
        ),
      ],
    );
  }
}

/// A sidebar navigation item
class SidebarItem extends StatelessComponent {
  final String label;
  final Component? icon;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;
  final String? badge;
  final bool collapsed;

  const SidebarItem({
    required this.label,
    this.icon,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    this.badge,
    this.collapsed = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-sidebar-item ${selected ? 'selected' : ''} ${disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (disabled) 'disabled': 'true',
        if (collapsed) 'title': label,
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': collapsed ? 'center' : 'flex-start',
        'gap': ArcaneSpacing.sm,
        'width': '100%',
        'padding': collapsed ? '10px' : '10px ${ArcaneSpacing.sm}',
        'background-color': selected ? ArcaneColors.accentContainer : ArcaneColors.transparent,
        'color': selected ? ArcaneColors.accent : ArcaneColors.onSurface,
        'border-radius': ArcaneRadius.md,
        'border': 'none',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'text-align': 'left',
        'font-size': ArcaneTypography.fontSm,
        'font-weight': selected ? ArcaneTypography.weightSemibold : ArcaneTypography.weightMedium,
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
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
            }),
            [icon!],
          ),
        if (!collapsed)
          span(
            styles: Styles(raw: {
              'flex': '1',
              'overflow': 'hidden',
              'text-overflow': 'ellipsis',
              'white-space': 'nowrap',
            }),
            [text(label)],
          ),
        if (!collapsed && badge != null)
          span(
            classes: 'arcane-sidebar-item-badge',
            styles: Styles(raw: {
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
    css('.arcane-sidebar-item:hover:not(:disabled):not(.selected)').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}
