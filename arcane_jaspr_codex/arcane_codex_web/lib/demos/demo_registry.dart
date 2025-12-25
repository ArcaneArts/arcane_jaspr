import 'package:arcane_jaspr/arcane_jaspr.dart';

import 'input_demos.dart';
import 'layout_demos.dart';
import 'typography_demos.dart';
import 'view_demos.dart';
import 'navigation_demos.dart';
import 'feedback_demos.dart';
import 'form_demos.dart';
import 'screen_demos.dart';
import 'auth_demos.dart';
import 'style_demos.dart';
import 'concept_demos.dart';

// Interactive demos
import 'interactive/input_interactive.dart';
import 'interactive/view_interactive.dart';
import 'interactive/navigation_interactive.dart';

/// Type alias for demo builder functions
typedef DemoBuilder = List<Component> Function();

/// Type alias for contextual demo builders (need theme state)
typedef ContextualDemoBuilder = List<Component> Function(bool isDark, VoidCallback onThemeToggle);

/// Central registry for component demos
/// Uses Map-based lookup instead of switch statement for better maintainability
class DemoRegistry {
  final bool isDark;
  final VoidCallback onThemeToggle;

  const DemoRegistry({
    required this.isDark,
    required this.onThemeToggle,
  });

  /// Static demos that don't require context
  static final Map<String, DemoBuilder> _staticDemos = {
    // Input components
    'button': InputDemos.button,
    'icon-button': InputDemos.iconButton,
    'close-button': InputDemos.closeButton,
    'fab': InputDemos.fab,
    'text-input': InputDemos.textInput,
    'text-area': InputDemos.textArea,
    'file-upload': InputDemos.fileUpload,
    'search-bar': InputDemos.searchBar,

    // Layout components
    'div': LayoutDemos.div,
    'row': LayoutDemos.row,
    'column': LayoutDemos.column,
    'container': LayoutDemos.container,
    'section': LayoutDemos.section,
    'box': LayoutDemos.box,
    'center': LayoutDemos.center,
    'flow': LayoutDemos.flow,
    'spacer': LayoutDemos.spacer,
    'expanded': LayoutDemos.expanded,
    'stack': LayoutDemos.stack,
    'positioned': LayoutDemos.positioned,
    'padding': LayoutDemos.padding,
    'gutter': LayoutDemos.gutter,
    'card': LayoutDemos.card,
    'tabs': LayoutDemos.tabs,
    'tile': LayoutDemos.tile,
    'button-group': LayoutDemos.buttonGroup,
    'hero-section': LayoutDemos.heroSection,
    'footer': LayoutDemos.footer,
    'auth-layout': LayoutDemos.authLayout,
    'dashboard-layout': LayoutDemos.dashboardLayout,
    'page-body': LayoutDemos.pageBody,
    'aspect-ratio': LayoutDemos.aspectRatio,
    'resizable': LayoutDemos.resizable,

    // Typography components
    'text': TypographyDemos.text,
    'heading': TypographyDemos.heading,
    'headline': TypographyDemos.headline,
    'subheadline': TypographyDemos.subheadline,
    'paragraph': TypographyDemos.paragraph,
    'span': TypographyDemos.span,
    'gradient-text': TypographyDemos.gradientText,
    'glow-text': TypographyDemos.glowText,
    'rich-text': TypographyDemos.richText,
    'code-snippet': TypographyDemos.codeSnippet,
    'inline-code': TypographyDemos.inlineCode,
    'pre': TypographyDemos.pre,

    // View components
    'avatar': ViewDemos.avatar,
    'badge': ViewDemos.badge,
    'chip': ViewDemos.chip,
    'divider': ViewDemos.divider,
    'loader': ViewDemos.loader,
    'skeleton': ViewDemos.skeleton,
    'empty-state': ViewDemos.emptyState,
    'data-table': ViewDemos.dataTable,
    'feature-card': ViewDemos.featureCard,
    'callout': ViewDemos.callout,
    'kbd': ViewDemos.kbd,
    'alert': ViewDemos.alert,
    'icon': ViewDemos.icon,
    'svg': ViewDemos.svg,

    // Navigation components
    'header': NavigationDemos.header,
    'breadcrumbs': NavigationDemos.breadcrumbs,

    // Feedback components
    'dialog': FeedbackDemos.dialog,
    'alert-banner': FeedbackDemos.alertBanner,

    // Form components
    'form': FormDemos.form,
    'field': FormDemos.field,
    'field-wrapper': FormDemos.fieldWrapper,

    // Screen components
    'screen': ScreenDemos.screen,

    // Authentication components
    'login-card': AuthDemos.loginCard,
    'signup-card': AuthDemos.signupCard,
    'forgot-password-card': AuthDemos.forgotPasswordCard,
    'social-buttons': AuthDemos.socialButtons,
    'github-button': AuthDemos.githubButton,
    'google-button': AuthDemos.googleButton,
    'apple-button': AuthDemos.appleButton,
    'auth-split-layout': AuthDemos.authSplitLayout,
    'auth-branding-panel': AuthDemos.authBrandingPanel,
    'password-policy': AuthDemos.passwordPolicy,

    // Style Reference demos
    'display': StyleDemos.display,
    'spacing': StyleDemos.spacing,
    'typography-styles': StyleDemos.typography,
    'colors': StyleDemos.colors,
    'borders': StyleDemos.borders,
    'effects': StyleDemos.effects,

    // Concept demos
    'aliases': ConceptDemos.aliases,
    'styling': ConceptDemos.styling,
    'theming': ConceptDemos.theming,
    'tokens': ConceptDemos.tokens,
  };

  /// Interactive component demos (stateful widgets)
  static final Map<String, Component> _interactiveDemos = {
    // Input interactive
    'search': const SearchDemo(),
    'select': const SelectDemo(),
    'checkbox': const CheckboxDemo(),
    'radio': const RadioDemo(),
    'toggle-switch': const ToggleSwitchDemo(),
    'slider': const SliderDemo(),
    'range-slider': const RangeSliderDemo(),
    'toggle-button': const ToggleButtonDemo(),
    'toggle-button-group': const ToggleButtonGroupDemo(),
    'cycle-button': const CycleButtonDemo(),
    'selector': const SelectorDemo(),
    'tag-input': const TagInputDemo(),
    'number-input': const NumberInputDemo(),
    'color-input': const ColorInputDemo(),
    'mutable-text': const MutableTextDemo(),
    'radio-group': const RadioGroupDemo(),
    'otp-input': const OtpInputDemo(),
    'combobox': const ComboboxDemo(),
    'calendar': const CalendarDemo(),
    'date-picker': const DatePickerDemo(),

    // View interactive
    'progress-bar': const ProgressBarDemo(),
    'tooltip': const TooltipDemo(),
    'accordion': const AccordionDemo(),
    'toast': const ToastDemo(),
    'meter': const MeterDemo(),
    'inline-tabs': const TabBarDemo(),
    'tree-view': const TreeViewDemo(),
    'popover': const PopoverDemo(),
    'hovercard': const HovercardDemo(),
    'expander': const ExpanderDemo(),
    'separator': const SeparatorDemo(),
    'scroll-area': const ScrollAreaDemo(),
    'timeline': const TimelineDemo(),
    'steps': const StepsDemo(),

    // Navigation interactive
    'drawer': const DrawerDemo(),
    'sidebar': const SidebarDemo(),
    'bottom-nav': const BottomNavDemo(),
    'dropdown-menu': const DropdownMenuDemo(),
    'mobile-menu': const MobileMenuDemo(),
    'mega-menu': const MegaMenuDemo(),
    'pagination': const PaginationDemo(),
    'context-menu': const ContextMenuDemo(),
    'menubar': const MenubarDemo(),
    'command': const CommandDemo(),
  };

  /// Contextual demos that need theme state
  static const Map<String, ContextualDemoBuilder> _contextualDemos = {
    'theme-toggle': InputDemos.themeToggle,
  };

  /// Default placeholder for missing demos
  static List<Component> _defaultDemo() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            textColor: TextColor.muted,
            fontStyle: FontStyle.italic,
          ),
          children: [ArcaneText('Demo coming soon...')],
        ),
      ];

  /// Get demo components for a given component type
  List<Component> getDemo(String componentType) {
    // Check static demos first (most common)
    final staticBuilder = _staticDemos[componentType];
    if (staticBuilder != null) {
      return staticBuilder();
    }

    // Check interactive demos
    final interactiveDemo = _interactiveDemos[componentType];
    if (interactiveDemo != null) {
      return [interactiveDemo];
    }

    // Check contextual demos
    final contextualBuilder = _contextualDemos[componentType];
    if (contextualBuilder != null) {
      return contextualBuilder(isDark, onThemeToggle);
    }

    // Fallback
    return _defaultDemo();
  }

  /// Check if a demo exists for a component type
  static bool hasDemo(String componentType) {
    return _staticDemos.containsKey(componentType) ||
        _interactiveDemos.containsKey(componentType) ||
        _contextualDemos.containsKey(componentType);
  }

  /// Get all registered component types
  static Set<String> get allComponentTypes => {
        ..._staticDemos.keys,
        ..._interactiveDemos.keys,
        ..._contextualDemos.keys,
      };
}
