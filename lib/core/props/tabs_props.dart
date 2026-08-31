import 'package:arcane_jaspr/flutter.dart';
import '../../component/view/icon.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

/// Tab item data.
class TabItemProps {
  final String label;
  final Widget content;
  final ArcaneGlyph? icon;
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
  final ArcaneGlyph? icon;

  const TabBarItemProps({required this.label, this.icon});
}

/// Tabs component properties.
class TabsProps {
  final List<TabItemProps> tabs;
  final int selectedIndex;
  final void Function(int index)? onChanged;
  final bool fill;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration.
  final ArcaneDecoration? decoration;

  const TabsProps({
    required this.tabs,
    required this.selectedIndex,
    this.onChanged,
    this.fill = false,
    this.styles,
    this.decoration,
  });

  TabsProps copyWith({
    List<TabItemProps>? tabs,
    int? selectedIndex,
    void Function(int index)? onChanged,
    bool? fill,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return TabsProps(
      tabs: tabs ?? this.tabs,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      onChanged: onChanged ?? this.onChanged,
      fill: fill ?? this.fill,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

/// Tab bar component properties.
class TabBarProps {
  final List<TabBarItemProps> tabs;
  final int selectedIndex;
  final void Function(int index) onChanged;
  final bool fill;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration.
  final ArcaneDecoration? decoration;

  const TabBarProps({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.fill = false,
    this.styles,
    this.decoration,
  });

  TabBarProps copyWith({
    List<TabBarItemProps>? tabs,
    int? selectedIndex,
    void Function(int index)? onChanged,
    bool? fill,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return TabBarProps(
      tabs: tabs ?? this.tabs,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      onChanged: onChanged ?? this.onChanged,
      fill: fill ?? this.fill,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
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
