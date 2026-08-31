import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/input/icon_button.dart';
import 'package:arcane_jaspr/component/menu/dropdown_menu.dart';
import 'package:arcane_jaspr/component/support/icons.dart';
import 'package:arcane_jaspr/flutter.dart';

class PopupMenu extends StatelessWidget {
  final Widget child;
  final List<ArcaneMenuItem> items;

  const PopupMenu({required this.child, required this.items, super.key});

  @override
  Widget build(BuildContext context) =>
      ArcaneDropdownMenu(trigger: child, items: items);
}

class IconButtonMenu extends StatelessWidget {
  final IconData icon;
  final List<ArcaneMenuItem> items;

  const IconButtonMenu({required this.icon, required this.items, super.key});

  @override
  Widget build(BuildContext context) => PopupMenu(
    items: items,
    child: IconButton(icon: icon(size: IconSize.md)),
  );
}

class TextButtonMenu extends StatelessWidget {
  final Widget child;
  final List<ArcaneMenuItem> items;

  const TextButtonMenu({required this.child, required this.items, super.key});

  @override
  Widget build(BuildContext context) => PopupMenu(items: items, child: child);
}

class OutlineButtonMenu extends StatelessWidget {
  final String label;
  final List<ArcaneMenuItem> items;

  const OutlineButtonMenu({
    required this.label,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) => PopupMenu(
    items: items,
    child: Button.outline(label: label),
  );
}
