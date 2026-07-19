import 'package:arcane_jaspr/core/props/progress_props.dart';
import 'package:arcane_jaspr/core/rendering/base/progress_render_base.dart';

/// Neubrutalism Progress Bar renderer.
///
/// Implements the Neubrutalism design language:
/// - Larger track heights (1.25x)
/// - Accent-colored indicator with subtle glow
/// - Larger border radius
class NeubrutalismProgress extends ProgressRenderBase {
  const NeubrutalismProgress(super.props, {super.key});

  @override
  String get rootClass => 'neubrutalism-progress';

  @override
  String get trackClass => 'neubrutalism-progress-track';

  @override
  String get valueClass => 'neubrutalism-progress-value';

  @override
  Map<String, String> trackStyles(ProgressProps props) {
    final String trackHeight = switch (props.size) {
      ComponentSize.small => '8px',
      ComponentSize.medium => '12px',
      ComponentSize.large => '16px',
    };
    return <String, String>{
      'position': 'relative',
      'width': '100%',
      'height': trackHeight,
      'background-color': props.trackColor ?? 'var(--nb-paper, var(--card))',
      'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
      'border-radius': '9999px',
      'overflow': 'hidden',
      'box-shadow':
          'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
    };
  }

  @override
  String indicatorClasses(bool indeterminate) => indeterminate
      ? 'neubrutalism-progress-indicator neubrutalism-progress-fill indeterminate'
      : 'neubrutalism-progress-indicator neubrutalism-progress-fill';

  @override
  Map<String, String> indicatorStyles(
    ProgressProps props,
    double percentage,
    bool indeterminate,
  ) {
    final String indicatorColor = switch (props.variant) {
      ProgressVariant.primary =>
        props.indicatorColor ?? 'var(--nb-accent, var(--primary))',
      ProgressVariant.success => props.indicatorColor ?? 'var(--success)',
      ProgressVariant.warning => props.indicatorColor ?? 'var(--warning)',
      ProgressVariant.error => props.indicatorColor ?? 'var(--destructive)',
      ProgressVariant.info => props.indicatorColor ?? 'var(--info)',
    };

    return <String, String>{
      'position': 'absolute',
      'top': '0',
      'left': '0',
      'height': '100%',
      'width': indeterminate ? '40%' : '$percentage%',
      'background-color': indicatorColor,
      'border-right': indeterminate
          ? 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)'
          : (percentage < 100
                ? 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)'
                : 'none'),
      if (indeterminate)
        'animation':
            'neubrutalism-progress-indeterminate 1.5s ease-in-out infinite'
      else
        'transition': 'width var(--nb-transition, 120ms ease)',
    };
  }

  @override
  Map<String, String> get valueStyles => <String, String>{
    'margin-top': '0.5rem',
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-xs)',
    'font-weight': '800',
    'color': 'var(--foreground)',
    'text-align': 'right',
    'font-variant-numeric': 'tabular-nums',
    'letter-spacing': '0.04em',
  };
}

class NeubrutalismCircularProgress extends CircularProgressRenderBase {
  const NeubrutalismCircularProgress(super.props, {super.key});

  @override
  String get rootClass => 'neubrutalism-circular-progress';

  @override
  Map<String, String> rootStyles(CircularProgressProps props) {
    final String size = props.size ?? '64px';
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
    final String strokeWidth = props.strokeWidth ?? '8px';
    final String fillColor =
        props.fillColor ?? 'var(--nb-accent, var(--primary))';
    final String trackColor =
        props.trackColor ?? 'var(--nb-paper-soft, var(--card))';
    return <String, String>{
      'position': 'absolute',
      'width': '100%',
      'height': '100%',
      'border-radius': '9999px',
      'background':
          'conic-gradient($fillColor 0deg ${clampedValue * 360}deg, $trackColor ${clampedValue * 360}deg 360deg)',
      'mask':
          'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
      '-webkit-mask':
          'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
      'transition': 'background var(--nb-transition, 120ms ease)',
    };
  }

  @override
  bool showCenter(CircularProgressProps props) =>
      props.showPercentage || props.label != null;

  @override
  Map<String, String> get percentStyles => <String, String>{
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-sm)',
    'font-weight': '900',
    'color': 'var(--foreground)',
    'font-variant-numeric': 'tabular-nums',
    'letter-spacing': '0.02em',
  };

  @override
  Map<String, String> get labelStyles => <String, String>{
    'font-family': 'var(--font-heading)',
    'font-size': '0.625rem',
    'font-weight': '700',
    'color': 'var(--foreground)',
    'margin-top': '0.125rem',
    'text-transform': 'uppercase',
    'letter-spacing': '0.06em',
  };
}

class NeubrutalismLoadingSpinner extends LoadingSpinnerRenderBase {
  const NeubrutalismLoadingSpinner(super.props, {super.key});

  @override
  String get rootClass => 'neubrutalism-loading-spinner';

  @override
  Map<String, String> spinnerStyles(LoadingSpinnerProps props) {
    final String size = props.size ?? '24px';
    final String color = props.color ?? 'var(--nb-accent, var(--primary))';
    return <String, String>{
      'display': 'inline-block',
      'width': size,
      'height': size,
      'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
      'border-right-color': color,
      'border-radius': '9999px',
      'animation': 'arcane-spin 0.75s linear infinite',
      'box-sizing': 'border-box',
    };
  }
}
