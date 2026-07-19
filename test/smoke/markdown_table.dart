import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';

class MarkdownTableExample extends StatelessWidget {
  const MarkdownTableExample({super.key});

  @override
  Widget build(BuildContext context) => const ArcaneApp(
    stylesheet: ShadcnStylesheet(theme: ShadcnTheme.midnight),
    brightness: Brightness.dark,
    home: Screen(
      title: 'Markdown',
      child: Collection(
        children: [
          Section(
            titleText: 'Rendered Markdown',
            card: true,
            children: [Markdown('# Arcane\n\n- Flutter-like\n- Jaspr-native')],
          ),
          Section(
            titleText: 'Markdown Table',
            card: true,
            children: [
              ArcaneTableMd(
                '| Package | Status |\n'
                '| --- | --- |\n'
                '| arcane_jaspr | active |\n'
                '| arcane_lexicon | active |',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
