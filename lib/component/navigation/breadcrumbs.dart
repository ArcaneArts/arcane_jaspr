import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/breadcrumbs_props.dart'
    show BreadcrumbItemProps, BreadcrumbSeparatorStyle, BreadcrumbSizeVariant;

/// Breadcrumb item in the navigation trail.
class BreadcrumbItem {
  final String label;
  final String? href;
  final Widget? icon;

  const BreadcrumbItem({
    required this.label,
    this.href,
    this.icon,
  });
}

enum BreadcrumbSeparator {
  slash,
  chevron,
  arrow,
  dot,
}

enum BreadcrumbSize {
  sm,
  md,
  lg,
}

/// Navigation breadcrumbs component.
class ArcaneBreadcrumbs extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final BreadcrumbSeparator separator;
  final BreadcrumbSize size;
  final bool showHomeIcon;
  final Widget? customSeparator;
  final void Function(BreadcrumbItem item, int index)? onItemClick;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneBreadcrumbs({
    required this.items,
    this.separator = BreadcrumbSeparator.chevron,
    this.size = BreadcrumbSize.md,
    this.showHomeIcon = false,
    this.customSeparator,
    this.onItemClick,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final itemProps = items
        .map((item) => BreadcrumbItemProps(
              label: item.label,
              href: item.href,
              icon: item.icon,
            ))
        .toList();

    final separatorStyle = switch (separator) {
      BreadcrumbSeparator.slash => BreadcrumbSeparatorStyle.slash,
      BreadcrumbSeparator.chevron => BreadcrumbSeparatorStyle.chevron,
      BreadcrumbSeparator.arrow => BreadcrumbSeparatorStyle.arrow,
      BreadcrumbSeparator.dot => BreadcrumbSeparatorStyle.dot,
    };

    final sizeVariant = switch (size) {
      BreadcrumbSize.sm => BreadcrumbSizeVariant.sm,
      BreadcrumbSize.md => BreadcrumbSizeVariant.md,
      BreadcrumbSize.lg => BreadcrumbSizeVariant.lg,
    };

    return context.renderers.breadcrumbs(BreadcrumbsProps(
      items: itemProps,
      separator: separatorStyle,
      size: sizeVariant,
      showHomeIcon: showHomeIcon,
      customSeparator: customSeparator,
      onItemClick: onItemClick != null
          ? (BreadcrumbItemProps itemProp, int index) {
              if (index < items.length) {
                onItemClick!(items[index], index);
              }
            }
          : null,
      styles: styles,
      decoration: decoration,
    ));
  }
}
