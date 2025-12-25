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

/// Steps layout options
enum StepsLayout {
  /// Vertical layout with numbers on the left
  vertical,

  /// Horizontal layout with numbers on top
  horizontal,
}

/// Step status
enum StepStatus {
  /// Completed step
  complete,

  /// Current/active step
  current,

  /// Pending/upcoming step
  pending,
}

/// Step item data
class ArcaneStepItem {
  /// Step title
  final String title;

  /// Step description
  final String? description;

  /// Step status
  final StepStatus status;

  /// Optional custom content
  final Component? content;

  const ArcaneStepItem({
    required this.title,
    this.description,
    this.status = StepStatus.pending,
    this.content,
  });
}

/// Steps size options
enum StepsSize {
  sm,
  md,
  lg,
}

/// A numbered steps component for showing progress through a process.
///
/// Supports vertical and horizontal layouts with numbered indicators.
///
/// ```dart
/// ArcaneSteps(
///   items: [
///     ArcaneStepItem(
///       title: 'Account',
///       description: 'Create your account',
///       status: StepStatus.complete,
///     ),
///     ArcaneStepItem(
///       title: 'Profile',
///       description: 'Set up your profile',
///       status: StepStatus.current,
///     ),
///     ArcaneStepItem(
///       title: 'Complete',
///       description: 'Start using the app',
///       status: StepStatus.pending,
///     ),
///   ],
/// )
/// ```
class ArcaneSteps extends StatelessComponent {
  /// Step items
  final List<ArcaneStepItem> items;

  /// Layout type
  final StepsLayout layout;

  /// Size
  final StepsSize size;

  /// Whether to show connector lines
  final bool showConnectors;

  /// Current step index (alternative to setting status on each item)
  final int? currentStep;

  /// Callback when a step is clicked (only works for completed steps)
  final void Function(int index)? onStepTap;

  const ArcaneSteps({
    required this.items,
    this.layout = StepsLayout.horizontal,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
    super.key,
  });

  /// Vertical layout steps
  const ArcaneSteps.vertical({
    required this.items,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
    super.key,
  }) : layout = StepsLayout.vertical;

  /// Horizontal layout steps
  const ArcaneSteps.horizontal({
    required this.items,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
    super.key,
  }) : layout = StepsLayout.horizontal;

  String get _indicatorSize => switch (size) {
        StepsSize.sm => '28px',
        StepsSize.md => '36px',
        StepsSize.lg => '44px',
      };

  String get _connectorSize => switch (size) {
        StepsSize.sm => '2px',
        StepsSize.md => '2px',
        StepsSize.lg => '3px',
      };

  String get _numberSize => switch (size) {
        StepsSize.sm => ArcaneTypography.fontSm,
        StepsSize.md => ArcaneTypography.fontMd,
        StepsSize.lg => ArcaneTypography.fontLg,
      };

  StepStatus _getEffectiveStatus(int index) {
    if (currentStep != null) {
      if (index < currentStep!) return StepStatus.complete;
      if (index == currentStep!) return StepStatus.current;
      return StepStatus.pending;
    }
    return items[index].status;
  }

  @override
  Component build(BuildContext context) {
    return switch (layout) {
      StepsLayout.vertical => _buildVertical(),
      StepsLayout.horizontal => _buildHorizontal(),
    };
  }

  Component _buildVertical() {
    return div(
      classes: 'arcane-steps arcane-steps-vertical',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
      }),
      [
        for (var i = 0; i < items.length; i++)
          _buildVerticalStep(items[i], i, _getEffectiveStatus(i)),
      ],
    );
  }

  Component _buildVerticalStep(ArcaneStepItem step, int index, StepStatus status) {
    final isLast = index == items.length - 1;
    final colors = _getStatusColors(status);
    final isClickable = onStepTap != null && status == StepStatus.complete;

    return div(
      classes: 'arcane-steps-item',
      styles: Styles(raw: {
        'display': 'flex',
        'gap': ArcaneSpacing.lg,
        'position': 'relative',
        'padding-bottom': isLast ? '0' : ArcaneSpacing.xl,
      }),
      [
        // Number indicator and connector column
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            // Number indicator
            _buildIndicator(index, status, colors, isClickable),
            // Connector line
            if (showConnectors && !isLast)
              div(
                classes: 'arcane-steps-connector',
                styles: Styles(raw: {
                  'width': _connectorSize,
                  'flex': '1',
                  'min-height': ArcaneSpacing.lg,
                  'background': status == StepStatus.complete
                      ? colors['line']!
                      : ArcaneColors.border,
                  'position': 'absolute',
                  'top': _indicatorSize,
                  'bottom': '0',
                }),
                [],
              ),
          ],
        ),
        // Content column
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'padding-top': '6px',
          }),
          [
            _buildContent(step, status, colors),
          ],
        ),
      ],
    );
  }

  Component _buildHorizontal() {
    return div(
      classes: 'arcane-steps arcane-steps-horizontal',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
      }),
      [
        for (var i = 0; i < items.length; i++)
          _buildHorizontalStep(items[i], i, _getEffectiveStatus(i)),
      ],
    );
  }

  Component _buildHorizontalStep(ArcaneStepItem step, int index, StepStatus status) {
    final isLast = index == items.length - 1;
    final colors = _getStatusColors(status);
    final isClickable = onStepTap != null && status == StepStatus.complete;

    return div(
      classes: 'arcane-steps-item',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'flex': isLast ? '0 0 auto' : '1',
        'min-width': '100px',
      }),
      [
        // Indicator row with connectors
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'width': '100%',
          }),
          [
            _buildIndicator(index, status, colors, isClickable),
            // Connector line
            if (showConnectors && !isLast)
              div(
                classes: 'arcane-steps-connector',
                styles: Styles(raw: {
                  'flex': '1',
                  'height': _connectorSize,
                  'background': status == StepStatus.complete
                      ? colors['line']!
                      : ArcaneColors.border,
                  'margin': '0 ${ArcaneSpacing.sm}',
                }),
                [],
              ),
          ],
        ),
        // Content below
        div(
          styles: const Styles(raw: {
            'margin-top': ArcaneSpacing.md,
            'text-align': 'center',
            'padding-right': ArcaneSpacing.sm,
          }),
          [
            _buildContent(step, status, colors, centered: true),
          ],
        ),
      ],
    );
  }

  Component _buildIndicator(int index, StepStatus status, Map<String, String> colors, bool isClickable) {
    final isFilled = status == StepStatus.complete || status == StepStatus.current;

    return button(
      classes: 'arcane-steps-indicator arcane-steps-indicator-${status.name}',
      attributes: {
        'type': 'button',
        if (isClickable) 'data-step-index': '$index',
        if (!isClickable) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'width': _indicatorSize,
        'height': _indicatorSize,
        'border-radius': ArcaneRadius.full,
        'background': isFilled ? colors['bg']! : ArcaneColors.background,
        'border': '2px solid ${colors['border']!}',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'font-size': _numberSize,
        'font-weight': ArcaneTypography.weightSemibold,
        'color': isFilled ? colors['text']! : colors['border']!,
        'flex-shrink': '0',
        'z-index': '1',
        'cursor': isClickable ? 'pointer' : 'default',
        'transition': ArcaneEffects.transitionFast,
        'padding': '0',
      }),
      events: isClickable
          ? {
              'click': (e) => onStepTap?.call(index),
            }
          : null,
      [
        if (status == StepStatus.complete)
          span([text('✓')])
        else
          span([text('${index + 1}')]),
      ],
    );
  }

  Component _buildContent(
    ArcaneStepItem step,
    StepStatus status,
    Map<String, String> colors, {
    bool centered = false,
  }) {
    return div(
      classes: 'arcane-steps-content',
      styles: Styles(raw: {
        'text-align': centered ? 'center' : 'left',
      }),
      [
        // Title
        div(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontMd,
            'font-weight': ArcaneTypography.weightSemibold,
            'color': status == StepStatus.pending
                ? ArcaneColors.muted
                : ArcaneColors.onSurface,
            'margin-bottom': step.description != null || step.content != null
                ? ArcaneSpacing.xs
                : '0',
          }),
          [text(step.title)],
        ),
        // Description
        if (step.description != null)
          div(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'line-height': ArcaneTypography.leadingNormal,
            }),
            [text(step.description!)],
          ),
        // Custom content
        if (step.content != null)
          div(
            styles: const Styles(raw: {
              'margin-top': ArcaneSpacing.sm,
            }),
            [step.content!],
          ),
      ],
    );
  }

  Map<String, String> _getStatusColors(StepStatus status) {
    return switch (status) {
      StepStatus.complete => {
          'bg': ArcaneColors.success,
          'border': ArcaneColors.success,
          'text': ArcaneColors.background,
          'line': ArcaneColors.success,
        },
      StepStatus.current => {
          'bg': ArcaneColors.accent,
          'border': ArcaneColors.accent,
          'text': ArcaneColors.background,
          'line': ArcaneColors.accent,
        },
      StepStatus.pending => {
          'bg': 'transparent',
          'border': ArcaneColors.border,
          'text': ArcaneColors.muted,
          'line': ArcaneColors.border,
        },
    };
  }
}

/// Alias for ArcaneSteps
typedef ASteps = ArcaneSteps;
