import 'package:arcane_jaspr/core/props/otp_input_props.dart';
import 'package:arcane_jaspr/core/rendering/base/otp_input_render_base.dart';

/// ShadCN-style OTP input component
/// Reference: https://ui.shadcn.com/docs/components/input-otp
class ShadcnOtpInput extends OtpInputRenderBase {
  const ShadcnOtpInput(super.props, {super.key});

  @override
  String get rootClass => 'arcane-otp-input';

  @override
  String get idleState => 'default';

  @override
  Map<String, String> get extraRootAttrs => const <String, String>{};

  @override
  Map<String, String> get rootStyles => const <String, String>{
    'display': 'flex',
    'flex-direction': 'column',
    'gap': 'var(--space-2)',
  };

  @override
  Map<String, String> get labelStyles => const <String, String>{
    'font-size': 'var(--font-size-sm)',
    'font-weight': 'var(--font-weight-medium)',
    'color': 'var(--foreground)',
  };

  @override
  String get digitsRowClass => 'arcane-otp-digits';

  @override
  Map<String, String> get digitsRowStyles => const <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'gap': 'var(--space-2)',
  };

  @override
  Map<String, String> get separatorStyles => const <String, String>{
    'color': 'var(--muted-foreground)',
    'font-size': '18px',
    'margin': '0 4px',
  };

  @override
  String get digitClass => 'arcane-otp-digit';

  @override
  (String, String) sizeStyles(OtpInputSizeVariant size) => switch (size) {
    OtpInputSizeVariant.sm => ('40px', '16px'),
    OtpInputSizeVariant.md => ('48px', '18px'),
    OtpInputSizeVariant.lg => ('56px', '20px'),
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
    if (props.disabled) 'disabled': 'true',
    'value': digitValue(i, digits),
    'data-state': isFilled(i, digits) ? 'filled' : 'empty',
    'data-disabled': '${props.disabled}',
  };

  @override
  Map<String, String> digitStyles(
    int i,
    bool hasError,
    List<String> digits,
    String size,
    String fontSize,
  ) => <String, String>{
    'width': size,
    'height': size,
    'font-size': fontSize,
    'text-align': 'center',
    'font-weight': 'var(--font-weight-semibold)',
    'color': 'var(--foreground)',
    'background-color': 'var(--background)',
    'border': '2px solid ${hasError ? 'var(--destructive)' : 'var(--input)'}',
    'border-radius': 'var(--radius-sm)',
    'transition':
        'border-color var(--transition), box-shadow var(--transition)',
    'caret-color': 'transparent',
    if (props.disabled) 'opacity': '0.5',
    if (props.disabled) 'cursor': 'not-allowed',
  };
}
