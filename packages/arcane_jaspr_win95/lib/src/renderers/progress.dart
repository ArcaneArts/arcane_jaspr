import 'package:arcane_jaspr/core/props/progress_props.dart';
import 'package:arcane_jaspr/core/rendering/base/progress_render_base.dart';

/// Win95 Progress Bar renderer.
class Win95Progress extends ProgressRenderBase {
  const Win95Progress(super.props, {super.key});

  @override
  String get rootClass => 'win95-progress';

  @override
  String get trackClass => 'win95-progress-track';

  @override
  String get valueClass => 'win95-progress-value';

  @override
  Map<String, String> trackStyles(ProgressProps props) =>
      const <String, String>{};

  @override
  String indicatorClasses(bool indeterminate) => indeterminate
      ? 'win95-progress-indicator indeterminate'
      : 'win95-progress-indicator';

  /// Without an explicit width the block-level indicator resolves to `auto`,
  /// which is 100% of the track, so every meter rendered permanently full. The
  /// fill is emitted as a plain percentage with no transition: a Win95 meter
  /// snapped to each new value in whole segments and never eased between them.
  /// An indeterminate meter is the hourglass instead (see win95_css.dart), so
  /// it spans the full track and lets the art centre itself.
  @override
  Map<String, String> indicatorStyles(
    ProgressProps props,
    double percentage,
    bool indeterminate,
  ) => <String, String>{
    'width': indeterminate ? '100%' : '${percentage.toStringAsFixed(2)}%',
  };

  @override
  Map<String, String> get valueStyles => const <String, String>{};
}

/// Win95 Circular Progress renderer.
class Win95CircularProgress extends CircularProgressRenderBase {
  const Win95CircularProgress(super.props, {super.key});

  @override
  String get rootClass => 'win95-circular-progress';

  @override
  Map<String, String> rootStyles(CircularProgressProps props) =>
      const <String, String>{};

  /// Feeds the swept angle to the hard-stop conic gauge in win95_css.dart. The
  /// ring itself is authored in the sheet; only the value can vary per
  /// instance, so it travels as a custom property rather than a full gradient.
  /// Emitted unconditionally: without it 5% and 95% rendered identically.
  @override
  Map<String, String> ringStyles(CircularProgressProps props) {
    final int percentage = (props.value.clamp(0.0, 1.0) * 100).round();
    return <String, String>{'--w95-gauge-pct': '$percentage%'};
  }

  @override
  bool showCenter(CircularProgressProps props) =>
      props.showPercentage || props.label != null;

  @override
  Map<String, String> get percentStyles => const <String, String>{};

  @override
  Map<String, String> get labelStyles => const <String, String>{};
}

/// Win95 Loading Spinner renderer.
class Win95LoadingSpinner extends LoadingSpinnerRenderBase {
  const Win95LoadingSpinner(super.props, {super.key});

  @override
  String get rootClass => 'win95-loading-spinner';

  @override
  Map<String, String> spinnerStyles(LoadingSpinnerProps props) =>
      const <String, String>{};
}
