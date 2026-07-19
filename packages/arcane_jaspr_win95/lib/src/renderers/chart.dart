import 'package:arcane_jaspr/core/rendering/base/chart_render_base.dart';

/// Win95 Chart renderer (neutralized skeleton).
class Win95Chart extends ChartRenderBase {
  const Win95Chart(super.props, {super.key});

  @override
  String get cssClass => 'win95-chart';

  @override
  Map<String, String> get rootStyles => const <String, String>{};

  @override
  Map<String, String> get titleStyles => const <String, String>{};

  @override
  Map<String, String> get descriptionStyles => const <String, String>{};

  @override
  Map<String, String> get pointRowStyles => const <String, String>{};

  @override
  Map<String, String> get pointLabelStyles => const <String, String>{};

  @override
  Map<String, String> get trackStyles => const <String, String>{};

  @override
  Map<String, String> fillStyles(String width) => const <String, String>{};

  @override
  Map<String, String> get pointValueStyles => const <String, String>{};
}
