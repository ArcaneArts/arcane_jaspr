import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'scripts/slider_scripts.dart';
import 'scripts/input/input_scripts.dart';
import 'scripts/button/button_scripts.dart';
import 'scripts/navigation/navigation_scripts.dart';
import 'scripts/dialog/dialog_scripts.dart';

/// Provides fallback JavaScript for Arcane components on static sites.
///
/// When Jaspr client hydration is unavailable (static site generation),
/// these scripts provide interactivity for Arcane components.
///
/// Usage: Include [ArcaneScriptsComponent] once in your app, or use
/// [ArcaneApp] which includes it automatically.
///
/// ## Modular Script Organization
///
/// Scripts are organized into categories for maintainability:
/// - [SliderScripts] - Range sliders
/// - [InputScripts] - Checkboxes, toggles, color pickers, file uploads, etc.
/// - [ButtonScripts] - Buttons, toggle buttons, cycle buttons, theme toggles
/// - [NavigationScripts] - Tabs, accordions, dropdowns, tree views, pagination
/// - [DialogScripts] - Dialogs, toasts, popovers, tooltips, drawers
class ArcaneScripts {
  ArcaneScripts._();

  /// Complete fallback script for all Arcane components.
  ///
  /// This script:
  /// 1. Waits for DOM to be ready
  /// 2. Binds interactive handlers to all Arcane components
  /// 3. Uses dataset markers to prevent double-binding
  static String get all => '''
(function() {
  'use strict';

  // Wait for DOM to be ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindAllComponents);
  } else {
    // Small delay to ensure DOM is fully rendered
    setTimeout(bindAllComponents, 100);
  }

  function bindAllComponents() {
    console.log('[Arcane] Initializing component interactivity...');

    // Sliders
    bindSliders();

    // Inputs
    bindColorInputs();
    bindCheckboxes();
    bindToggleSwitches();
    bindRadioButtons();
    bindNumberInputs();
    bindTagInputs();
    bindFileUploads();
    bindMutableText();
    bindOtpInputs();
    bindComboboxes();
    bindCalendars();
    bindDatePickers();

    // Buttons
    bindToggleButtonGroups();
    bindCycleButtons();
    bindToggleButtons();
    bindButtons();
    bindThemeToggles();

    // Navigation
    bindTabs();
    bindExpandersAccordions();
    bindDropdowns();
    bindSelectors();
    bindTreeViews();
    bindPagination();
    bindChips();
    bindBackToTop();
    bindContextMenus();
    bindMenubars();
    bindResizables();
    bindCommandPalettes();
    bindSteps();
    bindTimelines();

    // Dialogs & Overlays
    bindToasts();
    bindPopovers();
    bindTooltips();
    bindDialogs();
    bindDrawers();
    bindMobileMenus();
  }

  ${SliderScripts.code}
  ${InputScripts.code}
  ${ButtonScripts.code}
  ${NavigationScripts.code}
  ${DialogScripts.code}
})();
''';
}

/// Component that injects Arcane fallback scripts into the page.
///
/// Include this once in your app (or use [ArcaneApp] which includes it automatically)
/// to enable interactivity on static sites.
///
/// ## Example
///
/// ```dart
/// // Manually include scripts
/// Fragment(children: [
///   MyApp(),
///   const ArcaneScriptsComponent(),
/// ])
///
/// // Or use ArcaneApp which includes it automatically
/// ArcaneApp(
///   theme: ArcaneTheme.green,
///   child: MyApp(),
/// )
/// ```
class ArcaneScriptsComponent extends StatelessComponent {
  const ArcaneScriptsComponent({super.key});

  @override
  Component build(BuildContext context) {
    return dom.script(content: ArcaneScripts.all);
  }
}
