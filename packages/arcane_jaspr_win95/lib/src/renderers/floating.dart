import 'package:arcane_jaspr/core/rendering/base/floating_render_base.dart';

/// Win95 Floating renderer.
///
/// Unified component for tooltip, popover, and hovercard patterns.
class Win95Floating extends FloatingRenderBase {
  const Win95Floating(super.props, {super.key});

  @override
  String get containerClass => 'win95-floating-container';

  @override
  String floatingContentClasses(bool hasRichContent) => hasRichContent
      ? 'win95-floating-content win95-popover'
      : 'win95-floating-content win95-tooltip';

  @override
  Map<String, String> floatingContentStyles({
    required String positionProp,
    required String positionValue,
    required Map<String, String> alignment,
    required bool hasRichContent,
    required double? maxWidth,
  }) => const <String, String>{};

  @override
  String get arrowClass => 'win95-floating-arrow';

  @override
  Map<String, String> arrowStyles(Map<String, String> arrowPositionStyles) =>
      const <String, String>{};

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'win95-floating-$_autoCounter';
  }
}
