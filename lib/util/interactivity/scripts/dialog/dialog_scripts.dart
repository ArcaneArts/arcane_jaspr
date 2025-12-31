/// Dialog and overlay interactivity scripts barrel file.
///
/// Aggregates all dialog-related scripts for use in static sites.
library;

import 'chat_scripts.dart';
import 'drawer_scripts.dart';
import 'email_dialog_scripts.dart';
import 'item_picker_scripts.dart';
import 'mobile_menu_scripts.dart';
import 'modal_scripts.dart';
import 'popover_scripts.dart';
import 'sheet_scripts.dart';
import 'time_dialog_scripts.dart';
import 'toast_scripts.dart';
import 'tooltip_scripts.dart';

export 'chat_scripts.dart';
export 'drawer_scripts.dart';
export 'email_dialog_scripts.dart';
export 'item_picker_scripts.dart';
export 'mobile_menu_scripts.dart';
export 'modal_scripts.dart';
export 'popover_scripts.dart';
export 'sheet_scripts.dart';
export 'time_dialog_scripts.dart';
export 'toast_scripts.dart';
export 'tooltip_scripts.dart';

/// Combined dialog scripts for backward compatibility.
class DialogScripts {
  DialogScripts._();

  static String get code => '''
${ToastScripts.code}
${PopoverScripts.code}
${TooltipScripts.code}
${ModalScripts.code}
${DrawerScripts.code}
${MobileMenuScripts.code}
${SheetScripts.code}
${EmailDialogScripts.code}
${TimeDialogScripts.code}
${ItemPickerScripts.code}
${ChatScripts.code}
''';
}
