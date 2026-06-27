import 'package:arcane_jaspr/core/rendering/base/spec_row_render_base.dart';

/// Neon SpecRow renderer.
///
/// Displays a label-value pair with space-between layout.
/// Used in pricing cards for specifications.
class NeonSpecRow extends SpecRowRenderBase {
  const NeonSpecRow(super.props, {super.key});

  @override
  String get cssPrefix => 'neon';

  @override
  String get highlightColor => 'var(--neon-accent)';

  @override
  String get valueFontWeight => 'var(--font-weight-semibold)';
}
