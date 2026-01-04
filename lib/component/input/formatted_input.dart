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

/// A part of a formatted input (editable segment or static text).
class InputPart {
  /// Whether this part is editable
  final bool editable;

  /// Maximum length for editable parts
  final int? length;

  /// Width in pixels (for editable parts)
  final double? width;

  /// Placeholder text
  final String? placeholder;

  /// Static text (for non-editable parts)
  final String? staticText;

  /// Current value
  final String? value;

  /// Input type hint
  final String inputType;

  const InputPart._({
    required this.editable,
    this.length,
    this.width,
    this.placeholder,
    this.staticText,
    this.value,
    this.inputType = 'text',
  });

  /// Creates an editable input part
  const InputPart.editable({
    int? length,
    double? width,
    String? placeholder,
    String inputType = 'text',
  }) : this._(
          editable: true,
          length: length,
          width: width,
          placeholder: placeholder,
          inputType: inputType,
        );

  /// Creates a static text part
  const InputPart.static(String text)
      : this._(
          editable: false,
          staticText: text,
        );

  /// Returns a copy with a new value
  InputPart withValue(String value) => InputPart._(
        editable: editable,
        length: length,
        width: width,
        placeholder: placeholder,
        staticText: staticText,
        value: value,
        inputType: inputType,
      );
}

/// Value container for formatted input
class FormattedValue {
  /// List of input parts
  final List<InputPart> parts;

  const FormattedValue(this.parts);

  /// Gets values from all editable parts
  List<String?> get values =>
      parts.where((p) => p.editable).map((p) => p.value).toList();

  /// Gets the combined string value
  String get combinedValue => parts.map((p) => p.value ?? p.staticText ?? '').join();
}

/// A formatted/patterned input for structured data like dates, phone numbers, etc.
///
/// ```dart
/// ArcaneFormattedInput(
///   onChanged: (value) => print(value.combinedValue),
///   initialValue: FormattedValue([
///     InputPart.editable(length: 2, width: 40, placeholder: 'MM').withValue('01'),
///     InputPart.static('/'),
///     InputPart.editable(length: 2, width: 40, placeholder: 'DD').withValue('15'),
///     InputPart.static('/'),
///     InputPart.editable(length: 4, width: 60, placeholder: 'YYYY').withValue('2024'),
///   ]),
/// )
/// ```
class ArcaneFormattedInput extends StatefulComponent {
  /// Current value
  final FormattedValue initialValue;

  /// Called when any part changes
  final void Function(FormattedValue value)? onChanged;

  /// Label text
  final String? label;

  /// Error message
  final String? error;

  /// Whether the input is disabled
  final bool disabled;

  /// Size variant
  final FormattedInputSize size;

  const ArcaneFormattedInput({
    required this.initialValue,
    this.onChanged,
    this.label,
    this.error,
    this.disabled = false,
    this.size = FormattedInputSize.md,
    super.key,
  });

  /// Date input (MM/DD/YYYY)
  factory ArcaneFormattedInput.date({
    String? initialMonth,
    String? initialDay,
    String? initialYear,
    void Function(FormattedValue value)? onChanged,
    String? label,
    String? error,
    bool disabled = false,
  }) {
    return ArcaneFormattedInput(
      initialValue: FormattedValue([
        const InputPart.editable(length: 2, width: 40, placeholder: 'MM', inputType: 'number')
            .withValue(initialMonth ?? ''),
        const InputPart.static('/'),
        const InputPart.editable(length: 2, width: 40, placeholder: 'DD', inputType: 'number')
            .withValue(initialDay ?? ''),
        const InputPart.static('/'),
        const InputPart.editable(length: 4, width: 60, placeholder: 'YYYY', inputType: 'number')
            .withValue(initialYear ?? ''),
      ]),
      onChanged: onChanged,
      label: label ?? 'Date',
      error: error,
      disabled: disabled,
    );
  }

  /// Time input (HH:MM)
  factory ArcaneFormattedInput.time({
    String? initialHour,
    String? initialMinute,
    void Function(FormattedValue value)? onChanged,
    String? label,
    String? error,
    bool disabled = false,
  }) {
    return ArcaneFormattedInput(
      initialValue: FormattedValue([
        const InputPart.editable(length: 2, width: 40, placeholder: 'HH', inputType: 'number')
            .withValue(initialHour ?? ''),
        const InputPart.static(':'),
        const InputPart.editable(length: 2, width: 40, placeholder: 'MM', inputType: 'number')
            .withValue(initialMinute ?? ''),
      ]),
      onChanged: onChanged,
      label: label ?? 'Time',
      error: error,
      disabled: disabled,
    );
  }

  /// Phone number input
  factory ArcaneFormattedInput.phone({
    String? initialAreaCode,
    String? initialPrefix,
    String? initialLine,
    void Function(FormattedValue value)? onChanged,
    String? label,
    String? error,
    bool disabled = false,
  }) {
    return ArcaneFormattedInput(
      initialValue: FormattedValue([
        const InputPart.static('('),
        const InputPart.editable(length: 3, width: 45, placeholder: '000', inputType: 'tel')
            .withValue(initialAreaCode ?? ''),
        const InputPart.static(') '),
        const InputPart.editable(length: 3, width: 45, placeholder: '000', inputType: 'tel')
            .withValue(initialPrefix ?? ''),
        const InputPart.static('-'),
        const InputPart.editable(length: 4, width: 55, placeholder: '0000', inputType: 'tel')
            .withValue(initialLine ?? ''),
      ]),
      onChanged: onChanged,
      label: label ?? 'Phone',
      error: error,
      disabled: disabled,
    );
  }

  /// Credit card input
  factory ArcaneFormattedInput.creditCard({
    void Function(FormattedValue value)? onChanged,
    String? label,
    String? error,
    bool disabled = false,
  }) {
    return ArcaneFormattedInput(
      initialValue: FormattedValue([
        const InputPart.editable(length: 4, width: 55, placeholder: '0000', inputType: 'number')
            .withValue(''),
        const InputPart.static(' '),
        const InputPart.editable(length: 4, width: 55, placeholder: '0000', inputType: 'number')
            .withValue(''),
        const InputPart.static(' '),
        const InputPart.editable(length: 4, width: 55, placeholder: '0000', inputType: 'number')
            .withValue(''),
        const InputPart.static(' '),
        const InputPart.editable(length: 4, width: 55, placeholder: '0000', inputType: 'number')
            .withValue(''),
      ]),
      onChanged: onChanged,
      label: label ?? 'Card Number',
      error: error,
      disabled: disabled,
    );
  }

  @override
  State<ArcaneFormattedInput> createState() => _FormattedInputState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-formatted-input-segment input:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
  ];
}

class _FormattedInputState extends State<ArcaneFormattedInput> {
  late List<InputPart> _parts;

  @override
  void initState() {
    super.initState();
    _parts = List.from(component.initialValue.parts);
  }

  void _updatePart(int index, String value) {
    final part = _parts[index];
    if (part.length != null && value.length > part.length!) {
      return; // Exceed max length
    }

    setState(() {
      _parts[index] = part.withValue(value);
    });

    component.onChanged?.call(FormattedValue(_parts));
  }

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null;
    final (height, fontSize) = switch (component.size) {
      FormattedInputSize.sm => (ArcaneLayout.inputHeightSm, ArcaneTypography.fontSm),
      FormattedInputSize.md => (ArcaneLayout.inputHeightMd, ArcaneTypography.fontSm),
      FormattedInputSize.lg => (ArcaneLayout.inputHeightLg, ArcaneTypography.fontMd),
    };

    return div(
      classes: 'arcane-formatted-input ${component.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
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
            [text(component.label!)],
          ),

        // Input parts container
        div(
          classes: 'arcane-formatted-input-container',
          styles: Styles(raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'padding': '0 ${ArcaneSpacing.sm}',
            'background': ArcaneColors.surface,
            'border': '1px solid ${hasError ? ArcaneColors.error : ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'height': height,
            if (component.disabled) 'opacity': '0.5',
            if (component.disabled) 'pointer-events': 'none',
          }),
          [
            for (var i = 0; i < _parts.length; i++)
              if (_parts[i].editable)
                _buildEditablePart(i, _parts[i], fontSize)
              else
                _buildStaticPart(_parts[i], fontSize),
          ],
        ),

        // Error message
        if (hasError)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.error,
            }),
            [text(component.error!)],
          ),
      ],
    );
  }

  Component _buildEditablePart(int index, InputPart part, String fontSize) {
    return div(
      classes: 'arcane-formatted-input-segment',
      [
        input(
          type: InputType.text,
          attributes: {
            'value': part.value ?? '',
            'placeholder': part.placeholder ?? '',
            if (part.length != null) 'maxlength': '${part.length}',
            if (component.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'width': part.width != null ? '${part.width}px' : 'auto',
            'min-width': '30px',
            'padding': '4px',
            'border': 'none',
            'background': 'transparent',
            'color': ArcaneColors.onSurface,
            'font-size': fontSize,
            'text-align': 'center',
            'outline': 'none',
            'font-variant-numeric': 'tabular-nums',
          }),
          events: {
            'input': (event) {
              final dynamic target = event.target;
              if (target != null) {
                _updatePart(index, target.value ?? '');
              }
            },
          },
        ),
      ],
    );
  }

  Component _buildStaticPart(InputPart part, String fontSize) {
    return span(
      classes: 'arcane-formatted-input-static',
      styles: Styles(raw: {
        'color': ArcaneColors.muted,
        'font-size': fontSize,
        'user-select': 'none',
      }),
      [text(part.staticText ?? '')],
    );
  }
}

/// Size variants for formatted input
enum FormattedInputSize {
  sm,
  md,
  lg,
}