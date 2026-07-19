import 'package:arcane_jaspr/core/rendering/base/floating_render_base.dart';

/// Neubrutalism Floating renderer.
///
/// Unified component for tooltip, popover, and hovercard patterns.
/// Implements the Neubrutalism design language with subtle glow effects.
class NeubrutalismFloating extends FloatingRenderBase {
  const NeubrutalismFloating(super.props, {super.key});

  @override
  String get triggerClass => 'neubrutalism-floating-trigger';

  @override
  String get containerClass => 'neubrutalism-floating-container';

  @override
  String get cssTooltipClasses =>
      'neubrutalism-floating neubrutalism-floating-tooltip neubrutalism-tooltip';

  @override
  Map<String, String> cssTooltipStyles(Map<String, String> positionStyles) =>
      <String, String>{
        'position': 'absolute',
        'z-index': '50',
        'padding': '6px 10px',
        'max-width': '${props.maxWidth ?? 250}px',
        'font-family': 'var(--font-body)',
        'font-size': 'var(--arcane-font-size-sm)',
        'font-weight': '600',
        'line-height': '1.4',
        'background': 'var(--nb-ink, #000)',
        'color': 'var(--nb-paper, #fff)',
        'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'border-radius': '0',
        'box-shadow':
            'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
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
      ? 'neubrutalism-floating-content neubrutalism-popover'
      : 'neubrutalism-floating-content neubrutalism-tooltip';

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
    if (hasRichContent) 'min-width': '220px',
    'padding': hasRichContent ? '14px 16px' : '6px 10px',
    'background': hasRichContent
        ? 'var(--nb-paper, var(--card))'
        : 'var(--nb-ink, #000)',
    'color': hasRichContent
        ? 'var(--nb-ink, var(--popover-foreground))'
        : 'var(--nb-paper, #fff)',
    'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
    'border-radius': '0',
    'box-shadow': hasRichContent
        ? 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))'
        : 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
    'outline': 'none',
  };

  @override
  String get arrowClass => 'neubrutalism-floating-arrow';

  @override
  Map<String, String> arrowStyles(Map<String, String> arrowPositionStyles) =>
      <String, String>{
        'position': 'absolute',
        'width': '10px',
        'height': '10px',
        'background': 'transparent',
        'border-left': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'border-top': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        ...arrowPositionStyles,
      };

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neubrutalism-floating-$_autoCounter';
  }
}
