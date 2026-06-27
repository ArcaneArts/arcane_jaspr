import 'package:arcane_jaspr/core/rendering/base/floating_render_base.dart';

/// Neon Floating renderer.
///
/// Unified component for tooltip, popover, and hovercard patterns.
/// Implements the Neon design language with subtle glow effects.
class NeonFloating extends FloatingRenderBase {
  const NeonFloating(super.props, {super.key});

  @override
  String get triggerClass => 'neon-floating-trigger';

  @override
  String get containerClass => 'neon-floating-container';

  @override
  String get cssTooltipClasses =>
      'neon-floating neon-floating-tooltip neon-tooltip';

  @override
  Map<String, String> cssTooltipStyles(Map<String, String> positionStyles) =>
      <String, String>{
        'position': 'absolute',
        'z-index': '50',
        'padding': '6px 10px',
        'max-width': '${props.maxWidth ?? 250}px',
        'font-size': 'var(--arcane-font-size-sm)',
        'font-weight': '500',
        'line-height': '1.4',
        'color': 'var(--popover-foreground)',
        'overflow': 'hidden',
        'white-space': 'nowrap',
        'pointer-events': 'none',
        'opacity': '0',
        'visibility': 'hidden',
        'transition':
            'opacity 0.15s ease, visibility 0.15s ease, transform 0.15s ease',
        ...positionStyles,
      };

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
  }) => <String, String>{
    'position': 'absolute',
    positionProp: positionValue,
    ...alignment,
    'z-index': '50',
    if (maxWidth != null) 'max-width': '${maxWidth}px',
    if (hasRichContent) 'min-width': '200px',
    'padding': hasRichContent ? '14px 16px' : '6px 10px',
    'color': 'var(--popover-foreground)',
    'outline': 'none',
  };

  @override
  String get arrowClass => 'neon-floating-arrow';

  @override
  Map<String, String> arrowStyles(Map<String, String> arrowPositionStyles) =>
      <String, String>{
        'position': 'absolute',
        'width': '10px',
        'height': '10px',
        'background': 'var(--neon-panel-tint)',
        'border-left': '1px solid var(--neon-panel-border)',
        'border-top': '1px solid var(--neon-panel-border)',
        ...arrowPositionStyles,
      };

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neon-floating-$_autoCounter';
  }
}
