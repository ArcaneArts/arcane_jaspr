import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Tab item data
class TabItem {
  /// Unique identifier
  final String id;

  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Whether tab is disabled
  final bool disabled;

  /// Badge/count to display
  final String? badge;

  const TabItem({
    required this.id,
    required this.label,
    this.icon,
    this.disabled = false,
    this.badge,
  });
}

/// Tab bar style variants
enum TabsStyle {
  /// Underline indicator style
  underline,

  /// Pill/button style
  pills,

  /// Segmented control style
  segmented,

  /// Boxed/card style
  boxed,
}

/// Tab bar size variants
enum TabsSize {
  sm,
  md,
  lg,
}

/// Simple inline tab bar component
///
/// For switching between different views/content panels.
///
/// ```dart
/// ArcaneTabs(
///   tabs: [
///     TabItem(id: 'overview', label: 'Overview'),
///     TabItem(id: 'settings', label: 'Settings'),
///     TabItem(id: 'logs', label: 'Logs', badge: '3'),
///   ],
///   activeTab: 'overview',
///   onTabChange: (id) => print('Selected: $id'),
/// )
/// ```
class ArcaneTabs extends StatelessComponent {
  /// List of tab items
  final List<TabItem> tabs;

  /// Currently active tab ID
  final String activeTab;

  /// Callback when tab changes
  final void Function(String tabId)? onTabChange;

  /// Style variant
  final TabsStyle style;

  /// Size variant
  final TabsSize size;

  /// Whether tabs should fill available width
  final bool fullWidth;

  /// Custom content for each tab (keyed by tab ID)
  final Map<String, Component>? content;

  const ArcaneTabs({
    required this.tabs,
    required this.activeTab,
    this.onTabChange,
    this.style = TabsStyle.underline,
    this.size = TabsSize.md,
    this.fullWidth = false,
    this.content,
    super.key,
  });

  /// Underline tabs
  const ArcaneTabs.underline({
    required this.tabs,
    required this.activeTab,
    this.onTabChange,
    this.size = TabsSize.md,
    this.fullWidth = false,
    this.content,
    super.key,
  }) : style = TabsStyle.underline;

  /// Pill tabs
  const ArcaneTabs.pills({
    required this.tabs,
    required this.activeTab,
    this.onTabChange,
    this.size = TabsSize.md,
    this.fullWidth = false,
    this.content,
    super.key,
  }) : style = TabsStyle.pills;

  /// Segmented tabs
  const ArcaneTabs.segmented({
    required this.tabs,
    required this.activeTab,
    this.onTabChange,
    this.size = TabsSize.md,
    this.fullWidth = false,
    this.content,
    super.key,
  }) : style = TabsStyle.segmented;

  (String padding, String fontSize, String gap) get _sizeStyles => switch (size) {
        TabsSize.sm => ('6px 12px', ArcaneTypography.fontXs, ArcaneSpacing.xs),
        TabsSize.md => ('10px 16px', ArcaneTypography.fontSm, ArcaneSpacing.sm),
        TabsSize.lg => ('14px 24px', ArcaneTypography.fontMd, ArcaneSpacing.md),
      };

  @override
  Component build(BuildContext context) {
    final (padding, fontSize, gap) = _sizeStyles;

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.md,
      }),
      [
        // Tab bar
        div(
          attributes: {'role': 'tablist'},
          styles: Styles(raw: {
            'display': 'flex',
            'gap': style == TabsStyle.segmented ? '0' : gap,
            if (style == TabsStyle.underline)
              'border-bottom': '1px solid ${ArcaneColors.border}',
            if (style == TabsStyle.segmented) ...{
              'background': ArcaneColors.surfaceVariant,
              'padding': '4px',
              'border-radius': ArcaneRadius.md,
            },
            if (style == TabsStyle.boxed) ...{
              'background': ArcaneColors.surfaceVariant,
              'padding': '4px',
              'border-radius': ArcaneRadius.md,
            },
          }),
          [
            for (final tab in tabs)
              _buildTab(tab, padding, fontSize),
          ],
        ),

        // Content panel
        if (content != null && content!.containsKey(activeTab))
          div(
            attributes: {
              'role': 'tabpanel',
              'aria-labelledby': 'tab-$activeTab',
            },
            styles: const Styles(raw: {}),
            [content![activeTab]!],
          ),
      ],
    );
  }

  Component _buildTab(TabItem tab, String padding, String fontSize) {
    final isActive = tab.id == activeTab;
    final isDisabled = tab.disabled;

    final tabStyles = switch (style) {
      TabsStyle.underline => {
          'background': 'transparent',
          'border': 'none',
          'border-bottom': isActive
              ? '2px solid ${ArcaneColors.accent}'
              : '2px solid transparent',
          'margin-bottom': '-1px',
          'color': isActive ? ArcaneColors.accent : ArcaneColors.muted,
          'border-radius': '0',
        },
      TabsStyle.pills => {
          'background': isActive ? ArcaneColors.accent : 'transparent',
          'border': 'none',
          'color': isActive ? ArcaneColors.onSurface : ArcaneColors.muted,
          'border-radius': ArcaneRadius.full,
        },
      TabsStyle.segmented => {
          'background': isActive ? ArcaneColors.surface : 'transparent',
          'border': 'none',
          'color': isActive ? ArcaneColors.onSurface : ArcaneColors.muted,
          'border-radius': ArcaneRadius.sm,
          if (isActive) 'box-shadow': ArcaneEffects.shadowSm,
        },
      TabsStyle.boxed => {
          'background': isActive ? ArcaneColors.surface : 'transparent',
          'border': isActive
              ? '1px solid ${ArcaneColors.border}'
              : '1px solid transparent',
          'color': isActive ? ArcaneColors.onSurface : ArcaneColors.muted,
          'border-radius': ArcaneRadius.sm,
        },
    };

    return button(
      type: ButtonType.button,
      attributes: {
        'role': 'tab',
        'id': 'tab-${tab.id}',
        'aria-selected': isActive ? 'true' : 'false',
        if (isDisabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': ArcaneSpacing.xs,
        'padding': padding,
        'font-size': fontSize,
        'font-weight': isActive
            ? ArcaneTypography.weightMedium
            : ArcaneTypography.weightNormal,
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'white-space': 'nowrap',
        if (fullWidth) 'flex': '1',
        ...tabStyles,
      }),
      events: isDisabled
          ? null
          : {
              'click': (_) => onTabChange?.call(tab.id),
            },
      [
        if (tab.icon != null) tab.icon!,
        text(tab.label),
        if (tab.badge != null)
          span(
            styles: const Styles(raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
              'min-width': '18px',
              'height': '18px',
              'padding': '0 6px',
              'background': ArcaneColors.accent,
              'color': ArcaneColors.onSurface,
              'font-size': ArcaneTypography.fontXs,
              'font-weight': ArcaneTypography.weightMedium,
              'border-radius': ArcaneRadius.full,
            }),
            [text(tab.badge!)],
          ),
      ],
    );
  }
}