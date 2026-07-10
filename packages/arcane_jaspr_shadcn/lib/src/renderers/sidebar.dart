import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/sidebar_props.dart';
import 'package:arcane_jaspr/core/rendering/base/sidebar_render_base.dart';

/// ShadCN-style sidebar component
/// Reference: https://ui.shadcn.com/docs/components/sidebar
class ShadcnSidebar extends StatelessComponent {
  final SidebarProps props;

  const ShadcnSidebar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double currentWidth = props.isCollapsed
        ? props.collapsedWidth
        : props.width;

    // ShadCN Sidebar: flex h-full w-[--sidebar-width] flex-col bg-sidebar
    return dom.aside(
      classes:
          'arcane-sidebar ${props.isCollapsed ? 'collapsed' : ''} ${props.rightSide ? 'right' : 'left'}',
      attributes: {'data-state': props.isCollapsed ? 'collapsed' : 'expanded'},
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'width': '${currentWidth}px',
          'height': '100%',
          'background-color': 'var(--background)',
          'border-${props.rightSide ? 'left' : 'right'}':
              '1px solid var(--border)',
          'transition': 'width var(--transition-slow)',
          'flex-shrink': '0',
          'overflow': 'hidden',
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      [
        // ShadCN SidebarHeader
        if (props.header != null)
          dom.div(classes: 'sidebar-header', [props.header!]),

        // ShadCN SidebarContent with nav wrapper
        dom.nav(
          classes: 'sidebar-nav',
          styles: const dom.Styles(
            raw: {
              'flex': '1',
              'min-height': '0',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.5rem',
              'overflow-y': 'auto',
              'overflow-x': 'hidden',
              'padding': '0.75rem',
            },
          ),
          props.children,
        ),

        // ShadCN SidebarFooter
        dom.div(
          classes: 'arcane-sidebar-footer',
          styles: const dom.Styles(
            raw: {
              'padding': '8px',
              'border-top': '1px solid var(--border)',
              'flex-shrink': '0',
            },
          ),
          [
            if (props.footer != null && !props.isCollapsed) props.footer!,
            if (props.showCollapseToggle)
              dom.button(
                classes: 'arcane-sidebar-toggle',
                attributes: {
                  'type': 'button',
                  'aria-label': props.isCollapsed
                      ? 'Expand sidebar'
                      : 'Collapse sidebar',
                  'data-state': props.isCollapsed ? 'collapsed' : 'expanded',
                },
                styles: dom.Styles(
                  raw: {
                    'display': 'inline-flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'width': props.isCollapsed ? '32px' : '100%',
                    'height': '32px',
                    'margin': props.isCollapsed ? '0 auto' : '0',
                    'margin-top': props.footer != null && !props.isCollapsed
                        ? '8px'
                        : '0',
                    'border-radius': 'var(--radius-sm)',
                    'background': 'transparent',
                    'border': 'none',
                    'color': 'var(--muted-foreground)',
                    'cursor': 'pointer',
                    'transition':
                        'color var(--transition), background-color var(--transition)',
                    'font-size': 'var(--font-size-sm)',
                  },
                ),
                events: props.onToggleCollapse != null
                    ? {'click': (_) => props.onToggleCollapse!()}
                    : null,
                [
                  dom.span(
                    styles: dom.Styles(
                      raw: {
                        'transition': 'transform var(--transition-slow)',
                        'transform': props.rightSide
                            ? (props.isCollapsed
                                  ? 'rotate(180deg)'
                                  : 'rotate(0)')
                            : (props.isCollapsed
                                  ? 'rotate(0)'
                                  : 'rotate(180deg)'),
                      },
                    ),
                    [ArcaneIcon.chevronLeft(size: IconSize.sm)],
                  ),
                  if (!props.isCollapsed)
                    const dom.span(
                      styles: dom.Styles(
                        raw: {
                          'margin-left': '8px',
                          'font-size': 'var(--font-size-sm)',
                        },
                      ),
                      [Component.text('Collapse')],
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// ShadCN-style sidebar item using codex structure
/// Renders as: `<div class="sidebar-tree-item"><a class="sidebar-link">...</a></div>`
class ShadcnSidebarItem extends SidebarItemRenderBase {
  const ShadcnSidebarItem(super.props, {super.key});
}

/// ShadCN-style sidebar group
class ShadcnSidebarGroup extends StatelessComponent {
  final SidebarGroupProps props;

  const ShadcnSidebarGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // ShadCN SidebarGroup
    return dom.div(
      classes: 'arcane-sidebar-group',
      styles: const dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'width': '100%',
          'min-width': '0',
          'flex-direction': 'column',
          'padding': '8px',
        },
      ),
      [
        // ShadCN SidebarGroupLabel
        if (props.label != null && !props.collapsed)
          dom.div(
            classes: 'arcane-sidebar-group-label',
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'height': '32px',
                'flex-shrink': '0',
                'align-items': 'center',
                'border-radius': 'var(--radius-sm)',
                'padding': '0 8px',
                'font-size': 'var(--font-size-xs)',
                'font-weight': 'var(--font-weight-medium)',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(props.label!)],
          ),
        // ShadCN SidebarGroupContent
        dom.div(
          classes: 'arcane-sidebar-group-items',
          styles: const dom.Styles(
            raw: {
              'width': '100%',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': 'var(--space-1)',
              'font-size': 'var(--font-size-sm)',
            },
          ),
          props.children,
        ),
      ],
    );
  }
}

/// ShadCN-style sidebar submenu using native details/summary
/// Renders as: `<div class="sidebar-section"><details class="sidebar-details">...</details></div>`
class ShadcnSidebarSubMenu extends SidebarSubMenuRenderBase {
  const ShadcnSidebarSubMenu(super.props, {super.key});
}

/// ShadCN-style sidebar section (fixed, non-collapsible)
/// Renders as: `<div class="sidebar-section"><div class="sidebar-section-header">...</div><div class="sidebar-tree">...</div></div>`
class ShadcnSidebarSection extends SidebarSectionRenderBase {
  const ShadcnSidebarSection(super.props, {super.key});
}

/// Content only visible when sidebar is expanded
class ShadcnSidebarExpanded extends StatelessComponent {
  final List<Component> children;

  const ShadcnSidebarExpanded(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    // The visibility is controlled by CSS class on parent
    return dom.div(
      classes: 'arcane-sidebar-expanded-only',
      styles: const dom.Styles(
        raw: {'display': 'var(--sidebar-expanded-display, block)'},
      ),
      children,
    );
  }
}

/// Content only visible when sidebar is collapsed
class ShadcnSidebarCollapsed extends StatelessComponent {
  final List<Component> children;

  const ShadcnSidebarCollapsed(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    // The visibility is controlled by CSS class on parent
    return dom.div(
      classes: 'arcane-sidebar-collapsed-only',
      styles: const dom.Styles(
        raw: {'display': 'var(--sidebar-collapsed-display, none)'},
      ),
      children,
    );
  }
}

/// Sidebar separator
class ShadcnSidebarSeparator extends SidebarSeparatorRenderBase {
  const ShadcnSidebarSeparator({super.key});

  @override
  String get cssClass => 'arcane-sidebar-separator';

  @override
  Map<String, String> get separatorStyles => const <String, String>{
    'height': '1px',
    'background-color': 'var(--border)',
    'margin': '8px 0',
  };
}
