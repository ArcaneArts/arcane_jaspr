import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/static_table_props.dart';

/// Shared structural base for themed static-table renderers.
///
/// Every theme renders the same `div > table > (thead > tr > th) + (tbody > tr >
/// td)` scaffold with identical alignment resolution, striping/divider
/// conditionals and cell loops. The body cells are byte-identical across themes;
/// the themes diverge only in the container/table/header-band styles, the header
/// cell styling and the row background, which are exposed as abstract members.
///
/// This base lives in core and depends only on core props; it must never depend
/// on a theme package.
abstract class StaticTableRenderBase extends StatelessComponent {
  const StaticTableRenderBase(this.props, {super.key});

  final StaticTableProps props;

  /// Theme class prefix (e.g. `'arcane'`, `'neon'`, `'neubrutalism'`).
  String get classPrefix;

  /// Inline styles for the outer scroll container.
  Map<String, String> get containerStyles;

  /// Inline styles for the `<table>` element.
  Map<String, String> get tableStyles;

  /// Theme-specific (non-sticky) portion of the `<thead>` styles.
  Map<String, String> theadBaseStyles();

  /// Inline styles for a header cell with the resolved [textAlign].
  Map<String, String> headerCellStyles(String textAlign);

  /// Inline styles for the body row at [rowIndex] (theme-specific key sets).
  Map<String, String> rowStyles(int rowIndex);

  /// Resolves the alignment for the column at [index].
  String _alignFor(int index) =>
      (props.alignments != null && index < props.alignments!.length)
      ? props.alignments![index].css
      : 'left';

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: '$classPrefix-static-table-container',
      styles: dom.Styles(raw: containerStyles),
      <Component>[
        dom.table(
          classes: '$classPrefix-static-table',
          styles: dom.Styles(raw: tableStyles),
          <Component>[
            // Header
            if (props.showHeader)
              dom.thead(
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
                    for (int i = 0; i < props.headers.length; i++)
                      dom.th(
                        styles: dom.Styles(raw: headerCellStyles(_alignFor(i))),
                        <Component>[Component.text(props.headers[i])],
                      ),
                  ]),
                ],
              ),

            // Body
            dom.tbody(<Component>[
              for (int rowIndex = 0; rowIndex < props.rows.length; rowIndex++)
                dom.tr(
                  styles: dom.Styles(raw: rowStyles(rowIndex)),
                  <Component>[
                    for (
                      int colIndex = 0;
                      colIndex < props.rows[rowIndex].length;
                      colIndex++
                    )
                      dom.td(
                        styles: dom.Styles(
                          raw: <String, String>{
                            'padding': '1rem 1.5rem',
                            'text-align': _alignFor(colIndex),
                            'color': 'var(--foreground)',
                          },
                        ),
                        <Component>[props.rows[rowIndex][colIndex]],
                      ),
                  ],
                ),
            ]),
          ],
        ),
      ],
    );
  }
}

/// Shared structural base for themed key-value-table renderers.
///
/// The flex row scaffold, the key-width conditional logic and the key/value
/// cells are identical across themes; only the wrapper, divider border, the
/// key cell's leading styles and the value cell styles diverge.
abstract class KeyValueTableRenderBase extends StatelessComponent {
  const KeyValueTableRenderBase(this.props, {super.key});

  final KeyValueTableProps props;

  /// Theme class prefix (e.g. `'arcane'`, `'neon'`, `'neubrutalism'`).
  String get classPrefix;

  /// Inline styles for the outer wrapper.
  Map<String, String> get containerStyles;

  /// `border-bottom` / `border-right` divider value for the theme.
  String get dividerBorder;

  /// Leading key-cell styles (before the shared key-width conditionals).
  Map<String, String> get keyLeadingStyles;

  /// Inline styles for the value cell.
  Map<String, String> get valueStyles;

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: '$classPrefix-kv-table',
      styles: dom.Styles(raw: containerStyles),
      <Component>[
        for (int i = 0; i < props.rows.length; i++)
          dom.div(
            classes: '$classPrefix-kv-table-row',
            styles: dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                if (props.showDividers && i < props.rows.length - 1)
                  'border-bottom': dividerBorder,
              },
            ),
            <Component>[
              // Key
              dom.div(
                classes: '$classPrefix-kv-table-key',
                styles: dom.Styles(
                  raw: <String, String>{
                    ...keyLeadingStyles,
                    if (props.keyWidth != null) 'width': '${props.keyWidth}px',
                    if (props.keyWidth != null) 'flex-shrink': '0',
                    if (props.keyWidth == null) 'flex': '0 0 30%',
                    'border-right': dividerBorder,
                  },
                ),
                <Component>[Component.text(props.rows[i].key)],
              ),

              // Value
              dom.div(
                classes: '$classPrefix-kv-table-value',
                styles: dom.Styles(raw: valueStyles),
                <Component>[props.rows[i].value],
              ),
            ],
          ),
      ],
    );
  }
}
