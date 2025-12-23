import '../tokens/tokens.dart';

// CSS variable references for QualityNode brand colors
const String _qnBorder = 'var(--qn-border, rgba(5, 150, 105, 0.25))';

/// Complete border presets combining width, style, and color.
///
/// These presets provide ready-to-use border configurations for common
/// UI patterns. Use for quick, consistent border styling.
///
/// ## Standard Borders
///
/// | Preset       | Description                    |
/// |--------------|--------------------------------|
/// | `none`       | No border                      |
/// | `subtle`     | 1px barely visible             |
/// | `standard`   | 1px default border             |
/// | `medium`     | 1px medium emphasis            |
/// | `accent`     | 1px accent color               |
///
/// ## Status Borders
///
/// | Preset    | Use Case                          |
/// |-----------|-----------------------------------|
/// | `success` | Success/confirmation states       |
/// | `warning` | Warning/caution states            |
/// | `error`   | Error/destructive states          |
/// | `info`    | Informational states              |
/// | `focus`   | Focus ring (2px)                  |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     border: BorderPreset.standard,    // All sides
///     borderLeft: BorderPreset.accent,  // Left only
///     borderBottom: BorderPreset.subtle, // Bottom only
///   ),
/// )
/// ```
enum BorderPreset {
  /// No border
  none,

  /// 1px solid subtle border
  subtle,

  /// 1px solid standard border
  standard,

  /// 1px solid medium border
  medium,

  /// 1px solid light border
  light,

  /// 1px solid accent border
  accent,

  /// 1px solid success border
  success,

  /// 1px solid warning border
  warning,

  /// 1px solid error border
  error,

  /// 1px solid info border
  info,

  /// 2px solid ring (focus state)
  focus,

  /// 2px solid accent
  accentThick,

  /// Dashed subtle border
  dashedSubtle,

  /// Dashed standard border
  dashedStandard,

  /// Brand colored border (theme-reactive)
  brand,

  /// 2px solid brand primary (for highlighted cards)
  brandThick,

  /// Top border only (subtle)
  topSubtle,

  /// Bottom border only (subtle)
  bottomSubtle;

  String get css => switch (this) {
        BorderPreset.none => 'none',
        BorderPreset.subtle => '1px solid ${ArcaneColors.borderSubtle}',
        BorderPreset.standard => '1px solid ${ArcaneColors.border}',
        BorderPreset.medium => '1px solid ${ArcaneColors.borderMedium}',
        BorderPreset.light => '1px solid ${ArcaneColors.borderLight}',
        BorderPreset.accent => '1px solid ${ArcaneColors.accent}',
        BorderPreset.success => '1px solid ${ArcaneColors.success}',
        BorderPreset.warning => '1px solid ${ArcaneColors.warning}',
        BorderPreset.error => '1px solid ${ArcaneColors.error}',
        BorderPreset.info => '1px solid ${ArcaneColors.info}',
        BorderPreset.focus => '2px solid ${ArcaneColors.ring}',
        BorderPreset.accentThick => '2px solid ${ArcaneColors.accent}',
        BorderPreset.dashedSubtle => '1px dashed ${ArcaneColors.borderSubtle}',
        BorderPreset.dashedStandard => '1px dashed ${ArcaneColors.border}',
        BorderPreset.brand => '1px solid $_qnBorder',
        BorderPreset.brandThick => '2px solid ${ArcaneColors.accent}',
        BorderPreset.topSubtle => '1px solid ${ArcaneColors.borderSubtle}',
        BorderPreset.bottomSubtle => '1px solid ${ArcaneColors.borderSubtle}',
      };
}

/// Border radius presets for rounded corners.
///
/// These presets use CSS custom properties that can be themed.
///
/// ## Radius Scale
///
/// | Value   | Size   | Use Case                           |
/// |---------|--------|-------------------------------------|
/// | `none`  | 0      | Sharp corners                       |
/// | `xs`    | 4px    | Subtle rounding                     |
/// | `sm`    | 6px    | Buttons, inputs                     |
/// | `md`    | 8px    | Cards, dialogs                      |
/// | `lg`    | 12px   | Large cards, panels                 |
/// | `xl`    | 16px   | Hero sections                       |
/// | `full`  | 9999px | Pill shapes                         |
/// | `circle`| 50%    | Perfect circles (avatars)           |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     borderRadius: Radius.md,       // Standard card
///     // borderRadius: Radius.full,  // Pill button
///     // borderRadius: Radius.circle, // Avatar
///   ),
/// )
/// ```
enum Radius {
  /// No radius (0)
  none,

  /// Extra small (4px)
  xs,

  /// Small (6px theme-reactive)
  sm,

  /// Medium (8px theme-reactive)
  md,

  /// Large (12px theme-reactive)
  lg,

  /// Extra large (16px theme-reactive)
  xl,

  /// 2x Extra large (24px theme-reactive)
  xxl,

  /// Full/pill (9999px)
  full,

  /// Circle (50%)
  circle;

  String get css => switch (this) {
        Radius.none => ArcaneRadius.none,
        Radius.xs => ArcaneRadius.xs,
        Radius.sm => ArcaneRadius.sm,
        Radius.md => ArcaneRadius.md,
        Radius.lg => ArcaneRadius.lg,
        Radius.xl => ArcaneRadius.xl,
        Radius.xxl => ArcaneRadius.xxl,
        Radius.full => ArcaneRadius.full,
        Radius.circle => ArcaneRadius.circle,
      };

  /// Static (non-CSS-variable) value for calculations
  String get staticCss => switch (this) {
        Radius.none => ArcaneRadius.none,
        Radius.xs => ArcaneRadius.xs,
        Radius.sm => ArcaneRadius.smStatic,
        Radius.md => ArcaneRadius.mdStatic,
        Radius.lg => ArcaneRadius.lgStatic,
        Radius.xl => ArcaneRadius.xlStatic,
        Radius.xxl => ArcaneRadius.xxlStatic,
        Radius.full => ArcaneRadius.fullStatic,
        Radius.circle => ArcaneRadius.circle,
      };
}

/// Border width presets for controlling border thickness.
///
/// Use with directional border properties for fine-grained control.
///
/// ## Width Scale
///
/// | Value      | Size | Use Case                      |
/// |------------|------|-------------------------------|
/// | `none`     | 0    | Remove border                 |
/// | `hairline` | 1px  | Subtle dividers               |
/// | `thin`     | 1px  | Standard borders              |
/// | `medium`   | 2px  | Emphasized borders            |
/// | `thick`    | 3px  | Strong emphasis               |
/// | `heavy`    | 4px  | Maximum emphasis              |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     borderLeft: BorderPreset.accent,
///     borderLeftWidth: BorderWidth.thick,  // 3px accent left
///   ),
/// )
/// ```
enum BorderWidth {
  /// No border
  none,

  /// Hairline (1px)
  hairline,

  /// Thin (1px)
  thin,

  /// Medium (2px)
  medium,

  /// Thick (3px)
  thick,

  /// Heavy (4px)
  heavy;

  String get css => switch (this) {
        BorderWidth.none => '0',
        BorderWidth.hairline => '1px',
        BorderWidth.thin => '1px',
        BorderWidth.medium => '2px',
        BorderWidth.thick => '3px',
        BorderWidth.heavy => '4px',
      };
}

/// Border style
enum BorderStyle {
  none,
  solid,
  dashed,
  dotted,
  double_,
  groove,
  ridge,
  inset,
  outset;

  String get css => switch (this) {
        BorderStyle.none => 'none',
        BorderStyle.solid => 'solid',
        BorderStyle.dashed => 'dashed',
        BorderStyle.dotted => 'dotted',
        BorderStyle.double_ => 'double',
        BorderStyle.groove => 'groove',
        BorderStyle.ridge => 'ridge',
        BorderStyle.inset => 'inset',
        BorderStyle.outset => 'outset',
      };
}

/// Outline presets
enum OutlinePreset {
  /// No outline
  none,

  /// Standard focus outline
  focus,

  /// Accent focus outline
  focusAccent,

  /// Error focus outline
  focusError,

  /// Ring outline
  ring;

  String get css => switch (this) {
        OutlinePreset.none => 'none',
        OutlinePreset.focus => '2px solid ${ArcaneColors.ring}',
        OutlinePreset.focusAccent => '2px solid ${ArcaneColors.accent}',
        OutlinePreset.focusError => '2px solid ${ArcaneColors.error}',
        OutlinePreset.ring => '2px solid ${ArcaneColors.ring}',
      };
}
