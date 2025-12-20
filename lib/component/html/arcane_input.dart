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
        FontWeight,
        FontStyle,
        StyleRule,
        Display,
        Position,
        Overflow,
        Cursor,
        Visibility,
        TextDecoration,
        TextTransform,
        FontFamily,
        WhiteSpace,
        events;

import '../../util/style_types/arcane_style_data.dart';

/// A raw input component that wraps the HTML `<input>` element.
///
/// This is a low-level wrapper for direct HTML input elements.
class RawInput extends StatelessComponent {
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;
  final String? name;
  final InputType? type;
  final String? value;
  final String? placeholder;
  final bool disabled;
  final bool readOnly;
  final bool required;
  final bool autofocus;
  final Map<String, String>? attributes;
  final Map<String, void Function(dynamic)>? events;

  const RawInput({
    this.styles,
    this.classes,
    this.id,
    this.name,
    this.type,
    this.value,
    this.placeholder,
    this.disabled = false,
    this.readOnly = false,
    this.required = false,
    this.autofocus = false,
    this.attributes,
    this.events,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return input(
      id: id,
      name: name,
      type: type,
      value: value,
      disabled: disabled,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      attributes: {
        if (placeholder != null) 'placeholder': placeholder!,
        if (readOnly) 'readonly': '',
        if (required) 'required': '',
        if (autofocus) 'autofocus': '',
        ...?attributes,
      },
    );
  }
}
