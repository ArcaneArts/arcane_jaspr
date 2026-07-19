import 'package:arcane_jaspr/core/props/progress_props.dart';
import 'package:arcane_jaspr/core/rendering/base/progress_render_base.dart';

/// Neon Progress Bar renderer.
class NeonProgress extends ProgressRenderBase {
  const NeonProgress(super.props, {super.key});

  @override
  String get rootClass => 'neon-progress';

  @override
  String get trackClass => 'neon-progress-track';

  @override
  String get valueClass => 'neon-progress-value';

  @override
  Map<String, String> trackStyles(ProgressProps props) =>
      const <String, String>{};

  @override
  String indicatorClasses(bool indeterminate) => indeterminate
      ? 'neon-progress-indicator indeterminate'
      : 'neon-progress-indicator';

  @override
  Map<String, String> indicatorStyles(
    ProgressProps props,
    double percentage,
    bool indeterminate,
  ) => const <String, String>{};

  @override
  Map<String, String> get valueStyles => const <String, String>{};
}

/// Neon Circular Progress renderer.
class NeonCircularProgress extends CircularProgressRenderBase {
  const NeonCircularProgress(super.props, {super.key});

  @override
  String get rootClass => 'neon-circular-progress';

  @override
  Map<String, String> rootStyles(CircularProgressProps props) =>
      const <String, String>{};

  @override
  Map<String, String> ringStyles(CircularProgressProps props) =>
      const <String, String>{};

  @override
  bool showCenter(CircularProgressProps props) =>
      props.showPercentage || props.label != null;

  @override
  Map<String, String> get percentStyles => const <String, String>{};

  @override
  Map<String, String> get labelStyles => const <String, String>{};
}

/// Neon Loading Spinner renderer.
class NeonLoadingSpinner extends LoadingSpinnerRenderBase {
  const NeonLoadingSpinner(super.props, {super.key});

  @override
  String get rootClass => 'neon-loading-spinner';

  @override
  Map<String, String> spinnerStyles(LoadingSpinnerProps props) =>
      const <String, String>{};
}
