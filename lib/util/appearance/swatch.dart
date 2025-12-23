import 'colors.dart';

/// A complete color swatch with 11 shades (Tailwind-style: 50-950)
///
/// Used to define a full color palette for a theme, where:
/// - shade50 is the lightest (near white)
/// - shade500 is the primary/base color
/// - shade950 is the darkest (near black)
class ColorSwatch {
  final Color shade50;
  final Color shade100;
  final Color shade200;
  final Color shade300;
  final Color shade400;
  final Color shade500;
  final Color shade600;
  final Color shade700;
  final Color shade800;
  final Color shade900;
  final Color shade950;

  const ColorSwatch({
    required this.shade50,
    required this.shade100,
    required this.shade200,
    required this.shade300,
    required this.shade400,
    required this.shade500,
    required this.shade600,
    required this.shade700,
    required this.shade800,
    required this.shade900,
    required this.shade950,
  });

  /// Get shade by number (50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950)
  Color operator [](int shade) => switch (shade) {
        50 => shade50,
        100 => shade100,
        200 => shade200,
        300 => shade300,
        400 => shade400,
        500 => shade500,
        600 => shade600,
        700 => shade700,
        800 => shade800,
        900 => shade900,
        950 => shade950,
        _ => shade500,
      };

  /// Primary color for dark mode (typically 400-500)
  Color get primaryDark => shade500;

  /// Primary color for light mode (typically 600)
  Color get primaryLight => shade600;

  /// Hover color for dark mode
  Color get hoverDark => shade400;

  /// Hover color for light mode
  Color get hoverLight => shade700;

  /// Container/muted color for dark mode
  Color get containerDark => shade950;

  /// Container/muted color for light mode
  Color get containerLight => shade100;

  /// Foreground color for dark mode (text on accent)
  Color get foregroundDark => shade950;

  /// Foreground color for light mode (text on accent)
  Color get foregroundLight => Colors.white;

  /// All shade values in order
  List<Color> get all => [
        shade50,
        shade100,
        shade200,
        shade300,
        shade400,
        shade500,
        shade600,
        shade700,
        shade800,
        shade900,
        shade950,
      ];

  /// All shade keys
  static const List<int> shadeKeys = [
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
    950
  ];

  /// Generate CSS variables for this swatch with a given prefix
  Map<String, String> toCssVariables(String prefix) {
    String rgb(Color color) => '${color.red}, ${color.green}, ${color.blue}';
    return {
      '$prefix-50': shade50.css,
      '$prefix-100': shade100.css,
      '$prefix-200': shade200.css,
      '$prefix-300': shade300.css,
      '$prefix-400': shade400.css,
      '$prefix-500': shade500.css,
      '$prefix-600': shade600.css,
      '$prefix-700': shade700.css,
      '$prefix-800': shade800.css,
      '$prefix-900': shade900.css,
      '$prefix-950': shade950.css,
      // RGB variants for alpha blending
      '$prefix-50-rgb': rgb(shade50),
      '$prefix-100-rgb': rgb(shade100),
      '$prefix-200-rgb': rgb(shade200),
      '$prefix-300-rgb': rgb(shade300),
      '$prefix-400-rgb': rgb(shade400),
      '$prefix-500-rgb': rgb(shade500),
      '$prefix-600-rgb': rgb(shade600),
      '$prefix-700-rgb': rgb(shade700),
      '$prefix-800-rgb': rgb(shade800),
      '$prefix-900-rgb': rgb(shade900),
      '$prefix-950-rgb': rgb(shade950),
    };
  }
}

/// Predefined Tailwind color swatches
abstract class Swatches {
  // Red
  static const ColorSwatch red = ColorSwatch(
    shade50: Color(0xFFFEF2F2),
    shade100: Color(0xFFFEE2E2),
    shade200: Color(0xFFFECACA),
    shade300: Color(0xFFFCA5A5),
    shade400: Color(0xFFF87171),
    shade500: Color(0xFFEF4444),
    shade600: Color(0xFFDC2626),
    shade700: Color(0xFFB91C1C),
    shade800: Color(0xFF991B1B),
    shade900: Color(0xFF7F1D1D),
    shade950: Color(0xFF450A0A),
  );

  // Orange
  static const ColorSwatch orange = ColorSwatch(
    shade50: Color(0xFFFFF7ED),
    shade100: Color(0xFFFFEDD5),
    shade200: Color(0xFFFED7AA),
    shade300: Color(0xFFFDBA74),
    shade400: Color(0xFFFB923C),
    shade500: Color(0xFFF97316),
    shade600: Color(0xFFEA580C),
    shade700: Color(0xFFC2410C),
    shade800: Color(0xFF9A3412),
    shade900: Color(0xFF7C2D12),
    shade950: Color(0xFF431407),
  );

  // Amber (Yellow theme)
  static const ColorSwatch amber = ColorSwatch(
    shade50: Color(0xFFFFFBEB),
    shade100: Color(0xFFFEF3C7),
    shade200: Color(0xFFFDE68A),
    shade300: Color(0xFFFCD34D),
    shade400: Color(0xFFFBBF24),
    shade500: Color(0xFFF59E0B),
    shade600: Color(0xFFD97706),
    shade700: Color(0xFFB45309),
    shade800: Color(0xFF92400E),
    shade900: Color(0xFF78350F),
    shade950: Color(0xFF451A03),
  );

  // Emerald (Green theme)
  static const ColorSwatch emerald = ColorSwatch(
    shade50: Color(0xFFECFDF5),
    shade100: Color(0xFFD1FAE5),
    shade200: Color(0xFFA7F3D0),
    shade300: Color(0xFF6EE7B7),
    shade400: Color(0xFF34D399),
    shade500: Color(0xFF10B981),
    shade600: Color(0xFF059669),
    shade700: Color(0xFF047857),
    shade800: Color(0xFF065F46),
    shade900: Color(0xFF064E3B),
    shade950: Color(0xFF022C22),
  );

  // Blue
  static const ColorSwatch blue = ColorSwatch(
    shade50: Color(0xFFEFF6FF),
    shade100: Color(0xFFDBEAFE),
    shade200: Color(0xFFBFDBFE),
    shade300: Color(0xFF93C5FD),
    shade400: Color(0xFF60A5FA),
    shade500: Color(0xFF3B82F6),
    shade600: Color(0xFF2563EB),
    shade700: Color(0xFF1D4ED8),
    shade800: Color(0xFF1E40AF),
    shade900: Color(0xFF1E3A8A),
    shade950: Color(0xFF172554),
  );

  // Indigo
  static const ColorSwatch indigo = ColorSwatch(
    shade50: Color(0xFFEEF2FF),
    shade100: Color(0xFFE0E7FF),
    shade200: Color(0xFFC7D2FE),
    shade300: Color(0xFFA5B4FC),
    shade400: Color(0xFF818CF8),
    shade500: Color(0xFF6366F1),
    shade600: Color(0xFF4F46E5),
    shade700: Color(0xFF4338CA),
    shade800: Color(0xFF3730A3),
    shade900: Color(0xFF312E81),
    shade950: Color(0xFF1E1B4B),
  );

  // Violet (Purple theme)
  static const ColorSwatch violet = ColorSwatch(
    shade50: Color(0xFFF5F3FF),
    shade100: Color(0xFFEDE9FE),
    shade200: Color(0xFFDDD6FE),
    shade300: Color(0xFFC4B5FD),
    shade400: Color(0xFFA78BFA),
    shade500: Color(0xFF8B5CF6),
    shade600: Color(0xFF7C3AED),
    shade700: Color(0xFF6D28D9),
    shade800: Color(0xFF5B21B6),
    shade900: Color(0xFF4C1D95),
    shade950: Color(0xFF2E1065),
  );

  // Pink
  static const ColorSwatch pink = ColorSwatch(
    shade50: Color(0xFFFDF2F8),
    shade100: Color(0xFFFCE7F3),
    shade200: Color(0xFFFBCFE8),
    shade300: Color(0xFFF9A8D4),
    shade400: Color(0xFFF472B6),
    shade500: Color(0xFFEC4899),
    shade600: Color(0xFFDB2777),
    shade700: Color(0xFFBE185D),
    shade800: Color(0xFF9D174D),
    shade900: Color(0xFF831843),
    shade950: Color(0xFF500724),
  );

  // Zinc (Dark Grey / Black theme base)
  static const ColorSwatch zinc = ColorSwatch(
    shade50: Color(0xFFFAFAFA),
    shade100: Color(0xFFF4F4F5),
    shade200: Color(0xFFE4E4E7),
    shade300: Color(0xFFD4D4D8),
    shade400: Color(0xFFA1A1AA),
    shade500: Color(0xFF71717A),
    shade600: Color(0xFF52525B),
    shade700: Color(0xFF3F3F46),
    shade800: Color(0xFF27272A),
    shade900: Color(0xFF18181B),
    shade950: Color(0xFF09090B),
  );

  // Slate (Grey theme base)
  static const ColorSwatch slate = ColorSwatch(
    shade50: Color(0xFFF8FAFC),
    shade100: Color(0xFFF1F5F9),
    shade200: Color(0xFFE2E8F0),
    shade300: Color(0xFFCBD5E1),
    shade400: Color(0xFF94A3B8),
    shade500: Color(0xFF64748B),
    shade600: Color(0xFF475569),
    shade700: Color(0xFF334155),
    shade800: Color(0xFF1E293B),
    shade900: Color(0xFF0F172A),
    shade950: Color(0xFF020617),
  );

  // Gray (Light Grey theme base)
  static const ColorSwatch gray = ColorSwatch(
    shade50: Color(0xFFF9FAFB),
    shade100: Color(0xFFF3F4F6),
    shade200: Color(0xFFE5E7EB),
    shade300: Color(0xFFD1D5DB),
    shade400: Color(0xFF9CA3AF),
    shade500: Color(0xFF6B7280),
    shade600: Color(0xFF4B5563),
    shade700: Color(0xFF374151),
    shade800: Color(0xFF1F2937),
    shade900: Color(0xFF111827),
    shade950: Color(0xFF030712),
  );

  // Neutral (White/Black theme base)
  static const ColorSwatch neutral = ColorSwatch(
    shade50: Color(0xFFFAFAFA),
    shade100: Color(0xFFF5F5F5),
    shade200: Color(0xFFE5E5E5),
    shade300: Color(0xFFD4D4D4),
    shade400: Color(0xFFA3A3A3),
    shade500: Color(0xFF737373),
    shade600: Color(0xFF525252),
    shade700: Color(0xFF404040),
    shade800: Color(0xFF262626),
    shade900: Color(0xFF171717),
    shade950: Color(0xFF0A0A0A),
  );
}
