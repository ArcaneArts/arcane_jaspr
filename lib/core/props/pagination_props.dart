import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

enum PaginationStyleVariant { outline, filled, ghost, simple }

enum PaginationSizeVariant { sm, md, lg }

/// Pagination component properties.
class PaginationProps {
  final int currentPage;
  final int totalPages;
  final void Function(int page)? onPageChange;
  final PaginationStyleVariant variant;
  final PaginationSizeVariant size;
  final int siblingCount;
  final bool showFirstLast;
  final bool showPrevNext;
  final bool showPageCount;
  final String previousText;
  final String nextText;
  final List<int?> pageNumbers;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const PaginationProps({
    required this.currentPage,
    required this.totalPages,
    this.onPageChange,
    this.variant = PaginationStyleVariant.outline,
    this.size = PaginationSizeVariant.md,
    this.siblingCount = 1,
    this.showFirstLast = true,
    this.showPrevNext = true,
    this.showPageCount = false,
    this.previousText = '<-',
    this.nextText = '->',
    this.pageNumbers = const [],
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for pagination components.
mixin PaginationRendererContract {
  /// Renders a pagination control.
  Component pagination(PaginationProps props);
}
