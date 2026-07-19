import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

enum OtpInputSizeVariant {
  sm,
  md,
  lg,
}

/// OTP input component properties.
class OtpInputProps {
  final int length;
  final List<String> digits;
  final bool obscure;
  final OtpInputSizeVariant size;
  final bool disabled;
  final String? error;
  final String? label;
  final String? separator;
  final int? separatorPosition;
  final void Function(int index, String value)? onInput;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const OtpInputProps({
    this.length = 6,
    this.digits = const [],
    this.obscure = false,
    this.size = OtpInputSizeVariant.md,
    this.disabled = false,
    this.error,
    this.label,
    this.separator,
    this.separatorPosition,
    this.onInput,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for OTP input components.
mixin OtpInputRendererContract {
  /// Render an OTP input component.
  Component otpInput(OtpInputProps props);
}
