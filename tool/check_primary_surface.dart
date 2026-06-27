#!/usr/bin/env dart

library;

import 'dart:io';

const List<String> _requiredMainExports = <String>[
  'component/collection/collection.dart',
  'component/collection/section.dart',
  'component/dialog/confirm_text.dart',
  'component/dialog/date.dart',
  'component/dialog/date_multi.dart',
  'component/dialog/date_range.dart',
  'component/dialog/email.dart',
  'component/dialog/text.dart',
  'component/dialog/time.dart',
  'component/dialog/toast.dart',
  'component/form/provider.dart',
  'component/form/node/bool.dart',
  'component/form/node/color.dart',
  'component/form/node/date.dart',
  'component/form/node/enum.dart',
  'component/form/node/string.dart',
  'component/form/node/time.dart',
  'component/input/fab.dart',
  'component/input/icon_button.dart',
  'component/input/mutable_text.dart',
  'component/input/popup_menu.dart',
  'component/input/search.dart',
  'component/input/selector.dart',
  'component/layout/carpet.dart',
  'component/layout/fancy_icon.dart',
  'component/layout/fancy_progress.dart',
  'component/layout/form_header.dart',
  'component/layout/radio_cards.dart',
  'component/layout/scaffold.dart',
  'component/layout/section.dart',
  'component/screen/abstract_screen.dart',
  'component/screen/fill_screen.dart',
  'component/screen/sliver_screen.dart',
  'component/support/delete_icon_button.dart',
  'component/support/delete_menu_button.dart',
  'component/support/gesture.dart',
  'component/support/icons.dart',
  'component/view/bar.dart',
  'component/view/card_section.dart',
  'component/view/center_body.dart',
  'component/view/expander.dart',
  'component/view/glass.dart',
  'component/view/image.dart',
  'component/view/logo.dart',
  'component/view/markdown.dart',
  'component/view/tile.dart',
  'mods/card.dart',
];

const List<_BannedToken> _docBannedTokens = <_BannedToken>[
  _BannedToken(label: 'StatelessComponent', pattern: r'StatelessComponent'),
  _BannedToken(label: 'StatefulComponent', pattern: r'StatefulComponent'),
  _BannedToken(label: 'Component build', pattern: r'Component build\s*\('),
  _BannedToken(label: 'htmlFor', pattern: r'htmlFor'),
  _BannedToken(label: 'dom.InputType', pattern: r'dom\.InputType'),
  _BannedToken(label: '<Component>', pattern: r'<Component>'),
  _BannedToken(label: 'ArcaneText', pattern: r'\bArcaneText\b'),
  _BannedToken(label: 'ArcaneHeadline', pattern: r'\bArcaneHeadline\b'),
  _BannedToken(label: 'ArcaneRow', pattern: r'\bArcaneRow\b'),
  _BannedToken(label: 'ArcaneColumn', pattern: r'\bArcaneColumn\b'),
  _BannedToken(label: 'ArcaneButton', pattern: r'\bArcaneButton\b'),
  _BannedToken(label: 'ArcaneCard', pattern: r'\bArcaneCard\b'),
  _BannedToken(label: 'ArcaneDataTable', pattern: r'\bArcaneDataTable\b'),
  _BannedToken(label: 'ArcaneStaticTable', pattern: r'\bArcaneStaticTable\b'),
  _BannedToken(label: '<Widget>', pattern: r'<Widget>'),
  _BannedToken(label: '<ArcaneMenuItem>', pattern: r'<ArcaneMenuItem>'),
  _BannedToken(label: '<SearchResult>', pattern: r'<SearchResult>'),
  _BannedToken(
    label: 'const <Type>[...]',
    pattern: r'const\s+<[A-Za-z_][A-Za-z0-9_<>?, ]*>',
  ),
];

const List<_BannedToken> _catalogBannedTokens = <_BannedToken>[
  _BannedToken(label: 'StatelessComponent', pattern: r'StatelessComponent'),
  _BannedToken(label: 'StatefulComponent', pattern: r'StatefulComponent'),
  _BannedToken(label: 'Component build', pattern: r'Component build\s*\('),
  _BannedToken(label: 'htmlFor', pattern: r'htmlFor'),
  _BannedToken(label: 'dom.InputType', pattern: r'dom\.InputType'),
  _BannedToken(label: '<Component>', pattern: r'<Component>'),
];

const List<_BannedToken> _publicApiBannedTokens = <_BannedToken>[
  _BannedToken(
    label: 'StatelessComponent inheritance',
    pattern: r'class\s+[A-Z][A-Za-z0-9_]*\s+extends\s+StatelessComponent\b',
  ),
  _BannedToken(
    label: 'StatefulComponent inheritance',
    pattern: r'class\s+[A-Z][A-Za-z0-9_]*\s+extends\s+StatefulComponent\b',
  ),
  _BannedToken(label: 'Component build', pattern: r'\bComponent build\s*\('),
  _BannedToken(label: 'List<Component>', pattern: r'\bList<Component>\b'),
  _BannedToken(
    label: 'Component? parameter or field',
    pattern: r'\bComponent\?\s+[A-Za-z_]',
  ),
  _BannedToken(
    label: 'Component field or parameter',
    pattern: r'\b(?:final|const|late|required|static)\s+Component\s+[A-Za-z_]',
  ),
];

void main(List<String> args) {
  final Directory packageRootDirectory = Directory.current;
  final File pubspecFile = File('${packageRootDirectory.path}/pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    stderr.writeln('Run this script from the arcane_jaspr package root.');
    exit(1);
  }

  final File mainSurfaceFile = File(
    '${packageRootDirectory.path}/lib/arcane_jaspr.dart',
  );
  final List<String> exportPaths = _readExportPaths(mainSurfaceFile);
  final List<String> failures = <String>[];

  _checkRequiredExports(exportPaths, failures);
  _checkPublicApi(packageRootDirectory, exportPaths, failures);
  _checkDocsAndExamples(packageRootDirectory, failures);

  if (failures.isNotEmpty) {
    stderr.writeln('Primary surface check failed:');
    for (String failure in failures) {
      stderr.writeln('- $failure');
    }
    exit(1);
  }

  stdout.writeln('Primary surface check passed.');
}

void _checkRequiredExports(List<String> exportPaths, List<String> failures) {
  final Set<String> exportSet = Set<String>.from(exportPaths);

  for (String requiredExport in _requiredMainExports) {
    if (!exportSet.contains(requiredExport)) {
      failures.add('lib/arcane_jaspr.dart: missing export $requiredExport');
    }
  }
}

void _checkPublicApi(
  Directory packageRootDirectory,
  List<String> exportPaths,
  List<String> failures,
) {
  for (String exportPath in exportPaths) {
    if (!exportPath.startsWith('component/') &&
        exportPath != 'mods/card.dart') {
      continue;
    }

    if (exportPath.startsWith('component/html/')) {
      continue;
    }

    final File sourceFile = File('${packageRootDirectory.path}/lib/$exportPath');
    if (!sourceFile.existsSync()) {
      failures.add('Missing exported file: ${sourceFile.path}');
      continue;
    }

    final String content = sourceFile.readAsStringSync();
    final String sanitizedContent = _stripImportsAndComments(content);

    for (_BannedToken bannedToken in _publicApiBannedTokens) {
      final RegExp pattern = RegExp(bannedToken.pattern, multiLine: true);
      if (pattern.hasMatch(sanitizedContent)) {
        failures.add('${sourceFile.path}: ${bannedToken.label}');
      }
    }
  }
}

void _checkDocsAndExamples(
  Directory packageRootDirectory,
  List<String> failures,
) {
  final List<File> filesToScan = <File>[
    File('${packageRootDirectory.path}/README.md'),
    File('${packageRootDirectory.path}/arcane_jaspr_neon/README.md'),
    File(
      '${packageRootDirectory.path}/arcane_jaspr_neon/arcane_neon_web/README.md',
    ),
    File(
      '${packageRootDirectory.path}/arcane_jaspr_neon/arcane_neon_web/lib/components/demo_registry.dart',
    ),
  ];

  filesToScan.addAll(
    _collectFiles(
      Directory(
        '${packageRootDirectory.path}/arcane_jaspr_neon/arcane_neon_web/content',
      ),
      '.md',
    ),
  );
  filesToScan.addAll(
    _collectFiles(
      Directory('${packageRootDirectory.path}/test/smoke'),
      '.dart',
    ),
  );
  filesToScan.addAll(
    _collectFiles(
      Directory(
        '${packageRootDirectory.path}/../Oracular/templates/arcane_jaspr_docs',
      ),
      '.md',
    ),
  );
  filesToScan.addAll(
    _collectFiles(
      Directory(
        '${packageRootDirectory.path}/../Oracular/templates/arcane_jaspr_app/lib',
      ),
      '.dart',
    ),
  );

  for (File file in filesToScan) {
    if (!file.existsSync()) {
      continue;
    }

    final String content = file.readAsStringSync();
    final List<_BannedToken> bannedTokens =
        file.path.endsWith('/content/docs/components-catalog.md')
        ? _catalogBannedTokens
        : _docBannedTokens;

    for (_BannedToken bannedToken in bannedTokens) {
      final RegExp pattern = RegExp(bannedToken.pattern, multiLine: true);
      if (pattern.hasMatch(content)) {
        failures.add('${file.path}: ${bannedToken.label}');
      }
    }
  }
}

List<String> _readExportPaths(File sourceFile) {
  final String content = sourceFile.readAsStringSync();
  final RegExp exportPattern = RegExp(r"export '([^']+)'");
  final List<String> exportPaths = <String>[];

  for (RegExpMatch match in exportPattern.allMatches(content)) {
    final String? exportPath = match.group(1);
    if (exportPath != null) {
      exportPaths.add(exportPath);
    }
  }

  return exportPaths;
}

List<File> _collectFiles(Directory directory, String extension) {
  if (!directory.existsSync()) {
    return <File>[];
  }

  final List<FileSystemEntity> entities = directory.listSync(recursive: true);
  final List<File> files = <File>[];

  for (FileSystemEntity entity in entities) {
    if (entity is! File) {
      continue;
    }

    if (!entity.path.endsWith(extension)) {
      continue;
    }

    if (entity.path.contains('/web/')) {
      continue;
    }

    if (entity.path.endsWith('/Plan.md')) {
      continue;
    }

    files.add(entity);
  }

  files.sort((File left, File right) => left.path.compareTo(right.path));
  return files;
}

String _stripImportsAndComments(String content) {
  final List<String> lines = content.split('\n');
  final List<String> keptLines = <String>[];

  for (String line in lines) {
    final String trimmed = line.trimLeft();

    if (trimmed.startsWith('import ')) {
      continue;
    }

    if (trimmed.startsWith('export ')) {
      continue;
    }

    if (trimmed.startsWith('part ')) {
      continue;
    }

    if (trimmed.startsWith('//')) {
      continue;
    }

    if (trimmed.startsWith('///')) {
      continue;
    }

    keptLines.add(line);
  }

  return keptLines.join('\n');
}

class _BannedToken {
  final String label;
  final String pattern;

  const _BannedToken({required this.label, required this.pattern});
}
