import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/pagination_props.dart';

/// ShadCN-style pagination component
/// Reference: https://ui.shadcn.com/docs/components/pagination
class ShadcnPagination extends StatelessComponent {
  final PaginationProps props;

  const ShadcnPagination(this.props, {super.key});

  (String padding, String fontSize, String minWidth, String height)
  get _sizeStyles => switch (props.size) {
    PaginationSizeVariant.sm => ('0 8px', '14px', '32px', '32px'),
    PaginationSizeVariant.md => ('0 12px', '14px', '40px', '40px'),
    PaginationSizeVariant.lg => ('0 16px', '16px', '48px', '48px'),
  };

  @override
  Component build(BuildContext context) {
    final (padding, fontSize, minWidth, height) = _sizeStyles;

    if (props.variant == PaginationStyleVariant.simple) {
      return _buildSimplePagination(padding, fontSize);
    }

    // ShadCN Pagination
    return dom.nav(
      classes: 'arcane-pagination',
      attributes: {'aria-label': 'Pagination', 'role': 'navigation'},
      styles: const dom.Styles(
        raw: {'display': 'flex', 'width': '100%', 'justify-content': 'center'},
      ),
      [
        // ShadCN PaginationContent
        dom.ul(
          classes: 'arcane-pagination-content',
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'flex-direction': 'row',
              'align-items': 'center',
              'gap': 'var(--space-1)',
              'list-style': 'none',
              'margin': '0',
              'padding': '0',
            },
          ),
          [
            // First page button
            if (props.showFirstLast && props.totalPages > 3)
              dom.li([
                _buildButton(
                  content: ArcaneIcon.chevronsLeft(size: IconSize.sm),
                  page: 1,
                  disabled: props.currentPage == 1,
                  padding: padding,
                  fontSize: fontSize,
                  minWidth: minWidth,
                  height: height,
                ),
              ]),

            // Previous button
            if (props.showPrevNext)
              dom.li([
                _buildButton(
                  content: Component.text(props.previousText),
                  page: props.currentPage - 1,
                  disabled: props.currentPage == 1,
                  padding: padding,
                  fontSize: fontSize,
                  minWidth: minWidth,
                  height: height,
                  isPrevNext: true,
                ),
              ]),

            // Page numbers
            for (final page in props.pageNumbers)
              dom.li([
                if (page == null)
                  // ShadCN PaginationEllipsis
                  dom.span(
                    classes: 'arcane-pagination-ellipsis',
                    styles: dom.Styles(
                      raw: {
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'height': height,
                        'width': minWidth,
                        'color': 'var(--muted-foreground)',
                      },
                    ),
                    [const Component.text('\u{2026}')], // Ellipsis
                  )
                else
                  _buildButton(
                    content: Component.text(page.toString()),
                    page: page,
                    isActive: page == props.currentPage,
                    padding: padding,
                    fontSize: fontSize,
                    minWidth: minWidth,
                    height: height,
                  ),
              ]),

            // Next button
            if (props.showPrevNext)
              dom.li([
                _buildButton(
                  content: Component.text(props.nextText),
                  page: props.currentPage + 1,
                  disabled: props.currentPage == props.totalPages,
                  padding: padding,
                  fontSize: fontSize,
                  minWidth: minWidth,
                  height: height,
                  isPrevNext: true,
                ),
              ]),

            // Last page button
            if (props.showFirstLast && props.totalPages > 3)
              dom.li([
                _buildButton(
                  content: ArcaneIcon.chevronsRight(size: IconSize.sm),
                  page: props.totalPages,
                  disabled: props.currentPage == props.totalPages,
                  padding: padding,
                  fontSize: fontSize,
                  minWidth: minWidth,
                  height: height,
                ),
              ]),
          ],
        ),
      ],
    );
  }

  Component _buildSimplePagination(String padding, String fontSize) {
    return dom.nav(
      attributes: {'aria-label': 'Pagination'},
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'space-between',
          'gap': '16px',
        },
      ),
      [
        // Previous
        dom.button(
          styles: dom.Styles(
            raw: {
              'padding': padding,
              'font-size': fontSize,
              'background': 'transparent',
              'border': 'none',
              'color': props.currentPage == 1
                  ? 'var(--muted)'
                  : 'var(--primary)',
              'cursor': props.currentPage == 1 ? 'not-allowed' : 'pointer',
              'opacity': props.currentPage == 1 ? '0.5' : '1',
            },
          ),
          events: props.currentPage == 1
              ? null
              : {
                  'click': (_) =>
                      props.onPageChange?.call(props.currentPage - 1),
                },
          [Component.text(props.previousText)],
        ),

        // Page count
        if (props.showPageCount)
          dom.span(
            styles: dom.Styles(
              raw: {'font-size': fontSize, 'color': 'var(--muted-foreground)'},
            ),
            [
              Component.text(
                'Page ${props.currentPage} of ${props.totalPages}',
              ),
            ],
          ),

        // Next
        dom.button(
          styles: dom.Styles(
            raw: {
              'padding': padding,
              'font-size': fontSize,
              'background': 'transparent',
              'border': 'none',
              'color': props.currentPage == props.totalPages
                  ? 'var(--muted)'
                  : 'var(--primary)',
              'cursor': props.currentPage == props.totalPages
                  ? 'not-allowed'
                  : 'pointer',
              'opacity': props.currentPage == props.totalPages ? '0.5' : '1',
            },
          ),
          events: props.currentPage == props.totalPages
              ? null
              : {
                  'click': (_) =>
                      props.onPageChange?.call(props.currentPage + 1),
                },
          [Component.text(props.nextText)],
        ),
      ],
    );
  }

  Component _buildButton({
    required Component content,
    required int page,
    bool isActive = false,
    bool disabled = false,
    required String padding,
    required String fontSize,
    required String minWidth,
    required String height,
    bool isPrevNext = false,
  }) {
    final Map<String, String> buttonStyles = switch (props.variant) {
      PaginationStyleVariant.outline => {
        'background-color': isActive ? 'var(--background)' : 'transparent',
        'border': isActive ? '1px solid var(--input)' : '1px solid transparent',
        'color': 'var(--foreground)',
      },
      PaginationStyleVariant.filled => {
        'background-color': isActive ? 'var(--accent)' : 'transparent',
        'border': '1px solid transparent',
        'color': isActive ? 'var(--accent-foreground)' : 'var(--foreground)',
      },
      PaginationStyleVariant.ghost => {
        'background-color': isActive ? 'var(--accent)' : 'transparent',
        'border': '1px solid transparent',
        'color': isActive ? 'var(--accent-foreground)' : 'var(--foreground)',
      },
      PaginationStyleVariant.simple => {
        'background-color': 'transparent',
        'border': '1px solid transparent',
        'color': 'var(--primary)',
      },
    };

    return dom.button(
      classes:
          'arcane-pagination-link ${isActive ? 'active' : ''} ${disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (disabled) 'disabled': 'true',
        if (isActive) 'aria-current': 'page',
        'data-state': isActive ? 'active' : 'inactive',
        'data-disabled': '$disabled',
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'white-space': 'nowrap',
          'border-radius': 'var(--radius-sm)',
          'font-size': fontSize,
          'font-weight': 'var(--font-weight-medium)',
          'height': height,
          'min-width': minWidth,
          'padding': padding,
          if (isPrevNext) 'gap': 'var(--space-1)',
          'transition':
              'color var(--transition), background-color var(--transition)',
          'cursor': disabled ? 'not-allowed' : 'pointer',
          'pointer-events': disabled ? 'none' : 'auto',
          'opacity': disabled ? '0.5' : '1',
          ...buttonStyles,
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      events: disabled
          ? null
          : {'click': (_) => props.onPageChange?.call(page)},
      [content],
    );
  }
}
