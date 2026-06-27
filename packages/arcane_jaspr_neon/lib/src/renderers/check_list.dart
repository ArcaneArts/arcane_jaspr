import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/check_list_props.dart';
import 'package:arcane_jaspr/core/rendering/base/check_list_render_base.dart';

/// Neon CheckItem renderer (neutralized skeleton).
class NeonCheckItem extends CheckItemRenderBase {
  const NeonCheckItem(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get defaultIconColor => 'currentColor';
}

/// Neon CheckList renderer (neutralized skeleton).
class NeonCheckList extends CheckListRenderBase {
  const NeonCheckList(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  Component buildCheckItem(CheckItemProps itemProps) => NeonCheckItem(itemProps);
}

/// Neon FeatureRow renderer (neutralized skeleton).
class NeonFeatureRow extends FeatureRowRenderBase {
  const NeonFeatureRow(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get defaultIncludedColor => 'currentColor';

  @override
  Component buildCircularIcon(
    Component iconWidget,
    String iconColor,
    String iconSize,
  ) => dom.div(
    classes: 'neon-feature-row-icon',
    styles: dom.Styles(
      raw: <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': iconSize,
        'height': iconSize,
        'border-radius': '50%',
        'flex-shrink': '0',
        'color': iconColor,
      },
    ),
    <Component>[iconWidget],
  );
}
