import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

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

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneProgressBar({
    required this.value,
    this.size = ComponentSize.md,
    this.variant = ProgressVariant.primary,
    this.indeterminate = false,
    this.showValue = false,
    this.trackColor,
    this.indicatorColor,
    this.styles,
    this.decoration,
    super.key,
  });

  const ArcaneProgressBar.standard({
    required this.value,
    this.size = ComponentSize.md,
    this.showValue = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ProgressVariant.primary,
       indeterminate = false,
       trackColor = null,
       indicatorColor = null;

  const ArcaneProgressBar.success({
    required this.value,
    this.size = ComponentSize.md,
    this.showValue = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ProgressVariant.success,
       indeterminate = false,
       trackColor = null,
       indicatorColor = null;

  const ArcaneProgressBar.warning({
    required this.value,
    this.size = ComponentSize.md,
    this.showValue = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ProgressVariant.warning,
       indeterminate = false,
       trackColor = null,
       indicatorColor = null;

  const ArcaneProgressBar.error({
    required this.value,
    this.size = ComponentSize.md,
    this.showValue = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ProgressVariant.error,
       indeterminate = false,
       trackColor = null,
       indicatorColor = null;

  @override
  Widget build(BuildContext context) {
    return context.renderers.progress(
      ProgressProps(
        value: value,
        size: size,
        variant: variant,
        indeterminate: indeterminate,
        showValue: showValue,
        trackColor: trackColor,
        indicatorColor: indicatorColor,
        styles: styles,
        decoration: decoration,
      ),
    );
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

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneCircularProgress({
    required this.value,
    this.size,
    this.strokeWidth,
    this.fillColor,
    this.trackColor,
    this.label,
    this.showPercentage = true,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.circularProgress(
      CircularProgressProps(
        value: value,
        size: size,
        strokeWidth: strokeWidth,
        fillColor: fillColor,
        trackColor: trackColor,
        label: label,
        showPercentage: showPercentage,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}

/// Indeterminate loading spinner.
class ArcaneLoadingSpinner extends StatelessWidget {
  final String? size;
  final String? color;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneLoadingSpinner({
    this.size,
    this.color,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.loadingSpinner(
      LoadingSpinnerProps(
        size: size,
        color: color,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}
