import 'package:arcane_jaspr/core/rendering/base/sidebar_render_base.dart';

class NeubrutalismSidebar extends SidebarRenderBase {
  const NeubrutalismSidebar(super.props, {super.key});

  @override
  String get sidebarBaseClass => 'neubrutalism-sidebar';

  @override
  String get footerClass => 'neubrutalism-sidebar-footer';

  @override
  String get collapseButtonClass =>
      'neubrutalism-button neubrutalism-sidebar-collapse';
}

class NeubrutalismSidebarItem extends SidebarItemRenderBase {
  const NeubrutalismSidebarItem(super.props, {super.key});
}

class NeubrutalismSidebarGroup extends SidebarGroupRenderBase {
  const NeubrutalismSidebarGroup(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-sidebar-group';

  @override
  String get labelClass => 'neubrutalism-sidebar-group-label';

  @override
  Map<String, String> get labelStyles => const <String, String>{
    'padding': '0.375rem 1rem 0.375rem 1.25rem',
    'font-size': '0.6875rem',
    'font-weight': '600',
    'text-transform': 'uppercase',
    'letter-spacing': '0.12em',
    'color': 'var(--nb-accent, var(--primary))',
    'opacity': '0.78',
    'font-family': 'var(--font-heading)',
  };
}

class NeubrutalismSidebarSubMenu extends SidebarSubMenuRenderBase {
  const NeubrutalismSidebarSubMenu(super.props, {super.key});
}

class NeubrutalismSidebarSection extends SidebarSectionRenderBase {
  const NeubrutalismSidebarSection(super.props, {super.key});
}

class NeubrutalismSidebarSeparator extends SidebarSeparatorRenderBase {
  const NeubrutalismSidebarSeparator({super.key});

  @override
  String get cssClass => 'neubrutalism-sidebar-separator';

  @override
  Map<String, String> get separatorStyles => const <String, String>{
    'height': '0',
    'border-top': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
    'margin': '0.875rem 0',
  };
}
