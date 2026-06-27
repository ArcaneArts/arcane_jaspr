import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/scroll_rail_props.dart';
import 'package:arcane_jaspr/core/rendering/base/scroll_rail_render_base.dart';

class NeonScrollRail extends ScrollRailRenderBase {
  const NeonScrollRail(super.props, {super.key});

  @override
  String get railClass => 'neon-scroll-rail';

  @override
  String get idPrefix => 'neon-scroll-rail-';

  @override
  String get defaultBackground => 'var(--neon-surface-1)';

  @override
  String borderStyle(bool showBorder) {
    if (!showBorder) {
      return 'none';
    }
    return '1px solid var(--neon-control-border)';
  }

  @override
  String get scrollbarColor => 'var(--neon-accent) transparent';
}

class NeonScrollRailLayout extends ScrollRailLayoutRenderBase {
  const NeonScrollRailLayout(super.props, {super.key});

  @override
  String get layoutClass => 'neon-scroll-rail-layout';

  @override
  String get contentClass => 'neon-scroll-rail-content';

  @override
  String get mainRailPersistenceId => 'neon-main-rail';

  @override
  String get defaultContentBackground => 'var(--neon-surface-0)';

  @override
  Component buildRail(ScrollRailProps railProps) => NeonScrollRail(railProps);
}
