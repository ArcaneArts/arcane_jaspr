import 'package:arcane_jaspr/core/rendering/base/floating_render_base.dart';

/// ShadCN Floating renderer.
///
/// Unified component for tooltip, popover, and hovercard patterns.
/// Handles text tooltips with CSS :hover, and rich content with state management.
///
/// Reference: https://ui.shadcn.com/docs/components/tooltip
/// Reference: https://ui.shadcn.com/docs/components/popover
/// Reference: https://ui.shadcn.com/docs/components/hover-card
class ShadcnFloating extends FloatingRenderBase {
  const ShadcnFloating(super.props, {super.key});

  @override
  String get triggerClass => 'arcane-floating-trigger';

  @override
  String get containerClass => 'arcane-floating-container';

  @override
  String get cssTooltipClasses => 'arcane-floating arcane-floating-tooltip';

  @override
  Map<String, String> cssTooltipStyles(Map<String, String> positionStyles) =>
      <String, String>{
        'position': 'absolute',
        'z-index': '50',
        'padding': '6px 12px',
        'max-width': '${props.maxWidth ?? 250}px',
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-medium)',
        'line-height': '1.4',
        'color': 'var(--popover-foreground)',
        'background-color': 'var(--popover)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-sm)',
        'box-shadow': 'var(--shadow-md)',
        'overflow': 'hidden',
        'white-space': 'nowrap',
        'pointer-events': 'none',
        'opacity': '0',
        'visibility': 'hidden',
        'transition':
            'opacity var(--transition), visibility var(--transition), transform var(--transition)',
        ...positionStyles,
      };

  @override
  String floatingContentClasses(bool hasRichContent) => 'arcane-floating-content';

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
