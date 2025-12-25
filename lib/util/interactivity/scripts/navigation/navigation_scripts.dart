/// Navigation component interactivity scripts barrel file.
///
/// Aggregates all navigation-related scripts for use in static sites.
library;

import 'tabs_scripts.dart';
import 'accordion_scripts.dart';
import 'dropdown_scripts.dart';
import 'selector_scripts.dart';
import 'tree_view_scripts.dart';
import 'pagination_scripts.dart';
import 'chip_scripts.dart';
import 'back_to_top_scripts.dart';
import 'context_menu_scripts.dart';
import 'menubar_scripts.dart';
import 'resizable_scripts.dart';
import 'command_palette_scripts.dart';
import 'steps_scripts.dart';
import 'timeline_scripts.dart';

export 'tabs_scripts.dart';
export 'accordion_scripts.dart';
export 'dropdown_scripts.dart';
export 'selector_scripts.dart';
export 'tree_view_scripts.dart';
export 'pagination_scripts.dart';
export 'chip_scripts.dart';
export 'back_to_top_scripts.dart';
export 'context_menu_scripts.dart';
export 'menubar_scripts.dart';
export 'resizable_scripts.dart';
export 'command_palette_scripts.dart';
export 'steps_scripts.dart';
export 'timeline_scripts.dart';

/// Combined navigation scripts for backward compatibility.
class NavigationScripts {
  NavigationScripts._();

  static String get code => '''
${TabsScripts.code}
${AccordionScripts.code}
${DropdownScripts.code}
${SelectorScripts.code}
${TreeViewScripts.code}
${PaginationScripts.code}
${ChipScripts.code}
${BackToTopScripts.code}
${ContextMenuScripts.code}
${MenubarScripts.code}
${ResizableScripts.code}
${CommandPaletteScripts.code}
${StepsScripts.code}
${TimelineScripts.code}
''';
}
