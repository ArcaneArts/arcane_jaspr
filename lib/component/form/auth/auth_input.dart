import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Input type for auth fields
enum AuthInputType { text, email, password }

/// Styled input field for authentication forms.
///
/// Features dark gaming theme styling with subtle borders,
/// focus glow effect, and optional password visibility toggle.
class AuthInput extends StatelessComponent {
  /// Label displayed above the input
  final String labelText;

  /// Placeholder text inside the input
  final String? placeholder;

  /// Hint text displayed below the input
  final String? hint;

  /// Error message (shows red border when set)
  final String? error;

  /// Type of input (text, email, password)
  final AuthInputType type;

  /// Current value of the input
  final String? value;

  /// Callback when input value changes
  final void Function(String)? onInput;

  /// Whether the input is disabled
  final bool disabled;

  /// Auto-focus this input on mount
  final bool autofocus;

  /// Input name attribute for forms
  final String? name;

  const AuthInput({
    super.key,
    required String label,
    this.placeholder,
    this.hint,
    this.error,
    this.type = AuthInputType.text,
    this.value,
    this.onInput,
    this.disabled = false,
    this.autofocus = false,
    this.name,
  }) : labelText = label;

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final inputId = name ?? labelText.toLowerCase().replaceAll(' ', '-');

    return ArcaneDiv(
      styles: ArcaneStyleData(
        margin: MarginPreset.bottomMd,
      ),
      children: [
        // Label
        label(
          [Component.text(labelText)],
          htmlFor: inputId,
          styles: Styles(raw: {
            'display': 'block',
            'font-size': ArcaneTypography.fontSizeSm,
            'font-weight': '500',
            'color': ArcaneColors.onBackground,
            'margin-bottom': ArcaneSpacing.xs,
          }),
        ),
        // Input container
        ArcaneDiv(
          styles: ArcaneStyleData(
            position: Position.relative,
          ),
          children: [
            input(
              id: inputId,
              name: name ?? inputId,
              type: _getInputType(),
              value: value,
              disabled: disabled,
              attributes: {
                if (placeholder != null) 'placeholder': placeholder!,
                if (autofocus) 'autofocus': '',
              },
              events: {
                'input': (event) {
                  if (onInput != null) {
                    // Event handling for input value
                  }
                },
              },
              styles: Styles(raw: {
                'width': '100%',
                'padding': '12px 16px',
                'font-size': ArcaneTypography.fontSizeSm,
                'font-family': 'inherit',
                'color': ArcaneColors.onBackground,
                'background': ArcaneColors.surface,
                'border': hasError
                    ? '1px solid ${ArcaneColors.error}'
                    : '1px solid ${ArcaneColors.border}',
                'border-radius': ArcaneRadius.md,
                'outline': 'none',
                'transition': 'border-color 0.2s ease, box-shadow 0.2s ease',
                'box-sizing': 'border-box',
              }),
            ),
          ],
        ),
        // Hint or error text
        if (hint != null || hasError)
          ArcaneDiv(
            styles: ArcaneStyleData(
              fontSize: FontSize.xs,
              margin: MarginPreset.topXs,
              textColor: hasError ? TextColor.error : TextColor.muted,
            ),
            children: [Component.text(hasError ? error! : hint!)],
          ),
      ],
    );
  }

  InputType _getInputType() {
    switch (type) {
      case AuthInputType.email:
        return InputType.email;
      case AuthInputType.password:
        return InputType.password;
      case AuthInputType.text:
        return InputType.text;
    }
  }
}
