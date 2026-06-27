import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

export '../../core/props/progress_props.dart'
    show ComponentSize, ProgressVariant;

/// Progress bar component with various styles.
class ArcaneProgressBar extends StatelessWidget {
  final double value;
  final ComponentSize size;
  final ProgressVariant variant;
  final bool indeterminate;
  final bool showValue;
  final String? trackColor;
  final String? indicatorColor;

  const ArcaneProgressBar({
    required this.value,
    this.size = ComponentSize.md,
    this.variant = ProgressVariant.primary,
    this.indeterminate = false,
    this.showValue = false,
    this.trackColor,
    this.indicatorColor,
    super.key,
  });

  const ArcaneProgressBar.standard({
    required this.value,
    this.size = ComponentSize.md,
    this.showValue = false,
    super.key,
  })  : variant = ProgressVariant.primary,
        indeterminate = false,
        trackColor = null,
        indicatorColor = null;

  const ArcaneProgressBar.success({
    required this.value,
    this.size = ComponentSize.md,
    this.showValue = false,
    super.key,
  })  : variant = ProgressVariant.success,
        indeterminate = false,
        trackColor = null,
        indicatorColor = null;

  const ArcaneProgressBar.warning({
    required this.value,
    this.size = ComponentSize.md,
    this.showValue = false,
    super.key,
  })  : variant = ProgressVariant.warning,
        indeterminate = false,
        trackColor = null,
        indicatorColor = null;

  const ArcaneProgressBar.error({
    required this.value,
    this.size = ComponentSize.md,
    this.showValue = false,
    super.key,
  })  : variant = ProgressVariant.error,
        indeterminate = false,
        trackColor = null,
        indicatorColor = null;

  @override
  Widget build(BuildContext context) {
    return context.renderers.progress(ProgressProps(
      value: value,
      size: size,
      variant: variant,
      indeterminate: indeterminate,
      showValue: showValue,
      trackColor: trackColor,
      indicatorColor: indicatorColor,
    ));
  }
}

/// Circular progress indicator.
class ArcaneCircularProgress extends StatelessWidget {
  final double value;
  final String? size;
  final String? strokeWidth;
  final String? fillColor;
  final String? trackColor;
  final String? label;
  final bool showPercentage;

  const ArcaneCircularProgress({
    required this.value,
    this.size,
    this.strokeWidth,
    this.fillColor,
    this.trackColor,
    this.label,
    this.showPercentage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.circularProgress(CircularProgressProps(
      value: value,
      size: size,
      strokeWidth: strokeWidth,
      fillColor: fillColor,
      trackColor: trackColor,
      label: label,
      showPercentage: showPercentage,
    ));
  }
}

/// Indeterminate loading spinner.
class ArcaneLoadingSpinner extends StatelessWidget {
  final String? size;
  final String? color;

  const ArcaneLoadingSpinner({
    this.size,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.loadingSpinner(LoadingSpinnerProps(
      size: size,
      color: color,
    ));
  }
}
