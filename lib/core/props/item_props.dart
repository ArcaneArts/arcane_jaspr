import 'package:arcane_jaspr/flutter.dart';

import '../../util/style_types/arcane_style_data.dart';

class ItemProps {
  final Widget child;
  final String? href;
  final bool external;
  final ArcaneStyleData? styles;
  final String? classes;

  const ItemProps({
    required this.child,
    this.href,
    this.external = false,
    this.styles,
    this.classes,
  });

  ItemProps copyWith({
    Widget? child,
    String? href,
    bool? external,
    ArcaneStyleData? styles,
    String? classes,
  }) {
    return ItemProps(
      child: child ?? this.child,
      href: href ?? this.href,
      external: external ?? this.external,
      styles: styles ?? this.styles,
      classes: classes ?? this.classes,
    );
  }
}

mixin ItemRendererContract {
  Widget item(ItemProps props);
}
