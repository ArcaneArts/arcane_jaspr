import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Progress bar size
enum ProgressSize {
  sm,
  md,
  lg,
}

/// Progress bar component with various styles
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneProgressBar(
///   value: 0.75,
///   style: ProgressStyle.success,
/// )
/// ```
class ArcaneProgressBar extends StatelessComponent {
  final double value; // 0.0 to 1.0
  final String? label;
  final ProgressSize size;
  final ProgressStyle? style;
  final bool showPercentage;
  final bool animated;

  const ArcaneProgressBar({
    required this.value,
    this.label,
    this.size = ProgressSize.md,
    this.style,
    this.showPercentage = false,
    this.animated = true,
    super.key,
  });

  /// Standard progress bar
  const ArcaneProgressBar.standard({
    required this.value,
    this.label,
    this.size = ProgressSize.md,
    this.showPercentage = false,
    this.animated = true,
    super.key,
  }) : style = ProgressStyle.standard;

  /// Success progress bar
  const ArcaneProgressBar.success({
    required this.value,
    this.label,
    this.size = ProgressSize.md,
    this.showPercentage = false,
    this.animated = true,
    super.key,
  }) : style = ProgressStyle.success;

  /// Warning progress bar
  const ArcaneProgressBar.warning({
    required this.value,
    this.label,
    this.size = ProgressSize.md,
    this.showPercentage = false,
    this.animated = true,
    super.key,
  }) : style = ProgressStyle.warning;

  /// Error progress bar
  const ArcaneProgressBar.error({
    required this.value,
    this.label,
    this.size = ProgressSize.md,
    this.showPercentage = false,
    this.animated = true,
    super.key,
  }) : style = ProgressStyle.error;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? ProgressStyle.standard;
    final percent = (value.clamp(0.0, 1.0) * 100).round();

    final height = switch (size) {
      ProgressSize.sm => '4px',
      ProgressSize.md => '8px',
      ProgressSize.lg => '12px',
    };

    final fillGradient = effectiveStyle.gradientValue ??
        'linear-gradient(90deg, ${effectiveStyle.fillColor} 0%, ${effectiveStyle.fillColor} 100%)';

    return div(
      classes: 'arcane-progress-bar',
      styles: const Styles(raw: {
        'width': '100%',
      }),
      [
        if (label != null || showPercentage)
          div(
            classes: 'arcane-progress-bar-header',
            styles: const Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'margin-bottom': ArcaneSpacing.sm,
              'font-size': ArcaneTypography.fontMd,
            }),
            [
              if (label != null)
                span(
                  styles: const Styles(raw: {
                    'color': ArcaneColors.onSurface,
                    'font-weight': ArcaneTypography.weightMedium,
                  }),
                  [text(label!)],
                ),
              if (showPercentage)
                span(
                  styles: const Styles(raw: {
                    'color': ArcaneColors.muted,
                  }),
                  [text('$percent%')],
                ),
            ],
          ),
        // Track
        div(
          classes: 'arcane-progress-bar-track',
          styles: Styles(raw: {
            'width': '100%',
            'height': height,
            'background': effectiveStyle.trackColor,
            'border-radius': ArcaneRadius.full,
            'overflow': 'hidden',
          }),
          [
            // Fill
            div(
              classes: 'arcane-progress-bar-fill',
              styles: Styles(raw: {
                'width': '$percent%',
                'height': '100%',
                'background': fillGradient,
                'border-radius': ArcaneRadius.full,
                'transition': animated ? 'width 0.5s ease-out' : 'none',
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }
}

/// Circular progress indicator
class ArcaneCircularProgress extends StatelessComponent {
  final double value; // 0.0 to 1.0
  final String? size;
  final String? strokeWidth;
  final ProgressStyle? style;
  final String? label;
  final bool showPercentage;

  const ArcaneCircularProgress({
    required this.value,
    this.size,
    this.strokeWidth,
    this.style,
    this.label,
    this.showPercentage = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? ProgressStyle.standard;
    final percent = (value.clamp(0.0, 1.0) * 100).round();
    final actualSize = size ?? '80px';
    final actualStroke = strokeWidth ?? '8px';

    return div(
      classes: 'arcane-circular-progress',
      styles: Styles(raw: {
        'position': 'relative',
        'width': actualSize,
        'height': actualSize,
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
      }),
      [
        // Background circle using conic gradient
        div(
          styles: Styles(raw: {
            'position': 'absolute',
            'width': '100%',
            'height': '100%',
            'border-radius': ArcaneRadius.full,
            'background':
                'conic-gradient(${effectiveStyle.fillColor} 0deg ${value * 360}deg, ${effectiveStyle.trackColor} ${value * 360}deg 360deg)',
            'mask':
                'radial-gradient(farthest-side, transparent calc(100% - $actualStroke), #fff calc(100% - $actualStroke))',
            '-webkit-mask':
                'radial-gradient(farthest-side, transparent calc(100% - $actualStroke), #fff calc(100% - $actualStroke))',
          }),
          [],
        ),
        // Center content
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'justify-content': 'center',
          }),
          [
            if (showPercentage)
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontXl,
                  'font-weight': ArcaneTypography.weightBold,
                  'color': ArcaneColors.onSurface,
                }),
                [text('$percent%')],
              ),
            if (label != null)
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                }),
                [text(label!)],
              ),
          ],
        ),
      ],
    );
  }
}

/// Indeterminate loading spinner
class ArcaneLoadingSpinner extends StatelessComponent {
  final String? size;
  final String? color;

  const ArcaneLoadingSpinner({
    this.size,
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final actualSize = size ?? '24px';

    return div(
      classes: 'arcane-loading-spinner',
      styles: Styles(raw: {
        'width': actualSize,
        'height': actualSize,
        'border': '3px solid ${ArcaneColors.border}',
        'border-top-color': color ?? ArcaneColors.accent,
        'border-radius': ArcaneRadius.full,
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}