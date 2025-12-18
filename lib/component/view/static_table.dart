import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// A static table component for displaying simple tabular data.
class StaticTable extends StatelessComponent {
  /// Table headers
  final List<String> headers;

  /// Table rows (each row is a list of cell contents)
  final List<List<Component>> rows;

  /// Whether to show row dividers
  final bool showDividers;

  /// Whether to stripe alternate rows
  final bool striped;

  /// Whether the header is sticky
  final bool stickyHeader;

  /// Column alignments
  final List<TextAlign>? alignments;

  /// Whether to show the header
  final bool showHeader;

  const StaticTable({
    required this.headers,
    required this.rows,
    this.showDividers = true,
    this.striped = false,
    this.stickyHeader = false,
    this.alignments,
    this.showHeader = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return div(
      classes: 'arcane-static-table-container',
      styles: Styles(raw: {
        'overflow-x': 'auto',
        'border': '1px solid var(--arcane-outline-variant)',
        'border-radius': theme.borderRadiusCss,
      }),
      [
        table(
          classes: 'arcane-static-table',
          styles: Styles(raw: {
            'width': '100%',
            'border-collapse': 'collapse',
            'font-size': '0.875rem',
          }),
          [
            // Header
            if (showHeader)
              thead(
                styles: Styles(raw: {
                  'background-color': 'var(--arcane-surface-variant)',
                  if (stickyHeader) 'position': 'sticky',
                  if (stickyHeader) 'top': '0',
                  if (stickyHeader) 'z-index': '1',
                }),
                [
                  tr([
                    for (var i = 0; i < headers.length; i++)
                      th(
                        styles: Styles(raw: {
                          'padding': '12px 16px',
                          'text-align': (alignments != null && i < alignments!.length)
                              ? alignments![i].css
                              : 'left',
                          'font-weight': '600',
                          'color': 'var(--arcane-on-surface)',
                          'white-space': 'nowrap',
                        }),
                        [text(headers[i])],
                      ),
                  ]),
                ],
              ),

            // Body
            tbody([
              for (var rowIndex = 0; rowIndex < rows.length; rowIndex++)
                tr(
                  styles: Styles(raw: {
                    'background-color': striped && rowIndex.isOdd
                        ? 'var(--arcane-surface-variant)'
                        : 'var(--arcane-surface)',
                    if (showDividers && rowIndex < rows.length - 1)
                      'border-bottom': '1px solid var(--arcane-outline-variant)',
                  }),
                  [
                    for (var colIndex = 0;
                        colIndex < rows[rowIndex].length;
                        colIndex++)
                      td(
                        styles: Styles(raw: {
                          'padding': '12px 16px',
                          'text-align': (alignments != null &&
                                  colIndex < alignments!.length)
                              ? alignments![colIndex].css
                              : 'left',
                          'color': 'var(--arcane-on-surface)',
                        }),
                        [rows[rowIndex][colIndex]],
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

/// A simple key-value table (two columns)
class KeyValueTable extends StatelessComponent {
  final List<KeyValueRow> rows;
  final double? keyWidth;
  final bool showDividers;

  const KeyValueTable({
    required this.rows,
    this.keyWidth,
    this.showDividers = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return div(
      classes: 'arcane-kv-table',
      styles: Styles(raw: {
        'border': '1px solid var(--arcane-outline-variant)',
        'border-radius': theme.borderRadiusCss,
        'overflow': 'hidden',
      }),
      [
        for (var i = 0; i < rows.length; i++)
          div(
            classes: 'arcane-kv-table-row',
            styles: Styles(raw: {
              'display': 'flex',
              if (showDividers && i < rows.length - 1)
                'border-bottom': '1px solid var(--arcane-outline-variant)',
            }),
            [
              // Key
              div(
                classes: 'arcane-kv-table-key',
                styles: Styles(raw: {
                  'padding': '12px 16px',
                  'background-color': 'var(--arcane-surface-variant)',
                  'font-weight': '500',
                  'color': 'var(--arcane-on-surface)',
                  'font-size': '0.875rem',
                  if (keyWidth != null) 'width': '${keyWidth}px',
                  if (keyWidth != null) 'flex-shrink': '0',
                  if (keyWidth == null) 'flex': '0 0 30%',
                  'border-right': '1px solid var(--arcane-outline-variant)',
                }),
                [text(rows[i].key)],
              ),

              // Value
              div(
                classes: 'arcane-kv-table-value',
                styles: Styles(raw: {
                  'flex': '1',
                  'padding': '12px 16px',
                  'background-color': 'var(--arcane-surface)',
                  'color': 'var(--arcane-on-surface)',
                  'font-size': '0.875rem',
                }),
                [rows[i].value],
              ),
            ],
          ),
      ],
    );
  }
}

/// A row for KeyValueTable
class KeyValueRow {
  final String key;
  final Component value;

  const KeyValueRow({required this.key, required this.value});

  /// Create from a string value
  factory KeyValueRow.text(String key, String value) =>
      KeyValueRow(key: key, value: span([text(value)]));
}
