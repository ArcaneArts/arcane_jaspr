import 'package:arcane_jaspr/core/rendering/base/spec_row_render_base.dart';

/// Win95 SpecRow renderer (neutralized skeleton).
class Win95SpecRow extends SpecRowRenderBase {
  const Win95SpecRow(super.props, {super.key});

  @override
  String get cssPrefix => 'win95';

  @override
  String get highlightColor => 'var(--foreground)';

  @override
  String get valueFontWeight => 'var(--font-weight-semibold)';
}
