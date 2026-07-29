import 'dart:convert';
import 'dart:io';

const Map<String, String> _loaderSources = <String, String>{
  'win98': 'assets/loaders/apng/win98-hourglass_win98_1x.png',
  'amber': 'assets/loaders/apng/win98-hourglass_amber_1x.png',
  'gameboy': 'assets/loaders/apng/win98-hourglass_gameboy_1x.png',
};

const String _outputPath =
    'packages/arcane_jaspr_win95/lib/src/win95_loader_assets.dart';

void main() {
  final StringBuffer output = StringBuffer()
    ..writeln('// GENERATED FILE. DO NOT EDIT.')
    ..writeln('// Run: dart run tool/bundle_win95_loaders.dart')
    ..writeln('library;')
    ..writeln();

  for (final MapEntry<String, String> source in _loaderSources.entries) {
    final File file = File(source.value);
    if (!file.existsSync()) {
      stderr.writeln('Missing Win95 loader source: ${source.value}');
      exitCode = 1;
      return;
    }

    final String encoded = base64Encode(file.readAsBytesSync());
    output
      ..writeln("const String win95Loader${_pascalCase(source.key)}DataUri =")
      ..writeln("    'data:image/png;base64,$encoded';")
      ..writeln();
  }

  final File outputFile = File(_outputPath);
  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(output.toString());
  stdout.writeln('Bundled ${_loaderSources.length} Win95 APNG loaders.');
}

String _pascalCase(String value) =>
    '${value.substring(0, 1).toUpperCase()}${value.substring(1)}';
