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
  Map<String, String> get labelStyles => const <String, String>{};
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
  Map<String, String> get separatorStyles => const <String, String>{};
}
