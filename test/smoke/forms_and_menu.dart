import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';

class FormsAndMenuExample extends StatefulWidget {
  const FormsAndMenuExample({super.key});

  @override
  State<FormsAndMenuExample> createState() => _FormsAndMenuExampleState();
}

class _FormsAndMenuExampleState extends State<FormsAndMenuExample> {
  final Map<String, dynamic> _storage = <String, dynamic>{
    'email': 'builder@arcane.art',
    'meeting_date': DateTime(2026, 3, 14),
    'meeting_time': const TimeOfDay(hour: 9, minute: 30),
    'role': 'admin',
  };

  late ArcaneFieldProvider<String> _emailProvider;
  late ArcaneFieldProvider<DateTime> _dateProvider;
  late ArcaneFieldProvider<TimeOfDay> _timeProvider;
  late ArcaneFieldProvider<String> _roleProvider;

  @override
  void initState() {
    super.initState();
    _emailProvider = ArcaneFieldMapProvider<String>(
      defaultValue: '',
      storage: _storage,
    );
    _dateProvider = ArcaneFieldMapProvider<DateTime>(
      defaultValue: DateTime(2026, 3, 14),
      storage: _storage,
    );
    _timeProvider = ArcaneFieldMapProvider<TimeOfDay>(
      defaultValue: const TimeOfDay(hour: 9, minute: 30),
      storage: _storage,
    );
    _roleProvider = ArcaneFieldMapProvider<String>(
      defaultValue: 'admin',
      storage: _storage,
    );
  }

  @override
  Widget build(BuildContext context) => ArcaneApp(
    stylesheet: const ShadcnStylesheet(theme: ShadcnTheme.midnight),
    brightness: Brightness.dark,
    home: Screen(
      title: 'Planner',
      subtitle: 'Form and menu smoke coverage',
      actions: [
        PopupMenu(
          items: const [
            MenuItemAction(label: 'New'),
            MenuItemAction(label: 'Duplicate'),
            MenuItemSeparator(),
            MenuItemAction(label: 'Delete', destructive: true),
          ],
          child: IconButton(icon: Icons.moreHorizontal()),
        ),
      ],
      child: Collection(
        children: [
          Section(
            titleText: 'Meeting',
            card: true,
            showDivider: true,
            children: [
              ArcaneStringField(
                provider: _emailProvider,
                name: 'Email',
                placeholder: 'name@example.com',
              ),
              ArcaneDateField(provider: _dateProvider, name: 'Meeting date'),
              ArcaneTimeField(provider: _timeProvider, name: 'Meeting time'),
              ArcaneEnumField(
                provider: _roleProvider,
                name: 'Owner role',
                options: const ['admin', 'editor'],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
