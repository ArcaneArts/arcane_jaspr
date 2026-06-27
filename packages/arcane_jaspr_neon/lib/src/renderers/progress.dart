import 'package:arcane_jaspr/core/props/progress_props.dart';
import 'package:arcane_jaspr/core/rendering/base/progress_render_base.dart';

/// Neon Progress Bar renderer.
///
/// Implements the Neon design language:
/// - Larger track heights (1.25x)
/// - Accent-colored indicator with subtle glow
/// - Larger border radius
class NeonProgress extends ProgressRenderBase {
  const NeonProgress(super.props, {super.key});

  @override
  String get rootClass => 'neon-progress';

  @override
  String get trackClass => 'neon-progress-track';

  @override
  String get valueClass => 'neon-progress-value';

  @override
  Map<String, String> trackStyles(ProgressProps props) {
    // Neon track heights - 1.25x larger
    final String trackHeight = switch (props.size) {
      ComponentSize.small => '4px', // vs ShadCN 2px
      ComponentSize.medium => '6px', // vs ShadCN 4px
      ComponentSize.large => '10px', // vs ShadCN 8px
    };
    return <String, String>{
      'position': 'relative',
      'width': '100%',
      'height': trackHeight,
      'background-color': props.trackColor ?? 'var(--muted)',
      'border-radius': 'var(--arcane-radius-full)',
      'overflow': 'hidden',
    };
  }

  @override
  String indicatorClasses(bool indeterminate) =>
      indeterminate ? 'neon-progress-indicator indeterminate' : 'neon-progress-indicator';

  @override
  Map<String, String> indicatorStyles(
    ProgressProps props,
    double percentage,
    bool indeterminate,
  ) {
    // Neon variant colors with accent as primary
    final (String indicatorColor, String? glowColor) = switch (props.variant) {
      ProgressVariant.primary => (
        props.indicatorColor ?? 'var(--neon-accent)',
        '0 0 15px color-mix(in srgb, var(--neon-accent) 24%, transparent)',
      ),
      ProgressVariant.success => (
        props.indicatorColor ?? 'var(--success)',
        '0 0 10px rgba(var(--success-rgb), 0.25)',
      ),
      ProgressVariant.warning => (
        props.indicatorColor ?? 'var(--warning)',
        null,
      ),
      ProgressVariant.error => (
        props.indicatorColor ?? 'var(--destructive)',
        '0 0 10px rgba(var(--destructive-rgb), 0.25)',
      ),
      ProgressVariant.info => (
        props.indicatorColor ?? 'var(--info)',
        '0 0 10px rgba(var(--info-rgb), 0.25)',
      ),
    };

    return <String, String>{
      'position': 'absolute',
      'top': '0',
      'left': '0',
      'height': '100%',
      'width': indeterminate ? '40%' : '$percentage%',
      'background-color': indicatorColor,
      'border-radius': 'var(--arcane-radius-full)',
      'box-shadow': ?glowColor,
      if (indeterminate)
        'animation': 'neon-progress-indeterminate 1.5s ease-in-out infinite'
      else
        'transition': 'width 0.3s ease-out',
    };
  }

  @override
  Map<String, String> get valueStyles => <String, String>{
    'margin-top': '0.5rem',
    'font-size': 'var(--font-size-xs)',
    'font-weight': 'var(--font-weight-medium)',
    'color': 'var(--muted-foreground)',
    'text-align': 'right',
    'font-variant-numeric': 'tabular-nums',
  };
}

/// Neon Circular Progress renderer.
class NeonCircularProgress extends CircularProgressRenderBase {
  const NeonCircularProgress(super.props, {super.key});

  @override
  String get rootClass => 'neon-circular-progress';

  @override
  Map<String, String> rootStyles(CircularProgressProps props) {
    final String size = props.size ?? '64px'; // Neon: slightly larger default
    return <String, String>{
      'position': 'relative',
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'width': size,
      'height': size,
    };
  }

  @override
  Map<String, String> ringStyles(CircularProgressProps props) {
    final double clampedValue = props.value.clamp(0.0, 1.0);
    final String strokeWidth = props.strokeWidth ?? '6px'; // Neon: thicker stroke
    final String fillColor = props.fillColor ?? 'var(--neon-accent)';
    final String trackColor = props.trackColor ?? 'var(--muted)';
    return <String, String>{
      'position': 'absolute',
      'width': '100%',
      'height': '100%',
      'border-radius': 'var(--arcane-radius-full)',
      'background':
          'conic-gradient($fillColor 0deg ${clampedValue * 360}deg, $trackColor ${clampedValue * 360}deg 360deg)',
      'mask':
          'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
      '-webkit-mask':
          'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
      // Neon: subtle glow
      'transition': 'all 0.3s ease-out',
    };
  }

  @override
  bool showCenter(CircularProgressProps props) =>
      props.showPercentage || props.label != null;

  @override
  Map<String, String> get percentStyles => <String, String>{
    'font-size': 'var(--font-size-sm)',
    'font-weight': 'var(--font-weight-semibold)',
    'color': 'var(--foreground)',
    'font-variant-numeric': 'tabular-nums',
  };

  @override
  Map<String, String> get labelStyles => <String, String>{
    'font-size': '0.625rem',
    'color': 'var(--muted-foreground)',
    'margin-top': '0.125rem',
  };
}

/// Neon Loading Spinner renderer.
class NeonLoadingSpinner extends LoadingSpinnerRenderBase {
  const NeonLoadingSpinner(super.props, {super.key});

  @override
  String get rootClass => 'neon-loading-spinner';

  @override
  Map<String, String> spinnerStyles(LoadingSpinnerProps props) {
    final String size = props.size ?? '24px';
    final String color = props.color ?? 'var(--neon-accent)';
    return <String, String>{
      'display': 'inline-block',
      'width': size,
      'height': size,
      'border': '2px solid color-mix(in srgb, $color 12%, transparent)',
      'border-top-color': color,
      'border-radius': 'var(--arcane-radius-full)',
      'animation': 'arcane-spin 0.75s linear infinite',
      'box-shadow': '0 0 14px color-mix(in srgb, $color 35%, transparent)',
    };
  }
}
