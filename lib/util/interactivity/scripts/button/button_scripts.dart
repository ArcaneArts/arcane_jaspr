/// Button interactivity scripts barrel file.
///
/// Aggregates all button-related scripts for use in static sites.
library;

import 'button_feedback_scripts.dart';
import 'cycle_button_scripts.dart';
import 'theme_toggle_scripts.dart';
import 'toggle_button_group_scripts.dart';
import 'toggle_button_scripts.dart';

export 'button_feedback_scripts.dart';
export 'cycle_button_scripts.dart';
export 'theme_toggle_scripts.dart';
export 'toggle_button_group_scripts.dart';
export 'toggle_button_scripts.dart';

/// Combined button scripts for backward compatibility.
class ButtonScripts {
  ButtonScripts._();

  static String get code => '''
${ThemeToggleScripts.code}
${ToggleButtonGroupScripts.code}
${CycleButtonScripts.code}
${ToggleButtonScripts.code}
${ButtonFeedbackScripts.code}
''';
}
