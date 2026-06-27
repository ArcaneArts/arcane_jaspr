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
  Map<String, String> get rootStyles => const <String, String>{
    'display': 'flex',
    'flex-direction': 'column',
    'gap': '10px',
  };

  @override
  Map<String, String> get labelStyles => const <String, String>{
    'font-family': 'var(--font-heading)',
    'font-size': '0.75rem',
    'font-weight': '600',
    'letter-spacing': '0.08em',
    'text-transform': 'uppercase',
    'color': 'var(--muted-foreground)',
  };

  @override
  String get digitsRowClass => 'neon-otp-digits';

  @override
  Map<String, String> get digitsRowStyles => const <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'gap': '10px',
  };

  @override
  Map<String, String> get separatorStyles => const <String, String>{
    'color': 'var(--neon-accent)',
    'font-size': 'var(--font-size-lg)',
    'font-weight': '700',
    'margin': '0 4px',
  };

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
  ) => <String, String>{
    'width': size,
    'height': size,
    'font-family': 'var(--font-heading)',
    'font-size': fontSize,
    'text-align': 'center',
    'font-weight': '600',
    'font-variant-numeric': 'tabular-nums',
    'color': 'var(--foreground)',
    'background':
        'linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), color-mix(in srgb, var(--card) 86%, transparent))',
    'border':
        '1px solid ${hasError ? 'var(--destructive)' : 'var(--neon-control-border)'}',
    'clip-path': 'var(--neon-control-clip)',
    'transition':
        'border-color 0.18s ease, box-shadow 0.18s ease, background 0.18s ease',
    'caret-color': 'var(--neon-accent)',
    'box-shadow': isFilled(i, digits)
        ? 'var(--neon-glow-md)'
        : 'var(--neon-inset)',
    if (props.disabled) 'opacity': '0.5',
    if (props.disabled) 'cursor': 'not-allowed',
  };
}
