import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// Dot indicator size variants
enum DotIndicatorSize {
  /// Small dots (6px)
  sm,

  /// Medium dots (8px) - default
  md,

  /// Large dots (10px)
  lg,
}

/// Dot indicator for carousels, steppers, and page indicators.
///
/// ```dart
/// ArcaneDotIndicator(
///   index: currentPage,
///   length: totalPages,
///   onChanged: (index) => setState(() => currentPage = index),
/// )
/// ```
class ArcaneDotIndicator extends StatelessComponent {
  /// Currently active index
  final int index;

  /// Total number of dots
  final int length;

  /// Callback when a dot is tapped
  final void Function(int)? onChanged;

  /// Size variant
  final DotIndicatorSize size;

  /// Active dot color
  final String? activeColor;

  /// Inactive dot color
  final String? inactiveColor;

  /// Spacing between dots
  final String? spacing;

  /// Whether dots are interactive (clickable)
  final bool interactive;

  const ArcaneDotIndicator({
    required this.index,
    required this.length,
    this.onChanged,
    this.size = DotIndicatorSize.md,
    this.activeColor,
    this.inactiveColor,
    this.spacing,
    this.interactive = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final dotSize = switch (size) {
      DotIndicatorSize.sm => '6px',
      DotIndicatorSize.md => '8px',
      DotIndicatorSize.lg => '10px',
    };

    final effectiveSpacing = spacing ?? ArcaneSpacing.sm;
    final effectiveActiveColor = activeColor ?? ArcaneColors.accent;
    final effectiveInactiveColor = inactiveColor ?? ArcaneColors.surfaceVariant;

    return div(
      classes: 'arcane-dot-indicator',
      attributes: {
        'role': 'tablist',
        'aria-label': 'Page indicators',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': effectiveSpacing,
      }),
      [
        for (var i = 0; i < length; i++)
          button(
            type: ButtonType.button,
            classes: 'arcane-dot ${i == index ? 'active' : ''}',
            attributes: {
              'role': 'tab',
              'aria-selected': '${i == index}',
              'aria-label': 'Page ${i + 1} of $length',
              if (!interactive) 'disabled': 'true',
            },
            styles: Styles(raw: {
              'width': i == index ? 'calc($dotSize * 2)' : dotSize,
              'height': dotSize,
              'border-radius': ArcaneRadius.full,
              'background': i == index
                  ? effectiveActiveColor
                  : effectiveInactiveColor,
              'border': 'none',
              'padding': '0',
              'cursor': interactive ? 'pointer' : 'default',
              'transition': 'all 0.2s ease',
            }),
            events: interactive && onChanged != null
                ? {'click': (_) => onChanged!(i)}
                : null,
            [],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-dot:hover:not(:disabled):not(.active)').styles(raw: {
      'background': ArcaneColors.muted,
    }),
    css('.arcane-dot:focus-visible').styles(raw: {
      'outline': '2px solid ${ArcaneColors.accent}',
      'outline-offset': '2px',
    }),
  ];
}

/// A more elaborate step indicator with labels.
///
/// ```dart
/// ArcaneStepIndicator(
///   currentStep: 2,
///   steps: ['Account', 'Profile', 'Review', 'Complete'],
///   onStepTap: (step) => goToStep(step),
/// )
/// ```
class ArcaneStepIndicator extends StatelessComponent {
  /// Current step (0-indexed)
  final int currentStep;

  /// List of step labels
  final List<String> steps;

  /// Callback when a step is tapped
  final void Function(int)? onStepTap;

  /// Whether completed steps are clickable
  final bool allowStepNavigation;

  /// Size variant
  final StepIndicatorSize size;

  const ArcaneStepIndicator({
    required this.currentStep,
    required this.steps,
    this.onStepTap,
    this.allowStepNavigation = true,
    this.size = StepIndicatorSize.md,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (circleSize, fontSize, lineHeight) = switch (size) {
      StepIndicatorSize.sm => ('24px', ArcaneTypography.fontXs, '2px'),
      StepIndicatorSize.md => ('32px', ArcaneTypography.fontSm, '3px'),
      StepIndicatorSize.lg => ('40px', ArcaneTypography.fontMd, '4px'),
    };

    return div(
      classes: 'arcane-step-indicator',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
      }),
      [
        for (var i = 0; i < steps.length; i++) ...[
          // Step item
          div(
            classes: 'arcane-step-item',
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'gap': ArcaneSpacing.xs,
            }),
            [
              // Circle
              button(
                type: ButtonType.button,
                classes: 'arcane-step-circle ${i < currentStep ? 'completed' : ''} ${i == currentStep ? 'active' : ''}',
                attributes: {
                  if (i == currentStep) 'aria-current': 'step',
                  if (!allowStepNavigation || i > currentStep) 'disabled': 'true',
                },
                styles: Styles(raw: {
                  'width': circleSize,
                  'height': circleSize,
                  'border-radius': ArcaneRadius.full,
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': fontSize,
                  'font-weight': ArcaneTypography.weightMedium,
                  'border': 'none',
                  'background': i <= currentStep
                      ? ArcaneColors.accent
                      : ArcaneColors.surfaceVariant,
                  'color': i <= currentStep
                      ? ArcaneColors.accentForeground
                      : ArcaneColors.muted,
                  'cursor': allowStepNavigation && i <= currentStep
                      ? 'pointer'
                      : 'default',
                  'transition': ArcaneEffects.transitionFast,
                }),
                events: allowStepNavigation && i <= currentStep && onStepTap != null
                    ? {'click': (_) => onStepTap!(i)}
                    : null,
                [
                  if (i < currentStep)
                    text('✓')
                  else
                    text('${i + 1}'),
                ],
              ),

              // Label
              span(
                styles: Styles(raw: {
                  'font-size': fontSize,
                  'color': i == currentStep
                      ? ArcaneColors.onSurface
                      : ArcaneColors.muted,
                  'font-weight': i == currentStep
                      ? ArcaneTypography.weightMedium
                      : ArcaneTypography.weightNormal,
                  'text-align': 'center',
                  'white-space': 'nowrap',
                }),
                [text(steps[i])],
              ),
            ],
          ),

          // Connector line (not after last step)
          if (i < steps.length - 1)
            div(
              classes: 'arcane-step-connector',
              styles: Styles(raw: {
                'flex': '1',
                'height': lineHeight,
                'margin': '0 ${ArcaneSpacing.sm}',
                'margin-top': 'calc($circleSize / 2 - $lineHeight / 2)',
                'background': i < currentStep
                    ? ArcaneColors.accent
                    : ArcaneColors.border,
                'transition': ArcaneEffects.transitionFast,
              }),
              [],
            ),
        ],
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-step-circle:hover:not(:disabled)').styles(raw: {
      'transform': 'scale(1.1)',
    }),
    css('.arcane-step-circle:focus-visible').styles(raw: {
      'outline': '2px solid ${ArcaneColors.accent}',
      'outline-offset': '2px',
    }),
  ];
}

/// Size variants for step indicator
enum StepIndicatorSize {
  sm,
  md,
  lg,
}
