import 'dart:convert';
import 'dart:io';

/// Bundles the animated hourglass loader art into the Win95 renderer package.
///
/// The source art is 26x26 pixels at 1x, and the 2x/3x sheets are the same
/// frames redrawn on a whole-integer pixel grid rather than upscaled. Both are
/// bundled so the emitted CSS can hand a HiDPI display the sheet that maps 1:1
/// onto its device pixels via `image-set()`; the 1x URI stays the plain
/// `--w95-loader-image` value host apps reference.
///
/// Usage: dart run tool/bundle_win95_loaders.dart
const List<String> _loaderPalettes = <String>['win98', 'amber', 'gameboy'];

/// Pixel-density variants bundled per palette, keyed by the identifier suffix
/// appended to the generated constant name ('' is the 1x base).
const Map<String, String> _loaderScales = <String, String>{
  '': '1x',
  '2x': '2x',
  '3x': '3x',
};

const String _outputPath =
    'packages/arcane_jaspr_win95/lib/src/win95_loader_assets.dart';

void main() {
  final StringBuffer output = StringBuffer()
    ..writeln('// GENERATED FILE. DO NOT EDIT.')
    ..writeln('// Run: dart run tool/bundle_win95_loaders.dart')
    ..writeln('library;')
    ..writeln();

  int bundled = 0;
  for (final String palette in _loaderPalettes) {
    for (final MapEntry<String, String> scale in _loaderScales.entries) {
      final String path =
          'assets/loaders/apng/win98-hourglass_${palette}_${scale.value}.png';
      final File file = File(path);
      if (!file.existsSync()) {
        stderr.writeln('Missing Win95 loader source: $path');
        exitCode = 1;
        return;
      }

      final String encoded = base64Encode(file.readAsBytesSync());
      output
        ..writeln(
          'const String win95Loader${_pascalCase(palette)}DataUri${scale.key} =',
        )
        ..writeln("    'data:image/png;base64,$encoded';")
        ..writeln();
      bundled++;
    }
  }

  final File outputFile = File(_outputPath);
  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(output.toString());
  stdout.writeln('Bundled $bundled Win95 APNG loaders.');
}

String _pascalCase(String value) =>
    '${value.substring(0, 1).toUpperCase()}${value.substring(1)}';
