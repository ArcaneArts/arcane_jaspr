import 'package:arcane_jaspr/component/input/icon_button.dart';
import 'package:arcane_jaspr/component/support/icons.dart';
import 'package:arcane_jaspr/flutter.dart';

class DeleteIconButton extends StatelessWidget {
  final void Function()? onPressed;

  const DeleteIconButton({this.onPressed, super.key});

  @override
  Widget build(BuildContext context) =>
      IconButton.destructive(icon: Icons.trash2(), onPressed: onPressed);
}
