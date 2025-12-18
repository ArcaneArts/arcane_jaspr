import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

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
    final theme = ArcaneTheme.of(context);

    return div(
      classes: 'arcane-tabs',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'width': '100%',
      }),
      [
        // Tab list
        div(
          classes: 'arcane-tabs-list',
          attributes: {'role': 'tablist'},
          styles: Styles(raw: {
            'display': 'flex',
            'border-bottom': '1px solid var(--arcane-outline-variant)',
            'gap': '4px',
          }),
          [
            for (var i = 0; i < component.tabs.length; i++)
              _buildTab(context, theme, i, component.tabs[i]),
          ],
        ),
        // Tab panel
        div(
          classes: 'arcane-tabs-panel',
          attributes: {'role': 'tabpanel'},
          styles: Styles(raw: {
            'padding-top': '16px',
          }),
          [
            if (_selectedIndex < component.tabs.length)
              component.tabs[_selectedIndex].content,
          ],
        ),
      ],
    );
  }

  Component _buildTab(
      BuildContext context, ArcaneTheme theme, int index, ArcaneTabItem tab) {
    final isSelected = index == _selectedIndex;
    final isDisabled = tab.disabled;

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
        'gap': '8px',
        'padding': '10px 16px',
        'font-size': '0.875rem',
        'font-weight': isSelected ? '600' : '500',
        'color': isSelected
            ? 'var(--arcane-primary)'
            : 'var(--arcane-on-surface-variant)',
        'background': 'transparent',
        'border': 'none',
        'border-bottom': isSelected
            ? '2px solid var(--arcane-primary)'
            : '2px solid transparent',
        'margin-bottom': '-1px',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
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
            styles: Styles(raw: {
              'background-color': 'var(--arcane-primary)',
              'color': 'var(--arcane-on-primary)',
              'font-size': '0.75rem',
              'padding': '2px 6px',
              'border-radius': '9999px',
              'font-weight': '500',
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
class TabBar extends StatelessComponent {
  final List<TabBarItem> tabs;
  final int selectedIndex;
  final void Function(int index) onChanged;
  final bool fill;

  const TabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.fill = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return div(
      classes: 'arcane-tab-bar',
      attributes: {'role': 'tablist'},
      styles: Styles(raw: {
        'display': 'flex',
        'border-bottom': '1px solid var(--arcane-outline-variant)',
      }),
      [
        for (var i = 0; i < tabs.length; i++)
          _buildTab(context, theme, i, tabs[i]),
      ],
    );
  }

  Component _buildTab(
      BuildContext context, ArcaneTheme theme, int index, TabBarItem tab) {
    final isSelected = index == selectedIndex;

    return button(
      classes: 'arcane-tab-bar-item ${isSelected ? 'selected' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '8px',
        'padding': '10px 16px',
        'font-size': '0.875rem',
        'font-weight': isSelected ? '600' : '500',
        'color': isSelected
            ? 'var(--arcane-primary)'
            : 'var(--arcane-on-surface-variant)',
        'background': 'transparent',
        'border-bottom': isSelected
            ? '2px solid var(--arcane-primary)'
            : '2px solid transparent',
        'margin-bottom': '-1px',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
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
class TabBarItem {
  final String label;
  final Component? icon;

  const TabBarItem({
    required this.label,
    this.icon,
  });
}
