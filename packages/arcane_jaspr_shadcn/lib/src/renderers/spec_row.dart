import 'package:arcane_jaspr/core/rendering/base/spec_row_render_base.dart';

/// ShadCN SpecRow renderer.
///
/// Displays a label-value pair with space-between layout.
class ShadcnSpecRow extends SpecRowRenderBase {
  const ShadcnSpecRow(super.props, {super.key});

  @override
  String get cssPrefix => 'arcane';

  @override
  String get highlightColor => 'var(--primary)';

  @override
  String get valueFontWeight => 'var(--font-weight-medium)';
}
