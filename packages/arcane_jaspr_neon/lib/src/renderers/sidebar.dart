import 'package:arcane_jaspr/core/rendering/base/sidebar_render_base.dart';

class NeonSidebar extends SidebarRenderBase {
  const NeonSidebar(super.props, {super.key});

  @override
  String get sidebarBaseClass => 'neon-sidebar';

  @override
  String get footerClass => 'neon-sidebar-footer';

  @override
  String get collapseButtonClass => 'neon-button neon-sidebar-collapse';
}

class NeonSidebarItem extends SidebarItemRenderBase {
  const NeonSidebarItem(super.props, {super.key});
}

class NeonSidebarGroup extends SidebarGroupRenderBase {
  const NeonSidebarGroup(super.props, {super.key});

  @override
  String get cssClass => 'neon-sidebar-group';

  @override
  String get labelClass => 'neon-sidebar-group-label';

  @override
  Map<String, String> get labelStyles => const <String, String>{
    'padding': '0.375rem 1rem 0.375rem 1.25rem',
    'font-size': '0.6875rem',
    'font-weight': '600',
    'text-transform': 'uppercase',
    'letter-spacing': '0.12em',
    'color': 'var(--neon-accent)',
    'opacity': '0.78',
    'font-family': 'var(--font-heading)',
  };
}

class NeonSidebarSubMenu extends SidebarSubMenuRenderBase {
  const NeonSidebarSubMenu(super.props, {super.key});
}

class NeonSidebarSection extends SidebarSectionRenderBase {
  const NeonSidebarSection(super.props, {super.key});
}

class NeonSidebarSeparator extends SidebarSeparatorRenderBase {
  const NeonSidebarSeparator({super.key});

  @override
  String get cssClass => 'neon-sidebar-separator';

  @override
  Map<String, String> get separatorStyles => const <String, String>{
    'height': '1px',
    'background':
        'linear-gradient(90deg, transparent, var(--neon-panel-border-hot), transparent)',
    'margin': '0.75rem 0',
  };
}
