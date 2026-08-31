// Tool to generate the complete ArcaneIcon wrapper for all Lucide icons
// Uses the Lucide icon font for efficient loading (single font file vs 1600+ separate SVG components)
// Run with: dart tool/generate_icons.dart

import 'dart:convert';
import 'dart:io';

import 'package:fast_log/fast_log.dart';

/// Dart reserved words that need special handling
const Set<String> dartReservedWords = <String>{
  'assert', 'break', 'case', 'catch', 'class', 'const', 'continue',
  'default', 'do', 'else', 'enum', 'extends', 'false', 'final',
  'finally', 'for', 'if', 'in', 'is', 'new', 'null', 'rethrow',
  'return', 'super', 'switch', 'this', 'throw', 'true', 'try',
  'var', 'void', 'while', 'with', 'yield',
  // Also handle common type names that conflict
  'int', 'double', 'bool', 'String', 'List', 'Map', 'Set',
  'Function', 'Type', 'Object', 'dynamic', 'Future', 'Stream',
  'import', 'export', 'library', 'part', 'typedef', 'abstract',
  // Jaspr types that would conflict
  'component',
};

/// Special abbreviations - keep uppercase for AZ/ZA sorting icons only
const Map<String, String> upperAbbreviations = <String, String>{
  'az': 'AZ',
  'za': 'ZA',
};

/// Decorative icons excluded from the product-facing API.
///
/// These symbols are strongly associated with generic AI-generated chrome and
/// are intentionally unavailable rather than merely discouraged.
const Set<String> forbiddenIconNames = <String>{
  'sparkle',
  'sparkles',
  'wand-sparkles',
};

/// Semantic aliases for common icon names
/// Maps alias method name -> actual lucide icon name (kebab-case)
const Map<String, String> semanticAliases = <String, String>{
  // Navigation
  'home': 'house',
  'close': 'x',
  'back': 'arrow-left',
  'forward': 'arrow-right',
  'up': 'arrow-up',
  'down': 'arrow-down',

  // Actions
  'edit': 'pencil',
  'delete': 'trash-2',
  'remove': 'trash',
  'add': 'plus',
  'create': 'plus',
  'cancel': 'x',
  'confirm': 'check',

  // UI elements
  'dropdown': 'chevron-down',
  'expand': 'chevron-down',
  'collapse': 'chevron-up',
  'next': 'chevron-right',
  'prev': 'chevron-left',
  'previous': 'chevron-left',

  // Grid/Layout
  'grid': 'grid-3x3',
  'dashboard': 'layout-dashboard',
  'sidebar': 'panel-left',

  // Status
  'success': 'circle-check',
  'error': 'circle-x',
  'warning': 'triangle-alert',
  'danger': 'triangle-alert',
  'info': 'info',
  'help': 'circle-question-mark',

  // User
  'profile': 'user',
  'account': 'user',
  'avatar': 'circle-user-round',

  // Misc
  'search': 'search',
  'settings': 'settings',
  'options': 'settings',
  'preferences': 'settings',
  'config': 'settings',
  'notifications': 'bell',
  'alerts': 'bell',
  'email': 'mail',
  'message': 'message-square',
  'chat': 'message-circle',
  'comment': 'message-square',
  'attachment': 'paperclip',
  'link': 'link',
  'share': 'share-2',
  'save': 'save',
  'download': 'download',
  'upload': 'upload',
  'copy': 'copy',
  'paste': 'clipboard',
  'cut': 'scissors',
  'undo': 'undo-2',
  'redo': 'redo-2',
  'refresh': 'refresh-cw',
  'reload': 'refresh-cw',
  'sync': 'refresh-cw',
  'loading': 'loader-circle',
  'spinner': 'loader-circle',
  'lock': 'lock',
  'unlock': 'lock-open',
  'visible': 'eye',
  'hidden': 'eye-off',
  'show': 'eye',
  'hide': 'eye-off',
  'play': 'play',
  'pause': 'pause',
  'stop': 'square',
  'record': 'circle',
  'volume': 'volume-2',
  'mute': 'volume-x',
  'fullscreen': 'maximize',
  'exitFullscreen': 'minimize',
  'zoomIn': 'zoom-in',
  'zoomOut': 'zoom-out',
  'calendar': 'calendar',
  'date': 'calendar',
  'time': 'clock',
  'timer': 'timer',
  'alarm': 'alarm-clock',
  'location': 'map-pin',
  'pin': 'map-pin',
  'phone': 'phone',
  'call': 'phone',
  'video': 'video',
  'camera': 'camera',
  'image': 'image',
  'photo': 'image',
  'gallery': 'images',
  'music': 'music',
  'audio': 'music',
  'file': 'file',
  'document': 'file-text',
  'folder': 'folder',
  'directory': 'folder',
  'print': 'printer',
  'export': 'file-output',
  'moreHorizontal': 'ellipsis',
  'moreVertical': 'ellipsis-vertical',
  'filter': 'funnel',
  'sort': 'arrow-up-down',
  'key': 'key-round',
  'map': 'map',
};

/// Custom brand icons with SVG path data (not from Lucide font)
/// Maps method name -> (viewBox, list of path data)
const Map<String, (String viewBox, List<String> paths)>
customBrandIcons = <String, (String, List<String>)>{
  'xbox': (
    '0 0 50 50',
    <String>[
      'M 25 2 C 20.709 2 16.618563 3.2007813 13.226562 5.3007812 C 13.007563 5.3737813 12.629156 5.6617969 12.285156 5.9667969 C 15.330156 3.5477969 22.371734 8.3929375 24.427734 9.8359375 C 24.773734 10.078938 25.228219 10.078938 25.574219 9.8359375 C 27.630219 8.3929375 34.671797 3.5467969 37.716797 5.9667969 C 37.372797 5.6617969 36.993391 5.3737813 36.775391 5.3007812 C 33.382391 3.2007813 29.291 2 25 2 z M 11 8 C 9.403 8 8.2363281 9.3007812 8.2363281 9.3007812 C 4.4443281 13.400781 2.0507812 18.9 2.0507812 25 C 2.0507812 37.7 12.328 48 25 48 C 31.685 48 37.771891 45.1 41.962891 40.5 C 41.962891 40.5 41.464094 37.499609 38.371094 33.099609 C 34.912094 27.882609 27.905109 21.311922 25.662109 19.294922 C 25.279109 18.950922 24.708125 18.952781 24.328125 19.300781 C 22.638125 20.847781 18.277406 25.177781 17.316406 26.300781 C 15.021406 28.700781 8.6353281 36.299609 8.2363281 40.599609 C 8.2363281 40.599609 6.8386406 37.200391 9.9316406 29.400391 C 11.856641 24.714391 17.835375 17.747984 20.734375 14.708984 C 21.119375 14.305984 21.110125 13.669109 20.703125 13.287109 C 19.743125 12.388109 17.505281 10.812609 15.488281 9.5996094 C 14.092281 8.6996094 12.497 8.1 11 8 z M 38.689453 8 C 38.036453 8 33.794078 9.3428281 29.330078 13.298828 C 28.908078 13.672828 28.891203 14.325469 29.283203 14.730469 C 30.900203 16.401469 35.322656 20.681391 37.972656 24.900391 C 41.265656 30.300391 43.2605 34.6 42.0625 40.5 C 45.7545 36.4 48.050781 31 48.050781 25 C 47.950781 19 45.655281 13.500391 41.863281 9.4003906 C 41.763281 9.3003906 41.663453 9.1996094 41.564453 9.0996094 C 40.766453 8.1996094 39.587453 8 38.689453 8 z',
    ],
  ),
  'playstation': (
    '0 0 30 30',
    <String>[
      'M 11.181641 3.7421875 L 11.181641 24.857422 L 15.761719 26.257812 L 15.761719 8.5761719 C 15.761719 8.0671719 15.761625 7.8135937 16.015625 7.5585938 C 16.142625 7.3045937 16.396391 7.3046406 16.650391 7.4316406 C 17.286391 7.6856406 17.669922 8.1948906 17.669922 9.2128906 L 17.669922 16.207031 C 19.195922 16.970031 20.466375 16.970031 21.484375 16.207031 C 22.502375 15.444031 23.011719 14.300578 23.011719 12.392578 C 23.012719 10.357578 22.630234 9.0853594 21.740234 8.0683594 C 20.977234 7.0503594 19.578969 6.1594375 17.542969 5.5234375 C 14.998969 4.7604375 12.835641 4.1241875 11.181641 3.7421875 z M 9.9101562 16.972656 L 4.0585938 19.007812 L 3.1699219 19.388672 C 1.7709219 20.024672 1.0078125 20.660875 1.0078125 21.296875 C 1.1348125 22.059875 1.388875 23.078844 3.296875 23.714844 C 5.077875 24.350844 6.4770625 24.604891 10.039062 23.587891 L 10.039062 21.296875 C 6.6030625 22.440875 6.0949375 22.314547 5.5859375 22.060547 C 5.0769375 21.806547 5.076125 21.550828 5.203125 21.423828 C 5.585125 21.169828 6.984375 20.660156 6.984375 20.660156 L 9.9101562 19.642578 L 9.9101562 16.972656 z M 22.853516 17.962891 C 22.440109 17.948984 22.026781 17.956531 21.613281 17.988281 C 20.214281 17.988281 18.941063 18.243 17.414062 18.625 L 17.414062 21.296875 L 20.212891 20.277344 L 21.738281 19.769531 C 21.738281 19.769531 22.375812 19.642625 22.757812 19.515625 C 23.393812 19.388625 24.15625 19.642578 24.15625 19.642578 C 24.53825 19.642578 24.792969 19.768438 24.792969 20.023438 C 24.919969 20.277438 24.665297 20.406156 24.029297 20.660156 L 22.630859 21.169922 L 17.542969 23.076172 L 17.542969 25.748047 L 19.832031 24.984375 L 26.191406 22.695312 L 26.955078 22.3125 C 28.481078 21.8035 29.117234 21.167297 28.990234 20.404297 C 28.990234 19.642297 28.100219 19.134 26.574219 18.625 C 25.333719 18.24325 24.093734 18.004609 22.853516 17.962891 z',
    ],
  ),
  'crossplay': (
    '0 0 1200 1200',
    <String>[
      'm381.76 840.01h-57.758v60h179.98v-120h-101.95c0 25.082-8.0859 47.113-20.266 60z',
      'm743.98 1020h240v-360h-240zm60-300h120v240h-120z',
      'm563.98 480.01v420h120v-60h-60v-300h420v360h60v-420z',
      'm144 239.99h659.98v180.02h60v-240.02h-779.98v540.02h419.98v-120h-359.98z',
    ],
  ),
};

/// Icons that need manual name adjustments (kebab-case key -> method name)
const Map<String, String> nameOverrides = <String, String>{
  // Reserved words or conflicts
  'import': 'importIcon',
  'type': 'typeIcon',
  'switch': 'switchIcon',
  'case': 'caseIcon',
  'default': 'defaultIcon',
  'for': 'forIcon',
  'if': 'ifIcon',
  'return': 'returnIcon',
  'try': 'tryIcon',
  'catch': 'catchIcon',
  'finally': 'finallyIcon',
  'throw': 'throwIcon',
  'new': 'newIcon',
  'null': 'nullIcon',
  'true': 'trueIcon',
  'false': 'falseIcon',
  'this': 'thisIcon',
  'super': 'superIcon',
  'class': 'classIcon',
  'enum': 'enumIcon',
  'void': 'voidIcon',
  'var': 'varIcon',
  'final': 'finalIcon',
  'const': 'constIcon',
  'assert': 'assertIcon',
  'break': 'breakIcon',
  'continue': 'continueIcon',
  'do': 'doIcon',
  'else': 'elseIcon',
  'extends': 'extendsIcon',
  'in': 'inIcon',
  'is': 'isIcon',
  'rethrow': 'rethrowIcon',
  'while': 'whileIcon',
  'with': 'withIcon',
  'yield': 'yieldIcon',
  // Common type conflicts
  'list': 'listIcon',
  'map': 'mapIcon',
  'set': 'setIcon',
  'key': 'keyIcon',
  'view': 'viewIcon',
  'factory': 'factoryIcon',
  'target': 'targetIcon',
  'timer': 'timerIcon',
  'contrast': 'contrastIcon',
  'radius': 'radiusIcon',
};

/// Convert kebab-case to camelCase (for method names)
String kebabToCamel(String kebab) {
  final List<String> parts = kebab.split('-');
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < parts.length; i++) {
    final String part = parts[i];
    if (part.isEmpty) continue;

    // Check for special abbreviations (AZ/ZA)
    final String lower = part.toLowerCase();
    if (upperAbbreviations.containsKey(lower)) {
      if (i == 0) {
        buffer.write(lower); // First part stays lowercase
      } else {
        buffer.write(upperAbbreviations[lower]!);
      }
      continue;
    }

    // Handle numeric parts
    if (RegExp(r'^\d').hasMatch(part)) {
      if (buffer.isEmpty) {
        buffer.write('icon$part');
      } else {
        buffer.write(part);
      }
      continue;
    }

    if (i == 0) {
      buffer.write(part.toLowerCase());
    } else {
      buffer.write(part[0].toUpperCase() + part.substring(1).toLowerCase());
    }
  }

  return buffer.toString();
}

/// Get the method name, handling reserved words
String getMethodName(String kebabName) {
  // Check for overrides first
  if (nameOverrides.containsKey(kebabName)) {
    return nameOverrides[kebabName]!;
  }

  final String camel = kebabToCamel(kebabName);

  // Check if it's a reserved word
  if (dartReservedWords.contains(camel)) {
    return '${camel}Icon';
  }

  return camel;
}

void main() async {
  // Read icon info from the lucide font info.json
  final File infoFile = File('assets/fonts/lucide/info.json');
  if (!infoFile.existsSync()) {
    error(
      'info.json not found. Run: npm pack lucide-static && extract font files',
    );
    exit(1);
  }

  final String infoContent = await infoFile.readAsString();
  final Map<String, dynamic> iconInfo =
      jsonDecode(infoContent) as Map<String, dynamic>;

  final List<String> iconNames =
      iconInfo.keys
          .where((String name) => !forbiddenIconNames.contains(name))
          .toList()
        ..sort();
  print('Found ${iconNames.length} icons in Lucide font');

  // Build codepoint map
  final Map<String, String> codepoints = <String, String>{};
  for (final String name in iconNames) {
    final Map<String, dynamic> info = iconInfo[name] as Map<String, dynamic>;
    // encodedCode is like "\\e585" - we need just "e585"
    String code = info['encodedCode'] as String;
    if (code.startsWith('\\')) {
      code = code.substring(1);
    }
    codepoints[name] = code;
  }

  // Generate the Dart file
  final StringBuffer buffer = StringBuffer();

  buffer.writeln('''
// GENERATED FILE - DO NOT EDIT MANUALLY
// Generated by tool/generate_icons.dart
// Uses the Lucide icon font for efficient loading
// Font files: assets/fonts/lucide/lucide.woff2 (245KB for all ${iconNames.length} icons)

import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart'
    hide
        BuildContext,
        InheritedComponent,
        Key,
        State,
        StatefulComponent,
        StatelessComponent,
        UniqueKey,
        ValueKey,
        runApp;
import 'package:jaspr/dom.dart' as dom;

/// Icon size presets for consistent sizing.
enum IconSize {
  xs,
  sm,
  md,
  lg,
  xl,
  xl2,
}

/// Extension to convert IconSize to pixel values.
extension IconSizeExtension on IconSize {
  double get pixels => switch (this) {
        IconSize.xs => 12,
        IconSize.sm => 16,
        IconSize.md => 20,
        IconSize.lg => 24,
        IconSize.xl => 32,
        IconSize.xl2 => 48,
      };
}

/// A structurally bounded, single rendered glyph.
///
/// Semantic icon slots accept this type instead of arbitrary [Widget] trees,
/// preventing callers from composing overlapping or multi-icon marks.
sealed class ArcaneGlyph extends StatelessWidget {
  const ArcaneGlyph({super.key});
}

/// Base component for font-based icons.
/// Uses the Lucide icon font with Unicode codepoints.
final class _LucideIcon extends ArcaneGlyph {
  final String codepoint;
  final IconSize size;

  const _LucideIcon({
    required this.codepoint,
    this.size = IconSize.md,
  });

  @override
  Widget build(BuildContext context) {
    final double px = size.pixels;
    return dom.i(
      styles: dom.Styles(raw: <String, String>{
        'font-family': "'lucide', sans-serif",
        'font-style': 'normal',
        'font-weight': 'normal',
        'font-size': '\${px}px',
        'line-height': '1',
        'display': 'inline-block',
        'width': '\${px}px',
        'height': '\${px}px',
        '-webkit-font-smoothing': 'antialiased',
        '-moz-osx-font-smoothing': 'grayscale',
      }),
      [Component.text(String.fromCharCode(int.parse(codepoint, radix: 16)))],
    );
  }
}

/// Custom SVG-based icon component for brand icons.
/// Uses inline SVG paths for icons not available in the Lucide font.
final class _CustomSvgIcon extends ArcaneGlyph {
  final String viewBox;
  final List<String> paths;
  final List<String>? pathFills;
  final IconSize size;

  const _CustomSvgIcon({
    required this.viewBox,
    required this.paths,
    this.pathFills,
    this.size = IconSize.md,
  });

  @override
  Widget build(BuildContext context) {
    final String px = size.pixels.toStringAsFixed(0);
    return Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': px,
        'height': px,
        'viewBox': viewBox,
        'fill': 'currentColor',
      },
      children: <Component>[
        for (final (int index, String path) in paths.indexed)
          Component.element(
            tag: 'path',
            attributes: <String, String>{
              'd': path,
              if (pathFills != null) 'fill': pathFills![index],
            },
            children: <Component>[],
          ),
      ],
    );
  }
}

/// Wrapper class providing access to all ${iconNames.length} Lucide icons.
///
/// Uses the Lucide icon font for efficient loading - a single 245KB font file
/// instead of 1600+ separate SVG component files.
///
/// Usage:
/// ```dart
/// ArcaneIcon.house()
/// ArcaneIcon.search(size: IconSize.lg)
/// ArcaneIcon.settings()
/// ```
///
/// All methods accept an optional [size] parameter (default: IconSize.md = 20px).
///
/// For the complete icon catalog, visit: https://lucide.dev/icons
class ArcaneIcon {
  ArcaneIcon._();

  /// Creates one custom SVG glyph. Multiple paths remain inside one SVG mark.
  static ArcaneGlyph customSvg({
    required String viewBox,
    required List<String> paths,
    List<String>? pathFills,
    IconSize size = IconSize.md,
  }) {
    assert(pathFills == null || pathFills.length == paths.length);
    return _CustomSvgIcon(
      viewBox: viewBox,
      paths: paths,
      pathFills: pathFills,
      size: size,
    );
  }
''');

  // Generate methods for each icon
  for (final String name in iconNames) {
    final String methodName = getMethodName(name);
    final String codepoint = codepoints[name]!;
    // Convert name to PascalCase for the doc comment
    final String displayName = name
        .split('-')
        .map((String s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1))
        .join('');

    buffer.writeln('''
  /// $displayName icon
  static ArcaneGlyph $methodName({IconSize size = IconSize.md}) =>
      _LucideIcon(codepoint: '$codepoint', size: size);
''');
  }

  // Add semantic aliases section
  buffer.writeln('''
  // ============================================================================
  // Semantic Aliases
  // These provide intuitive names that map to the actual Lucide icon names.
  // For example: home() -> house(), edit() -> pencil(), close() -> x()
  // ============================================================================
''');

  // Generate alias methods
  final Set<String> existingMethods = iconNames
      .map((String n) => getMethodName(n))
      .toSet();

  for (final MapEntry<String, String> entry in semanticAliases.entries) {
    final String aliasName = entry.key;
    final String targetIconName = entry.value;

    // Skip if alias would conflict with an existing method
    if (existingMethods.contains(aliasName)) {
      continue;
    }

    // Get the codepoint for the target icon
    if (!codepoints.containsKey(targetIconName)) {
      warn('Alias "$aliasName" -> "$targetIconName" not found in icon set');
      continue;
    }

    final String codepoint = codepoints[targetIconName]!;

    buffer.writeln('''
  /// Alias for $targetIconName - semantic name for common use case
  static ArcaneGlyph $aliasName({IconSize size = IconSize.md}) =>
      _LucideIcon(codepoint: '$codepoint', size: size);
''');
  }

  // Add custom brand icons section
  buffer.writeln('''
  // ============================================================================
  // Custom Brand/Platform Icons (SVG-based)
  // These icons use inline SVG paths as they are not part of the Lucide font.
  // ============================================================================
''');

  // Generate custom brand icon methods
  for (final MapEntry<String, (String, List<String>)> entry
      in customBrandIcons.entries) {
    final String methodName = entry.key;
    final String viewBox = entry.value.$1;
    final List<String> paths = entry.value.$2;

    // Convert method name to display name (e.g., 'xbox' -> 'Xbox')
    final String displayName =
        methodName[0].toUpperCase() + methodName.substring(1);

    // Format paths as a Dart list literal
    final String pathsLiteral = paths.map((String p) => "'$p'").join(', ');

    buffer.writeln('''
  /// $displayName brand icon (SVG-based)
  static ArcaneGlyph $methodName({IconSize size = IconSize.md}) =>
      _CustomSvgIcon(viewBox: '$viewBox', paths: <String>[$pathsLiteral], size: size);
''');
  }

  buffer.writeln('}');

  // Write the generated file
  final File outputFile = File('lib/component/view/icon.dart');
  await outputFile.writeAsString(buffer.toString());

  info('Generated ${outputFile.path} with ${iconNames.length} icons');

  // Generate CSS file for the font
  await _generateFontCss();
}

/// Generate CSS file with @font-face for the Lucide icon font
Future<void> _generateFontCss() async {
  const String css = '''
/* Lucide Icon Font - Generated by tool/generate_icons.dart */
/* Include this CSS in your web app to load the icon font */

@font-face {
  font-family: 'lucide';
  src: url('fonts/lucide/lucide.woff2') format('woff2'),
       url('fonts/lucide/lucide.woff') format('woff'),
       url('fonts/lucide/lucide.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
  font-display: block;
}
''';

  final File cssFile = File('assets/fonts/lucide/lucide.css');
  await cssFile.writeAsString(css);
  info('Generated ${cssFile.path}');
}
