import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/stat_card_render_base.dart';

import 'decoration_styles.dart';

/// Neon stat-card renderer.
class NeonStatCard extends StatCardRenderBase {
  const NeonStatCard(super.props, {super.key});

  @override
  String get cssClass => 'neon-stat-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neonDecorationStyles(decoration);
}

/// Neon stat-card-row renderer.
class NeonStatCardRow extends StatCardRowRenderBase {
  const NeonStatCardRow(super.props, {super.key});

  @override
  String get cssClass => 'neon-stat-card-row';
}
