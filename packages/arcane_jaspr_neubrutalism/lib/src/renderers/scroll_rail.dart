import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/scroll_rail_props.dart';
import 'package:arcane_jaspr/core/rendering/base/scroll_rail_render_base.dart';

class NeubrutalismScrollRail extends ScrollRailRenderBase {
  const NeubrutalismScrollRail(super.props, {super.key});

  @override
  String get railClass => 'neubrutalism-scroll-rail';

  @override
  String get idPrefix => 'neubrutalism-scroll-rail-';

  @override
  String get defaultBackground => 'var(--nb-paper, var(--card))';

  @override
  String borderStyle(bool showBorder) {
    if (!showBorder) {
      return 'none';
    }
    return 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)';
  }

  @override
  String get scrollbarColor => 'var(--nb-accent, var(--primary)) transparent';
}

class NeubrutalismScrollRailLayout extends ScrollRailLayoutRenderBase {
  const NeubrutalismScrollRailLayout(super.props, {super.key});

  @override
  String get layoutClass => 'neubrutalism-scroll-rail-layout';

  @override
  String get contentClass => 'neubrutalism-scroll-rail-content';

  @override
  String get mainRailPersistenceId => 'neubrutalism-main-rail';

  @override
  String get defaultContentBackground => 'var(--background)';

  @override
  Component buildRail(ScrollRailProps railProps) =>
      NeubrutalismScrollRail(railProps);
}
