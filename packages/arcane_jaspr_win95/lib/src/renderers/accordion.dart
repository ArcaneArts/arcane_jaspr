import 'package:arcane_jaspr/core/rendering/base/accordion_render_base.dart';

/// Win95 Accordion renderer (neutralized skeleton).
///
/// Uses native HTML details/summary elements for reliable expand/collapse
/// behavior that works in SSR environments without JavaScript hydration issues.
class Win95Accordion extends AccordionRenderBase {
  const Win95Accordion(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

  @override
  String get accentColorFallback => 'currentColor';

  @override
  Map<String, String> detailsStyles() => const <String, String>{};

  @override
  Map<String, String> categoryBadgeStyles(String accentColor) =>
      const <String, String>{};

  @override
  Map<String, String> chevronStyles(String accentColor) =>
      const <String, String>{};

  @override
  String get contentBorderTop => 'none';
}
