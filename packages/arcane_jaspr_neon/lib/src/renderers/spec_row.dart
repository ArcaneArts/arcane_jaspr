import 'package:arcane_jaspr/core/rendering/base/spec_row_render_base.dart';

/// Neon SpecRow renderer (neutralized skeleton).
class NeonSpecRow extends SpecRowRenderBase {
  const NeonSpecRow(super.props, {super.key});

  @override
  String get cssPrefix => 'neon';

  @override
  String get highlightColor => 'var(--foreground)';

  @override
  String get valueFontWeight => 'var(--font-weight-semibold)';
}
