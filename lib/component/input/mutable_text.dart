import 'package:arcane_jaspr/component/input/icon_button.dart';
import 'package:arcane_jaspr/component/input/text_input.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/component/support/icons.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/component/typography/text.dart';
import 'package:arcane_jaspr/util/arcane.dart';
import 'package:arcane_jaspr/util/style_types/index.dart';

import 'mutable_text_types.dart';

class MutableText extends StatefulWidget {
  final String value;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onEditingStarted;
  final int maxLines;
  final int? minLines;
  final String? placeholder;
  final MutableTextTrigger trigger;
  final MutableTextInputType inputType;
  final MutableTextStyle variant;

  const MutableText(
    this.value, {
    this.onChanged,
    this.onEditingComplete,
    this.onEditingStarted,
    this.maxLines = 1,
    this.minLines,
    this.placeholder,
    this.trigger = MutableTextTrigger.click,
    this.inputType = MutableTextInputType.text,
    this.variant = MutableTextStyle.inline,
    super.key,
  });

  @override
  State<MutableText> createState() => _MutableTextState();
}

class _MutableTextState extends State<MutableText> {
  bool _editing = false;
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = component.value;
  }

  @override
  void didUpdateComponent(covariant MutableText oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (!_editing && component.value != oldComponent.value) {
      _value = component.value;
    }
  }

  void _startEditing() {
    if (component.onChanged == null) {
      return;
    }
    setState(() {
      _editing = true;
      _value = component.value;
    });
    component.onEditingStarted?.call();
  }

  void _finishEditing() {
    setState(() {
      _editing = false;
    });
    component.onEditingComplete?.call();
  }

  TextInputType get _textInputType => switch (component.inputType) {
    MutableTextInputType.email => TextInputType.email,
    MutableTextInputType.number => TextInputType.number,
    MutableTextInputType.url => TextInputType.url,
    _ => TextInputType.text,
  };

  Widget get _displayText => switch (component.variant) {
    MutableTextStyle.subtle => Text.bodySmall(component.value),
    MutableTextStyle.underline => Text(
        component.value,
        decoration: TextDecoration.underline,
      ),
    MutableTextStyle.dashed => Text(
        component.value,
        decoration: TextDecoration.underline,
      ),
    MutableTextStyle.input => Text.body(component.value),
    _ => Text(component.value),
  };

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      final Widget field = component.maxLines > 1 || component.inputType == MutableTextInputType.multiline
          ? TextArea(
              value: _value,
              rows: component.maxLines,
              placeholder: component.placeholder,
              onChange: (String value) {
                _value = value;
              },
            )
          : TextInput(
              value: _value,
              placeholder: component.placeholder,
              type: _textInputType,
              onChange: (String value) {
                _value = value;
              },
              onSubmit: (String value) {
                component.onChanged?.call(value);
                _finishEditing();
              },
            );

      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        gap: 8,
        children: <Widget>[
          Expanded(child: field),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              component.onChanged?.call(_value);
              _finishEditing();
            },
          ),
          IconButton(
            icon: Icon(Icons.x),
            onPressed: _finishEditing,
          ),
        ],
      );
    }

    if (component.onChanged == null) {
      return _displayText;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      gap: 8,
      children: <Widget>[
        _displayText,
        IconButton(
          icon: Icon(Icons.pencil),
          onPressed: _startEditing,
        ),
      ],
    );
  }
}
