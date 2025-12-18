import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Day/Night theme toggle switch
class ThemeToggle extends StatelessComponent {
  final bool isDark;
  final String size;

  const ThemeToggle({
    this.isDark = true,
    this.size = 'medium',
  });

  @override
  Component build(BuildContext context) {
    String width;
    String height;
    String iconSize;
    String thumbSize;

    switch (size) {
      case 'small':
        width = '52px';
        height = '28px';
        iconSize = '14px';
        thumbSize = '20px';
        break;
      case 'large':
        width = '80px';
        height = '44px';
        iconSize = '22px';
        thumbSize = '36px';
        break;
      default: // medium
        width = '64px';
        height = '36px';
        iconSize = '18px';
        thumbSize = '28px';
    }

    return div(
      styles: Styles(raw: {
        'position': 'relative',
        'width': width,
        'height': height,
        'border-radius': '999px',
        'background': isDark
            ? 'linear-gradient(135deg, #1e1b4b 0%, #312e81 100%)'
            : 'linear-gradient(135deg, #fef3c7 0%, #fde68a 100%)',
        'cursor': 'pointer',
        'transition': 'all 0.3s ease',
        'box-shadow': isDark
            ? 'inset 0 2px 4px rgba(0,0,0,0.3), 0 0 20px rgba(139, 92, 246, 0.2)'
            : 'inset 0 2px 4px rgba(0,0,0,0.1), 0 0 20px rgba(251, 191, 36, 0.3)',
        'overflow': 'hidden',
      }),
      [
        // Stars (visible in dark mode)
        if (isDark) ...[
          for (var i = 0; i < 5; i++)
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'width': '2px',
                'height': '2px',
                'background': '#FFFFFF',
                'border-radius': '50%',
                'opacity': '0.6',
                'left': '${10 + i * 8}px',
                'top': '${8 + (i % 3) * 6}px',
              }),
              [],
            ),
        ],
        // Clouds (visible in light mode)
        if (!isDark) ...[
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              'width': '16px',
              'height': '8px',
              'background': '#FFFFFF',
              'border-radius': '999px',
              'opacity': '0.8',
              'left': '8px',
              'top': '10px',
            }),
            [],
          ),
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              'width': '12px',
              'height': '6px',
              'background': '#FFFFFF',
              'border-radius': '999px',
              'opacity': '0.6',
              'left': '14px',
              'top': '20px',
            }),
            [],
          ),
        ],
        // Thumb (sun/moon)
        div(
          styles: Styles(raw: {
            'position': 'absolute',
            'top': '50%',
            'transform': 'translateY(-50%)',
            'left': isDark ? 'calc(100% - $thumbSize - 4px)' : '4px',
            'width': thumbSize,
            'height': thumbSize,
            'border-radius': '50%',
            'background': isDark ? '#e0e7ff' : '#fbbf24',
            'box-shadow': isDark
                ? '0 0 10px rgba(224, 231, 255, 0.5)'
                : '0 0 15px rgba(251, 191, 36, 0.6)',
            'transition': 'left 0.3s ease, background 0.3s ease',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'overflow': 'hidden',
          }),
          [
            // Moon craters or sun rays
            if (isDark)
              div(
                styles: Styles(raw: {
                  'position': 'absolute',
                  'width': '40%',
                  'height': '40%',
                  'background': '#c7d2fe',
                  'border-radius': '50%',
                  'top': '20%',
                  'right': '20%',
                }),
                [],
              ),
            span(
              styles: Styles(raw: {
                'font-size': iconSize,
                'line-height': '1',
              }),
              [text(isDark ? '🌙' : '☀️')],
            ),
          ],
        ),
      ],
    );
  }
}

/// Simple text-based theme toggle
class ThemeToggleSimple extends StatelessComponent {
  final bool isDark;

  const ThemeToggleSimple({
    this.isDark = true,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '12px',
        'padding': '8px 16px',
        'border-radius': '999px',
        'background': 'rgba(63, 63, 70, 0.3)',
        'cursor': 'pointer',
      }),
      [
        span(
          styles: Styles(raw: {
            'font-size': '18px',
            'opacity': isDark ? '0.4' : '1',
            'transition': 'opacity 0.2s ease',
          }),
          [text('☀️')],
        ),
        // Toggle track
        div(
          styles: Styles(raw: {
            'position': 'relative',
            'width': '40px',
            'height': '20px',
            'border-radius': '999px',
            'background': isDark ? '#3F3F46' : '#FDE68A',
          }),
          [
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'top': '2px',
                'left': isDark ? '22px' : '2px',
                'width': '16px',
                'height': '16px',
                'border-radius': '50%',
                'background': '#FFFFFF',
                'transition': 'left 0.2s ease',
              }),
              [],
            ),
          ],
        ),
        span(
          styles: Styles(raw: {
            'font-size': '18px',
            'opacity': isDark ? '1' : '0.4',
            'transition': 'opacity 0.2s ease',
          }),
          [text('🌙')],
        ),
      ],
    );
  }
}
