// Tool to generate the complete ArcaneIcon wrapper for all Lucide icons
// Run with: dart tool/generate_icons.dart

import 'dart:io';

/// Dart reserved words that need special handling
const dartReservedWords = {
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
/// Note: jaspr_lucide uses standard PascalCase (Cpu, Nfc, Gpu, etc.)
const upperAbbreviations = {
  'az': 'AZ',
  'za': 'ZA',
};

/// Icons with special class names in jaspr_lucide (due to Dart conflicts)
const classNameOverrides = {
  'component_': 'Component_', // Trailing underscore because of Dart conflict
};

/// Semantic aliases for common icon names
/// Maps alias method name -> actual lucide method name
const semanticAliases = {
  // Navigation
  'home': 'house',
  'close': 'x',
  'back': 'arrowLeft',
  'forward': 'arrowRight',
  'up': 'arrowUp',
  'down': 'arrowDown',

  // Actions
  'edit': 'pencil',
  'delete': 'trash2',
  'remove': 'trash',
  'add': 'plus',
  'create': 'plus',
  'cancel': 'x',
  'confirm': 'check',

  // UI elements
  'dropdown': 'chevronDown',
  'expand': 'chevronDown',
  'collapse': 'chevronUp',
  'next': 'chevronRight',
  'prev': 'chevronLeft',
  'previous': 'chevronLeft',

  // Grid/Layout
  'grid': 'grid3x3',
  'dashboard': 'layoutDashboard',
  'sidebar': 'panelLeft',

  // Status
  'success': 'circleCheck',
  'error': 'circleX',
  'warning': 'triangleAlert',
  'danger': 'triangleAlert',
  'info': 'info',
  'help': 'circleQuestionMark',

  // User
  'profile': 'user',
  'account': 'user',
  'avatar': 'circleUserRound',

  // Misc
  'search': 'search',
  'settings': 'settings',
  'options': 'settings',
  'preferences': 'settings',
  'config': 'settings',
  'notifications': 'bell',
  'alerts': 'bell',
  'email': 'mail',
  'message': 'messageSquare',
  'chat': 'messageCircle',
  'comment': 'messageSquare',
  'attachment': 'paperclip',
  'link': 'link',
  'share': 'share2',
  'save': 'save',
  'download': 'download',
  'upload': 'upload',
  'copy': 'copy',
  'paste': 'clipboard',
  'cut': 'scissors',
  'undo': 'undo2',
  'redo': 'redo2',
  'refresh': 'refreshCw',
  'reload': 'refreshCw',
  'sync': 'refreshCw',
  'loading': 'loaderCircle',
  'spinner': 'loaderCircle',
  'lock': 'lock',
  'unlock': 'lockOpen',
  'visible': 'eye',
  'hidden': 'eyeOff',
  'show': 'eye',
  'hide': 'eyeOff',
  'play': 'play',
  'pause': 'pause',
  'stop': 'square',
  'record': 'circle',
  'volume': 'volume2',
  'mute': 'volumeX',
  'fullscreen': 'maximize',
  'exitFullscreen': 'minimize',
  'zoomIn': 'zoomIn',
  'zoomOut': 'zoomOut',
  'calendar': 'calendar',
  'date': 'calendar',
  'time': 'clock',
  'timer': 'timer',
  'alarm': 'alarmClock',
  'location': 'mapPin',
  'pin': 'mapPin',
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
  'document': 'fileText',
  'folder': 'folder',
  'directory': 'folder',
  'print': 'printer',
  'export': 'fileOutput',

  // Backwards compatibility aliases for renamed icons
  'key': 'keyIcon',
  'factory': 'factoryIcon',
  'target': 'targetIcon',
  'map': 'mapIcon',
  'contrast': 'contrastIcon',
  'moreHorizontal': 'ellipsis',
  'moreVertical': 'ellipsisVertical',
  'filter': 'funnel',
  'sort': 'arrowUpDown',
};

/// Icons that need manual name adjustments
const nameOverrides = <String, String>{
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

/// Convert snake_case to PascalCase (for Lucide class names)
String snakeToPascal(String snake) {
  // Check for special class name overrides first
  if (classNameOverrides.containsKey(snake)) {
    return classNameOverrides[snake]!;
  }

  return snake.split('_').map((part) {
    if (part.isEmpty) return '';

    // Check for special abbreviations first (AZ/ZA for sorting icons)
    final lower = part.toLowerCase();
    if (upperAbbreviations.containsKey(lower)) {
      return upperAbbreviations[lower]!;
    }

    // Handle numeric parts
    if (RegExp(r'^\d').hasMatch(part)) {
      return part;
    }
    return part[0].toUpperCase() + part.substring(1).toLowerCase();
  }).join();
}

/// Convert snake_case to camelCase (for method names)
String snakeToCamel(String snake) {
  // Remove trailing underscore for method naming
  var cleanSnake = snake.endsWith('_') ? snake.substring(0, snake.length - 1) : snake;

  final parts = cleanSnake.split('_');
  final buffer = StringBuffer();

  for (var i = 0; i < parts.length; i++) {
    var part = parts[i];
    if (part.isEmpty) continue;

    // Check for special abbreviations (AZ/ZA)
    final lower = part.toLowerCase();
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
String getMethodName(String snakeName) {
  final camel = snakeToCamel(snakeName);

  // Check for overrides first
  if (nameOverrides.containsKey(snakeName)) {
    return nameOverrides[snakeName]!;
  }

  // Check if it's a reserved word
  if (dartReservedWords.contains(camel)) {
    return '${camel}Icon';
  }

  return camel;
}

void main() async {
  // Read icon names from jaspr_lucide exports
  final pubCacheDir = Platform.environment['HOME']! + '/.pub-cache/hosted/pub.dev';
  final lucideDir = Directory(pubCacheDir)
      .listSync()
      .whereType<Directory>()
      .firstWhere((d) => d.path.contains('jaspr_lucide'));

  final jasperLucideFile = File('${lucideDir.path}/lib/jaspr_lucide.dart');
  final content = await jasperLucideFile.readAsString();

  // Extract icon names from exports
  final exportRegex = RegExp(r"export 'generated_icons/(.+)\.dart';");
  final iconNames = exportRegex
      .allMatches(content)
      .map((m) => m.group(1)!)
      .toList()
    ..sort();

  print('Found ${iconNames.length} icons');

  // Group icons by category (based on common prefixes)
  final categories = <String, List<String>>{};
  for (final name in iconNames) {
    String category = 'misc';

    if (name.startsWith('arrow')) category = 'arrows';
    else if (name.startsWith('chevron')) category = 'chevrons';
    else if (name.startsWith('circle')) category = 'circles';
    else if (name.startsWith('square')) category = 'squares';
    else if (name.startsWith('file')) category = 'files';
    else if (name.startsWith('folder')) category = 'folders';
    else if (name.startsWith('user')) category = 'users';
    else if (name.startsWith('calendar')) category = 'calendar';
    else if (name.startsWith('clock')) category = 'time';
    else if (name.startsWith('chart')) category = 'charts';
    else if (name.startsWith('align')) category = 'alignment';
    else if (name.startsWith('badge')) category = 'badges';
    else if (name.startsWith('book')) category = 'books';
    else if (name.startsWith('box')) category = 'boxes';
    else if (name.startsWith('cloud')) category = 'cloud';
    else if (name.startsWith('code')) category = 'code';
    else if (name.startsWith('git')) category = 'git';
    else if (name.startsWith('layout')) category = 'layout';
    else if (name.startsWith('list')) category = 'lists';
    else if (name.startsWith('log')) category = 'auth';
    else if (name.startsWith('mail')) category = 'mail';
    else if (name.startsWith('message')) category = 'messages';
    else if (name.startsWith('panel')) category = 'panels';
    else if (name.startsWith('shield')) category = 'security';
    else if (name.startsWith('text')) category = 'text';
    else if (name.startsWith('toggle')) category = 'toggles';

    categories.putIfAbsent(category, () => []).add(name);
  }

  // Generate the Dart file
  final buffer = StringBuffer();

  buffer.writeln('''
// GENERATED FILE - DO NOT EDIT MANUALLY
// Generated by tool/generate_icons.dart
// Wraps all ${iconNames.length} Lucide icons with a clean API

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' show Unit;
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;

/// Icon size presets for consistent sizing across the app
enum IconSize {
  /// 12px - Tiny indicators, badges
  xs,
  /// 16px - Inline, compact UI, small buttons
  sm,
  /// 20px - Default size for most UI elements
  md,
  /// 24px - Prominent icons, large buttons
  lg,
  /// 32px - Hero sections, feature highlights
  xl,
  /// 48px - Large displays, marketing sections
  xl2,
}

/// Extension to convert IconSize to pixel values
extension IconSizeExtension on IconSize {
  /// Get the pixel value for this size
  double get pixels => switch (this) {
        IconSize.xs => 12,
        IconSize.sm => 16,
        IconSize.md => 20,
        IconSize.lg => 24,
        IconSize.xl => 32,
        IconSize.xl2 => 48,
      };

  /// Get as Unit for jaspr_lucide icons
  Unit get unit => Unit.pixels(pixels);
}

/// Wrapper class providing a clean, discoverable API for all ${iconNames.length} Lucide icons.
///
/// Instead of using confusing raw icon constructors like `House()` or `Search()`,
/// use this class for clarity and discoverability:
///
/// ```dart
/// ArcaneIcon.home()
/// ArcaneIcon.search(size: IconSize.lg)
/// ArcaneIcon.settings()
/// ```
///
/// All methods accept an optional [size] parameter (default: IconSize.md = 20px).
///
/// For the complete icon catalog, visit: https://lucide.dev/icons
class ArcaneIcon {
  ArcaneIcon._();
''');

  // Generate methods for each icon
  for (final name in iconNames) {
    final methodName = getMethodName(name);
    final className = snakeToPascal(name);

    buffer.writeln('''
  /// $className icon
  static Component $methodName({IconSize size = IconSize.md}) =>
      lucide.$className(width: size.unit, height: size.unit);
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
  for (final entry in semanticAliases.entries) {
    final aliasName = entry.key;
    final targetName = entry.value;

    // Skip if alias would conflict with an existing method
    final existingMethods = iconNames.map((n) => getMethodName(n)).toSet();
    if (existingMethods.contains(aliasName)) {
      continue;
    }

    buffer.writeln('''
  /// Alias for [$targetName] - semantic name for common use case
  static Component $aliasName({IconSize size = IconSize.md}) =>
      $targetName(size: size);
''');
  }

  buffer.writeln('}');

  // Write the generated file
  final outputFile = File('lib/component/view/icon.dart');
  await outputFile.writeAsString(buffer.toString());

  print('Generated ${outputFile.path} with ${iconNames.length} icons');
  print('Categories: ${categories.keys.join(', ')}');
}
