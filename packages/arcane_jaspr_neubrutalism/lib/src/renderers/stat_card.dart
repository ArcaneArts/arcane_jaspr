import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/stat_card_render_base.dart';

import 'decoration_styles.dart';

/// Neubrutalism stat-card renderer.
class NeubrutalismStatCard extends StatCardRenderBase {
  const NeubrutalismStatCard(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-stat-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neubrutalismDecorationStyles(decoration);
}

/// Neubrutalism stat-card-row renderer.
class NeubrutalismStatCardRow extends StatCardRowRenderBase {
  const NeubrutalismStatCardRow(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-stat-card-row';
}
