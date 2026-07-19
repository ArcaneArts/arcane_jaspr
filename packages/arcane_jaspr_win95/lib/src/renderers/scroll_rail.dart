import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/scroll_rail_props.dart';
import 'package:arcane_jaspr/core/rendering/base/scroll_rail_render_base.dart';

class Win95ScrollRail extends ScrollRailRenderBase {
  const Win95ScrollRail(super.props, {super.key});

  @override
  String get railClass => 'win95-scroll-rail';

  @override
  String get idPrefix => 'win95-scroll-rail-';

  @override
  String get defaultBackground => 'transparent';

  @override
  String borderStyle(bool showBorder) {
    if (!showBorder) {
      return 'none';
    }
    return '1px solid var(--border)';
  }

  @override
  String get scrollbarColor => 'auto';
}

class Win95ScrollRailLayout extends ScrollRailLayoutRenderBase {
  const Win95ScrollRailLayout(super.props, {super.key});

  @override
  String get layoutClass => 'win95-scroll-rail-layout';

  @override
  String get contentClass => 'win95-scroll-rail-content';

  @override
  String get mainRailPersistenceId => 'win95-main-rail';

  @override
  String get defaultContentBackground => 'transparent';

  @override
  Component buildRail(ScrollRailProps railProps) => Win95ScrollRail(railProps);
}
