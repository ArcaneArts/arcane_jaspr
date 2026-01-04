import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// A command palette for quick actions and navigation.
///
/// Similar to VS Code's Command Palette or Spotlight.
///
/// Example:
/// ```dart
/// ArcaneCommand(
///   isOpen: showCommand,
///   onClose: () => setState(() => showCommand = false),
///   groups: [
///     CommandGroup(
///       heading: 'Actions',
///       items: [
///         CommandItem(
///           icon: span([Component.text('📝')]),
///           label: 'New Document',
///           shortcut: '⌘N',
///           onSelect: () => createDoc(),
///         ),
///         CommandItem(
///           icon: span([Component.text('🔍')]),
///           label: 'Search',
///           shortcut: '⌘K',
///           onSelect: () => openSearch(),
///         ),
///       ],
///     ),
///   ],
/// )
/// ```
class ArcaneCommand extends StatefulComponent {
  /// Whether the command palette is open
  final bool isOpen;

  /// Called when palette should close
  final void Function()? onClose;

  /// Command groups to display
  final List<CommandGroup> groups;

  /// Placeholder for the search input
  final String placeholder;

  /// Empty state message
  final String emptyMessage;

  /// Called when search value changes
  final void Function(String)? onSearch;

  /// Custom filter function
  final bool Function(CommandItem, String)? filterFn;

  const ArcaneCommand({
    required this.groups,
    this.isOpen = false,
    this.onClose,
    this.placeholder = 'Type a command or search...',
    this.emptyMessage = 'No results found.',
    this.onSearch,
    this.filterFn,
    super.key,
  });

  @override
  State<ArcaneCommand> createState() => _ArcaneCommandState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-command-input:focus').styles(raw: {
      'outline': 'none',
    }),
    css('.arcane-command-item:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-command-item.selected').styles(raw: {
      'background-color': ArcaneColors.accentContainer,
    }),
    css('.arcane-command-item:focus').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
      'outline': 'none',
    }),
  ];
}

class _ArcaneCommandState extends State<ArcaneCommand> {
  String _searchQuery = '';

  List<CommandItem> get _allItems {
    return component.groups.expand((g) => g.items).toList();
  }

  List<CommandItem> get _filteredItems {
    if (_searchQuery.isEmpty) return _allItems;

    final query = _searchQuery.toLowerCase();
    return _allItems.where((item) {
      if (component.filterFn != null) {
        return component.filterFn!(item, _searchQuery);
      }
      return item.label.toLowerCase().contains(query) ||
          (item.keywords?.any((k) => k.toLowerCase().contains(query)) ?? false);
    }).toList();
  }

  void _handleSearch(String value) {
    setState(() {
      _searchQuery = value;
    });
    component.onSearch?.call(value);
  }

  void _selectItem(CommandItem item) {
    if (item.disabled) return;
    item.onSelect?.call();
    component.onClose?.call();
  }

  @override
  Component build(BuildContext context) {
    if (!component.isOpen) {
      return const div([], styles: Styles(raw: {'display': 'none'}));
    }

    final items = _filteredItems;

    return div(
      classes: 'arcane-command-overlay',
      attributes: {
        'data-command': 'true',
      },
      styles: const Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '9999',
        'display': 'flex',
        'align-items': 'flex-start',
        'justify-content': 'center',
        'padding-top': '20vh',
        'background-color': 'rgba(0, 0, 0, 0.5)',
      }),
      events: {
        'click': (e) {
          // Close when clicking overlay
          final target = e.target as dynamic;
          if (target.classList.contains('arcane-command-overlay')) {
            component.onClose?.call();
          }
        },
      },
      [
        div(
          classes: 'arcane-command-dialog',
          attributes: {
            'role': 'dialog',
            'aria-modal': 'true',
            'aria-label': 'Command palette',
          },
          styles: const Styles(raw: {
            'width': '100%',
            'max-width': '640px',
            'background-color': ArcaneColors.surface,
            'border': '1px solid ${ArcaneColors.border}',
            'border-radius': ArcaneRadius.lg,
            'box-shadow': ArcaneEffects.shadowXl,
            'overflow': 'hidden',
          }),
          [
            // Search input
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': ArcaneSpacing.sm,
                'padding': ArcaneSpacing.md,
                'border-bottom': '1px solid ${ArcaneColors.border}',
              }),
              [
                const span(
                  styles: Styles(raw: {
                    'color': ArcaneColors.muted,
                    'font-size': ArcaneTypography.fontLg,
                  }),
                  [Component.text('🔍')],
                ),
                input(
                  classes: 'arcane-command-input',
                  type: InputType.text,
                  attributes: {
                    'placeholder': component.placeholder,
                    'autofocus': 'true',
                    'autocomplete': 'off',
                    'spellcheck': 'false',
                  },
                  styles: const Styles(raw: {
                    'flex': '1',
                    'background': 'transparent',
                    'border': 'none',
                    'font-size': ArcaneTypography.fontMd,
                    'color': ArcaneColors.onSurface,
                  }),
                  events: {
                    'input': (e) {
                      final target = e.target as dynamic;
                      _handleSearch(target.value as String);
                    },
                  },
                ),
              ],
            ),

            // Results
            div(
              classes: 'arcane-command-list',
              attributes: {
                'role': 'listbox',
              },
              styles: const Styles(raw: {
                'max-height': '400px',
                'overflow-y': 'auto',
                'padding': ArcaneSpacing.sm,
              }),
              [
                if (items.isEmpty)
                  div(
                    styles: const Styles(raw: {
                      'padding': ArcaneSpacing.lg,
                      'text-align': 'center',
                      'color': ArcaneColors.muted,
                      'font-size': ArcaneTypography.fontSm,
                    }),
                    [Component.text(component.emptyMessage)],
                  )
                else if (_searchQuery.isEmpty)
                  // Show groups when not searching
                  for (final group in component.groups) ...[
                    if (group.heading != null)
                      div(
                        styles: const Styles(raw: {
                          'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                          'font-size': ArcaneTypography.fontXs,
                          'font-weight': ArcaneTypography.weightSemibold,
                          'color': ArcaneColors.muted,
                          'text-transform': 'uppercase',
                          'letter-spacing': '0.05em',
                        }),
                        [Component.text(group.heading!)],
                      ),
                    for (final item in group.items) _buildItem(item),
                  ]
                else
                  // Show flat list when searching
                  for (final item in items) _buildItem(item),
              ],
            ),

            // Footer with keyboard hints
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': ArcaneSpacing.md,
                'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                'border-top': '1px solid ${ArcaneColors.border}',
                'font-size': ArcaneTypography.fontXs,
                'color': ArcaneColors.muted,
              }),
              [
                _buildKeyHint('↵', 'Select'),
                _buildKeyHint('↑↓', 'Navigate'),
                _buildKeyHint('esc', 'Close'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildItem(CommandItem item) {
    return div(
      classes: 'arcane-command-item ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'option',
        'aria-selected': 'false',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'border-radius': ArcaneRadius.sm,
        'cursor': item.disabled ? 'not-allowed' : 'pointer',
        'transition': ArcaneEffects.transitionFast,
        if (item.disabled) 'opacity': '0.5',
      }),
      events: {
        'click': (e) => _selectItem(item),
      },
      [
        if (item.icon != null) item.icon!,
        span(
          styles: const Styles(raw: {
            'flex': '1',
            'font-size': ArcaneTypography.fontSm,
            'color': ArcaneColors.onSurface,
          }),
          [Component.text(item.label)],
        ),
        if (item.shortcut != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.muted,
              'padding': '2px ${ArcaneSpacing.xs}',
              'background-color': ArcaneColors.surfaceVariant,
              'border-radius': ArcaneRadius.sm,
              'font-family': ArcaneTypography.fontFamilyMono,
            }),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  Component _buildKeyHint(String key, String label) {
    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
      }),
      [
        span(
          styles: const Styles(raw: {
            'padding': '2px 6px',
            'background-color': ArcaneColors.surfaceVariant,
            'border-radius': ArcaneRadius.sm,
            'font-family': ArcaneTypography.fontFamilyMono,
          }),
          [Component.text(key)],
        ),
        span([Component.text(label)]),
      ],
    );
  }
}

/// A group of related commands
class CommandGroup {
  /// Group heading
  final String? heading;

  /// Items in this group
  final List<CommandItem> items;

  const CommandGroup({
    this.heading,
    required this.items,
  });
}

/// A single command item
class CommandItem {
  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Keyboard shortcut hint
  final String? shortcut;

  /// Called when item is selected
  final void Function()? onSelect;

  /// Whether this item is disabled
  final bool disabled;

  /// Additional search keywords
  final List<String>? keywords;

  const CommandItem({
    required this.label,
    this.icon,
    this.shortcut,
    this.onSelect,
    this.disabled = false,
    this.keywords,
  });
}