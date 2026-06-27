import 'package:arcane_jaspr/core/props/otp_input_props.dart';
import 'package:arcane_jaspr/core/rendering/base/otp_input_render_base.dart';

/// Neon OTP input component.
class NeonOtpInput extends OtpInputRenderBase {
  const NeonOtpInput(super.props, {super.key});

  @override
  String get rootClass => 'neon-otp-input';

  @override
  String get idleState => 'idle';

  @override
  Map<String, String> get extraRootAttrs => <String, String>{
    'data-size': props.size.name,
  };

  @override
  Map<String, String> get rootStyles => const <String, String>{};

  @override
  Map<String, String> get labelStyles => const <String, String>{};

  @override
  String get digitsRowClass => 'neon-otp-digits';

  @override
  Map<String, String> get digitsRowStyles => const <String, String>{};

  @override
  Map<String, String> get separatorStyles => const <String, String>{};

  @override
  String get digitClass => 'neon-otp-digit';

  @override
  (String, String) sizeStyles(OtpInputSizeVariant size) => switch (size) {
    OtpInputSizeVariant.sm => ('44px', '1rem'),
    OtpInputSizeVariant.md => ('52px', '1.125rem'),
    OtpInputSizeVariant.lg => ('60px', '1.25rem'),
  };

  @override
  Map<String, String> digitAttributes(
    int i,
    bool hasError,
    List<String> digits,
  ) => <String, String>{
    'maxlength': '1',
    'inputmode': 'numeric',
    'pattern': '[0-9]*',
    'autocomplete': 'one-time-code',
    'aria-label': 'Digit ${i + 1} of ${props.length}',
    'data-otp-index': '$i',
    'data-otp-length': '${props.length}',
    'data-state': isFilled(i, digits) ? 'filled' : 'empty',
    'data-disabled': '${props.disabled}',
    if (props.disabled) 'disabled': 'true',
    'value': digitValue(i, digits),
  };

  @override
  Map<String, String> digitStyles(
    int i,
    bool hasError,
    List<String> digits,
    String size,
    String fontSize,
  ) => const <String, String>{};
}
