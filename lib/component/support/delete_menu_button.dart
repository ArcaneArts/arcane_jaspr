import 'package:arcane_jaspr/component/input/popup_menu.dart';
import 'package:arcane_jaspr/component/menu/dropdown_menu.dart';
import 'package:arcane_jaspr/component/support/icons.dart';
import 'package:arcane_jaspr/flutter.dart';

class DeleteMenuButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;

  const DeleteMenuButton({this.onPressed, this.label = 'Delete', super.key});

  @override
  Widget build(BuildContext context) => IconButtonMenu(
    icon: Icons.moreHorizontal,
    items: <ArcaneMenuItem>[
      MenuItemAction(
        label: label,
        destructive: true,
        onSelect: onPressed,
        icon: Icons.trash2(),
      ),
    ],
  );
}
