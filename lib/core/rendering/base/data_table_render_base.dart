import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/data_table_props.dart';

/// Shared structural base for themed data-table renderers.
///
/// Every theme renders the same `div > table > (thead > tr > th) + (tbody > tr >
/// td)` scaffold with identical empty-state handling, select-all/row-select
/// checkbox wiring, per-column loops and row click events. The themes diverge
/// only in style values (container, table, header band, header/row cells and
/// the checkbox accent), the empty-state and cell paddings and the optional
/// `tbody` style attribute, which are exposed as abstract members.
///
/// This base lives in core and depends only on core props; it must never depend
/// on a theme package.
abstract class DataTableRenderBase<T> extends StatelessComponent {
  const DataTableRenderBase(this.props, {super.key});

  final DataTableProps<T> props;

  /// Theme class prefix (e.g. `'arcane'`, `'neon'`, `'neubrutalism'`).
  String get classPrefix;

  /// `padding` for the empty-state placeholder.
  String get emptyPadding;

  /// Inline styles for the outer scroll container.
  Map<String, String> get containerStyles;

  /// Inline styles for the `<table>` element.
  Map<String, String> get tableStyles;

  /// Theme-specific (non-sticky) portion of the `<thead>` styles. The shared
  /// sticky-header keys are appended by the base in the original order.
  Map<String, String> theadBaseStyles();

  /// Cell `padding` shared by the select-all header cell, the select cell and
  /// the body cells.
  String get cellPadding;

  /// `width` of the leading select-all column.
  String get selectAllWidth;

  /// Inline styles for the select checkboxes, or `null` for no `style`
  /// attribute (ShadCN omits it).
  Map<String, String>? get checkboxStyles;

  /// Inline styles for a header column cell.
  Map<String, String> headerCellStyles(DataColumnProps<T> column);

  /// Inline styles for a body row (theme-specific key sets).
  Map<String, String> rowStyles(bool isSelected, bool isClickable);

  /// Optional `<tbody>` styles, or `null` for no `style` attribute. ShadCN
  /// passes an empty style map; the other themes omit it.
  Map<String, String>? get bodyStyles;

  @override
  Component build(BuildContext context) {
    if (props.items.isEmpty) {
      return dom.div(
        classes: '$classPrefix-data-table-empty',
        styles: dom.Styles(
          raw: <String, String>{
            'padding': emptyPadding,
            'text-align': 'center',
            'color': 'var(--muted-foreground)',
          },
        ),
        <Component>[Component.text(props.emptyMessage)],
      );
    }

    final Map<String, String>? checkbox = checkboxStyles;
    final Map<String, String>? body = bodyStyles;

    return dom.div(
      classes: '$classPrefix-data-table-container',
      styles: dom.Styles(raw: containerStyles),
      <Component>[
        dom.table(
          classes: '$classPrefix-data-table',
          styles: dom.Styles(raw: tableStyles),
          <Component>[
            // Header
            if (props.showHeader)
              dom.thead(
                classes: '$classPrefix-data-table-header',
                styles: dom.Styles(
                  raw: <String, String>{
                    ...theadBaseStyles(),
                    if (props.stickyHeader) 'position': 'sticky',
                    if (props.stickyHeader) 'top': '0',
                    if (props.stickyHeader) 'z-index': '1',
                  },
                ),
                <Component>[
                  dom.tr(<Component>[
                    if (props.selectable)
                      dom.th(
                        styles: dom.Styles(
                          raw: <String, String>{
                            'padding': cellPadding,
                            'text-align': 'center',
                            'width': selectAllWidth,
                          },
                        ),
                        <Component>[
                          dom.input(
                            type: dom.InputType.checkbox,
                            attributes: <String, String>{
                              if (props.selectedItems.length ==
                                  props.items.length)
                                'checked': 'true',
                            },
                            styles: checkbox == null
                                ? null
                                : dom.Styles(raw: checkbox),
                            events: <String, EventCallback>{
                              if (props.onToggleSelectAll != null)
                                'change': (event) => props.onToggleSelectAll!(),
                            },
                          ),
                        ],
                      ),
                    for (final DataColumnProps<T> column in props.columns)
                      dom.th(
                        styles: dom.Styles(raw: headerCellStyles(column)),
                        <Component>[Component.text(column.header)],
                      ),
                  ]),
                ],
              ),

            // Body
            dom.tbody(
              classes: '$classPrefix-data-table-body',
              styles: body == null ? null : dom.Styles(raw: body),
              <Component>[
                for (int i = 0; i < props.items.length; i++)
                  _buildRow(props.items[i], checkbox),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildRow(T item, Map<String, String>? checkbox) {
    final bool isSelected = props.selectedItems.contains(item);
    final bool isClickable = props.onRowTap != null;

    return dom.tr(
      classes:
          '$classPrefix-data-table-row ${isSelected ? 'selected' : ''} ${isClickable ? 'clickable' : ''}',
      styles: dom.Styles(raw: rowStyles(isSelected, isClickable)),
      events: isClickable
          ? <String, EventCallback>{'click': (event) => props.onRowTap!(item)}
          : null,
      <Component>[
        if (props.selectable)
          dom.td(
            styles: dom.Styles(
              raw: <String, String>{
                'padding': cellPadding,
                'text-align': 'center',
              },
            ),
            <Component>[
              dom.input(
                type: dom.InputType.checkbox,
                attributes: <String, String>{if (isSelected) 'checked': 'true'},
                styles: checkbox == null ? null : dom.Styles(raw: checkbox),
                events: <String, EventCallback>{
                  if (props.onToggleSelection != null)
                    'change': (event) {
                      event.stopPropagation();
                      props.onToggleSelection!(item);
                    },
                  'click': (event) => event.stopPropagation(),
                },
              ),
            ],
          ),
        for (final DataColumnProps<T> column in props.columns)
          dom.td(
            styles: dom.Styles(
              raw: <String, String>{
                'padding': cellPadding,
                'text-align': column.align.css,
                'color': 'var(--foreground)',
              },
            ),
            <Component>[column.builder(item)],
          ),
      ],
    );
  }
}
