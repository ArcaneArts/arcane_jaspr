import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';

/// A data table component for displaying tabular data.
class DataTable<T> extends StatefulComponent {
  /// The data items to display
  final List<T> items;

  /// Column definitions
  final List<DataColumn<T>> columns;

  /// Callback when a row is clicked
  final void Function(T item)? onRowTap;

  /// Whether rows are selectable
  final bool selectable;

  /// Currently selected items
  final Set<T>? selectedItems;

  /// Callback when selection changes
  final void Function(Set<T> selected)? onSelectionChanged;

  /// Whether to show row dividers
  final bool showDividers;

  /// Whether to show the header
  final bool showHeader;

  /// Fixed header
  final bool stickyHeader;

  /// Empty state message
  final String emptyMessage;

  const DataTable({
    required this.items,
    required this.columns,
    this.onRowTap,
    this.selectable = false,
    this.selectedItems,
    this.onSelectionChanged,
    this.showDividers = true,
    this.showHeader = true,
    this.stickyHeader = false,
    this.emptyMessage = 'No data available',
    super.key,
  });

  @override
  State<DataTable<T>> createState() => _DataTableState<T>();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-data-table-row.clickable:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-data-table-row.selected.clickable:hover').styles(raw: {
      'background-color': ArcaneColors.accentContainer,
    }),
  ];
}

class _DataTableState<T> extends State<DataTable<T>> {
  late Set<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = component.selectedItems ?? {};
  }

  @override
  void didUpdateComponent(DataTable<T> oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.selectedItems != null) {
      _selectedItems = component.selectedItems!;
    }
  }

  void _toggleSelection(T item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
    component.onSelectionChanged?.call(Set.from(_selectedItems));
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectedItems.length == component.items.length) {
        _selectedItems.clear();
      } else {
        _selectedItems = Set.from(component.items);
      }
    });
    component.onSelectionChanged?.call(Set.from(_selectedItems));
  }

  @override
  Component build(BuildContext context) {
    if (component.items.isEmpty) {
      return div(
        classes: 'arcane-data-table-empty',
        styles: const Styles(raw: {
          'padding': '${ArcaneSpacing.massive} ${ArcaneSpacing.xl}',
          'text-align': 'center',
          'color': ArcaneColors.muted,
        }),
        [text(component.emptyMessage)],
      );
    }

    return div(
      classes: 'arcane-data-table-container',
      styles: const Styles(raw: {
        'overflow-x': 'auto',
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
      }),
      [
        table(
          classes: 'arcane-data-table',
          styles: const Styles(raw: {
            'width': '100%',
            'border-collapse': 'collapse',
            'font-size': ArcaneTypography.fontSm,
          }),
          [
            // Header
            if (component.showHeader)
              thead(
                classes: 'arcane-data-table-header',
                styles: Styles(raw: {
                  'background-color': ArcaneColors.surfaceVariant,
                  if (component.stickyHeader) 'position': 'sticky',
                  if (component.stickyHeader) 'top': '0',
                  if (component.stickyHeader) 'z-index': '1',
                }),
                [
                  tr([
                    if (component.selectable)
                      th(
                        styles: const Styles(raw: {
                          'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
                          'text-align': 'center',
                          'width': '48px',
                        }),
                        [
                          input(
                            type: InputType.checkbox,
                            attributes: {
                              if (_selectedItems.length ==
                                  component.items.length)
                                'checked': 'true',
                            },
                            events: {
                              'change': (event) => _toggleSelectAll(),
                            },
                          ),
                        ],
                      ),
                    for (final column in component.columns)
                      th(
                        styles: Styles(raw: {
                          'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
                          'text-align': column.align.css,
                          'font-weight': ArcaneTypography.weightSemibold,
                          'color': ArcaneColors.onSurface,
                          'white-space': 'nowrap',
                          if (column.width != null)
                            'width': '${column.width}px',
                        }),
                        [text(column.header)],
                      ),
                  ]),
                ],
              ),

            // Body
            tbody(
              classes: 'arcane-data-table-body',
              [
                for (var i = 0; i < component.items.length; i++)
                  _buildRow(context, i, component.items[i]),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildRow(BuildContext context, int index, T item) {
    final bool isSelected = _selectedItems.contains(item);
    final bool isClickable = component.onRowTap != null;

    return tr(
      classes: 'arcane-data-table-row ${isSelected ? 'selected' : ''} ${isClickable ? 'clickable' : ''}',
      styles: Styles(raw: {
        'background-color': isSelected
            ? ArcaneColors.accentContainer
            : ArcaneColors.surface,
        if (component.showDividers)
          'border-bottom': '1px solid ${ArcaneColors.border}',
        if (isClickable) 'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
      }),
      events: isClickable
          ? {
              'click': (event) => component.onRowTap!(item),
            }
          : null,
      [
        if (component.selectable)
          td(
            styles: const Styles(raw: {
              'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
              'text-align': 'center',
            }),
            [
              input(
                type: InputType.checkbox,
                attributes: {
                  if (isSelected) 'checked': 'true',
                },
                events: {
                  'change': (event) {
                    event.stopPropagation();
                    _toggleSelection(item);
                  },
                  'click': (event) => event.stopPropagation(),
                },
              ),
            ],
          ),
        for (final column in component.columns)
          td(
            styles: Styles(raw: {
              'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
              'text-align': column.align.css,
              'color': isSelected
                  ? ArcaneColors.accent
                  : ArcaneColors.onSurface,
            }),
            [column.builder(item)],
          ),
      ],
    );
  }
}

/// A column definition for DataTable
class DataColumn<T> {
  final String header;
  final Component Function(T item) builder;
  final TextAlign align;
  final double? width;
  final bool sortable;

  const DataColumn({
    required this.header,
    required this.builder,
    this.align = TextAlign.left,
    this.width,
    this.sortable = false,
  });
}