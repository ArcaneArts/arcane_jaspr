import 'package:arcane_jaspr/core/rendering/base/floating_render_base.dart';

/// Neon Floating renderer.
///
/// Unified component for tooltip, popover, and hovercard patterns.
class NeonFloating extends FloatingRenderBase {
  const NeonFloating(super.props, {super.key});

  @override
  String get containerClass => 'neon-floating-container';

  @override
  String floatingContentClasses(bool hasRichContent) => hasRichContent
      ? 'neon-floating-content neon-popover'
      : 'neon-floating-content neon-tooltip';

  @override
  Map<String, String> floatingContentStyles({
    required String positionProp,
    required String positionValue,
    required Map<String, String> alignment,
    required bool hasRichContent,
    required double? maxWidth,
  }) => const <String, String>{};

  @override
  String get arrowClass => 'neon-floating-arrow';

  @override
  Map<String, String> arrowStyles(Map<String, String> arrowPositionStyles) =>
      const <String, String>{};

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neon-floating-$_autoCounter';
  }
}
