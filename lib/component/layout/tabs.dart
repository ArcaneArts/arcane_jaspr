import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

/// A tab component for switching between views.
class ArcaneTabs extends StatefulWidget {
  final List<ArcaneTabItem> tabs;
  final int initialIndex;
  final void Function(int index)? onChanged;
  final bool fill;

  const ArcaneTabs({
    required this.tabs,
    this.initialIndex = 0,
    this.onChanged,
    this.fill = false,
    super.key,
  });

  @override
  State<ArcaneTabs> createState() => _ArcaneTabsState();
}

class _ArcaneTabsState extends State<ArcaneTabs> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = component.initialIndex;
  }

  void _selectTab(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      component.onChanged?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<TabItemProps> tabProps = component.tabs
        .map((tab) => TabItemProps(
              label: tab.label,
              content: tab.content,
              icon: tab.icon,
              badge: tab.badge,
              disabled: tab.disabled,
            ))
        .toList();

    return context.renderers.tabs(TabsProps(
      tabs: tabProps,
      selectedIndex: _selectedIndex,
      onChanged: _selectTab,
      fill: component.fill,
    ));
  }
}

/// A tab item for ArcaneTabs.
class ArcaneTabItem {
  final String label;
  final Widget content;
  final Widget? icon;
  final String? badge;
  final bool disabled;

  const ArcaneTabItem({
    required this.label,
    required this.content,
    this.icon,
    this.badge,
    this.disabled = false,
  });
}

/// A simple tab bar without content for custom tab handling.
class ArcaneTabBar extends StatelessWidget {
  final List<ArcaneTabBarItem> tabs;
  final int selectedIndex;
  final void Function(int index) onChanged;
  final bool fill;

  const ArcaneTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.fill = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<TabBarItemProps> tabProps = tabs
        .map((tab) => TabBarItemProps(
              label: tab.label,
              icon: tab.icon,
            ))
        .toList();

    return context.renderers.tabBar(TabBarProps(
      tabs: tabProps,
      selectedIndex: selectedIndex,
      onChanged: onChanged,
      fill: fill,
    ));
  }
}

/// A tab bar item.
class ArcaneTabBarItem {
  final String label;
  final Widget? icon;

  const ArcaneTabBarItem({
    required this.label,
    this.icon,
  });
}
