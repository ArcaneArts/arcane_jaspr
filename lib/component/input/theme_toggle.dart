import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Theme toggle size
enum ThemeToggleSize {
  small,
  medium,
  large,
}

/// Day/Night theme toggle switch
class ThemeToggle extends StatelessComponent {
  final bool isDark;
  final ThemeToggleSize size;
  final void Function(bool)? onChanged;

  const ThemeToggle({
    this.isDark = true,
    this.size = ThemeToggleSize.medium,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (width, height, iconSize, thumbSize) = switch (size) {
      ThemeToggleSize.small => ('52px', '28px', '14px', '20px'),
      ThemeToggleSize.medium => ('64px', '36px', '18px', '28px'),
      ThemeToggleSize.large => ('80px', '44px', '22px', '36px'),
    };

    return div(
      styles: Styles(raw: {
        'position': 'relative',
        'width': width,
        'height': height,
        'border-radius': ArcaneRadius.full,
        'background': isDark
            ? 'linear-gradient(135deg, #1e1b4b 0%, #312e81 100%)'
            : 'linear-gradient(135deg, #fef3c7 0%, #fde68a 100%)',
        'cursor': 'pointer',
        'transition': ArcaneEffects.transitionNormal,
        'box-shadow': isDark
            ? 'inset 0 2px 4px rgba(0,0,0,0.3), 0 0 20px rgba(139, 92, 246, 0.2)'
            : 'inset 0 2px 4px rgba(0,0,0,0.1), 0 0 20px rgba(251, 191, 36, 0.3)',
        'overflow': 'hidden',
      }),
      events: onChanged != null
          ? {
              'click': (event) => onChanged!(!isDark),
            }
          : null,
      [
        // Stars (visible in dark mode)
        if (isDark) ...[
          for (var i = 0; i < 5; i++)
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'width': '2px',
                'height': '2px',
                'background': ArcaneColors.white,
                'border-radius': ArcaneRadius.full,
                'opacity': '0.6',
                'left': '${10 + i * 8}px',
                'top': '${8 + (i % 3) * 6}px',
              }),
              [],
            ),
        ],
        // Clouds (visible in light mode)
        if (!isDark) ...[
          const div(
            styles: Styles(raw: {
              'position': 'absolute',
              'width': '16px',
              'height': '8px',
              'background': ArcaneColors.white,
              'border-radius': ArcaneRadius.full,
              'opacity': '0.8',
              'left': '8px',
              'top': '10px',
            }),
            [],
          ),
          const div(
            styles: Styles(raw: {
              'position': 'absolute',
              'width': '12px',
              'height': '6px',
              'background': ArcaneColors.white,
              'border-radius': ArcaneRadius.full,
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
            'border-radius': ArcaneRadius.full,
            'background': isDark ? '#e0e7ff' : '#fbbf24',
            'box-shadow': isDark
                ? '0 0 10px rgba(224, 231, 255, 0.5)'
                : '0 0 15px rgba(251, 191, 36, 0.6)',
            'transition': ArcaneEffects.transitionNormal,
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'overflow': 'hidden',
          }),
          [
            // Moon craters or sun rays
            if (isDark)
              const div(
                styles: Styles(raw: {
                  'position': 'absolute',
                  'width': '40%',
                  'height': '40%',
                  'background': '#c7d2fe',
                  'border-radius': ArcaneRadius.full,
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
  final void Function(bool)? onChanged;

  const ThemeToggleSimple({
    this.isDark = true,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'border-radius': ArcaneRadius.full,
        'background': 'rgba(63, 63, 70, 0.3)',
        'cursor': 'pointer',
      }),
      events: onChanged != null
          ? {
              'click': (event) => onChanged!(!isDark),
            }
          : null,
      [
        span(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontLg,
            'opacity': isDark ? '0.4' : '1',
            'transition': ArcaneEffects.transitionFast,
          }),
          [text('☀️')],
        ),
        // Toggle track
        div(
          styles: Styles(raw: {
            'position': 'relative',
            'width': '40px',
            'height': '20px',
            'border-radius': ArcaneRadius.full,
            'background': isDark ? ArcaneColors.surfaceVariant : '#FDE68A',
          }),
          [
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'top': '2px',
                'left': isDark ? '22px' : '2px',
                'width': '16px',
                'height': '16px',
                'border-radius': ArcaneRadius.full,
                'background': ArcaneColors.white,
                'transition': ArcaneEffects.transitionFast,
              }),
              [],
            ),
          ],
        ),
        span(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontLg,
            'opacity': isDark ? '1' : '0.4',
            'transition': ArcaneEffects.transitionFast,
          }),
          [text('🌙')],
        ),
      ],
    );
  }
}