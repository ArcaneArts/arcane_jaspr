import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Text with gradient color
class GradientText extends StatelessComponent {
  final String content;
  final String gradientStart;
  final String gradientEnd;
  final String? gradientAngle;
  final String fontSize;
  final String fontWeight;

  const GradientText({
    required this.content,
    this.gradientStart = '#10B981',
    this.gradientEnd = '#06B6D4',
    this.gradientAngle = '135deg',
    this.fontSize = '32px',
    this.fontWeight = '700',
  });

  @override
  Component build(BuildContext context) {
    return span(
      styles: Styles(raw: {
        'font-size': fontSize,
        'font-weight': fontWeight,
        'background':
            'linear-gradient($gradientAngle, $gradientStart 0%, $gradientEnd 100%)',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'color': 'transparent',
      }),
      [text(content)],
    );
  }
}

/// Animated gradient text with color shift
class AnimatedGradientText extends StatelessComponent {
  final String content;
  final String fontSize;
  final String fontWeight;

  const AnimatedGradientText({
    required this.content,
    this.fontSize = '32px',
    this.fontWeight = '700',
  });

  @override
  Component build(BuildContext context) {
    return span(
      styles: Styles(raw: {
        'font-size': fontSize,
        'font-weight': fontWeight,
        'background':
            'linear-gradient(135deg, #10B981 0%, #06B6D4 25%, #8B5CF6 50%, #EC4899 75%, #10B981 100%)',
        'background-size': '200% 200%',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'color': 'transparent',
        'animation': 'gradientShift 5s ease infinite',
      }),
      [text(content)],
    );
  }
}

/// Style injection for gradient animation
class GradientTextStyles extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'style',
      children: [text('''
        @keyframes gradientShift {
          0% { background-position: 0% 50%; }
          50% { background-position: 100% 50%; }
          100% { background-position: 0% 50%; }
        }
      ''')],
    );
  }
}
