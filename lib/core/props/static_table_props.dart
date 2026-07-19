import 'package:arcane_jaspr/flutter.dart';

import '../../util/arcane.dart';

/// Static table component properties.
class StaticTableProps {
  final List<String> headers;
  final List<List<Widget>> rows;
  final bool showDividers;
  final bool striped;
  final bool stickyHeader;
  final List<TextAlign>? alignments;
  final bool showHeader;

  const StaticTableProps({
    required this.headers,
    required this.rows,
    this.showDividers = true,
    this.striped = false,
    this.stickyHeader = false,
    this.alignments,
    this.showHeader = true,
  });
}

/// Key-value table component properties.
class KeyValueTableProps {
  final List<KeyValueRowData> rows;
  final double? keyWidth;
  final bool showDividers;

  const KeyValueTableProps({
    required this.rows,
    this.keyWidth,
    this.showDividers = true,
  });
}

/// Key-value row data.
class KeyValueRowData {
  final String key;
  final Widget value;

  const KeyValueRowData({required this.key, required this.value});
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for static table components.
mixin StaticTableRendererContract {
  Widget staticTable(StaticTableProps props);
  Widget keyValueTable(KeyValueTableProps props);
}
