/// Pre-built style presets that encapsulate all CSS for semantic meanings
/// Usage: ArcaneButton(style: ButtonStyle.warning)
///
/// These presets provide a Flutter-like API where you specify intent,
/// not raw CSS properties.

import 'tokens.dart';

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

// =============================================================================
// BADGE STYLE PRESETS
// =============================================================================

/// Badge styling presets
/// Use like: ArcaneBadge(style: BadgeStyle.success)
class BadgeStyle {
  final Map<String, String> styles;

  const BadgeStyle._(this.styles);

  /// Create a custom badge style
  const BadgeStyle.custom(this.styles);

  /// Merge with additional styles
  Map<String, String> withOverrides(Map<String, String> overrides) {
    return {...styles, ...overrides};
  }

  /// Default badge (neutral)
  static const BadgeStyle standard = BadgeStyle._({
    'background-color': ArcaneColors.surfaceVariant,
    'color': ArcaneColors.onSurface,
  });

  /// Primary badge (accent colored)
  static const BadgeStyle primary = BadgeStyle._({
    'background-color': ArcaneColors.accentContainer,
    'color': ArcaneColors.accent,
  });

  /// Secondary badge
  static const BadgeStyle secondary = BadgeStyle._({
    'background-color': ArcaneColors.secondaryContainer,
    'color': ArcaneColors.onSecondaryContainer,
  });

  /// Success badge (green)
  static const BadgeStyle success = BadgeStyle._({
    'background-color': ArcaneColors.success,
    'color': ArcaneColors.successForeground,
  });

  /// Warning badge (amber)
  static const BadgeStyle warning = BadgeStyle._({
    'background-color': ArcaneColors.warning,
    'color': ArcaneColors.warningForeground,
  });

  /// Error/destructive badge (red)
  static const BadgeStyle error = BadgeStyle._({
    'background-color': ArcaneColors.error,
    'color': ArcaneColors.errorForeground,
  });

  /// Alias for error
  static const BadgeStyle destructive = error;

  /// Info badge (blue)
  static const BadgeStyle info = BadgeStyle._({
    'background-color': ArcaneColors.info,
    'color': ArcaneColors.infoForeground,
  });

  /// Outline badge
  static const BadgeStyle outline = BadgeStyle._({
    'background-color': ArcaneColors.transparent,
    'color': ArcaneColors.onSurface,
    'border': '1px solid ${ArcaneColors.border}',
  });
}

// =============================================================================
// CARD STYLE PRESETS
// =============================================================================

/// Card styling presets
/// Use like: ArcaneCard(style: CardStyle.elevated)
class CardStyle {
  final Map<String, String> styles;

  const CardStyle._(this.styles);

  /// Create a custom card style
  const CardStyle.custom(this.styles);

  /// Merge with additional styles
  Map<String, String> withOverrides(Map<String, String> overrides) {
    return {...styles, ...overrides};
  }

  /// Elevated card with shadow
  static const CardStyle elevated = CardStyle._({
    'background-color': ArcaneColors.card,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.border}',
    'box-shadow': ArcaneEffects.shadowMd,
  });

  /// Flat card without shadow
  static const CardStyle flat = CardStyle._({
    'background-color': ArcaneColors.card,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.border}',
    'box-shadow': ArcaneEffects.shadowNone,
  });

  /// Outlined card (border only)
  static const CardStyle outlined = CardStyle._({
    'background-color': ArcaneColors.transparent,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.border}',
  });

  /// Ghost card (no border, no background)
  static const CardStyle ghost = CardStyle._({
    'background-color': ArcaneColors.transparent,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': 'none',
  });

  /// Glass/frosted card
  static const CardStyle glass = CardStyle._({
    'background-color': 'rgba(255, 255, 255, 0.05)',
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid rgba(255, 255, 255, 0.1)',
    'backdrop-filter': ArcaneEffects.backdropBlur,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlur,
  });

  /// Interactive card (shows hover effect)
  static const CardStyle interactive = CardStyle._({
    'background-color': ArcaneColors.card,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.border}',
    'cursor': 'pointer',
  });

  /// Subtle card (minimal styling)
  static const CardStyle subtle = CardStyle._({
    'background-color': ArcaneColors.surfaceVariant,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.borderSubtle}',
  });
}

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

// =============================================================================
// ALERT STYLE PRESETS
// =============================================================================

/// Alert/banner styling presets
/// Use like: ArcaneAlert(style: AlertStyle.warning)
class AlertStyle {
  final Map<String, String> styles;
  final String? iconColor;

  const AlertStyle._(this.styles, {this.iconColor});

  /// Create a custom alert style
  const AlertStyle.custom(this.styles, {this.iconColor});

  /// Info alert (blue)
  static const AlertStyle info = AlertStyle._({
    'background-color': 'rgba(59, 130, 246, 0.1)',
    'border': '1px solid rgba(59, 130, 246, 0.3)',
    'color': ArcaneColors.info,
  }, iconColor: ArcaneColors.info);

  /// Success alert (green)
  static const AlertStyle success = AlertStyle._({
    'background-color': 'rgba(16, 185, 129, 0.1)',
    'border': '1px solid rgba(16, 185, 129, 0.3)',
    'color': ArcaneColors.success,
  }, iconColor: ArcaneColors.success);

  /// Warning alert (amber)
  static const AlertStyle warning = AlertStyle._({
    'background-color': 'rgba(245, 158, 11, 0.1)',
    'border': '1px solid rgba(245, 158, 11, 0.3)',
    'color': ArcaneColors.warning,
  }, iconColor: ArcaneColors.warning);

  /// Error alert (red)
  static const AlertStyle error = AlertStyle._({
    'background-color': 'rgba(239, 68, 68, 0.1)',
    'border': '1px solid rgba(239, 68, 68, 0.3)',
    'color': ArcaneColors.error,
  }, iconColor: ArcaneColors.error);

  /// Alias for error
  static const AlertStyle destructive = error;
}

// =============================================================================
// CHIP STYLE PRESETS
// =============================================================================

/// Chip styling presets
/// Use like: ArcaneChip(style: ChipStyle.primary)
class ChipStyle {
  final Map<String, String> styles;

  const ChipStyle._(this.styles);

  /// Create a custom chip style
  const ChipStyle.custom(this.styles);

  /// Default chip
  static const ChipStyle standard = ChipStyle._({
    'background-color': ArcaneColors.surfaceVariant,
    'color': ArcaneColors.onSurface,
    'border': 'none',
  });

  /// Primary chip
  static const ChipStyle primary = ChipStyle._({
    'background-color': ArcaneColors.accentContainer,
    'color': ArcaneColors.accent,
    'border': 'none',
  });

  /// Outlined chip
  static const ChipStyle outline = ChipStyle._({
    'background-color': ArcaneColors.transparent,
    'color': ArcaneColors.onSurface,
    'border': '1px solid ${ArcaneColors.border}',
  });

  /// Success chip
  static const ChipStyle success = ChipStyle._({
    'background-color': 'rgba(16, 185, 129, 0.15)',
    'color': ArcaneColors.success,
    'border': 'none',
  });

  /// Warning chip
  static const ChipStyle warning = ChipStyle._({
    'background-color': 'rgba(245, 158, 11, 0.15)',
    'color': ArcaneColors.warning,
    'border': 'none',
  });

  /// Error chip
  static const ChipStyle error = ChipStyle._({
    'background-color': 'rgba(239, 68, 68, 0.15)',
    'color': ArcaneColors.error,
    'border': 'none',
  });
}

// =============================================================================
// PROGRESS STYLE PRESETS
// =============================================================================

/// Progress bar styling presets
class ProgressStyle {
  final String trackColor;
  final String fillColor;
  final String? gradientValue;

  const ProgressStyle._({
    required this.trackColor,
    required this.fillColor,
    this.gradientValue,
  });

  /// Default progress (accent color)
  static const ProgressStyle standard = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.accent,
  );

  /// Success progress (green)
  static const ProgressStyle success = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.success,
  );

  /// Warning progress (amber)
  static const ProgressStyle warning = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.warning,
  );

  /// Error progress (red)
  static const ProgressStyle error = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.error,
  );

  /// Gradient progress
  static const ProgressStyle gradient = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.accent,
    gradientValue: 'linear-gradient(90deg, ${ArcaneColors.accent}, ${ArcaneColors.accentHover})',
  );
}

// =============================================================================
// DIVIDER STYLE PRESETS
// =============================================================================

/// Divider styling presets
class DividerStyle {
  final Map<String, String> styles;

  const DividerStyle._(this.styles);

  /// Default divider
  static const DividerStyle standard = DividerStyle._({
    'background-color': ArcaneColors.border,
    'height': '1px',
  });

  /// Subtle divider
  static const DividerStyle subtle = DividerStyle._({
    'background-color': ArcaneColors.borderSubtle,
    'height': '1px',
  });

  /// Bold divider
  static const DividerStyle bold = DividerStyle._({
    'background-color': ArcaneColors.border,
    'height': '2px',
  });
}

// =============================================================================
// AVATAR STYLE PRESETS
// =============================================================================

/// Avatar styling presets
class AvatarStyle {
  final Map<String, String> styles;

  const AvatarStyle._(this.styles);

  /// Circle avatar
  static const AvatarStyle circle = AvatarStyle._({
    'border-radius': ArcaneRadius.full,
    'overflow': 'hidden',
  });

  /// Rounded square avatar
  static const AvatarStyle rounded = AvatarStyle._({
    'border-radius': ArcaneRadius.lg,
    'overflow': 'hidden',
  });

  /// Square avatar
  static const AvatarStyle square = AvatarStyle._({
    'border-radius': ArcaneRadius.md,
    'overflow': 'hidden',
  });
}

// =============================================================================
// TOOLTIP STYLE PRESETS
// =============================================================================

/// Tooltip styling presets
class TooltipStyle {
  final Map<String, String> styles;

  const TooltipStyle._(this.styles);

  /// Dark tooltip (default)
  static const TooltipStyle dark = TooltipStyle._({
    'background-color': ArcaneColors.inverseSurface,
    'color': ArcaneColors.onInverseSurface,
    'border-radius': ArcaneRadius.sm,
    'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
    'font-size': ArcaneTypography.fontXs,
  });

  /// Light tooltip
  static const TooltipStyle light = TooltipStyle._({
    'background-color': ArcaneColors.surface,
    'color': ArcaneColors.onSurface,
    'border': '1px solid ${ArcaneColors.border}',
    'border-radius': ArcaneRadius.sm,
    'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
    'font-size': ArcaneTypography.fontXs,
    'box-shadow': ArcaneEffects.shadowMd,
  });
}

// =============================================================================
// ICON BUTTON STYLE PRESETS
// =============================================================================

/// Icon button styling presets
/// Use like: ArcaneIconButton(style: IconButtonStyle.primary)
class IconButtonStyle {
  final Map<String, String> base;
  final Map<String, String> hover;

  const IconButtonStyle._({
    required this.base,
    this.hover = const {},
  });

  /// Primary icon button
  static const IconButtonStyle primary = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.accent,
      'color': ArcaneColors.accentForeground,
      'border': 'none',
    },
    hover: {
      'background-color': ArcaneColors.accentHover,
    },
  );

  /// Secondary icon button
  static const IconButtonStyle secondary = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.surfaceVariant,
      'color': ArcaneColors.onSurface,
      'border': '1px solid ${ArcaneColors.border}',
    },
    hover: {
      'background-color': ArcaneColors.surface,
    },
  );

  /// Outline icon button
  static const IconButtonStyle outline = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.transparent,
      'color': ArcaneColors.onSurface,
      'border': '1px solid ${ArcaneColors.border}',
    },
    hover: {
      'background-color': ArcaneColors.surfaceVariant,
    },
  );

  /// Ghost icon button (default)
  static const IconButtonStyle ghost = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.transparent,
      'color': ArcaneColors.muted,
      'border': 'none',
    },
    hover: {
      'background-color': ArcaneColors.surfaceVariant,
      'color': ArcaneColors.onSurface,
    },
  );

  /// Destructive icon button
  static const IconButtonStyle destructive = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.error,
      'color': ArcaneColors.errorForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );

  /// Success icon button
  static const IconButtonStyle success = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.success,
      'color': ArcaneColors.successForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );

  /// Warning icon button
  static const IconButtonStyle warning = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.warning,
      'color': ArcaneColors.warningForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );
}

// =============================================================================
// FAB STYLE PRESETS
// =============================================================================

/// FAB (Floating Action Button) styling presets
/// Use like: FAB(style: FABStyle.primary)
class FABStyle {
  final Map<String, String> base;

  const FABStyle._({required this.base});

  /// Primary FAB
  static const FABStyle primary = FABStyle._(
    base: {
      'background-color': ArcaneColors.accent,
      'color': ArcaneColors.accentForeground,
    },
  );

  /// Secondary FAB
  static const FABStyle secondary = FABStyle._(
    base: {
      'background-color': ArcaneColors.secondaryContainer,
      'color': ArcaneColors.onSecondaryContainer,
    },
  );

  /// Tertiary FAB
  static const FABStyle tertiary = FABStyle._(
    base: {
      'background-color': ArcaneColors.tertiaryContainer,
      'color': ArcaneColors.onTertiaryContainer,
    },
  );

  /// Surface FAB
  static const FABStyle surface = FABStyle._(
    base: {
      'background-color': ArcaneColors.surface,
      'color': ArcaneColors.onSurface,
      'border': '1px solid ${ArcaneColors.border}',
    },
  );

  /// Success FAB
  static const FABStyle success = FABStyle._(
    base: {
      'background-color': ArcaneColors.success,
      'color': ArcaneColors.successForeground,
    },
  );

  /// Destructive FAB
  static const FABStyle destructive = FABStyle._(
    base: {
      'background-color': ArcaneColors.error,
      'color': ArcaneColors.errorForeground,
    },
  );
}

// =============================================================================
// TOGGLE STYLE PRESETS
// =============================================================================

/// Toggle/Switch styling presets
/// Use like: ToggleSwitch(style: ToggleStyle.primary)
class ToggleStyle {
  final String activeColor;
  final String inactiveColor;
  final String thumbColor;

  const ToggleStyle._({
    required this.activeColor,
    required this.inactiveColor,
    required this.thumbColor,
  });

  /// Primary toggle (accent color when active)
  static const ToggleStyle primary = ToggleStyle._(
    activeColor: ArcaneColors.accent,
    inactiveColor: ArcaneColors.surfaceVariant,
    thumbColor: ArcaneColors.white,
  );

  /// Success toggle (green when active)
  static const ToggleStyle success = ToggleStyle._(
    activeColor: ArcaneColors.success,
    inactiveColor: ArcaneColors.surfaceVariant,
    thumbColor: ArcaneColors.white,
  );

  /// Warning toggle (amber when active)
  static const ToggleStyle warning = ToggleStyle._(
    activeColor: ArcaneColors.warning,
    inactiveColor: ArcaneColors.surfaceVariant,
    thumbColor: ArcaneColors.white,
  );

  /// Destructive toggle (red when active)
  static const ToggleStyle destructive = ToggleStyle._(
    activeColor: ArcaneColors.error,
    inactiveColor: ArcaneColors.surfaceVariant,
    thumbColor: ArcaneColors.white,
  );
}

// =============================================================================
// SLIDER STYLE PRESETS
// =============================================================================

/// Slider styling presets
/// Use like: Slider(style: SliderStyle.primary)
class SliderStyle {
  final String trackColor;
  final String activeColor;
  final String thumbColor;

  const SliderStyle._({
    required this.trackColor,
    required this.activeColor,
    required this.thumbColor,
  });

  /// Primary slider (accent color)
  static const SliderStyle primary = SliderStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    activeColor: ArcaneColors.accent,
    thumbColor: ArcaneColors.white,
  );

  /// Success slider (green)
  static const SliderStyle success = SliderStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    activeColor: ArcaneColors.success,
    thumbColor: ArcaneColors.white,
  );

  /// Warning slider (amber)
  static const SliderStyle warning = SliderStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    activeColor: ArcaneColors.warning,
    thumbColor: ArcaneColors.white,
  );

  /// Destructive slider (red)
  static const SliderStyle destructive = SliderStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    activeColor: ArcaneColors.error,
    thumbColor: ArcaneColors.white,
  );
}

// =============================================================================
// CHECKBOX STYLE PRESETS
// =============================================================================

/// Checkbox styling presets
/// Use like: Checkbox(style: CheckboxStyle.primary)
class CheckboxStyle {
  final String checkedColor;
  final String uncheckedBorder;
  final String checkColor;

  const CheckboxStyle._({
    required this.checkedColor,
    required this.uncheckedBorder,
    required this.checkColor,
  });

  /// Primary checkbox (accent color)
  static const CheckboxStyle primary = CheckboxStyle._(
    checkedColor: ArcaneColors.accent,
    uncheckedBorder: ArcaneColors.border,
    checkColor: ArcaneColors.accentForeground,
  );

  /// Success checkbox (green)
  static const CheckboxStyle success = CheckboxStyle._(
    checkedColor: ArcaneColors.success,
    uncheckedBorder: ArcaneColors.border,
    checkColor: ArcaneColors.successForeground,
  );

  /// Warning checkbox (amber)
  static const CheckboxStyle warning = CheckboxStyle._(
    checkedColor: ArcaneColors.warning,
    uncheckedBorder: ArcaneColors.border,
    checkColor: ArcaneColors.warningForeground,
  );

  /// Destructive checkbox (red)
  static const CheckboxStyle destructive = CheckboxStyle._(
    checkedColor: ArcaneColors.error,
    uncheckedBorder: ArcaneColors.border,
    checkColor: ArcaneColors.errorForeground,
  );
}
