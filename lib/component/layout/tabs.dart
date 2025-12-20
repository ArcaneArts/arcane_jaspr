import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';

/// A tab component for switching between views.
class ArcaneTabs extends StatefulComponent {
  /// The tab items
  final List<ArcaneTabItem> tabs;

  /// The initial selected index
  final int initialIndex;

  /// Callback when tab changes
  final void Function(int index)? onChanged;

  /// Whether to fill available width
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
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-tabs',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'width': '100%',
      }),
      [
        // Tab list
        div(
          classes: 'arcane-tabs-list',
          attributes: {'role': 'tablist'},
          styles: const Styles(raw: {
            'display': 'flex',
            'border-bottom': '1px solid ${ArcaneColors.border}',
            'gap': ArcaneSpacing.xs,
          }),
          [
            for (var i = 0; i < component.tabs.length; i++)
              _buildTab(context, i, component.tabs[i]),
          ],
        ),
        // Tab panel
        div(
          classes: 'arcane-tabs-panel',
          attributes: {'role': 'tabpanel'},
          styles: const Styles(raw: {
            'padding-top': ArcaneSpacing.md,
          }),
          [
            if (_selectedIndex < component.tabs.length)
              component.tabs[_selectedIndex].content,
          ],
        ),
      ],
    );
  }

  Component _buildTab(BuildContext context, int index, ArcaneTabItem tab) {
    final bool isSelected = index == _selectedIndex;
    final bool isDisabled = tab.disabled;

    return button(
      classes: 'arcane-tab ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'role': 'tab',
        'aria-selected': '$isSelected',
        if (isDisabled) 'aria-disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': '10px ${ArcaneSpacing.md}',
        'font-size': ArcaneTypography.fontSm,
        'font-weight': isSelected ? ArcaneTypography.weightSemibold : ArcaneTypography.weightMedium,
        'color': isSelected ? ArcaneColors.accent : ArcaneColors.muted,
        'background': ArcaneColors.transparent,
        'border': 'none',
        'border-bottom': isSelected
            ? '2px solid ${ArcaneColors.accent}'
            : '2px solid ${ArcaneColors.transparent}',
        'margin-bottom': '-1px',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        if (component.fill) 'flex': '1',
        if (component.fill) 'justify-content': 'center',
      }),
      events: {
        'click': (event) {
          if (!isDisabled) {
            _selectTab(index);
          }
        },
      },
      [
        if (tab.icon != null) tab.icon!,
        Component.text(tab.label),
        if (tab.badge != null)
          span(
            classes: 'arcane-tab-badge',
            styles: const Styles(raw: {
              'background-color': ArcaneColors.accent,
              'color': ArcaneColors.accentForeground,
              'font-size': ArcaneTypography.fontXs,
              'padding': '2px 6px',
              'border-radius': ArcaneRadius.full,
              'font-weight': ArcaneTypography.weightMedium,
            }),
            [Component.text(tab.badge!)],
          ),
      ],
    );
  }
}

/// A tab item for ArcaneTabs
class ArcaneTabItem {
  final String label;
  final Component content;
  final Component? icon;
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

/// A simple tab bar without content (for custom tab handling)
class ArcaneTabBar extends StatelessComponent {
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
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-tab-bar',
      attributes: {'role': 'tablist'},
      styles: const Styles(raw: {
        'display': 'flex',
        'border-bottom': '1px solid ${ArcaneColors.border}',
      }),
      [
        for (var i = 0; i < tabs.length; i++)
          _buildTab(context, i, tabs[i]),
      ],
    );
  }

  Component _buildTab(BuildContext context, int index, ArcaneTabBarItem tab) {
    final bool isSelected = index == selectedIndex;

    return button(
      classes: 'arcane-tab-bar-item ${isSelected ? 'selected' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': '10px ${ArcaneSpacing.md}',
        'font-size': ArcaneTypography.fontSm,
        'font-weight': isSelected ? ArcaneTypography.weightSemibold : ArcaneTypography.weightMedium,
        'color': isSelected ? ArcaneColors.accent : ArcaneColors.muted,
        'background': ArcaneColors.transparent,
        'border': 'none',
        'border-bottom': isSelected
            ? '2px solid ${ArcaneColors.accent}'
            : '2px solid ${ArcaneColors.transparent}',
        'margin-bottom': '-1px',
        'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
        if (fill) 'flex': '1',
        if (fill) 'justify-content': 'center',
      }),
      events: {
        'click': (event) => onChanged(index),
      },
      [
        if (tab.icon != null) tab.icon!,
        Component.text(tab.label),
      ],
    );
  }
}

/// A tab bar item
class ArcaneTabBarItem {
  final String label;
  final Component? icon;

  const ArcaneTabBarItem({
    required this.label,
    this.icon,
  });
}