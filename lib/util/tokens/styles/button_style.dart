import '../tokens.dart';

// =============================================================================
// BUTTON STYLE PRESETS
// =============================================================================

/// Button styling presets
/// Use like: ArcaneButton(style: ButtonStyle.warning)
class ButtonStyle {
  /// Base styles applied to the button
  final Map<String, String> base;

  /// Styles applied on hover (via @css or classes)
  final Map<String, String> hover;

  /// Styles applied when active/pressed
  final Map<String, String> active;

  /// Styles applied when disabled
  final Map<String, String> disabled;

  const ButtonStyle._({
    required this.base,
    this.hover = const {},
    this.active = const {},
    this.disabled = const {},
  });

  /// Create a custom button style
  const ButtonStyle.custom({
    required this.base,
    this.hover = const {},
    this.active = const {},
    this.disabled = const {},
  });

  /// Merge base styles with additional properties
  Map<String, String> withOverrides(Map<String, String> overrides) {
    return {...base, ...overrides};
  }

  // ---------------------------------------------------------------------------
  // Primary - Main call-to-action button
  // ---------------------------------------------------------------------------

  /// Primary action button with accent color
  static const ButtonStyle primary = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.accent,
      'color': ArcaneColors.accentForeground,
      'border': 'none',
    },
    hover: {
      'background-color': ArcaneColors.accentHover,
    },
  );

  // ---------------------------------------------------------------------------
  // Secondary - Less prominent actions
  // ---------------------------------------------------------------------------

  /// Secondary/muted button
  static const ButtonStyle secondary = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.surfaceVariant,
      'color': ArcaneColors.onSurface,
      'border': '1px solid ${ArcaneColors.border}',
    },
    hover: {
      'background-color': ArcaneColors.surface,
    },
  );

  // ---------------------------------------------------------------------------
  // Outline - Border-only button
  // ---------------------------------------------------------------------------

  /// Outline button with border
  static const ButtonStyle outline = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.transparent,
      'color': ArcaneColors.onSurface,
      'border': '1px solid ${ArcaneColors.border}',
    },
    hover: {
      'background-color': ArcaneColors.surfaceVariant,
    },
  );

  // ---------------------------------------------------------------------------
  // Ghost - Minimal/transparent button
  // ---------------------------------------------------------------------------

  /// Ghost button (transparent background)
  static const ButtonStyle ghost = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.transparent,
      'color': ArcaneColors.onSurface,
      'border': 'none',
    },
    hover: {
      'background-color': ArcaneColors.surfaceVariant,
    },
  );

  // ---------------------------------------------------------------------------
  // Semantic Status Buttons
  // ---------------------------------------------------------------------------

  /// Warning button (amber)
  static const ButtonStyle warning = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.warning,
      'color': ArcaneColors.warningForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );

  /// Destructive/danger button (red)
  static const ButtonStyle destructive = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.error,
      'color': ArcaneColors.errorForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );

  /// Alias for destructive
  static const ButtonStyle danger = destructive;

  /// Success button (green)
  static const ButtonStyle success = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.success,
      'color': ArcaneColors.successForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );

  /// Info button (blue)
  static const ButtonStyle info = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.info,
      'color': ArcaneColors.infoForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );

  // ---------------------------------------------------------------------------
  // Link - Text-only button styled as link
  // ---------------------------------------------------------------------------

  /// Link-style button
  static const ButtonStyle link = ButtonStyle._(
    base: {
      'background-color': ArcaneColors.transparent,
      'color': ArcaneColors.accent,
      'border': 'none',
      'text-decoration': 'underline',
      'padding': '0',
      'min-height': 'auto',
    },
    hover: {
      'color': ArcaneColors.accentHover,
    },
  );
}

// =============================================================================
// BUTTON SIZE PRESETS
// =============================================================================

/// Button size presets
class ButtonSizeStyle {
  final String height;
  final String paddingH;
  final String paddingV;
  final String fontSize;
  final String gap;

  const ButtonSizeStyle._({
    required this.height,
    required this.paddingH,
    required this.paddingV,
    required this.fontSize,
    required this.gap,
  });

  Map<String, String> get styles => {
        'min-height': height,
        'padding': '$paddingV $paddingH',
        'font-size': fontSize,
        'gap': gap,
      };

  /// Small button (32px height)
  static const ButtonSizeStyle sm = ButtonSizeStyle._(
    height: ArcaneLayout.buttonHeightSm,
    paddingH: '12px',
    paddingV: '6px',
    fontSize: ArcaneTypography.fontSm,
    gap: ArcaneSpacing.xs,
  );

  /// Medium button (40px height) - Default
  static const ButtonSizeStyle md = ButtonSizeStyle._(
    height: ArcaneLayout.buttonHeightMd,
    paddingH: '16px',
    paddingV: '10px',
    fontSize: ArcaneTypography.fontMd,
    gap: ArcaneSpacing.sm,
  );

  /// Large button (48px height)
  static const ButtonSizeStyle lg = ButtonSizeStyle._(
    height: ArcaneLayout.buttonHeightLg,
    paddingH: '24px',
    paddingV: '12px',
    fontSize: ArcaneTypography.fontReg,
    gap: ArcaneSpacing.sm,
  );
}
