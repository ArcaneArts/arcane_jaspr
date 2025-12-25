import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// One-time password input with separate digit fields.
///
/// Provides auto-advance focus, paste support, and keyboard navigation.
///
/// Example:
/// ```dart
/// ArcaneOtpInput(
///   length: 6,
///   onComplete: (code) => verifyCode(code),
/// )
/// ```
class ArcaneOtpInput extends StatefulComponent {
  /// Number of digits (typically 4 or 6)
  final int length;

  /// Called when all digits are filled
  final void Function(String)? onComplete;

  /// Called on any change
  final void Function(String)? onChange;

  /// Initial value (must match length if provided)
  final String? value;

  /// Hide digits like a password
  final bool obscure;

  /// Visual size
  final OtpInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Error message to display
  final String? error;

  /// Label above the input
  final String? label;

  /// Separator character between digits (e.g., '-')
  final String? separator;

  /// Position to show separator (e.g., 3 for "123-456")
  final int? separatorPosition;

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
    super.key,
  });

  /// Creates a 4-digit OTP input
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
    super.key,
  }) : length = 4;

  /// Creates a 6-digit OTP input
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
    super.key,
  }) : length = 6;

  @override
  State<ArcaneOtpInput> createState() => _ArcaneOtpInputState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-otp-digit:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
      'outline': 'none',
    }),
    css('.arcane-otp-digit:focus-visible').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
    css('.arcane-otp-digit.error').styles(raw: {
      'border-color': ArcaneColors.error,
    }),
    css('.arcane-otp-digit.error:focus').styles(raw: {
      'box-shadow': '0 0 0 2px rgba(239, 68, 68, 0.2)',
    }),
    css('.arcane-otp-digit.filled').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
  ];
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

    // Handle paste (multiple characters)
    if (value.length > 1) {
      _handlePaste(value);
      return;
    }

    // Single character input
    if (value.isNotEmpty && RegExp(r'[0-9]').hasMatch(value)) {
      setState(() {
        _digits[index] = value;
      });

      component.onChange?.call(_fullValue);

      // Auto-advance to next field
      if (index < component.length - 1) {
        // Focus next will be handled by JS
      }

      // Check if complete
      if (_digits.every((d) => d.isNotEmpty)) {
        component.onComplete?.call(_fullValue);
      }
    }
  }

  void _handlePaste(String pastedValue) {
    // Extract only digits
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

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null;
    final sizeStyles = component.size.styles;
    final sepPos = component.separatorPosition;

    return div(
      classes: 'arcane-otp-input ${hasError ? 'error' : ''} ${component.disabled ? 'disabled' : ''}',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Label
        if (component.label != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            [Component.text(component.label!)],
          ),

        // Digit inputs row
        div(
          classes: 'arcane-otp-digits',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.sm,
          }),
          [
            for (var i = 0; i < component.length; i++) ...[
              // Separator
              if (sepPos != null && i == sepPos && component.separator != null)
                span(
                  styles: const Styles(raw: {
                    'color': ArcaneColors.muted,
                    'font-size': ArcaneTypography.fontLg,
                    'margin': '0 ${ArcaneSpacing.xs}',
                  }),
                  [Component.text(component.separator!)],
                ),

              // Digit input
              input(
                classes: 'arcane-otp-digit ${hasError ? 'error' : ''} ${_digits[i].isNotEmpty ? 'filled' : ''}',
                type: component.obscure ? InputType.password : InputType.text,
                attributes: {
                  'maxlength': '1',
                  'inputmode': 'numeric',
                  'pattern': '[0-9]*',
                  'autocomplete': 'one-time-code',
                  'aria-label': 'Digit ${i + 1} of ${component.length}',
                  'data-otp-index': '$i',
                  'data-otp-length': '${component.length}',
                  if (component.disabled) 'disabled': 'true',
                  'value': _digits[i],
                },
                styles: Styles(raw: {
                  'width': sizeStyles['size']!,
                  'height': sizeStyles['size']!,
                  'font-size': sizeStyles['fontSize']!,
                  'text-align': 'center',
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': ArcaneColors.onSurface,
                  'background-color': ArcaneColors.surface,
                  'border': '2px solid ${hasError ? ArcaneColors.error : ArcaneColors.border}',
                  'border-radius': ArcaneRadius.md,
                  'transition': ArcaneEffects.transitionFast,
                  'caret-color': 'transparent',
                  if (component.disabled) 'opacity': '0.5',
                  if (component.disabled) 'cursor': 'not-allowed',
                }),
                events: {
                  'input': (e) {
                    final target = e.target as dynamic;
                    _handleInput(i, target.value as String);
                  },
                },
              ),
            ],
          ],
        ),

        // Error message
        if (hasError)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.error,
            }),
            [Component.text(component.error!)],
          ),
      ],
    );
  }
}

/// Size variants for OTP input
enum OtpInputSize {
  sm,
  md,
  lg,
}

extension OtpInputSizeExtension on OtpInputSize {
  Map<String, String> get styles => switch (this) {
        OtpInputSize.sm => {
            'size': '40px',
            'fontSize': ArcaneTypography.fontMd,
          },
        OtpInputSize.md => {
            'size': '48px',
            'fontSize': ArcaneTypography.fontLg,
          },
        OtpInputSize.lg => {
            'size': '56px',
            'fontSize': ArcaneTypography.fontXl,
          },
      };
}
