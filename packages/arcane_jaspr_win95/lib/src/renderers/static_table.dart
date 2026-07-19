import 'package:arcane_jaspr/core/rendering/base/static_table_render_base.dart';

/// Win95 Static Table renderer (neutralized skeleton).
class Win95StaticTable extends StaticTableRenderBase {
  const Win95StaticTable(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

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

/// Win95 Key-Value Table renderer (neutralized skeleton).
class Win95KeyValueTable extends KeyValueTableRenderBase {
  const Win95KeyValueTable(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

  @override
  Map<String, String> get containerStyles => const <String, String>{};

  @override
  String get dividerBorder => '1px solid var(--border)';

  @override
  Map<String, String> get keyLeadingStyles => const <String, String>{};

  @override
  Map<String, String> get valueStyles => const <String, String>{};
}
