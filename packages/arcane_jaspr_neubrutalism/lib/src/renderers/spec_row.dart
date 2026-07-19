import 'package:arcane_jaspr/core/rendering/base/spec_row_render_base.dart';

/// Neubrutalism SpecRow renderer.
///
/// Displays a label-value pair with space-between layout.
/// Used in pricing cards for specifications.
class NeubrutalismSpecRow extends SpecRowRenderBase {
  const NeubrutalismSpecRow(super.props, {super.key});

  @override
  String get cssPrefix => 'neubrutalism';

  @override
  String get highlightColor => 'var(--nb-accent, var(--primary))';

  @override
  String get valueFontWeight => 'var(--font-weight-semibold)';
}
