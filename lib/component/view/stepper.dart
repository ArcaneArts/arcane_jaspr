import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Step item data
class StepItem {
  final String title;
  final String? description;
  final bool completed;
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
  final List<StepItem> steps;
  final String activeColor;
  final String completedColor;
  final String inactiveColor;

  const Stepper({
    required this.steps,
    this.activeColor = '#10B981',
    this.completedColor = '#10B981',
    this.inactiveColor = '#3F3F46',
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0',
        'width': '100%',
      }),
      [
        for (var i = 0; i < steps.length; i++) _buildStep(steps[i], i),
      ],
    );
  }

  Component _buildStep(StepItem step, int index) {
    final isLast = index == steps.length - 1;
    String circleColor;
    String circleTextColor;
    String labelColor;

    if (step.completed) {
      circleColor = completedColor;
      circleTextColor = '#0A0A0B';
      labelColor = '#FAFAFA';
    } else if (step.active) {
      circleColor = activeColor;
      circleTextColor = '#0A0A0B';
      labelColor = '#FAFAFA';
    } else {
      circleColor = inactiveColor;
      circleTextColor = '#A1A1AA';
      labelColor = '#71717A';
    }

    return div(
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
          styles: Styles(raw: {
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
                'border-radius': '50%',
                'background': circleColor,
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'font-size': '14px',
                'font-weight': '600',
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
                  'margin': '0 8px',
                }),
                [],
              ),
          ],
        ),
        // Label
        div(
          styles: Styles(raw: {
            'margin-top': '12px',
            'text-align': 'center',
          }),
          [
            div(
              styles: Styles(raw: {
                'font-size': '14px',
                'font-weight': '500',
                'color': labelColor,
              }),
              [text(step.title)],
            ),
            if (step.description != null)
              div(
                styles: Styles(raw: {
                  'font-size': '12px',
                  'color': '#71717A',
                  'margin-top': '4px',
                }),
                [text(step.description!)],
              ),
          ],
        ),
      ],
    );
  }
}
