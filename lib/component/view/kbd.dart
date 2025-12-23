import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Keyboard key display style
enum KbdStyle {
  /// Default raised key style
  raised,

  /// Flat minimal style
  flat,

  /// Outline style
  outline,
}

/// Keyboard key display size
enum KbdSize {
  sm,
  md,
  lg,
}

/// Keyboard shortcut display component
///
/// Displays keyboard keys or shortcuts in a styled format.
///
/// ```dart
/// // Single key
/// ArcaneKbd('⌘')
///
/// // Key combination
/// ArcaneKbd.combo(['⌘', 'K'])
///
/// // With separator
/// ArcaneKbd.shortcut('Ctrl+Shift+P')
/// ```
class ArcaneKbd extends StatelessComponent {
  /// The key text to display
  final String? keyText;

  /// List of keys for a combination
  final List<String>? keys;

  /// Separator between keys (for combo display)
  final String separator;

  /// Style variant
  final KbdStyle style;

  /// Size variant
  final KbdSize size;

  const ArcaneKbd(
    this.keyText, {
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
    super.key,
  })  : keys = null,
        separator = '+';

  /// Display a key combination
  const ArcaneKbd.combo(
    this.keys, {
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
    super.key,
  }) : keyText = null;

  /// Parse a shortcut string like "Ctrl+Shift+P"
  factory ArcaneKbd.shortcut(
    String shortcut, {
    KbdStyle style = KbdStyle.raised,
    KbdSize size = KbdSize.md,
  }) {
    final parts = shortcut.split('+').map((s) => s.trim()).toList();
    return ArcaneKbd.combo(
      parts,
      separator: '+',
      style: style,
      size: size,
    );
  }

  (String padding, String fontSize, String minWidth) get _sizeStyles =>
      switch (size) {
        KbdSize.sm => ('2px 5px', ArcaneTypography.fontXs, '20px'),
        KbdSize.md => ('4px 8px', ArcaneTypography.fontSm, '24px'),
        KbdSize.lg => ('6px 12px', ArcaneTypography.fontMd, '32px'),
      };

  Map<String, String> get _styleMap {
    final (padding, fontSize, minWidth) = _sizeStyles;

    final baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'min-width': minWidth,
      'padding': padding,
      'font-size': fontSize,
      'font-family': ArcaneTypography.fontFamilyMono,
      'font-weight': ArcaneTypography.weightMedium,
      'line-height': '1',
      'white-space': 'nowrap',
      'user-select': 'none',
    };

    return switch (style) {
      KbdStyle.raised => {
          ...baseStyles,
          'background': 'linear-gradient(180deg, ${ArcaneColors.surfaceVariant} 0%, ${ArcaneColors.surface} 100%)',
          'border': '1px solid ${ArcaneColors.border}',
          'border-radius': ArcaneRadius.sm,
          'box-shadow': '0 2px 0 ${ArcaneColors.border}, inset 0 1px 0 ${ArcaneColors.onSurfaceAlpha10}',
          'color': ArcaneColors.onSurface,
        },
      KbdStyle.flat => {
          ...baseStyles,
          'background': ArcaneColors.surfaceVariant,
          'border': 'none',
          'border-radius': ArcaneRadius.sm,
          'color': ArcaneColors.onSurface,
        },
      KbdStyle.outline => {
          ...baseStyles,
          'background': 'transparent',
          'border': '1px solid ${ArcaneColors.border}',
          'border-radius': ArcaneRadius.sm,
          'color': ArcaneColors.muted,
        },
    };
  }

  @override
  Component build(BuildContext context) {
    if (keys != null && keys!.isNotEmpty) {
      return span(
        styles: const Styles(raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': '4px',
        }),
        [
          for (var i = 0; i < keys!.length; i++) ...[
            Component.element(
              tag: 'kbd',
              styles: Styles(raw: _styleMap),
              children: [text(keys![i])],
            ),
            if (i < keys!.length - 1)
              span(
                styles: const Styles(raw: {
                  'color': ArcaneColors.muted,
                  'font-size': ArcaneTypography.fontXs,
                }),
                [text(separator)],
              ),
          ],
        ],
      );
    }

    return Component.element(
      tag: 'kbd',
      styles: Styles(raw: _styleMap),
      children: [text(keyText ?? '')],
    );
  }
}
