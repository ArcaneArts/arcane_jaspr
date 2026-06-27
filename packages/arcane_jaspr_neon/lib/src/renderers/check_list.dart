import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/check_list_props.dart';
import 'package:arcane_jaspr/core/rendering/base/check_list_render_base.dart';

/// Neon CheckItem renderer.
class NeonCheckItem extends CheckItemRenderBase {
  const NeonCheckItem(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get defaultIconColor => 'var(--neon-accent)';
}

/// Neon CheckList renderer.
class NeonCheckList extends CheckListRenderBase {
  const NeonCheckList(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  Component buildCheckItem(CheckItemProps itemProps) => NeonCheckItem(itemProps);
}

/// Neon FeatureRow renderer.
///
/// Displays a feature with check/x indicator for included/excluded states.
/// Supports circular icon containers, strikethrough, and tooltips.
class NeonFeatureRow extends FeatureRowRenderBase {
  const NeonFeatureRow(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get defaultIncludedColor => 'var(--neon-accent)';

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
        'background-color': props.included
            ? 'color-mix(in srgb, var(--neon-accent) 18%, transparent)'
            : 'color-mix(in srgb, var(--foreground) 8%, transparent)',
        'color': iconColor,
      },
    ),
    <Component>[iconWidget],
  );
}
