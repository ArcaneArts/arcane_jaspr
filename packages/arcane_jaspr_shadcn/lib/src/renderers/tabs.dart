import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/tabs_props.dart';

/// ShadCN Tabs renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/tabs
///
/// ShadCN Tabs:
/// - TabsList: inline-flex h-10 items-center justify-center rounded-md bg-muted p-1 text-muted-foreground
/// - TabsTrigger: inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-sm font-medium
///   - Active: bg-background text-foreground shadow-sm
/// - TabsContent: mt-2 ring-offset-background focus-visible:outline-none focus-visible:ring-2
class ShadcnTabs extends StatelessComponent {
  final TabsProps props;

  const ShadcnTabs(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-tabs',
      styles: const dom.Styles(
        raw: {'display': 'flex', 'flex-direction': 'column', 'width': '100%'},
      ),
      [
        // Tab list - ShadCN: inline-flex h-10 items-center justify-center rounded-md bg-muted p-1
        dom.div(
          classes: 'arcane-tabs-list',
          attributes: {'role': 'tablist'},
          styles: dom.Styles(
            raw: {
              'display': 'inline-flex',
              // ShadCN: h-10
              'height': '40px',
              'align-items': 'center',
              'justify-content': 'center',
              // ShadCN: rounded-md
              'border-radius': 'var(--radius-sm)',
              // ShadCN: bg-muted
              'background-color': 'var(--muted)',
              // ShadCN: p-1
              'padding': '4px',
              // ShadCN: text-muted-foreground
              'color': 'var(--muted-foreground)',
              if (props.fill) 'width': '100%',
              ...?props.decoration?.universalStyles(),
              ...?props.styles?.toMap(),
            },
          ),
          [
            for (var i = 0; i < props.tabs.length; i++)
              _buildTab(i, props.tabs[i]),
          ],
        ),
        // Tab panel - ShadCN: mt-2
        dom.div(
          classes: 'arcane-tabs-panel',
          attributes: {'role': 'tabpanel'},
          styles: const dom.Styles(
            raw: {
              // ShadCN: mt-2
              'margin-top': '8px',
            },
          ),
          [
            if (props.selectedIndex < props.tabs.length)
              props.tabs[props.selectedIndex].content,
          ],
        ),
      ],
    );
  }

  Component _buildTab(int index, TabItemProps tab) {
    final bool isSelected = index == props.selectedIndex;
    final bool isDisabled = tab.disabled;

    return dom.button(
      classes:
          'arcane-tab ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'role': 'tab',
        'aria-selected': '$isSelected',
        if (isDisabled) 'aria-disabled': 'true',
        'data-state': isSelected ? 'active' : 'inactive',
        'data-disabled': '$isDisabled',
      },
      styles: dom.Styles(
        raw: {
          // ShadCN: inline-flex items-center justify-center
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': 'var(--space-2)',
          // ShadCN: whitespace-nowrap
          'white-space': 'nowrap',
          // ShadCN: rounded-sm (4px)
          'border-radius': 'var(--radius-xs)',
          // ShadCN: px-3 py-1.5
          'padding': '6px 12px',
          // ShadCN: text-sm font-medium
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-medium)',
          'border': 'none',
          // ShadCN: data-[state=active]:bg-background data-[state=active]:text-foreground
          'background-color': isSelected ? 'var(--background)' : 'transparent',
          'color': isSelected ? 'var(--foreground)' : 'var(--muted-foreground)',
          // ShadCN: data-[state=active]:shadow-sm
          'box-shadow': isSelected ? '0 1px 2px 0 rgb(0 0 0 / 0.05)' : 'none',
          // ShadCN: transition-all
          'transition': 'all var(--transition)',
          // ShadCN: disabled:pointer-events-none disabled:opacity-50
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'pointer-events': isDisabled ? 'none' : 'auto',
          'opacity': isDisabled ? '0.5' : '1',
          if (props.fill) 'flex': '1',
        },
      ),
      events: {
        'click': (event) {
          if (!isDisabled && props.onChanged != null) {
            props.onChanged!(index);
          }
        },
      },
      [
        if (tab.icon != null) tab.icon!,
        Component.text(tab.label),
        if (tab.badge != null)
          dom.span(
            classes: 'arcane-tab-badge',
            styles: const dom.Styles(
              raw: {
                'background-color': 'var(--primary)',
                'color': 'var(--primary-foreground)',
                'font-size': '0.6875rem',
                'padding': '2px 6px',
                'border-radius': 'var(--radius-full)',
                'font-weight': 'var(--font-weight-medium)',
                'margin-left': '4px',
              },
            ),
            [Component.text(tab.badge!)],
          ),
      ],
    );
  }
}

/// ShadCN TabBar renderer (tabs only, no content panel).
class ShadcnTabBar extends StatelessComponent {
  final TabBarProps props;

  const ShadcnTabBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-tab-bar',
      attributes: {'role': 'tablist'},
      styles: dom.Styles(
        raw: {
          // ShadCN: inline-flex h-10 items-center justify-center rounded-md bg-muted p-1
          'display': 'inline-flex',
          'height': '40px',
          'align-items': 'center',
          'justify-content': 'center',
          'border-radius': 'var(--radius-sm)',
          'background-color': 'var(--muted)',
          'padding': '4px',
          'color': 'var(--muted-foreground)',
          if (props.fill) 'width': '100%',
        },
      ),
      [for (var i = 0; i < props.tabs.length; i++) _buildTab(i, props.tabs[i])],
    );
  }

  Component _buildTab(int index, TabBarItemProps tab) {
    final bool isSelected = index == props.selectedIndex;

    return dom.button(
      classes: 'arcane-tab-bar-item ${isSelected ? 'selected' : ''}',
      attributes: {
        'type': 'button',
        'data-state': isSelected ? 'active' : 'inactive',
      },
      styles: dom.Styles(
        raw: {
          // ShadCN: inline-flex items-center justify-center whitespace-nowrap
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': 'var(--space-2)',
          'white-space': 'nowrap',
          // ShadCN: rounded-sm (4px)
          'border-radius': 'var(--radius-xs)',
          // ShadCN: px-3 py-1.5
          'padding': '6px 12px',
          // ShadCN: text-sm font-medium
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-medium)',
          'border': 'none',
          // ShadCN: data-[state=active]:bg-background data-[state=active]:text-foreground
          'background-color': isSelected ? 'var(--background)' : 'transparent',
          'color': isSelected ? 'var(--foreground)' : 'var(--muted-foreground)',
          // ShadCN: data-[state=active]:shadow-sm
          'box-shadow': isSelected ? '0 1px 2px 0 rgb(0 0 0 / 0.05)' : 'none',
          // ShadCN: transition-all
          'transition': 'all var(--transition)',
          'cursor': 'pointer',
          if (props.fill) 'flex': '1',
        },
      ),
      events: {'click': (event) => props.onChanged(index)},
      [if (tab.icon != null) tab.icon!, Component.text(tab.label)],
    );
  }
}
