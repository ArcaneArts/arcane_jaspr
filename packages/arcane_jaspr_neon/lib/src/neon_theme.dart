library;

/// Color palettes for the Neon (gamer) theme.
///
/// Each variant is a cohesive neon set: [color] is the primary accent, with a
/// warm ([accentHot]) and cool ([accentCool]) companion used for gradients and
/// glows. The `light*` fields seed light mode; dark mode is a near-black gamer
/// surface driven by [NeonStylesheet.darkSeed] with `accentGlow` enabled.
///
/// The default [green] is tuned to the QualityNode aesthetic (emerald primary,
/// cyan companion) so a site using the Neon theme is close to QualityNode out of
/// the box and only needs to override fonts/spacing.
enum NeonTheme {
  /// QualityNode emerald -> cyan.
  green(
    color: 0xFF059669,
    accentHot: 0xFF34D399,
    accentCool: 0xFF06B6D4,
    lightSurface: 0xFFF4FBF7,
    lightSecondary: 0xFFE3F4EC,
    lightAccent: 0xFFCDEBDC,
    lightBorder: 0xFF9FD9BE,
    lightInk: 0xFF064E3B,
  ),

  red(
    color: 0xFFFF3B3B,
    accentHot: 0xFFFF8A1F,
    accentCool: 0xFFFF2BD6,
    lightSurface: 0xFFFFF6F6,
    lightSecondary: 0xFFFFE3E3,
    lightAccent: 0xFFFFCFCF,
    lightBorder: 0xFFF2A0A0,
    lightInk: 0xFF7F1D1D,
  ),

  blue(
    color: 0xFF00A8FF,
    accentHot: 0xFF00E5FF,
    accentCool: 0xFF6366F1,
    lightSurface: 0xFFF3FAFF,
    lightSecondary: 0xFFDCEFFF,
    lightAccent: 0xFFC2E6FF,
    lightBorder: 0xFF8FC9EC,
    lightInk: 0xFF0C4A6E,
  ),

  purple(
    color: 0xFFA855F7,
    accentHot: 0xFFEC4899,
    accentCool: 0xFF6366F1,
    lightSurface: 0xFFFAF6FF,
    lightSecondary: 0xFFEEE4FF,
    lightAccent: 0xFFDECFFF,
    lightBorder: 0xFFBCA3EA,
    lightInk: 0xFF4C1D95,
  ),

  cyan(
    color: 0xFF06B6D4,
    accentHot: 0xFF22D3EE,
    accentCool: 0xFF3B82F6,
    lightSurface: 0xFFF2FCFF,
    lightSecondary: 0xFFDAF4FB,
    lightAccent: 0xFFBFEAF4,
    lightBorder: 0xFF86CEDD,
    lightInk: 0xFF155E75,
  ),

  pink(
    color: 0xFFEC4899,
    accentHot: 0xFFFF5169,
    accentCool: 0xFFA855F7,
    lightSurface: 0xFFFFF5FB,
    lightSecondary: 0xFFFFE0F1,
    lightAccent: 0xFFFFC6E6,
    lightBorder: 0xFFF098C4,
    lightInk: 0xFF831843,
  ),

  orange(
    color: 0xFFF97316,
    accentHot: 0xFFFF2D55,
    accentCool: 0xFFFFD23F,
    lightSurface: 0xFFFFF8F2,
    lightSecondary: 0xFFFFE9D5,
    lightAccent: 0xFFFFD6B0,
    lightBorder: 0xFFF2A86A,
    lightInk: 0xFF7C2D12,
  ),

  rainbow(
    color: 0xFF06B6D4,
    accentHot: 0xFFEC4899,
    accentCool: 0xFFA855F7,
    lightSurface: 0xFFF6F8FF,
    lightSecondary: 0xFFE7E9FF,
    lightAccent: 0xFFD3D8FF,
    lightBorder: 0xFF9AA6E0,
    lightInk: 0xFF1E1B4B,
  );

  /// Primary accent color.
  final int color;

  /// Warm companion accent (highlights, secondary glows).
  final int accentHot;

  /// Cool companion accent (gradient partner, focus/links).
  final int accentCool;

  /// Light-mode surface (background).
  final int lightSurface;

  /// Light-mode secondary/muted surface.
  final int lightSecondary;

  /// Light-mode accent surface.
  final int lightAccent;

  /// Light-mode border.
  final int lightBorder;

  /// Light-mode ink (deep accent text tone).
  final int lightInk;

  const NeonTheme({
    required this.color,
    required this.accentHot,
    required this.accentCool,
    required this.lightSurface,
    required this.lightSecondary,
    required this.lightAccent,
    required this.lightBorder,
    required this.lightInk,
  });
}
