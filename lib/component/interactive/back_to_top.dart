import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// A back to top button (Supabase-style)
class BackToTop extends StatelessComponent {
  /// Whether the button is visible
  final bool visible;

  /// Click handler
  final void Function()? onTap;

  /// Position from right
  final double right;

  /// Position from bottom
  final double bottom;

  /// Button size
  final double size;

  const BackToTop({
    this.visible = true,
    this.onTap,
    this.right = 24,
    this.bottom = 24,
    this.size = 48,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (!visible) {
      return const div([]);
    }

    return button(
      classes: 'arcane-back-to-top',
      attributes: {
        'type': 'button',
        'aria-label': 'Back to top',
      },
      styles: Styles(raw: {
        'position': 'fixed',
        'right': '${right}px',
        'bottom': '${bottom}px',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '${size}px',
        'height': '${size}px',
        'background-color': ArcaneColors.surface,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.full,
        'box-shadow': ArcaneEffects.shadowLg,
        'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
        'animation': 'arcane-back-to-top-fade 0.2s ease-out',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        span(
          styles: const Styles(raw: {
            'font-size': '1.25rem',
            'color': ArcaneColors.muted,
            'transform': 'rotate(-90deg)',
            'transition': ArcaneEffects.transitionFast,
          }),
          [text('→')],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-back-to-top-fade').styles(raw: {
      '0%': 'opacity: 0; transform: translateY(20px)',
      '100%': 'opacity: 1; transform: translateY(0)',
    }),
    css('.arcane-back-to-top:hover').styles(raw: {
      'transform': 'translateY(-4px)',
      'box-shadow': ArcaneEffects.shadowXl,
    }),
    css('.arcane-back-to-top:hover span').styles(raw: {
      'color': ArcaneColors.accent,
    }),
  ];
}

/// A scroll progress indicator
class ScrollProgress extends StatelessComponent {
  /// Progress value (0-100)
  final double progress;

  /// Whether to show at top or bottom
  final bool top;

  /// Bar height
  final double height;

  /// Color
  final String? color;

  const ScrollProgress({
    required this.progress,
    this.top = true,
    this.height = 3,
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-scroll-progress',
      styles: Styles(raw: {
        'position': 'fixed',
        if (top) 'top': '0' else 'bottom': '0',
        'left': '0',
        'width': '100%',
        'height': '${height}px',
        'z-index': '1000',
        'background-color': ArcaneColors.surfaceVariant,
      }),
      [
        div(
          classes: 'arcane-scroll-progress-bar',
          styles: Styles(raw: {
            'height': '100%',
            'width': '${progress.clamp(0, 100)}%',
            'background-color': color ?? ArcaneColors.accent,
            'transition': 'width 0.1s ease-out',
          }),
          [],
        ),
      ],
    );
  }
}

/// A floating action button
class FloatingActionButton extends StatelessComponent {
  /// Button icon/content
  final Component child;

  /// Click handler
  final void Function()? onTap;

  /// Position from right
  final double right;

  /// Position from bottom
  final double bottom;

  /// Button size
  final double size;

  /// Whether extended with label
  final String? label;

  /// Whether to use accent color
  final bool accent;

  const FloatingActionButton({
    required this.child,
    this.onTap,
    this.right = 24,
    this.bottom = 24,
    this.size = 56,
    this.label,
    this.accent = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-fab ${label != null ? 'extended' : ''}',
      attributes: {'type': 'button'},
      styles: Styles(raw: {
        'position': 'fixed',
        'right': '${right}px',
        'bottom': '${bottom}px',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': ArcaneSpacing.sm,
        if (label == null) 'width': '${size}px',
        'height': '${size}px',
        if (label != null) 'padding': '0 20px',
        'background-color': accent ? ArcaneColors.accent : ArcaneColors.surface,
        'color': accent ? ArcaneColors.accentForeground : ArcaneColors.onSurface,
        'border': accent ? 'none' : '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.full,
        'box-shadow': ArcaneEffects.shadowLg,
        'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        child,
        if (label != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
            }),
            [text(label!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-fab:hover').styles(raw: {
      'transform': 'scale(1.05)',
      'box-shadow': ArcaneEffects.shadowXl,
    }),
    css('.arcane-fab:active').styles(raw: {
      'transform': 'scale(0.98)',
    }),
  ];
}