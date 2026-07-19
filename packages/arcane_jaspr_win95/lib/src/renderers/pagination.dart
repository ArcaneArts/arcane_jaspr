import 'package:arcane_jaspr/core/rendering/base/pagination_render_base.dart';

/// Win95 Pagination renderer.
class Win95Pagination extends PaginationRenderBase {
  const Win95Pagination(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

  @override
  Map<String, String> buttonStyleVariant(bool isActive) =>
      const <String, String>{};
}
