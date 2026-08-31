import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';
import 'package:jaspr_test/server_test.dart';

class _SelectedSelectHarness extends StatelessWidget {
  const _SelectedSelectHarness();

  @override
  Widget build(BuildContext context) {
    return context.renderers.select<String>(
      const SelectProps<String>(
        id: 'selected-option-test',
        value: 'selected',
        isOpen: true,
        options: <SelectOptionProps<String>>[
          SelectOptionProps<String>(
            value: 'selected',
            label: 'Selected label',
            subtitle: 'Selected subtitle',
            description: 'Selected description',
          ),
        ],
      ),
    );
  }
}

Future<String> _render(
  ServerTester tester,
  ArcaneStylesheet stylesheet,
  Widget widget,
) async {
  tester.pumpComponent(
    ArcaneThemeProvider(stylesheet: stylesheet, child: widget),
  );
  final DocumentResponse response = await tester.request('/');
  expect(response.statusCode, 200, reason: response.body);
  return response.body;
}

String _openingTagForClass(String html, String className) {
  final Iterable<RegExpMatch> matches = RegExp(
    r'<[^>]+class="([^"]*)"[^>]*>',
  ).allMatches(html);
  for (final RegExpMatch match in matches) {
    final List<String> classes = match.group(1)!.split(' ');
    if (classes.contains(className)) {
      return match.group(0)!;
    }
  }
  fail('Missing .$className in rendered HTML');
}

void main() {
  group('shared anchored tooltip contract', () {
    const List<ArcaneStylesheet> stylesheets = <ArcaneStylesheet>[
      ShadcnStylesheet(),
      Win95Stylesheet(),
    ];

    for (final ArcaneStylesheet stylesheet in stylesheets) {
      testServer('${stylesheet.id} emits viewport anchor hooks', (
        ServerTester tester,
      ) async {
        final String html = await _render(
          tester,
          stylesheet,
          const ArcaneTooltip(
            text: 'Accessible hint',
            child: Button(label: 'Hover or focus'),
          ),
        );
        expect(
          _openingTagForClass(
            html,
            stylesheet.id == 'win95'
                ? 'win95-floating-container'
                : 'arcane-floating-container',
          ),
          contains('position: relative'),
        );
        expect(
          _openingTagForClass(
            html,
            stylesheet.id == 'win95'
                ? 'win95-floating-content'
                : 'arcane-floating-content',
          ),
          contains('data-arcane-anchor-placement="top"'),
        );
        expect(html, contains('data-arcane-anchor-align="center"'));
      });
    }
  });

  testServer('ShadCN dialog anchors its absolute close button', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ShadcnStylesheet(),
      const ArcaneDialog(
        id: 'positioned-dialog',
        isOpen: true,
        title: 'Positioned',
        child: Text('Dialog body'),
      ),
    );
    expect(
      _openingTagForClass(html, 'arcane-dialog'),
      contains('position: relative'),
    );
  });

  testServer('ShadCN field and select wrappers can shrink in narrow layouts', (
    ServerTester tester,
  ) async {
    final String fieldHtml = await _render(
      tester,
      const ShadcnStylesheet(),
      const ArcaneFieldWrapper(field: Text('Field')),
    );
    expect(
      _openingTagForClass(fieldHtml, 'arcane-field-wrapper'),
      contains('min-width: 0'),
    );
    expect(
      _openingTagForClass(fieldHtml, 'arcane-field-content'),
      contains('min-width: 0'),
    );

    final String selectHtml = await _render(
      tester,
      const ShadcnStylesheet(),
      const _SelectedSelectHarness(),
    );
    expect(
      _openingTagForClass(selectHtml, 'arcane-select-wrapper'),
      contains('min-width: 0'),
    );
    expect(
      _openingTagForClass(selectHtml, 'arcane-select'),
      contains('min-width: 0'),
    );
    expect(
      _openingTagForClass(selectHtml, 'arcane-select-option'),
      contains('min-width: 0'),
    );
  });

  testServer(
    'selected ShadCN option secondary content uses accent foreground',
    (ServerTester tester) async {
      final String html = await _render(
        tester,
        const ShadcnStylesheet(),
        const _SelectedSelectHarness(),
      );
      expect(
        _openingTagForClass(html, 'arcane-select-option-subtitle'),
        contains('color: var(--accent-foreground)'),
      );
      expect(
        _openingTagForClass(html, 'arcane-select-option-description'),
        contains('color: var(--accent-foreground)'),
      );
      expect(
        _openingTagForClass(html, 'arcane-select-option-checkmark'),
        contains('color: var(--accent-foreground)'),
      );
    },
  );
}
