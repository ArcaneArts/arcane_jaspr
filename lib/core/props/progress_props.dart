import 'package:jaspr/jaspr.dart';

import '../shared/shared.dart';
import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

export '../shared/shared.dart' show ComponentSize;

enum ProgressVariant {
  primary,
  success,
  warning,
  error,
  info,
}

/// Progress bar component properties.
class ProgressProps {
  final double value;
  final ComponentSize size;
  final ProgressVariant variant;
  final bool indeterminate;
  final bool showValue;
  final String? trackColor;
  final String? indicatorColor;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ProgressProps({
    this.value = 0.0,
    this.size = ComponentSize.medium,
    this.variant = ProgressVariant.primary,
    this.indeterminate = false,
    this.showValue = false,
    this.trackColor,
    this.indicatorColor,
    this.styles,
    this.decoration,
  });

  ProgressProps copyWith({
    double? value,
    ComponentSize? size,
    ProgressVariant? variant,
    bool? indeterminate,
    bool? showValue,
    String? trackColor,
    String? indicatorColor,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return ProgressProps(
      value: value ?? this.value,
      size: size ?? this.size,
      variant: variant ?? this.variant,
      indeterminate: indeterminate ?? this.indeterminate,
      showValue: showValue ?? this.showValue,
      trackColor: trackColor ?? this.trackColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

/// Circular progress component properties.
class CircularProgressProps {
  final double value;
  final String? size;
  final String? strokeWidth;
  final String? fillColor;
  final String? trackColor;
  final String? label;
  final bool showPercentage;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const CircularProgressProps({
    required this.value,
    this.size,
    this.strokeWidth,
    this.fillColor,
    this.trackColor,
    this.label,
    this.showPercentage = true,
    this.styles,
    this.decoration,
  });
}

/// Loading spinner component properties.
class LoadingSpinnerProps {
  final String? size;
  final String? color;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const LoadingSpinnerProps({
    this.size,
    this.color,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for progress components.
mixin ProgressRendererContract {
  /// Renders a linear progress bar component.
  Component progress(ProgressProps props);

  /// Renders a circular progress indicator component.
  Component circularProgress(CircularProgressProps props);

  /// Renders a loading spinner component.
  Component loadingSpinner(LoadingSpinnerProps props);
}
