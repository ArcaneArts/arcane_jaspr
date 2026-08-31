import 'dart:io';

import 'package:jaspr_test/jaspr_test.dart';

final RegExp _obviousAiPhrase = RegExp(
  r'''\b(?:great question|excellent point|you['’]re absolutely right|i hope this helps|feel free to reach out|let me know if you need anything else|as of my last update|i don['’]t have access to real-time data|experts believe|studies show|industry leaders agree|let['’]s dive in|let['’]s explore|delve into|game[- ]chang(?:er|ing)|cutting[- ]edge|testament to|the future looks bright|only time will tell|at the end of the day)\b''',
  caseSensitive: false,
);

final RegExp _citationLeak = RegExp(
  r'''(?:cite\s*turn\d+\w+\d+|contentReference\[oaicite:\d+\]|oai_citation|\[attached_file:\d+\]|grok_card)''',
  caseSensitive: false,
);

final RegExp _aiTracking = RegExp(
  r'''(?:utm_source=(?:chatgpt\.com|copilot\.com|openai|claude\.ai|perplexity\.ai)|referrer=grok\.com)''',
  caseSensitive: false,
);

Iterable<File> _readerFacingSources() sync* {
  const List<String> directFiles = <String>[
    'README.md',
    'packages/arcane_jaspr_neon/README.md',
    'arcane_jaspr_docs/README.md',
    'arcane_jaspr_docs/arcane_jaspr_docs_web/README.md',
    'arcane_jaspr_docs/arcane_jaspr_docs_web/lib/components/demo_registry.dart',
  ];
  for (final String path in directFiles) {
    yield File(path);
  }

  const List<String> roots = <String>[
    'arcane_jaspr_docs/arcane_jaspr_docs_web/content',
    'lib/component',
    'packages/arcane_jaspr_neon/lib',
  ];
  for (final String root in roots) {
    for (final FileSystemEntity entity in Directory(
      root,
    ).listSync(recursive: true, followLinks: false)) {
      if (entity is! File) continue;
      if (entity.path.endsWith('.md') || entity.path.endsWith('.dart')) {
        yield entity;
      }
    }
  }
}

void main() {
  test('reader-facing copy excludes obvious AI boilerplate and tool leaks', () {
    for (final File file in _readerFacingSources()) {
      final String source = file.readAsStringSync();
      expect(
        _obviousAiPhrase.firstMatch(source),
        isNull,
        reason: '${file.path} contains obvious AI boilerplate',
      );
      expect(
        _citationLeak.firstMatch(source),
        isNull,
        reason: '${file.path} contains AI citation markup',
      );
      expect(
        _aiTracking.firstMatch(source),
        isNull,
        reason: '${file.path} contains AI referral tracking',
      );
    }
  });
}
