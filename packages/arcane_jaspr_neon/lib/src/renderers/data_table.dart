import 'package:arcane_jaspr/core/props/data_table_props.dart';
import 'package:arcane_jaspr/core/rendering/base/data_table_render_base.dart';

/// Neon DataTable renderer.
class NeonDataTable<T> extends DataTableRenderBase<T> {
  const NeonDataTable(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get emptyPadding => '60px 30px';

  @override
  Map<String, String> get containerStyles => const <String, String>{};

  @override
  Map<String, String> get tableStyles => const <String, String>{};

  @override
  Map<String, String> theadBaseStyles() => const <String, String>{};

  @override
  String get cellPadding => '14px 20px';

  @override
  String get selectAllWidth => '56px';

  @override
  Map<String, String>? get checkboxStyles => const <String, String>{};

  @override
  Map<String, String> headerCellStyles(DataColumnProps<T> column) =>
      const <String, String>{};

  @override
  Map<String, String> rowStyles(bool isSelected, bool isClickable) =>
      const <String, String>{};

  @override
  Map<String, String>? get bodyStyles => null;
}
