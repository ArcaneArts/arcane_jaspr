import 'package:arcane_jaspr/flutter.dart';

/// Tab item data.
class TabItemProps {
  final String label;
  final Widget content;
  final Widget? icon;
  final String? badge;
  final bool disabled;

  const TabItemProps({
    required this.label,
    required this.content,
    this.icon,
    this.badge,
    this.disabled = false,
  });
}

/// Tab bar item data.
class TabBarItemProps {
  final String label;
  final Widget? icon;

  const TabBarItemProps({
    required this.label,
    this.icon,
  });
}

/// Tabs component properties.
class TabsProps {
  final List<TabItemProps> tabs;
  final int selectedIndex;
  final void Function(int index)? onChanged;
  final bool fill;

  const TabsProps({
    required this.tabs,
    required this.selectedIndex,
    this.onChanged,
    this.fill = false,
  });

  TabsProps copyWith({
    List<TabItemProps>? tabs,
    int? selectedIndex,
    void Function(int index)? onChanged,
    bool? fill,
  }) {
    return TabsProps(
      tabs: tabs ?? this.tabs,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      onChanged: onChanged ?? this.onChanged,
      fill: fill ?? this.fill,
    );
  }
}

/// Tab bar component properties.
class TabBarProps {
  final List<TabBarItemProps> tabs;
  final int selectedIndex;
  final void Function(int index) onChanged;
  final bool fill;

  const TabBarProps({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.fill = false,
  });

  TabBarProps copyWith({
    List<TabBarItemProps>? tabs,
    int? selectedIndex,
    void Function(int index)? onChanged,
    bool? fill,
  }) {
    return TabBarProps(
      tabs: tabs ?? this.tabs,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      onChanged: onChanged ?? this.onChanged,
      fill: fill ?? this.fill,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for tab components.
mixin TabsRendererContract {
  /// Renders a tabbed interface with content panels.
  Widget tabs(TabsProps props);

  /// Renders a standalone tab bar without content panels.
  Widget tabBar(TabBarProps props);
}
