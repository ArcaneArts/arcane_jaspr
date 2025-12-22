import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/style_types/index.dart' hide BorderRadius;

/// A breadcrumb item in the navigation trail
class BreadcrumbItem {
  /// The display label for this breadcrumb
  final String label;

  /// The navigation href (null for current/last item)
  final String? href;

  /// Optional icon to display before the label
  final Component? icon;

  const BreadcrumbItem({
    required this.label,
    this.href,
    this.icon,
  });
}

/// Breadcrumb separator styles
enum BreadcrumbSeparator {
  /// Slash separator (/)
  slash,

  /// Chevron separator (>)
  chevron,

  /// Arrow separator (→)
  arrow,

  /// Dot separator (•)
  dot,
}

/// Breadcrumb size variants
enum BreadcrumbSize {
  sm,
  md,
  lg,
}

/// Navigation breadcrumbs component
///
/// Shows the current page location within a navigational hierarchy.
///
/// ```dart
/// ArcaneBreadcrumbs(
///   items: [
///     BreadcrumbItem(label: 'Home', href: '/'),
///     BreadcrumbItem(label: 'Products', href: '/products'),
///     BreadcrumbItem(label: 'Widget Pro'),
///   ],
/// )
/// ```
class ArcaneBreadcrumbs extends StatelessComponent {
  /// The list of breadcrumb items
  final List<BreadcrumbItem> items;

  /// The separator style between items
  final BreadcrumbSeparator separator;

  /// Size variant
  final BreadcrumbSize size;

  /// Whether to show home icon for first item
  final bool showHomeIcon;

  /// Custom separator widget (overrides separator enum)
  final Component? customSeparator;

  /// Callback when a breadcrumb is clicked
  final void Function(BreadcrumbItem item, int index)? onItemClick;

  const ArcaneBreadcrumbs({
    required this.items,
    this.separator = BreadcrumbSeparator.chevron,
    this.size = BreadcrumbSize.md,
    this.showHomeIcon = false,
    this.customSeparator,
    this.onItemClick,
    super.key,
  });

  String get _separatorText => switch (separator) {
        BreadcrumbSeparator.slash => '/',
        BreadcrumbSeparator.chevron => '›',
        BreadcrumbSeparator.arrow => '→',
        BreadcrumbSeparator.dot => '•',
      };

  (String fontSize, String gap, String padding) get _sizeStyles =>
      switch (size) {
        BreadcrumbSize.sm => (
            ArcaneTypography.fontXs,
            ArcaneSpacing.xs,
            '2px 4px'
          ),
        BreadcrumbSize.md => (
            ArcaneTypography.fontSm,
            ArcaneSpacing.sm,
            '4px 8px'
          ),
        BreadcrumbSize.lg =>
          (ArcaneTypography.fontMd, ArcaneSpacing.md, '6px 12px'),
      };

  @override
  Component build(BuildContext context) {
    final (fontSize, gap, padding) = _sizeStyles;

    return nav(
      attributes: {'aria-label': 'Breadcrumb'},
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': gap,
        'font-size': fontSize,
      }),
      [
        ol(
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': gap,
            'list-style': 'none',
            'margin': '0',
            'padding': '0',
          }),
          [
            for (var i = 0; i < items.length; i++) ...[
              li(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': ArcaneSpacing.xs,
                }),
                [
                  _buildBreadcrumbItem(items[i], i, isLast: i == items.length - 1),
                ],
              ),
              if (i < items.length - 1)
                span(
                  attributes: {'aria-hidden': 'true'},
                  styles: const Styles(raw: {
                    'color': ArcaneColors.muted,
                    'user-select': 'none',
                  }),
                  [customSeparator ?? text(_separatorText)],
                ),
            ],
          ],
        ),
      ],
    );
  }

  Component _buildBreadcrumbItem(BreadcrumbItem item, int index,
      {required bool isLast}) {
    final (fontSize, _, padding) = _sizeStyles;

    final content = span(
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
      }),
      [
        if (item.icon != null) item.icon!,
        if (showHomeIcon && index == 0 && item.icon == null)
          span(
            styles: const Styles(raw: {'font-size': '1.1em'}),
            [text('🏠')],
          ),
        text(item.label),
      ],
    );

    if (isLast || item.href == null) {
      // Current page - not a link
      return span(
        attributes: {'aria-current': 'page'},
        styles: Styles(raw: {
          'color': ArcaneColors.onSurface,
          'font-weight': ArcaneTypography.weightMedium,
          'padding': padding,
        }),
        [content],
      );
    }

    // Navigable link
    return a(
      href: item.href!,
      styles: Styles(raw: {
        'color': ArcaneColors.muted,
        'text-decoration': 'none',
        'padding': padding,
        'border-radius': ArcaneRadius.sm,
        'transition': ArcaneEffects.transitionFast,
      }),
      events: onItemClick != null
          ? {
              'click': (event) {
                onItemClick!(item, index);
              }
            }
          : null,
      [content],
    );
  }
}
