import 'package:arcane_jaspr/component/dialog/dialog.dart';
import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/input/date_picker.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/component/typography/text.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class DialogDate extends StatefulWidget {
  final String title;
  final DateTime? value;
  final void Function(DateTime?) onConfirm;
  final String? description;

  const DialogDate({
    required this.title,
    required this.onConfirm,
    this.value,
    this.description,
    super.key,
  });

  @override
  State<DialogDate> createState() => _DialogDateState();
}

class _DialogDateState extends State<DialogDate> {
  DateTime? _value;

  @override
  void initState() {
    super.initState();
    _value = component.value;
  }

  @override
  Widget build(BuildContext context) => ArcaneDialog(
    title: component.title,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 12,
      children: <Widget>[
        if (component.description != null) Text.body(component.description!),
        ArcaneDatePicker(
          value: _value,
          onChanged: (DateTime? value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    ),
    actions: <Widget>[
      Button.ghost(onPressed: () {}, label: 'Cancel'),
      Button.primary(
        onPressed: () => component.onConfirm(_value),
        label: 'Done',
      ),
    ],
  );
}
