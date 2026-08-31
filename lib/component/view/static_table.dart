import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart' as jaspr;

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

export '../../core/props/static_table_props.dart';

class StaticTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final bool showDividers;
  final bool striped;
  final bool stickyHeader;
  final List<TextAlign>? alignments;
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
  Widget build(BuildContext context) => context.renderers.staticTable(
    StaticTableProps(
      headers: headers,
      rows: rows,
      showDividers: showDividers,
      striped: striped,
      stickyHeader: stickyHeader,
      alignments: alignments,
      showHeader: showHeader,
    ),
  );
}

class KeyValueRow {
  final String key;
  final Widget value;

  const KeyValueRow({required this.key, required this.value});

  factory KeyValueRow.text(String key, String value) =>
      KeyValueRow(key: key, value: dom.span([jaspr.Component.text(value)]));
}

class KeyValueTable extends StatelessWidget {
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
  Widget build(BuildContext context) => context.renderers.keyValueTable(
    KeyValueTableProps(
      rows: rows
          .map(
            (KeyValueRow row) =>
                KeyValueRowData(key: row.key, value: row.value),
          )
          .toList(),
      keyWidth: keyWidth,
      showDividers: showDividers,
    ),
  );
}
