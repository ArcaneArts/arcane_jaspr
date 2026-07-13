import 'package:arcane_jaspr/core/rendering/base/sidebar_render_base.dart';

class Win95Sidebar extends SidebarRenderBase {
  const Win95Sidebar(super.props, {super.key});

  @override
  String get sidebarBaseClass => 'win95-sidebar';

  @override
  String get footerClass => 'win95-sidebar-footer';

  @override
  String get collapseButtonClass => 'win95-button win95-sidebar-collapse';
}

class Win95SidebarItem extends SidebarItemRenderBase {
  const Win95SidebarItem(super.props, {super.key});
}

class Win95SidebarGroup extends SidebarGroupRenderBase {
  const Win95SidebarGroup(super.props, {super.key});

  @override
  String get cssClass => 'win95-sidebar-group';

  @override
  String get labelClass => 'win95-sidebar-group-label';

  @override
  Map<String, String> get labelStyles => const <String, String>{};
}

class Win95SidebarSubMenu extends SidebarSubMenuRenderBase {
  const Win95SidebarSubMenu(super.props, {super.key});
}

class Win95SidebarSection extends SidebarSectionRenderBase {
  const Win95SidebarSection(super.props, {super.key});
}

class Win95SidebarSeparator extends SidebarSeparatorRenderBase {
  const Win95SidebarSeparator({super.key});

  @override
  String get cssClass => 'win95-sidebar-separator';

  @override
  Map<String, String> get separatorStyles => const <String, String>{};
}
