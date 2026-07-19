import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';

class MenuSearchDialogExample extends StatefulWidget {
  const MenuSearchDialogExample({super.key});

  @override
  State<MenuSearchDialogExample> createState() =>
      _MenuSearchDialogExampleState();
}

class _MenuSearchDialogExampleState extends State<MenuSearchDialogExample> {
  String _query = 'Arcane';

  @override
  Widget build(BuildContext context) => ArcaneApp(
    stylesheet: const ShadcnStylesheet(theme: ShadcnTheme.midnight),
    brightness: Brightness.dark,
    home: Screen(
      title: 'Discovery',
      actions: [
        PopupMenu(
          items: const [
            MenuItemAction(label: 'Open palette'),
            MenuItemAction(label: 'Open docs'),
          ],
          child: IconButton(icon: Icon(Icons.moreHorizontal)),
        ),
      ],
      child: Collection(
        children: [
          Section(
            titleText: 'Search',
            card: true,
            children: [
              Search(
                value: _query,
                showDropdown: true,
                onChanged: (String value) {
                  setState(() {
                    _query = value;
                  });
                },
                results: const [
                  SearchResult(
                    title: 'ArcaneJaspr',
                    subtitle: 'Primary package',
                  ),
                  SearchResult(
                    title: 'Arcane Lexicon',
                    subtitle: 'Knowledge base renderer',
                  ),
                ],
              ),
            ],
          ),
          const Section(
            titleText: 'Dialogs',
            card: true,
            children: [
              DialogText(title: 'Rename project', onConfirm: _noopConfirm),
              DialogDate(title: 'Pick a launch date', onConfirm: _noopDate),
            ],
          ),
        ],
      ),
    ),
  );

  static void _noopConfirm(String value) {}

  static void _noopDate(DateTime? value) {}
}
