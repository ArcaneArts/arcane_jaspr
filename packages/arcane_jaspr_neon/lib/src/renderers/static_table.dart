import 'package:arcane_jaspr/core/rendering/base/static_table_render_base.dart';

/// Neon Static Table renderer (neutralized skeleton).
class NeonStaticTable extends StaticTableRenderBase {
  const NeonStaticTable(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  Map<String, String> get containerStyles => const <String, String>{};

  @override
  Map<String, String> get tableStyles => const <String, String>{};

  @override
  Map<String, String> theadBaseStyles() => const <String, String>{};

  @override
  Map<String, String> headerCellStyles(String textAlign) =>
      const <String, String>{};

  @override
  Map<String, String> rowStyles(int rowIndex) => const <String, String>{};
}

/// Neon Key-Value Table renderer (neutralized skeleton).
class NeonKeyValueTable extends KeyValueTableRenderBase {
  const NeonKeyValueTable(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  Map<String, String> get containerStyles => const <String, String>{};

  @override
  String get dividerBorder => '1px solid var(--border)';

  @override
  Map<String, String> get keyLeadingStyles => const <String, String>{};

  @override
  Map<String, String> get valueStyles => const <String, String>{};
}
