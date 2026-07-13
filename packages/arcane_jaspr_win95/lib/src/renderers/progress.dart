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

  @override
  Map<String, String> indicatorStyles(
    ProgressProps props,
    double percentage,
    bool indeterminate,
  ) => const <String, String>{};

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

/// Win95 Loading Spinner renderer.
class Win95LoadingSpinner extends LoadingSpinnerRenderBase {
  const Win95LoadingSpinner(super.props, {super.key});

  @override
  String get rootClass => 'win95-loading-spinner';

  @override
  Map<String, String> spinnerStyles(LoadingSpinnerProps props) =>
      const <String, String>{};
}
