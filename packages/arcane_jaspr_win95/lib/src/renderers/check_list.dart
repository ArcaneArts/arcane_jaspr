import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/check_list_props.dart';
import 'package:arcane_jaspr/core/rendering/base/check_list_render_base.dart';

/// Win95 CheckItem renderer (neutralized skeleton).
class Win95CheckItem extends CheckItemRenderBase {
  const Win95CheckItem(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

  @override
  String get defaultIconColor => 'currentColor';
}

/// Win95 CheckList renderer (neutralized skeleton).
class Win95CheckList extends CheckListRenderBase {
  const Win95CheckList(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

  @override
  Component buildCheckItem(CheckItemProps itemProps) => Win95CheckItem(itemProps);
}

/// Win95 FeatureRow renderer (neutralized skeleton).
class Win95FeatureRow extends FeatureRowRenderBase {
  const Win95FeatureRow(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

  @override
  String get defaultIncludedColor => 'currentColor';

  @override
  Component buildCircularIcon(
    Component iconWidget,
    String iconColor,
    String iconSize,
  ) => dom.div(
    classes: 'win95-feature-row-icon',
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
