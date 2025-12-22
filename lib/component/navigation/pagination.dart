import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Pagination style variants
enum PaginationStyle {
  /// Default outlined buttons
  outline,

  /// Filled/solid buttons
  filled,

  /// Ghost/minimal buttons
  ghost,

  /// Simple text-only
  simple,
}

/// Pagination size variants
enum PaginationSize {
  sm,
  md,
  lg,
}

/// Page navigation component
///
/// Displays page numbers and navigation controls for paginated content.
///
/// ```dart
/// ArcanePagination(
///   currentPage: 3,
///   totalPages: 10,
///   onPageChange: (page) => print('Go to page $page'),
/// )
/// ```
class ArcanePagination extends StatelessComponent {
  /// Current active page (1-indexed)
  final int currentPage;

  /// Total number of pages
  final int totalPages;

  /// Callback when page changes
  final void Function(int page)? onPageChange;

  /// Style variant
  final PaginationStyle style;

  /// Size variant
  final PaginationSize size;

  /// Number of page buttons to show around current page
  final int siblingCount;

  /// Whether to show first/last page buttons
  final bool showFirstLast;

  /// Whether to show previous/next buttons
  final bool showPrevNext;

  /// Whether to show page count text
  final bool showPageCount;

  /// Custom previous button text
  final String previousText;

  /// Custom next button text
  final String nextText;

  const ArcanePagination({
    required this.currentPage,
    required this.totalPages,
    this.onPageChange,
    this.style = PaginationStyle.outline,
    this.size = PaginationSize.md,
    this.siblingCount = 1,
    this.showFirstLast = true,
    this.showPrevNext = true,
    this.showPageCount = false,
    this.previousText = '←',
    this.nextText = '→',
    super.key,
  });

  /// Simple pagination with just prev/next
  const ArcanePagination.simple({
    required this.currentPage,
    required this.totalPages,
    this.onPageChange,
    this.size = PaginationSize.md,
    this.previousText = '← Previous',
    this.nextText = 'Next →',
    super.key,
  })  : style = PaginationStyle.simple,
        siblingCount = 0,
        showFirstLast = false,
        showPrevNext = true,
        showPageCount = true;

  (String padding, String fontSize, String minWidth) get _sizeStyles =>
      switch (size) {
        PaginationSize.sm => ('6px 10px', ArcaneTypography.fontXs, '28px'),
        PaginationSize.md => ('8px 12px', ArcaneTypography.fontSm, '36px'),
        PaginationSize.lg => ('10px 16px', ArcaneTypography.fontMd, '44px'),
      };

  List<int?> _getPageNumbers() {
    final List<int?> pages = [];
    final int leftSiblingIndex = (currentPage - siblingCount).clamp(1, totalPages);
    final int rightSiblingIndex = (currentPage + siblingCount).clamp(1, totalPages);

    final bool showLeftDots = leftSiblingIndex > 2;
    final bool showRightDots = rightSiblingIndex < totalPages - 1;

    if (!showLeftDots && showRightDots) {
      // No left dots, show first few pages
      for (var i = 1; i <= 3 + 2 * siblingCount && i <= totalPages; i++) {
        pages.add(i);
      }
      pages.add(null); // dots
      pages.add(totalPages);
    } else if (showLeftDots && !showRightDots) {
      // No right dots, show last few pages
      pages.add(1);
      pages.add(null); // dots
      for (var i = totalPages - (2 + 2 * siblingCount); i <= totalPages; i++) {
        if (i > 1) pages.add(i);
      }
    } else if (showLeftDots && showRightDots) {
      // Both dots
      pages.add(1);
      pages.add(null); // left dots
      for (var i = leftSiblingIndex; i <= rightSiblingIndex; i++) {
        pages.add(i);
      }
      pages.add(null); // right dots
      pages.add(totalPages);
    } else {
      // No dots needed, show all pages
      for (var i = 1; i <= totalPages; i++) {
        pages.add(i);
      }
    }

    return pages;
  }

  @override
  Component build(BuildContext context) {
    final (padding, fontSize, minWidth) = _sizeStyles;
    final pages = _getPageNumbers();

    if (style == PaginationStyle.simple) {
      return _buildSimplePagination(padding, fontSize);
    }

    return nav(
      attributes: {'aria-label': 'Pagination'},
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
      }),
      [
        // First page button
        if (showFirstLast && totalPages > 3)
          _buildButton(
            content: '««',
            page: 1,
            disabled: currentPage == 1,
            padding: padding,
            fontSize: fontSize,
            minWidth: minWidth,
          ),

        // Previous button
        if (showPrevNext)
          _buildButton(
            content: previousText,
            page: currentPage - 1,
            disabled: currentPage == 1,
            padding: padding,
            fontSize: fontSize,
            minWidth: minWidth,
          ),

        // Page numbers
        for (final page in pages)
          if (page == null)
            span(
              styles: Styles(raw: {
                'padding': padding,
                'color': ArcaneColors.muted,
              }),
              [text('…')],
            )
          else
            _buildButton(
              content: page.toString(),
              page: page,
              isActive: page == currentPage,
              padding: padding,
              fontSize: fontSize,
              minWidth: minWidth,
            ),

        // Next button
        if (showPrevNext)
          _buildButton(
            content: nextText,
            page: currentPage + 1,
            disabled: currentPage == totalPages,
            padding: padding,
            fontSize: fontSize,
            minWidth: minWidth,
          ),

        // Last page button
        if (showFirstLast && totalPages > 3)
          _buildButton(
            content: '»»',
            page: totalPages,
            disabled: currentPage == totalPages,
            padding: padding,
            fontSize: fontSize,
            minWidth: minWidth,
          ),
      ],
    );
  }

  Component _buildSimplePagination(String padding, String fontSize) {
    return nav(
      attributes: {'aria-label': 'Pagination'},
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'gap': ArcaneSpacing.md,
      }),
      [
        // Previous
        button(
          styles: Styles(raw: {
            'padding': padding,
            'font-size': fontSize,
            'background': 'transparent',
            'border': 'none',
            'color': currentPage == 1 ? ArcaneColors.muted : ArcaneColors.accent,
            'cursor': currentPage == 1 ? 'not-allowed' : 'pointer',
            'opacity': currentPage == 1 ? '0.5' : '1',
          }),
          events: currentPage == 1
              ? null
              : {
                  'click': (_) => onPageChange?.call(currentPage - 1),
                },
          [text(previousText)],
        ),

        // Page count
        if (showPageCount)
          span(
            styles: Styles(raw: {
              'font-size': fontSize,
              'color': ArcaneColors.muted,
            }),
            [text('Page $currentPage of $totalPages')],
          ),

        // Next
        button(
          styles: Styles(raw: {
            'padding': padding,
            'font-size': fontSize,
            'background': 'transparent',
            'border': 'none',
            'color': currentPage == totalPages
                ? ArcaneColors.muted
                : ArcaneColors.accent,
            'cursor': currentPage == totalPages ? 'not-allowed' : 'pointer',
            'opacity': currentPage == totalPages ? '0.5' : '1',
          }),
          events: currentPage == totalPages
              ? null
              : {
                  'click': (_) => onPageChange?.call(currentPage + 1),
                },
          [text(nextText)],
        ),
      ],
    );
  }

  Component _buildButton({
    required String content,
    required int page,
    bool isActive = false,
    bool disabled = false,
    required String padding,
    required String fontSize,
    required String minWidth,
  }) {
    final Map<String, String> buttonStyles = switch (style) {
      PaginationStyle.outline => {
          'background': isActive ? ArcaneColors.accent : 'transparent',
          'border': isActive
              ? '1px solid ${ArcaneColors.accent}'
              : '1px solid ${ArcaneColors.border}',
          'color': isActive ? ArcaneColors.onSurface : ArcaneColors.onSurface,
        },
      PaginationStyle.filled => {
          'background': isActive ? ArcaneColors.accent : ArcaneColors.surfaceVariant,
          'border': 'none',
          'color': isActive ? ArcaneColors.onSurface : ArcaneColors.onSurface,
        },
      PaginationStyle.ghost => {
          'background': isActive ? ArcaneColors.surfaceVariant : 'transparent',
          'border': 'none',
          'color': isActive ? ArcaneColors.accent : ArcaneColors.onSurface,
        },
      PaginationStyle.simple => {
          'background': 'transparent',
          'border': 'none',
          'color': ArcaneColors.accent,
        },
    };

    return button(
      attributes: {
        if (disabled) 'disabled': 'true',
        if (isActive) 'aria-current': 'page',
      },
      styles: Styles(raw: {
        'padding': padding,
        'font-size': fontSize,
        'min-width': minWidth,
        'border-radius': ArcaneRadius.md,
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'font-weight':
            isActive ? ArcaneTypography.weightMedium : ArcaneTypography.weightNormal,
        ...buttonStyles,
      }),
      events: disabled
          ? null
          : {
              'click': (_) => onPageChange?.call(page),
            },
      [text(content)],
    );
  }
}