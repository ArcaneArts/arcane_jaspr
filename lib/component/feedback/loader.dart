import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Spinner loader component
class ArcaneLoader extends StatelessComponent {
  final String size;
  final String color;
  final String strokeWidth;

  const ArcaneLoader({
    this.size = '32px',
    this.color = '#10B981',
    this.strokeWidth = '3px',
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'width': size,
        'height': size,
        'border': '$strokeWidth solid rgba(63, 63, 70, 0.3)',
        'border-top-color': color,
        'border-radius': '50%',
        'animation': 'spin 1s linear infinite',
      }),
      [],
    );
  }
}

/// Dots loader animation
class DotsLoader extends StatelessComponent {
  final String color;
  final String dotSize;

  const DotsLoader({
    this.color = '#10B981',
    this.dotSize = '8px',
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'gap': '6px',
        'align-items': 'center',
      }),
      [
        for (var i = 0; i < 3; i++)
          div(
            styles: Styles(raw: {
              'width': dotSize,
              'height': dotSize,
              'border-radius': '50%',
              'background': color,
              'animation': 'dotBounce 1.4s infinite ease-in-out both',
              'animation-delay': '${i * 0.16}s',
            }),
            [],
          ),
      ],
    );
  }
}

/// Pulse loader animation
class PulseLoader extends StatelessComponent {
  final String size;
  final String color;

  const PulseLoader({
    this.size = '40px',
    this.color = '#10B981',
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'position': 'relative',
        'width': size,
        'height': size,
      }),
      [
        div(
          styles: Styles(raw: {
            'position': 'absolute',
            'inset': '0',
            'border-radius': '50%',
            'background': color,
            'opacity': '0.4',
            'animation': 'pulseGrow 1.5s infinite ease-in-out',
          }),
          [],
        ),
        div(
          styles: Styles(raw: {
            'position': 'absolute',
            'inset': '25%',
            'border-radius': '50%',
            'background': color,
          }),
          [],
        ),
      ],
    );
  }
}

/// Loading overlay for full-screen loading states
class LoadingOverlay extends StatelessComponent {
  final Component? loader;
  final String? message;

  const LoadingOverlay({
    this.loader,
    this.message,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '24px',
        'background': 'rgba(10, 10, 11, 0.9)',
        'backdrop-filter': 'blur(8px)',
        '-webkit-backdrop-filter': 'blur(8px)',
        'z-index': '9999',
      }),
      [
        loader ?? const ArcaneLoader(size: '48px'),
        if (message != null)
          span(
            styles: Styles(raw: {
              'color': '#A1A1AA',
              'font-size': '16px',
            }),
            [text(message!)],
          ),
      ],
    );
  }
}

/// Style injection for loader animations
class LoaderStyles extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'style',
      children: [text('''
        @keyframes spin {
          to { transform: rotate(360deg); }
        }
        @keyframes dotBounce {
          0%, 80%, 100% { transform: scale(0); }
          40% { transform: scale(1); }
        }
        @keyframes pulseGrow {
          0%, 100% { transform: scale(0.8); opacity: 0.5; }
          50% { transform: scale(1.2); opacity: 0.2; }
        }
        @keyframes pulse {
          0%, 100% { opacity: 0.4; transform: scale(1); }
          50% { opacity: 0.2; transform: scale(1.3); }
        }
      ''')],
    );
  }
}
