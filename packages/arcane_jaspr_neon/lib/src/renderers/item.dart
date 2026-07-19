import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/component/html/arcane_link.dart';
import 'package:arcane_jaspr/component/html/div.dart';
import 'package:arcane_jaspr/core/props/item_props.dart';

class NeonItem extends StatelessComponent {
  final ItemProps props;

  const NeonItem(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (props.href == null) {
      return ArcaneDiv(
        styles: props.styles,
        classes: props.classes == null ? null : <String>[props.classes!],
        children: <Component>[props.child],
      );
    }

    if (props.external) {
      return ArcaneLink.external(
        href: props.href!,
        styles: props.styles,
        classes: props.classes == null ? null : <String>[props.classes!],
        child: props.child,
      );
    }

    return ArcaneLink(
      href: props.href!,
      styles: props.styles,
      classes: props.classes == null ? null : <String>[props.classes!],
      child: props.child,
    );
  }
}
