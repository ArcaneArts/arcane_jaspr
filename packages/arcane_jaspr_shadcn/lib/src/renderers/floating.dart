import 'package:arcane_jaspr/core/rendering/base/floating_render_base.dart';

/// ShadCN Floating renderer.
///
/// Unified component for tooltip, popover, and hovercard patterns.
/// Handles text tooltips and rich floating content.
///
/// Reference: https://ui.shadcn.com/docs/components/tooltip
/// Reference: https://ui.shadcn.com/docs/components/popover
/// Reference: https://ui.shadcn.com/docs/components/hover-card
class ShadcnFloating extends FloatingRenderBase {
  const ShadcnFloating(super.props, {super.key});

  @override
  String get containerClass => 'arcane-floating-container';

  @override
  String floatingContentClasses(bool hasRichContent) =>
      'arcane-floating-content';

  @override
  Map<String, String> floatingContentStyles({
    required String positionProp,
    required String positionValue,
    required Map<String, String> alignment,
    required bool hasRichContent,
    required double? maxWidth,
  }) => <String, String>{
    'position': 'absolute',
    positionProp: positionValue,
    ...alignment,
    'z-index': '50',
    if (maxWidth != null) 'max-width': '${maxWidth}px',
    if (hasRichContent) 'min-width': '180px',
    'background-color': 'var(--popover)',
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius-sm)',
    'box-shadow': 'var(--shadow-md)',
    'padding': hasRichContent ? '16px' : '6px 12px',
    'color': 'var(--popover-foreground)',
    'outline': 'none',
  };

  @override
  String get arrowClass => 'arcane-floating-arrow';

  @override
  Map<String, String> arrowStyles(Map<String, String> arrowPositionStyles) =>
      <String, String>{
        'position': 'absolute',
        'width': '12px',
        'height': '12px',
        'background-color': 'var(--popover)',
        'border-left': '1px solid var(--border)',
        'border-top': '1px solid var(--border)',
        ...arrowPositionStyles,
      };

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'arcane-floating-$_autoCounter';
  }
}
