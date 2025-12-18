/// Color utilities for Arcane Jaspr
/// Provides a simple color representation for CSS output

class Color {
  final int value;

  const Color(this.value);

  const Color.fromARGB(int a, int r, int g, int b)
      : value = (((a & 0xff) << 24) |
            ((r & 0xff) << 16) |
            ((g & 0xff) << 8) |
            ((b & 0xff) << 0)) &
            0xFFFFFFFF;

  const Color.fromRGBO(int r, int g, int b, double opacity)
      : value = ((((opacity * 0xff ~/ 1) & 0xff) << 24) |
            ((r & 0xff) << 16) |
            ((g & 0xff) << 8) |
            ((b & 0xff) << 0)) &
            0xFFFFFFFF;

  int get alpha => (0xff000000 & value) >> 24;
  int get red => (0x00ff0000 & value) >> 16;
  int get green => (0x0000ff00 & value) >> 8;
  int get blue => (0x000000ff & value) >> 0;

  double get opacity => alpha / 0xFF;

  Color withOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }

  Color withAlpha(int a) {
    return Color.fromARGB(a, red, green, blue);
  }

  /// Convert to CSS rgba() string
  String get css => 'rgba($red, $green, $blue, ${opacity.toStringAsFixed(2)})';

  /// Convert to CSS hex string
  String get hex {
    String r = red.toRadixString(16).padLeft(2, '0');
    String g = green.toRadixString(16).padLeft(2, '0');
    String b = blue.toRadixString(16).padLeft(2, '0');
    if (alpha == 255) {
      return '#$r$g$b';
    }
    String a = alpha.toRadixString(16).padLeft(2, '0');
    return '#$r$g$b$a';
  }

  /// Lighten the color by a percentage (0-100)
  Color lighten([int amount = 10]) {
    final hsl = _toHsl();
    final lightness = (hsl[2] + amount / 100).clamp(0.0, 1.0);
    return _fromHsl(hsl[0], hsl[1], lightness);
  }

  /// Darken the color by a percentage (0-100)
  Color darken([int amount = 10]) {
    final hsl = _toHsl();
    final lightness = (hsl[2] - amount / 100).clamp(0.0, 1.0);
    return _fromHsl(hsl[0], hsl[1], lightness);
  }

  /// Spin the hue by degrees
  Color spin(double degrees) {
    final hsl = _toHsl();
    final hue = (hsl[0] + degrees) % 360;
    return _fromHsl(hue < 0 ? hue + 360 : hue, hsl[1], hsl[2]);
  }

  /// Compute luminance (0.0 to 1.0)
  double computeLuminance() {
    final r = _linearize(red / 255);
    final g = _linearize(green / 255);
    final b = _linearize(blue / 255);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  double _linearize(double c) {
    return c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055).pow(2.4);
  }

  List<double> _toHsl() {
    final r = red / 255;
    final g = green / 255;
    final b = blue / 255;
    final max = [r, g, b].reduce((a, b) => a > b ? a : b);
    final min = [r, g, b].reduce((a, b) => a < b ? a : b);
    final l = (max + min) / 2;

    if (max == min) {
      return [0, 0, l];
    }

    final d = max - min;
    final s = l > 0.5 ? d / (2 - max - min) : d / (max + min);

    double h;
    if (max == r) {
      h = ((g - b) / d + (g < b ? 6 : 0)) / 6;
    } else if (max == g) {
      h = ((b - r) / d + 2) / 6;
    } else {
      h = ((r - g) / d + 4) / 6;
    }

    return [h * 360, s, l];
  }

  static Color _fromHsl(double h, double s, double l) {
    if (s == 0) {
      final v = (l * 255).round();
      return Color.fromARGB(255, v, v, v);
    }

    double hue2rgb(double p, double q, double t) {
      if (t < 0) t += 1;
      if (t > 1) t -= 1;
      if (t < 1 / 6) return p + (q - p) * 6 * t;
      if (t < 1 / 2) return q;
      if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
      return p;
    }

    final q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    final p = 2 * l - q;
    final hNorm = h / 360;

    return Color.fromARGB(
      255,
      (hue2rgb(p, q, hNorm + 1 / 3) * 255).round(),
      (hue2rgb(p, q, hNorm) * 255).round(),
      (hue2rgb(p, q, hNorm - 1 / 3) * 255).round(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Color && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Color(0x${value.toRadixString(16).padLeft(8, '0')})';
}

extension _DoublePow on double {
  double pow(double exp) => _pow(this, exp);
  static double _pow(double base, double exp) {
    if (base == 0) return 0;
    return base.sign * (base.abs()).toDouble()._realPow(exp);
  }

  double _realPow(double exp) {
    // Simple implementation using dart:math would require import
    // For now, approximate for sRGB linearization
    double result = 1;
    double term = 1;
    double lnBase = _ln(this);
    for (int i = 1; i < 20; i++) {
      term *= exp * lnBase / i;
      result += term;
    }
    return result;
  }

  double _ln(double x) {
    if (x <= 0) return double.negativeInfinity;
    double y = (x - 1) / (x + 1);
    double result = 0;
    double term = y;
    for (int i = 1; i < 40; i += 2) {
      result += term / i;
      term *= y * y;
    }
    return 2 * result;
  }
}

/// Common colors
abstract class Colors {
  static const Color transparent = Color(0x00000000);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Grays
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color gray950 = Color(0xFF030712);

  // Slate
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate950 = Color(0xFF020617);

  // Zinc (Supabase-style dark theme base)
  static const Color zinc50 = Color(0xFFFAFAFA);
  static const Color zinc100 = Color(0xFFF4F4F5);
  static const Color zinc200 = Color(0xFFE4E4E7);
  static const Color zinc300 = Color(0xFFD4D4D8);
  static const Color zinc400 = Color(0xFFA1A1AA);
  static const Color zinc500 = Color(0xFF71717A);
  static const Color zinc600 = Color(0xFF52525B);
  static const Color zinc700 = Color(0xFF3F3F46);
  static const Color zinc800 = Color(0xFF27272A);
  static const Color zinc900 = Color(0xFF18181B);
  static const Color zinc950 = Color(0xFF09090B);

  // Primary colors
  static const Color red = Color(0xFFEF4444);
  static const Color orange = Color(0xFFF97316);
  static const Color amber = Color(0xFFF59E0B);
  static const Color yellow = Color(0xFFEAB308);
  static const Color lime = Color(0xFF84CC16);
  static const Color green = Color(0xFF22C55E);
  static const Color emerald = Color(0xFF10B981);
  static const Color teal = Color(0xFF14B8A6);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color sky = Color(0xFF0EA5E9);
  static const Color blue = Color(0xFF3B82F6);
  static const Color indigo = Color(0xFF6366F1);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color purple = Color(0xFFA855F7);
  static const Color fuchsia = Color(0xFFD946EF);
  static const Color pink = Color(0xFFEC4899);
  static const Color rose = Color(0xFFF43F5E);

  // Extended emerald palette (Supabase accent)
  static const Color emerald50 = Color(0xFFECFDF5);
  static const Color emerald100 = Color(0xFFD1FAE5);
  static const Color emerald200 = Color(0xFFA7F3D0);
  static const Color emerald300 = Color(0xFF6EE7B7);
  static const Color emerald400 = Color(0xFF34D399);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald600 = Color(0xFF059669);
  static const Color emerald700 = Color(0xFF047857);
  static const Color emerald800 = Color(0xFF065F46);
  static const Color emerald900 = Color(0xFF064E3B);
  static const Color emerald950 = Color(0xFF022C22);

  // Extended cyan palette
  static const Color cyan50 = Color(0xFFECFEFF);
  static const Color cyan100 = Color(0xFFCFFAFE);
  static const Color cyan200 = Color(0xFFA5F3FC);
  static const Color cyan300 = Color(0xFF67E8F9);
  static const Color cyan400 = Color(0xFF22D3EE);
  static const Color cyan500 = Color(0xFF06B6D4);
  static const Color cyan600 = Color(0xFF0891B2);
  static const Color cyan700 = Color(0xFF0E7490);
  static const Color cyan800 = Color(0xFF155E75);
  static const Color cyan900 = Color(0xFF164E63);
  static const Color cyan950 = Color(0xFF083344);

  // Extended violet palette
  static const Color violet50 = Color(0xFFF5F3FF);
  static const Color violet100 = Color(0xFFEDE9FE);
  static const Color violet200 = Color(0xFFDDD6FE);
  static const Color violet300 = Color(0xFFC4B5FD);
  static const Color violet400 = Color(0xFFA78BFA);
  static const Color violet500 = Color(0xFF8B5CF6);
  static const Color violet600 = Color(0xFF7C3AED);
  static const Color violet700 = Color(0xFF6D28D9);
  static const Color violet800 = Color(0xFF5B21B6);
  static const Color violet900 = Color(0xFF4C1D95);
  static const Color violet950 = Color(0xFF2E1065);

  // Extended amber palette
  static const Color amber50 = Color(0xFFFFFBEB);
  static const Color amber100 = Color(0xFFFEF3C7);
  static const Color amber200 = Color(0xFFFDE68A);
  static const Color amber300 = Color(0xFFFCD34D);
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber600 = Color(0xFFD97706);
  static const Color amber700 = Color(0xFFB45309);
  static const Color amber800 = Color(0xFF92400E);
  static const Color amber900 = Color(0xFF78350F);
  static const Color amber950 = Color(0xFF451A03);

  // Extended red palette (for errors/destructive)
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red100 = Color(0xFFFEE2E2);
  static const Color red200 = Color(0xFFFECACA);
  static const Color red300 = Color(0xFFFCA5A5);
  static const Color red400 = Color(0xFFF87171);
  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red700 = Color(0xFFB91C1C);
  static const Color red800 = Color(0xFF991B1B);
  static const Color red900 = Color(0xFF7F1D1D);
  static const Color red950 = Color(0xFF450A0A);
}
