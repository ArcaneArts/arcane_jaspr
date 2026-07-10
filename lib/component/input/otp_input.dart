import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/otp_input_props.dart'
    show OtpInputSizeVariant, OtpInputProps;

/// Size variants for OTP input.
enum OtpInputSize {
  sm,
  md,
  lg,
}

/// One-time password input with separate digit fields.
class ArcaneOtpInput extends StatefulWidget {
  final int length;
  final void Function(String)? onComplete;
  final void Function(String)? onChange;
  final String? value;
  final bool obscure;
  final OtpInputSize size;
  final bool disabled;
  final String? error;
  final String? label;
  final String? separator;
  final int? separatorPosition;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ArcaneOtpInput({
    this.length = 6,
    this.onComplete,
    this.onChange,
    this.value,
    this.obscure = false,
    this.size = OtpInputSize.md,
    this.disabled = false,
    this.error,
    this.label,
    this.separator,
    this.separatorPosition,
    this.styles,
    this.decoration,
    super.key,
  });

  const ArcaneOtpInput.fourDigit({
    this.onComplete,
    this.onChange,
    this.value,
    this.obscure = false,
    this.size = OtpInputSize.md,
    this.disabled = false,
    this.error,
    this.label,
    this.separator,
    this.separatorPosition,
    this.styles,
    this.decoration,
    super.key,
  }) : length = 4;

  const ArcaneOtpInput.sixDigit({
    this.onComplete,
    this.onChange,
    this.value,
    this.obscure = false,
    this.size = OtpInputSize.md,
    this.disabled = false,
    this.error,
    this.label,
    this.separator,
    this.separatorPosition,
    this.styles,
    this.decoration,
    super.key,
  }) : length = 6;

  @override
  State<ArcaneOtpInput> createState() => _ArcaneOtpInputState();
}

class _ArcaneOtpInputState extends State<ArcaneOtpInput> {
  late List<String> _digits;

  @override
  void initState() {
    super.initState();
    _initDigits();
  }

  void _initDigits() {
    if (component.value != null && component.value!.length == component.length) {
      _digits = component.value!.split('');
    } else {
      _digits = List.filled(component.length, '');
    }
  }

  String get _fullValue => _digits.join();

  void _handleInput(int index, String value) {
    if (component.disabled) return;

    if (value.length > 1) {
      _handlePaste(value);
      return;
    }

    if (value.isNotEmpty && RegExp(r'[0-9]').hasMatch(value)) {
      setState(() {
        _digits[index] = value;
      });

      component.onChange?.call(_fullValue);

      if (_digits.every((d) => d.isNotEmpty)) {
        component.onComplete?.call(_fullValue);
      }
    }
  }

  void _handlePaste(String pastedValue) {
    final digits = pastedValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return;

    setState(() {
      for (var i = 0; i < component.length && i < digits.length; i++) {
        _digits[i] = digits[i];
      }
    });

    component.onChange?.call(_fullValue);

    if (_digits.every((d) => d.isNotEmpty)) {
      component.onComplete?.call(_fullValue);
    }
  }

  OtpInputSizeVariant get _propsSize => switch (component.size) {
        OtpInputSize.sm => OtpInputSizeVariant.sm,
        OtpInputSize.md => OtpInputSizeVariant.md,
        OtpInputSize.lg => OtpInputSizeVariant.lg,
      };

  @override
  Widget build(BuildContext context) {
    return context.renderers.otpInput(OtpInputProps(
      length: component.length,
      digits: _digits,
      obscure: component.obscure,
      size: _propsSize,
      disabled: component.disabled,
      error: component.error,
      label: component.label,
      separator: component.separator,
      separatorPosition: component.separatorPosition,
      onInput: _handleInput,
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}
