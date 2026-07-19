import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/stat_card_render_base.dart';

import 'decoration_styles.dart';

/// Win95 stat-card renderer.
class Win95StatCard extends StatCardRenderBase {
  const Win95StatCard(super.props, {super.key});

  @override
  String get cssClass => 'win95-stat-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      win95DecorationStyles(decoration);
}

/// Win95 stat-card-row renderer.
class Win95StatCardRow extends StatCardRowRenderBase {
  const Win95StatCardRow(super.props, {super.key});

  @override
  String get cssClass => 'win95-stat-card-row';
}
