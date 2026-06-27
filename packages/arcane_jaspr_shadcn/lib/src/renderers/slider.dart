import 'package:arcane_jaspr/core/props/slider_props.dart';
import 'package:arcane_jaspr/core/rendering/base/slider_render_base.dart';

/// ShadCN Slider renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/slider
class ShadcnSlider extends SliderRenderBase {
  const ShadcnSlider(super.props, {super.key});

  String get _fillColor => switch (props.variant) {
    SliderVariant.primary => 'var(--primary)',
    SliderVariant.success => 'var(--success, #22c55e)',
    SliderVariant.warning => 'var(--warning, #f59e0b)',
    SliderVariant.error => 'var(--destructive)',
  };

  @override
  String get classPrefix => 'arcane-slider';

  @override
  String get labelRowMarginBottom => '0.5rem';

  @override
  String get minMaxRowMarginTop => '0.25rem';

  @override
  int get maxStepMarkers => 20;

  @override
  Map<String, String> extraRootAttrs() => const <String, String>{};

  @override
  Map<String, String> thumbStateAttrs() => const <String, String>{};

  @override
  (String, String, String) sizeMetrics(ComponentSize size) => switch (size) {
    ComponentSize.sm => ('6px', '16px', '24px'),
    ComponentSize.md => ('8px', '20px', '32px'), // ShadCN default h-2 (8px)
    ComponentSize.lg => ('10px', '24px', '40px'),
  };

  @override
  double percentFor(double current) =>
      ((current - props.min) / (props.max - props.min) * 100).clamp(0.0, 100.0);

  @override
  Map<String, String> labelTextStyles() => const <String, String>{
    'font-size': 'var(--font-size-sm)',
    'font-weight': 'var(--font-weight-medium)',
    'color': 'var(--foreground)',
  };

  @override
  Map<String, String> valueTextStyles() => const <String, String>{
    'font-size': 'var(--font-size-sm)',
    'font-weight': 'var(--font-weight-medium)',
    'font-variant-numeric': 'tabular-nums',
    'color': 'var(--muted-foreground)',
    'min-width': '40px',
    'text-align': 'right',
  };

  @override
  Map<String, String> trackStyles(String trackHeight) => <String, String>{
    'position': 'absolute',
    'left': '0',
    'right': '0',
    'height': trackHeight,
    'background-color': 'var(--secondary)',
    'border-radius': 'var(--radius-full)',
    'overflow': 'hidden',
  };

  @override
  Map<String, String> trackFillStyles({
    required bool isRange,
    required double percentage,
    required double loPct,
    required double hiPct,
  }) {
    if (!isRange) {
      return <String, String>{
        'position': 'absolute',
        'left': '0',
        'top': '0',
        'width': '$percentage%',
        'height': '100%',
        'background-color': _fillColor,
        'transition': 'width 0.1s ease-out',
      };
    }
    return <String, String>{
      'position': 'absolute',
      'left': '$loPct%',
      'right': '${100 - hiPct}%',
      'top': '0',
      'height': '100%',
      'background-color': _fillColor,
      'transition': 'left 0.1s ease-out, right 0.1s ease-out',
    };
  }

  @override
  Map<String, String> stepMarkerStyles() => const <String, String>{
    'width': '2px',
    'height': '2px',
    'background': 'var(--muted-foreground)',
    'border-radius': 'var(--radius-full)',
  };

  @override
  Map<String, String> thumbStyles({
    required double leftPct,
    required String thumbSize,
    required int thumbSizeNum,
  }) => <String, String>{
    'position': 'absolute',
    'left': 'calc($leftPct% - ${thumbSizeNum / 2}px)',
    'top': '50%',
    'transform': 'translateY(-50%)',
    'width': thumbSize,
    'height': thumbSize,
    'background-color': 'var(--background)',
    'border': '2px solid $_fillColor',
    'border-radius': 'var(--radius-full)',
    'transition':
        'left 0.1s ease-out, color var(--transition), transform var(--transition), box-shadow var(--transition)',
    'z-index': '2',
    'cursor': props.disabled ? 'not-allowed' : 'grab',
  };

  @override
  Map<String, String> minMaxLabelStyles() => const <String, String>{
    'font-size': 'var(--font-size-xs)',
    'color': 'var(--muted-foreground)',
  };
}
