import '../tokens.dart';

// =============================================================================
// INPUT STYLE PRESETS
// =============================================================================

/// Input field styling presets
/// Use like: ArcaneTextInput(style: InputStyle.filled)
class InputStyle {
  final Map<String, String> base;
  final Map<String, String> focus;
  final Map<String, String> error;
  final Map<String, String> disabled;

  const InputStyle._({
    required this.base,
    this.focus = const {},
    this.error = const {},
    this.disabled = const {},
  });

  /// Create a custom input style
  const InputStyle.custom({
    required this.base,
    this.focus = const {},
    this.error = const {},
    this.disabled = const {},
  });

  /// Standard input with border
  static const InputStyle standard = InputStyle._(
    base: {
      'background-color': ArcaneColors.surface,
      'border': '1px solid ${ArcaneColors.border}',
      'border-radius': ArcaneRadius.md,
      'color': ArcaneColors.onSurface,
      'transition': 'all ${ArcaneEffects.transitionFast}',
    },
    focus: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
      'outline': 'none',
    },
    error: {
      'border-color': ArcaneColors.error,
      'box-shadow': '0 0 0 2px rgba(239, 68, 68, 0.2)',
    },
    disabled: {
      'opacity': '0.5',
      'cursor': 'not-allowed',
    },
  );

  /// Filled input (no border, background fill)
  static const InputStyle filled = InputStyle._(
    base: {
      'background-color': ArcaneColors.surfaceVariant,
      'border': '1px solid transparent',
      'border-radius': ArcaneRadius.md,
      'color': ArcaneColors.onSurface,
      'transition': 'all ${ArcaneEffects.transitionFast}',
    },
    focus: {
      'background-color': ArcaneColors.surface,
      'border-color': ArcaneColors.accent,
      'outline': 'none',
    },
    error: {
      'border-color': ArcaneColors.error,
    },
    disabled: {
      'opacity': '0.5',
      'cursor': 'not-allowed',
    },
  );

  /// Ghost input (minimal styling)
  static const InputStyle ghost = InputStyle._(
    base: {
      'background-color': ArcaneColors.transparent,
      'border': 'none',
      'border-bottom': '1px solid ${ArcaneColors.border}',
      'border-radius': '0',
      'color': ArcaneColors.onSurface,
      'transition': 'all ${ArcaneEffects.transitionFast}',
    },
    focus: {
      'border-bottom-color': ArcaneColors.accent,
      'outline': 'none',
    },
    error: {
      'border-bottom-color': ArcaneColors.error,
    },
    disabled: {
      'opacity': '0.5',
      'cursor': 'not-allowed',
    },
  );
}

// =============================================================================
// INPUT SIZE PRESETS
// =============================================================================

/// Input size presets
class InputSizeStyle {
  final String height;
  final String paddingH;
  final String paddingV;
  final String fontSize;

  const InputSizeStyle._({
    required this.height,
    required this.paddingH,
    required this.paddingV,
    required this.fontSize,
  });

  Map<String, String> get styles => {
        'height': height,
        'padding': '$paddingV $paddingH',
        'font-size': fontSize,
      };

  /// Small input (32px height)
  static const InputSizeStyle sm = InputSizeStyle._(
    height: ArcaneLayout.inputHeightSm,
    paddingH: '10px',
    paddingV: '6px',
    fontSize: ArcaneTypography.fontSm,
  );

  /// Medium input (40px height) - Default
  static const InputSizeStyle md = InputSizeStyle._(
    height: ArcaneLayout.inputHeightMd,
    paddingH: '14px',
    paddingV: '10px',
    fontSize: ArcaneTypography.fontMd,
  );

  /// Large input (48px height)
  static const InputSizeStyle lg = InputSizeStyle._(
    height: ArcaneLayout.inputHeightLg,
    paddingH: '16px',
    paddingV: '12px',
    fontSize: ArcaneTypography.fontReg,
  );
}
