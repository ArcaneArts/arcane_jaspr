import 'dart:io';

const Map<String, String> _themePackages = <String, String>{
  'shadcn': 'packages/arcane_jaspr_shadcn',
  'neon': 'packages/arcane_jaspr_neon',
  'neubrutalism': 'packages/arcane_jaspr_neubrutalism',
};

void main() {
  final List<String> failures = <String>[];

  _checkCoreImports(failures);
  for (MapEntry<String, String> themePackage in _themePackages.entries) {
    _checkThemePackage(themePackage.key, themePackage.value, failures);
  }

  if (failures.isNotEmpty) {
    stderr.writeln('Theme isolation check failed:');
    for (String failure in failures) {
      stderr.writeln('- $failure');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln('Theme isolation check passed.');
}

void _checkCoreImports(List<String> failures) {
  final Directory lib = Directory('lib');
  if (!lib.existsSync()) {
    failures.add('Missing core lib/ directory.');
    return;
  }

  for (File file in _dartFiles(lib)) {
    final String content = file.readAsStringSync();
    for (String packageName in _themePackages.values.map(_packageName)) {
      if (content.contains("package:$packageName/")) {
        failures.add(
          '${file.path} imports concrete renderer package $packageName.',
        );
      }
    }
  }
}

void _checkThemePackage(
  String themeId,
  String packagePath,
  List<String> failures,
) {
  final Directory packageDir = Directory(packagePath);
  final Directory libDir = Directory('$packagePath/lib');
  if (!packageDir.existsSync() || !libDir.existsSync()) {
    failures.add('Missing theme package at $packagePath.');
    return;
  }

  final Set<String> otherPackageNames = _themePackages.entries
      .where((MapEntry<String, String> entry) => entry.key != themeId)
      .map((MapEntry<String, String> entry) => _packageName(entry.value))
      .toSet();
  final Set<String> otherThemeIds = _themePackages.keys
      .where((String otherThemeId) => otherThemeId != themeId)
      .toSet();

  bool sawThemeMarker = false;
  for (File file in _dartFiles(libDir)) {
    final String content = file.readAsStringSync();

    for (String packageName in otherPackageNames) {
      if (content.contains("package:$packageName/")) {
        failures.add(
          '${file.path} imports sibling renderer package $packageName.',
        );
      }
    }

    if (content.contains('arcane-theme-$themeId')) {
      sawThemeMarker = true;
    }

    if (content.contains('[class*="$themeId-"]')) {
      failures.add(
        '${file.path} uses substring theme selector [class*="$themeId-"].',
      );
    }

    for (String otherThemeId in otherThemeIds) {
      if (content.contains('arcane-theme-$otherThemeId') ||
          content.contains('$otherThemeId-')) {
        failures.add('${file.path} references sibling theme $otherThemeId.');
      }
    }
  }

  if (!sawThemeMarker) {
    failures.add('$packagePath does not scope CSS to arcane-theme-$themeId.');
  }
}

String _packageName(String packagePath) => packagePath.split('/').last;

Iterable<File> _dartFiles(Directory directory) sync* {
  for (FileSystemEntity entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      yield entity;
    }
  }
}
