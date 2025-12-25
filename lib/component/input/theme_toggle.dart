import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Theme toggle size
enum ThemeToggleSize {
  sm,
  md,
  lg,
}

/// A toggle switch for dark/light theme selection.
///
/// Clean, accessible toggle with clear visual states.
///
/// ```dart
/// ArcaneThemeToggle(
///   isDark: true,
///   onChanged: (isDark) => print(isDark),
/// )
/// ```
class ArcaneThemeToggle extends StatelessComponent {
  /// Current theme state (true = dark)
  final bool isDark;

  /// Size variant
  final ThemeToggleSize size;

  /// Callback when theme changes
  final void Function(bool isDark)? onChanged;

  const ArcaneThemeToggle({
    this.isDark = true,
    this.size = ThemeToggleSize.md,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (width, height, thumbSize, iconSize) = switch (size) {
      ThemeToggleSize.sm => ('48px', '26px', '20px', '12px'),
      ThemeToggleSize.md => ('56px', '30px', '24px', '14px'),
      ThemeToggleSize.lg => ('68px', '36px', '30px', '18px'),
    };

    return button(
      type: ButtonType.button,
      classes: 'arcane-theme-toggle',
      attributes: {
        'data-theme': isDark ? 'dark' : 'light',
        'aria-label': isDark ? 'Switch to light mode' : 'Switch to dark mode',
        'role': 'switch',
        'aria-checked': isDark.toString(),
      },
      styles: Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'align-items': 'center',
        'width': width,
        'height': height,
        'padding': '3px',
        'border': 'none',
        'border-radius': ArcaneRadius.full,
        'background': isDark
            ? ArcaneColors.surfaceVariant
            : ArcaneColors.warningAlpha30,
        'cursor': 'pointer',
        'transition': 'background 0.2s ease',
      }),
      events: onChanged != null
          ? {'click': (_) => onChanged!(!isDark)}
          : null,
      [
        // Track icons
        div(
          classes: 'arcane-theme-toggle-icons',
          styles: Styles(raw: {
            'position': 'absolute',
            'inset': '0',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'padding': '0 6px',
            'font-size': iconSize,
            'pointer-events': 'none',
          }),
          [
            // Sun icon (left)
            span(
              classes: 'arcane-theme-toggle-sun',
              styles: Styles(raw: {
                'opacity': isDark ? '0.3' : '1',
                'transition': 'opacity 0.2s ease',
              }),
              [text('☀️')],
            ),
            // Moon icon (right)
            span(
              classes: 'arcane-theme-toggle-moon',
              styles: Styles(raw: {
                'opacity': isDark ? '1' : '0.3',
                'transition': 'opacity 0.2s ease',
              }),
              [text('🌙')],
            ),
          ],
        ),

        // Thumb
        div(
          classes: 'arcane-theme-toggle-thumb',
          styles: Styles(raw: {
            'position': 'relative',
            'width': thumbSize,
            'height': thumbSize,
            'border-radius': ArcaneRadius.full,
            'background': isDark ? ArcaneColors.onSurface : ArcaneColors.warning,
            'box-shadow': '0 2px 4px ${ArcaneColors.onSurfaceAlpha20}',
            'transition': 'transform 0.2s ease, background 0.2s ease',
            'transform': isDark ? 'translateX(calc($width - $thumbSize - 6px))' : 'translateX(0)',
          }),
          [],
        ),
      ],
    );
  }
}

/// Simple inline theme toggle with labels.
///
/// ```dart
/// ArcaneThemeToggleSimple(
///   isDark: true,
///   onChanged: (isDark) => print(isDark),
/// )
/// ```
class ArcaneThemeToggleSimple extends StatelessComponent {
  /// Current theme state (true = dark)
  final bool isDark;

  /// Callback when theme changes
  final void Function(bool isDark)? onChanged;

  const ArcaneThemeToggleSimple({
    this.isDark = true,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      type: ButtonType.button,
      classes: 'arcane-theme-toggle-simple',
      attributes: {
        'data-theme': isDark ? 'dark' : 'light',
        'aria-label': isDark ? 'Switch to light mode' : 'Switch to dark mode',
        'role': 'switch',
        'aria-checked': isDark.toString(),
      },
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
        'border': 'none',
        'border-radius': ArcaneRadius.full,
        'background': ArcaneColors.surfaceVariant,
        'cursor': 'pointer',
      }),
      events: onChanged != null
          ? {'click': (_) => onChanged!(!isDark)}
          : null,
      [
        // Sun
        span(
          classes: 'arcane-theme-toggle-simple-sun',
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontMd,
            'opacity': isDark ? '0.4' : '1',
            'transition': 'opacity 0.2s ease',
          }),
          [text('☀️')],
        ),

        // Toggle track
        div(
          classes: 'arcane-theme-toggle-simple-track',
          styles: Styles(raw: {
            'position': 'relative',
            'width': '36px',
            'height': '18px',
            'border-radius': ArcaneRadius.full,
            'background': isDark ? ArcaneColors.accent : ArcaneColors.warning,
          }),
          [
            // Thumb
            div(
              classes: 'arcane-theme-toggle-simple-thumb',
              styles: Styles(raw: {
                'position': 'absolute',
                'top': '2px',
                'width': '14px',
                'height': '14px',
                'border-radius': ArcaneRadius.full,
                'background': ArcaneColors.surface,
                'transition': 'left 0.2s ease',
                'left': isDark ? '20px' : '2px',
              }),
              [],
            ),
          ],
        ),

        // Moon
        span(
          classes: 'arcane-theme-toggle-simple-moon',
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontMd,
            'opacity': isDark ? '1' : '0.4',
            'transition': 'opacity 0.2s ease',
          }),
          [text('🌙')],
        ),
      ],
    );
  }
}
