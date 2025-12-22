import '../tokens.dart';

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
    thumbColor: ArcaneColors.accentForeground,
  );

  /// Success toggle (green when active)
  static const ToggleStyle success = ToggleStyle._(
    activeColor: ArcaneColors.success,
    inactiveColor: ArcaneColors.surfaceVariant,
    thumbColor: ArcaneColors.successForeground,
  );

  /// Warning toggle (amber when active)
  static const ToggleStyle warning = ToggleStyle._(
    activeColor: ArcaneColors.warning,
    inactiveColor: ArcaneColors.surfaceVariant,
    thumbColor: ArcaneColors.warningForeground,
  );

  /// Destructive toggle (red when active)
  static const ToggleStyle destructive = ToggleStyle._(
    activeColor: ArcaneColors.error,
    inactiveColor: ArcaneColors.surfaceVariant,
    thumbColor: ArcaneColors.errorForeground,
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
    thumbColor: ArcaneColors.accentForeground,
  );

  /// Success slider (green)
  static const SliderStyle success = SliderStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    activeColor: ArcaneColors.success,
    thumbColor: ArcaneColors.successForeground,
  );

  /// Warning slider (amber)
  static const SliderStyle warning = SliderStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    activeColor: ArcaneColors.warning,
    thumbColor: ArcaneColors.warningForeground,
  );

  /// Destructive slider (red)
  static const SliderStyle destructive = SliderStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    activeColor: ArcaneColors.error,
    thumbColor: ArcaneColors.errorForeground,
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
