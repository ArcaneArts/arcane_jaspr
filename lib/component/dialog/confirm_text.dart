import 'package:arcane_jaspr/component/dialog/dialog.dart';
import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/input/text_input.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/component/typography/text.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class ConfirmText extends StatefulWidget {
  final String title;
  final String confirmPhrase;
  final void Function(String value)? onConfirm;
  final void Function()? onCancel;
  final String? description;

  const ConfirmText({
    required this.title,
    required this.confirmPhrase,
    this.onConfirm,
    this.onCancel,
    this.description,
    super.key,
  });

  @override
  State<ConfirmText> createState() => _ConfirmTextState();
}

class _ConfirmTextState extends State<ConfirmText> {
  String _value = '';

  @override
  Widget build(BuildContext context) => ArcaneDialog(
    title: component.title,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 12,
      children: <Widget>[
        if (component.description != null) Text.body(component.description!),
        Text.body('Type ${component.confirmPhrase} to continue.'),
        TextInput(
          value: _value,
          onChange: (String value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    ),
    actions: <Widget>[
      Button.ghost(onPressed: component.onCancel, label: 'Cancel'),
      Button.destructive(
        onPressed: _value == component.confirmPhrase
            ? () => component.onConfirm?.call(_value)
            : null,
        label: 'Confirm',
      ),
    ],
  );
}
