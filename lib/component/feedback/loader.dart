import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Spinner loader component
class ArcaneLoader extends StatelessComponent {
  final String size;
  final String? color;
  final String strokeWidth;

  const ArcaneLoader({
    this.size = '32px',
    this.color,
    this.strokeWidth = '3px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-loader-spinner',
      styles: Styles(raw: {
        'width': size,
        'height': size,
        'border': '$strokeWidth solid ${ArcaneColors.border}',
        'border-top-color': color ?? ArcaneColors.success,
        'border-radius': ArcaneRadius.full,
        'animation': 'spin 1s linear infinite',
      }),
      [],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes spin').styles(raw: {
      'to': 'transform: rotate(360deg)',
    }),
  ];
}

/// Dots loader animation
class DotsLoader extends StatelessComponent {
  final String? color;
  final String dotSize;

  const DotsLoader({
    this.color,
    this.dotSize = '8px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-dots-loader',
      styles: Styles(raw: {
        'display': 'flex',
        'gap': ArcaneSpacing.xs,
        'align-items': 'center',
      }),
      [
        for (int i = 0; i < 3; i++)
          div(
            styles: Styles(raw: {
              'width': dotSize,
              'height': dotSize,
              'border-radius': ArcaneRadius.full,
              'background': color ?? ArcaneColors.success,
              'animation': 'dotBounce 1.4s infinite ease-in-out both',
              'animation-delay': '${i * 0.16}s',
            }),
            [],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes dotBounce').styles(raw: {
      '0%, 80%, 100%': 'transform: scale(0)',
      '40%': 'transform: scale(1)',
    }),
  ];
}

/// Pulse loader animation
class PulseLoader extends StatelessComponent {
  final String size;
  final String? color;

  const PulseLoader({
    this.size = '40px',
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-pulse-loader',
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
            'border-radius': ArcaneRadius.full,
            'background': color ?? ArcaneColors.success,
            'opacity': '0.4',
            'animation': 'pulseGrow 1.5s infinite ease-in-out',
          }),
          [],
        ),
        div(
          styles: Styles(raw: {
            'position': 'absolute',
            'inset': '25%',
            'border-radius': ArcaneRadius.full,
            'background': color ?? ArcaneColors.success,
          }),
          [],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes pulseGrow').styles(raw: {
      '0%, 100%': 'transform: scale(0.8); opacity: 0.5',
      '50%': 'transform: scale(1.2); opacity: 0.2',
    }),
  ];
}

/// Loading overlay for full-screen loading states
class LoadingOverlay extends StatelessComponent {
  final Component? loader;
  final String? message;

  const LoadingOverlay({
    this.loader,
    this.message,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-loading-overlay',
      styles: Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': ArcaneSpacing.xl,
        'background': ArcaneColors.backgroundOverlay,
        'backdrop-filter': 'blur(8px)',
        '-webkit-backdrop-filter': 'blur(8px)',
        'z-index': '9999',
      }),
      [
        loader ?? const ArcaneLoader(size: '48px'),
        if (message != null)
          span(
            styles: Styles(raw: {
              'color': ArcaneColors.muted,
              'font-size': ArcaneTypography.fontBase,
            }),
            [text(message!)],
          ),
      ],
    );
  }
}

/// Style injection for loader animations
class LoaderStyles extends StatelessComponent {
  const LoaderStyles({super.key});

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
