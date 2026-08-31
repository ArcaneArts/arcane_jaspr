import 'package:arcane_jaspr/component/dialog/dialog.dart';
import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/input/text_input.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/component/typography/text.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class DialogText extends StatefulWidget {
  final String title;
  final String? description;
  final Widget descriptionWidget;
  final String confirmText;
  final String cancelText;
  final Widget? placeholder;
  final bool obscureText;
  final String? initialValue;
  final void Function(String result) onConfirm;
  final List<Widget>? actions;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType keyboardType;

  const DialogText({
    required this.title,
    required this.onConfirm,
    this.description,
    this.descriptionWidget = const SizedBox.shrink(),
    this.confirmText = 'Done',
    this.cancelText = 'Cancel',
    this.placeholder,
    this.obscureText = false,
    this.initialValue,
    this.actions,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  State<DialogText> createState() => _DialogTextState();
}

class _DialogTextState extends State<DialogText> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = component.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final Widget input = component.maxLines > 1
        ? TextArea(
            value: _value,
            rows: component.maxLines,
            onChange: (String value) {
              _value = value;
            },
          )
        : TextInput(
            value: _value,
            type: component.keyboardType,
            onChange: (String value) {
              _value = value;
            },
          );

    return ArcaneDialog(
      title: component.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 12,
        children: <Widget>[
          if (component.description != null) Text.body(component.description!),
          if (component.descriptionWidget is! SizedBox)
            component.descriptionWidget,
          input,
        ],
      ),
      actions: <Widget>[
        Button.ghost(onPressed: () {}, label: component.cancelText),
        Button.primary(
          onPressed: () => component.onConfirm(_value),
          label: component.confirmText,
        ),
        ...?component.actions,
      ],
    );
  }
}
