import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Generates the Windows 95 pixel-art cursor set as PNG data URIs.
///
/// Stock Win95 shipped monochrome bitmap cursors — the white/black-outline
/// arrow, the hourglass, the I-beam, the crosshair, the 4-way move cross, the
/// four resize double-arrows, and the circle-slash "unavailable" mark. The
/// pointing hand is the one addition: it was not in the shell, it arrived with
/// Internet Explorer, and it is used here only over real hypertext links.
/// Each cursor below is authored as an ASCII pixel map
/// ('o' = black, 'w' = white, '.' = transparent) at its original 1x pixel
/// size and encoded as a tiny RGBA PNG. The matching CSS hotspots live in
/// packages/arcane_jaspr_win95/lib/src/win95_css.dart, where each cursor is
/// exposed as a `--w95-cursor-*` custom property.
///
/// Usage: dart run tool/bundle_win95_cursors.dart [--preview <dir>]
/// (--preview additionally writes 8x upscaled PNGs for visual inspection.)

const String _outputPath =
    'packages/arcane_jaspr_win95/lib/src/win95_cursor_assets.dart';

class _CursorArt {
  const _CursorArt({required this.name, required this.rows, this.halo = false});

  /// PascalCase identifier suffix (`win95Cursor<name>DataUri`).
  final String name;

  /// Pixel rows: 'o' black, 'w' white, '.' transparent. Equal lengths.
  final List<String> rows;

  /// When true, every transparent pixel touching a black pixel becomes
  /// white — the 1px halo that kept black cursors visible on any surface.
  final bool halo;
}

/// The classic arrow: white fill, 1px black outline, tip at (0,0).
const List<String> _arrowRows = <String>[
  'o...........',
  'oo..........',
  'owo.........',
  'owwo........',
  'owwwo.......',
  'owwwwo......',
  'owwwwwo.....',
  'owwwwwwo....',
  'owwwwwwwo...',
  'owwwwwwwwo..',
  'owwwwwooooo.',
  'owwowwo.....',
  'owo.owwo....',
  'oo..owwo....',
  'o....owwo...',
  '.....owwo...',
  '......owwo..',
  '......owwo..',
  '.......oo...',
];

/// The wait hourglass: black plates, white glass, black sand mid-pour.
const List<String> _waitRows = <String>[
  'ooooooooooooo',
  'ooooooooooooo',
  '.owwwwwwwwwo.',
  '.owwwwwwwwwo.',
  '..owwwwwwwo..',
  '..owwooowwo..',
  '...owooowo...',
  '....ooooo....',
  '.....ooo.....',
  '.....ooo.....',
  '.....ooo.....',
  '.....ooo.....',
  '....owowo....',
  '...owwowwo...',
  '..owwwowwwo..',
  '..owwooowwo..',
  '.owwooooowwo.',
  '.ooooooooooo.',
  'ooooooooooooo',
  'ooooooooooooo',
];

/// The text I-beam: serifed stem, drawn solid black like the original.
const List<String> _ibeamRows = <String>[
  'oo.oo',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  '..o..',
  'oo.oo',
];

/// The IE-era pointing hand: white glove, 1px black outline, tip at (2,0).
/// Not a shell cursor — reserved for hypertext links, as Internet Explorer
/// used it on the Win95 desktop.
const List<String> _handRows = <String>[
  '..oo.........',
  '.owwo........',
  '.owwo........',
  '.owwo........',
  '.owwo........',
  '.owwo........',
  '.owwo.oo.oo..',
  '.owwoowwowwo.',
  '.owwwwwwwwwwo',
  'oowwwwwwwwwwo',
  'owwwwwwwwwwwo',
  'owwwwwwwwwwwo',
  '.owwwwwwwwwwo',
  '.owwwwwwwwwwo',
  '..owwwwwwwwo.',
  '..owwwwwwwwo.',
  '...owwwwwwo..',
  '...oooooooo..',
];

List<String> _blankRows(int width, int height) =>
    List<String>.filled(height, '.' * width);

List<String> _plot(List<String> rows, int x, int y) {
  if (y < 0 || y >= rows.length || x < 0 || x >= rows[y].length) {
    return rows;
  }
  final List<String> next = List<String>.of(rows);
  next[y] = next[y].replaceRange(x, x + 1, 'o');
  return next;
}

/// 4-way move cross (SIZEALL): 1px shafts, 7px-wide arrowheads.
List<String> _moveRows() {
  List<String> rows = _blankRows(19, 19);
  const int c = 9;
  for (int i = 0; i < 4; i++) {
    for (int dx = -i; dx <= i; dx++) {
      rows = _plot(rows, c + dx, i); // north head
      rows = _plot(rows, c + dx, 18 - i); // south head
      rows = _plot(rows, i, c + dx); // west head
      rows = _plot(rows, 18 - i, c + dx); // east head
    }
  }
  for (int i = 4; i <= 14; i++) {
    rows = _plot(rows, c, i);
    rows = _plot(rows, i, c);
  }
  return rows;
}

/// Vertical resize double-arrow (SIZENS).
List<String> _sizeNsRows() {
  List<String> rows = _blankRows(9, 19);
  const int c = 4;
  for (int i = 0; i < 4; i++) {
    for (int dx = -i; dx <= i; dx++) {
      rows = _plot(rows, c + dx, i);
      rows = _plot(rows, c + dx, 18 - i);
    }
  }
  for (int i = 4; i <= 14; i++) {
    rows = _plot(rows, c, i);
  }
  return rows;
}

/// Horizontal resize double-arrow (SIZEWE): the NS art transposed.
List<String> _sizeEwRows() {
  final List<String> ns = _sizeNsRows();
  return List<String>.generate(
    ns[0].length,
    (int y) => List<String>.generate(ns.length, (int x) => ns[x][y]).join(),
  );
}

/// Diagonal resize double-arrow (SIZENWSE): corner triangles + 1px shaft.
List<String> _sizeNwseRows() {
  List<String> rows = _blankRows(15, 15);
  for (int y = 0; y < 15; y++) {
    for (int x = 0; x < 15; x++) {
      final bool headNw = x + y <= 4;
      final bool headSe = x + y >= 24;
      final bool shaft = x == y && x >= 1 && x <= 13;
      if (headNw || headSe || shaft) {
        rows = _plot(rows, x, y);
      }
    }
  }
  return rows;
}

/// Diagonal resize double-arrow (SIZENESW): NWSE mirrored horizontally.
List<String> _sizeNeswRows() =>
    _sizeNwseRows().map((String row) => row.split('').reversed.join()).toList();

/// Precision crosshair (IDC_CROSS): 1px black cross, hotspot at its centre.
List<String> _crossRows() {
  List<String> rows = _blankRows(15, 15);
  const int c = 7;
  for (int i = 0; i < 15; i++) {
    rows = _plot(rows, c, i);
    rows = _plot(rows, i, c);
  }
  return rows;
}

/// Unavailable mark (IDC_NO): the circle-slash Win95 showed while dragging
/// over a target that refused the drop. Never a hover state on a disabled
/// control — those kept the plain arrow.
List<String> _noRows() {
  List<String> rows = _blankRows(17, 17);
  const double centre = 8;
  for (int y = 0; y < 17; y++) {
    for (int x = 0; x < 17; x++) {
      final double dx = x - centre;
      final double dy = y - centre;
      final double distance = (dx * dx + dy * dy);
      final bool ring = distance <= 64 && distance >= 39.0;
      final bool bar = distance <= 64 && (dx + dy).abs() <= 1.0;
      if (ring || bar) {
        rows = _plot(rows, x, y);
      }
    }
  }
  return rows;
}

List<_CursorArt> _cursors() => <_CursorArt>[
  const _CursorArt(name: 'Arrow', rows: _arrowRows),
  const _CursorArt(name: 'Wait', rows: _waitRows),
  const _CursorArt(name: 'Ibeam', rows: _ibeamRows),
  const _CursorArt(name: 'Hand', rows: _handRows),
  _CursorArt(name: 'Cross', rows: _crossRows(), halo: true),
  _CursorArt(name: 'No', rows: _noRows(), halo: true),
  _CursorArt(name: 'Move', rows: _moveRows(), halo: true),
  _CursorArt(name: 'SizeNs', rows: _sizeNsRows(), halo: true),
  _CursorArt(name: 'SizeEw', rows: _sizeEwRows(), halo: true),
  _CursorArt(name: 'SizeNwse', rows: _sizeNwseRows(), halo: true),
  _CursorArt(name: 'SizeNesw', rows: _sizeNeswRows(), halo: true),
];

List<String> _withHalo(List<String> rows) {
  final int height = rows.length;
  final int width = rows[0].length;
  bool nearBlack(int x, int y) {
    for (int dy = -1; dy <= 1; dy++) {
      for (int dx = -1; dx <= 1; dx++) {
        final int nx = x + dx;
        final int ny = y + dy;
        if (nx < 0 || ny < 0 || nx >= width || ny >= height) {
          continue;
        }
        if (rows[ny][nx] == 'o') {
          return true;
        }
      }
    }
    return false;
  }

  return List<String>.generate(
    height,
    (int y) => List<String>.generate(width, (int x) {
      if (rows[y][x] == '.' && nearBlack(x, y)) {
        return 'w';
      }
      return rows[y][x];
    }).join(),
  );
}

final List<int> _crcTable = List<int>.generate(256, (int n) {
  int c = n;
  for (int k = 0; k < 8; k++) {
    c = (c & 1) == 1 ? 0xEDB88320 ^ (c >> 1) : c >> 1;
  }
  return c;
});

int _crc32(List<int> bytes) {
  int c = 0xFFFFFFFF;
  for (final int byte in bytes) {
    c = _crcTable[(c ^ byte) & 0xFF] ^ (c >> 8);
  }
  return c ^ 0xFFFFFFFF;
}

List<int> _chunk(String type, List<int> data) {
  final BytesBuilder builder = BytesBuilder();
  builder.add(Uint8List(4)..buffer.asByteData().setUint32(0, data.length));
  final List<int> typed = <int>[...ascii.encode(type), ...data];
  builder.add(typed);
  builder.add(Uint8List(4)..buffer.asByteData().setUint32(0, _crc32(typed)));
  return builder.toBytes();
}

List<int> _encodePng(List<String> rows, {int scale = 1}) {
  final int height = rows.length * scale;
  final int width = rows[0].length * scale;
  final BytesBuilder raw = BytesBuilder();
  for (int y = 0; y < height; y++) {
    raw.addByte(0); // scanline filter: none
    final String row = rows[y ~/ scale];
    for (int x = 0; x < width; x++) {
      switch (row[x ~/ scale]) {
        case 'o':
          raw.add(const <int>[0x00, 0x00, 0x00, 0xFF]);
        case 'w':
        case 'W':
          raw.add(const <int>[0xFF, 0xFF, 0xFF, 0xFF]);
        default:
          raw.add(const <int>[0x00, 0x00, 0x00, 0x00]);
      }
    }
  }
  final ByteData header = ByteData(13)
    ..setUint32(0, width)
    ..setUint32(4, height)
    ..setUint8(8, 8) // bit depth
    ..setUint8(9, 6) // color type: RGBA
    ..setUint8(10, 0)
    ..setUint8(11, 0)
    ..setUint8(12, 0);
  final BytesBuilder png = BytesBuilder();
  png.add(const <int>[0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
  png.add(_chunk('IHDR', header.buffer.asUint8List()));
  png.add(_chunk('IDAT', zlib.encode(raw.toBytes())));
  png.add(_chunk('IEND', const <int>[]));
  return png.toBytes();
}

void main(List<String> arguments) {
  final int previewFlag = arguments.indexOf('--preview');
  final String? previewDir =
      previewFlag >= 0 && previewFlag + 1 < arguments.length
      ? arguments[previewFlag + 1]
      : null;

  final StringBuffer output = StringBuffer()
    ..writeln('// GENERATED FILE. DO NOT EDIT.')
    ..writeln('// Run: dart run tool/bundle_win95_cursors.dart')
    ..writeln('library;')
    ..writeln();

  for (final _CursorArt cursor in _cursors()) {
    final List<String> rows = cursor.halo
        ? _withHalo(cursor.rows)
        : cursor.rows;
    final String encoded = base64Encode(_encodePng(rows));
    output
      ..writeln('const String win95Cursor${cursor.name}DataUri =')
      ..writeln("    'data:image/png;base64,$encoded';")
      ..writeln();
    if (previewDir != null) {
      Directory(previewDir).createSync(recursive: true);
      File(
        '$previewDir/${cursor.name}.png',
      ).writeAsBytesSync(_encodePng(rows, scale: 8));
    }
  }

  final File outputFile = File(_outputPath);
  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(output.toString());
  stdout.writeln('Bundled ${_cursors().length} Win95 pixel-art cursors.');
}
