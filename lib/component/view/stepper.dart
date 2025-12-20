import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Step item data
class StepItem {
  /// Step title
  final String title;

  /// Step description
  final String? description;

  /// Whether this step is completed
  final bool completed;

  /// Whether this is the active step
  final bool active;

  const StepItem({
    required this.title,
    this.description,
    this.completed = false,
    this.active = false,
  });
}

/// Horizontal stepper for multi-step processes
class Stepper extends StatelessComponent {
  /// Steps to display
  final List<StepItem> steps;

  /// Color for active step
  final String? activeColor;

  /// Color for completed step
  final String? completedColor;

  /// Color for inactive step
  final String? inactiveColor;

  const Stepper({
    required this.steps,
    this.activeColor,
    this.completedColor,
    this.inactiveColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String effectiveActiveColor = activeColor ?? ArcaneColors.success;
    final String effectiveCompletedColor = completedColor ?? ArcaneColors.success;
    final String effectiveInactiveColor = inactiveColor ?? ArcaneColors.border;

    return div(
      classes: 'arcane-stepper',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0',
        'width': '100%',
      }),
      [
        for (var i = 0; i < steps.length; i++)
          _buildStep(steps[i], i, effectiveActiveColor, effectiveCompletedColor, effectiveInactiveColor),
      ],
    );
  }

  Component _buildStep(StepItem step, int index, String activeColor, String completedColor, String inactiveColor) {
    final bool isLast = index == steps.length - 1;
    String circleColor;
    String circleTextColor;
    String labelColor;

    if (step.completed) {
      circleColor = completedColor;
      circleTextColor = ArcaneColors.background;
      labelColor = ArcaneColors.onSurface;
    } else if (step.active) {
      circleColor = activeColor;
      circleTextColor = ArcaneColors.background;
      labelColor = ArcaneColors.onSurface;
    } else {
      circleColor = inactiveColor;
      circleTextColor = ArcaneColors.muted;
      labelColor = ArcaneColors.muted;
    }

    return div(
      classes: 'arcane-stepper-step',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'flex': isLast ? '0 0 auto' : '1',
        'min-width': '120px',
      }),
      [
        // Step indicator row
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'width': '100%',
          }),
          [
            // Circle
            div(
              styles: Styles(raw: {
                'width': '32px',
                'height': '32px',
                'border-radius': ArcaneRadius.full,
                'background': circleColor,
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'font-size': ArcaneTypography.fontSm,
                'font-weight': ArcaneTypography.weightSemibold,
                'color': circleTextColor,
                'flex-shrink': '0',
              }),
              [
                step.completed ? text('✓') : text('${index + 1}'),
              ],
            ),
            // Connector line
            if (!isLast)
              div(
                styles: Styles(raw: {
                  'flex': '1',
                  'height': '2px',
                  'background': step.completed ? completedColor : inactiveColor,
                  'margin': '0 ${ArcaneSpacing.sm}',
                }),
                [],
              ),
          ],
        ),
        // Label
        div(
          styles: const Styles(raw: {
            'margin-top': ArcaneSpacing.md,
            'text-align': 'center',
          }),
          [
            div(
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'font-weight': ArcaneTypography.weightMedium,
                'color': labelColor,
              }),
              [text(step.title)],
            ),
            if (step.description != null)
              div(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                  'margin-top': ArcaneSpacing.xs,
                }),
                [text(step.description!)],
              ),
          ],
        ),
      ],
    );
  }
}

/// Vertical stepper variant
class VerticalStepper extends StatelessComponent {
  /// Steps to display
  final List<StepItem> steps;

  /// Color for active/completed steps
  final String? activeColor;

  /// Color for inactive steps
  final String? inactiveColor;

  const VerticalStepper({
    required this.steps,
    this.activeColor,
    this.inactiveColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String effectiveActiveColor = activeColor ?? ArcaneColors.success;
    final String effectiveInactiveColor = inactiveColor ?? ArcaneColors.border;

    return div(
      classes: 'arcane-vertical-stepper',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
      }),
      [
        for (var i = 0; i < steps.length; i++)
          _buildStep(steps[i], i, effectiveActiveColor, effectiveInactiveColor),
      ],
    );
  }

  Component _buildStep(StepItem step, int index, String activeColor, String inactiveColor) {
    final bool isLast = index == steps.length - 1;
    final String dotColor = step.completed || step.active ? activeColor : inactiveColor;
    final String labelColor = step.completed || step.active ? ArcaneColors.onSurface : ArcaneColors.muted;

    return div(
      classes: 'arcane-vertical-stepper-step',
      styles: Styles(raw: {
        'display': 'flex',
        'gap': ArcaneSpacing.lg,
        'position': 'relative',
        'padding-bottom': isLast ? '0' : ArcaneSpacing.xl,
      }),
      [
        // Dot and line
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            // Dot
            div(
              styles: Styles(raw: {
                'width': '24px',
                'height': '24px',
                'border-radius': ArcaneRadius.full,
                'background': step.completed || step.active ? dotColor : ArcaneColors.background,
                'border': '2px solid $dotColor',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'font-size': ArcaneTypography.fontXs,
                'font-weight': ArcaneTypography.weightBold,
                'color': step.completed || step.active ? ArcaneColors.background : dotColor,
                'z-index': '1',
              }),
              [
                if (step.completed)
                  text('✓')
                else
                  text('${index + 1}'),
              ],
            ),
            // Line
            if (!isLast)
              div(
                styles: Styles(raw: {
                  'width': '2px',
                  'flex': '1',
                  'background': inactiveColor,
                  'position': 'absolute',
                  'top': '28px',
                  'bottom': '0',
                }),
                [],
              ),
          ],
        ),
        // Content
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'padding-top': '2px',
          }),
          [
            div(
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontMd,
                'font-weight': ArcaneTypography.weightMedium,
                'color': labelColor,
              }),
              [text(step.title)],
            ),
            if (step.description != null)
              div(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                  'margin-top': ArcaneSpacing.xs,
                  'line-height': ArcaneTypography.leadingNormal,
                }),
                [text(step.description!)],
              ),
          ],
        ),
      ],
    );
  }
}