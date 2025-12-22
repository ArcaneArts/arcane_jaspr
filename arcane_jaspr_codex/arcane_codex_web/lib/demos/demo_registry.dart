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

// Interactive demos
import 'interactive/input_interactive.dart';
import 'interactive/view_interactive.dart';
import 'interactive/navigation_interactive.dart';

/// Central registry for component demos
/// Maps component types to their demo builders
class DemoRegistry {
  final bool isDark;
  final VoidCallback onThemeToggle;

  const DemoRegistry({
    required this.isDark,
    required this.onThemeToggle,
  });

  /// Get demo components for a given component type
  List<Component> getDemo(String componentType) {
    switch (componentType) {
      // Input components
      case 'button':
        return InputDemos.button();
      case 'icon-button':
        return InputDemos.iconButton();
      case 'close-button':
        return InputDemos.closeButton();
      case 'fab':
        return InputDemos.fab();
      case 'text-input':
        return InputDemos.textInput();
      case 'text-area':
        return InputDemos.textArea();
      case 'search':
        return [const SearchDemo()];
      case 'select':
        return [const SelectDemo()];
      case 'checkbox':
        return [const CheckboxDemo()];
      case 'radio':
        return [const RadioDemo()];
      case 'toggle-switch':
        return [const ToggleSwitchDemo()];
      case 'slider':
        return [const SliderDemo()];
      case 'range-slider':
        return [const RangeSliderDemo()];
      case 'toggle-button':
        return [const ToggleButtonDemo()];
      case 'toggle-button-group':
        return [const ToggleButtonGroupDemo()];
      case 'cycle-button':
        return [const CycleButtonDemo()];
      case 'selector':
        return [const SelectorDemo()];
      case 'theme-toggle':
        return InputDemos.themeToggle(isDark, onThemeToggle);
      case 'tag-input':
        return [const TagInputDemo()];
      case 'number-input':
        return [const NumberInputDemo()];
      case 'file-upload':
        return InputDemos.fileUpload();
      case 'color-input':
        return [const ColorInputDemo()];

      // Layout components
      case 'div':
        return LayoutDemos.div();
      case 'row':
        return LayoutDemos.row();
      case 'column':
        return LayoutDemos.column();
      case 'container':
        return LayoutDemos.container();
      case 'section':
        return LayoutDemos.section();
      case 'box':
        return LayoutDemos.box();
      case 'center':
        return LayoutDemos.center();
      case 'flow':
        return LayoutDemos.flow();
      case 'spacer':
        return LayoutDemos.spacer();
      case 'expanded':
        return LayoutDemos.expanded();
      case 'stack':
        return LayoutDemos.stack();
      case 'positioned':
        return LayoutDemos.positioned();
      case 'padding':
        return LayoutDemos.padding();
      case 'gutter':
        return LayoutDemos.gutter();
      case 'card':
        return LayoutDemos.card();
      case 'tabs':
        return LayoutDemos.tabs();
      case 'tile':
        return LayoutDemos.tile();
      case 'button-group':
        return LayoutDemos.buttonGroup();
      case 'hero-section':
        return LayoutDemos.heroSection();
      case 'footer':
        return LayoutDemos.footer();
      case 'auth-layout':
        return LayoutDemos.authLayout();
      case 'dashboard-layout':
        return LayoutDemos.dashboardLayout();
      case 'page-body':
        return LayoutDemos.pageBody();
      case 'drawer':
        return [const DrawerDemo()];

      // Typography components
      case 'text':
        return TypographyDemos.text();
      case 'heading':
        return TypographyDemos.heading();
      case 'headline':
        return TypographyDemos.headline();
      case 'subheadline':
        return TypographyDemos.subheadline();
      case 'paragraph':
        return TypographyDemos.paragraph();
      case 'span':
        return TypographyDemos.span();
      case 'gradient-text':
        return TypographyDemos.gradientText();
      case 'glow-text':
        return TypographyDemos.glowText();
      case 'rich-text':
        return TypographyDemos.richText();
      case 'code-snippet':
        return TypographyDemos.codeSnippet();
      case 'inline-code':
        return TypographyDemos.inlineCode();
      case 'pre':
        return TypographyDemos.pre();

      // View components
      case 'avatar':
        return ViewDemos.avatar();
      case 'badge':
        return ViewDemos.badge();
      case 'chip':
        return ViewDemos.chip();
      case 'divider':
        return ViewDemos.divider();
      case 'progress-bar':
        return [const ProgressBarDemo()];
      case 'loader':
        return ViewDemos.loader();
      case 'skeleton':
        return ViewDemos.skeleton();
      case 'empty-state':
        return ViewDemos.emptyState();
      case 'data-table':
        return ViewDemos.dataTable();
      case 'timeline':
        return ViewDemos.timeline();
      case 'feature-card':
        return ViewDemos.featureCard();
      case 'tooltip':
        return ViewDemos.tooltip();
      case 'accordion':
        return [const AccordionDemo()];
      case 'toast':
        return [const ToastDemo()];
      case 'callout':
        return ViewDemos.callout();
      case 'kbd':
        return ViewDemos.kbd();
      case 'meter':
        return [const MeterDemo()];
      case 'alert':
        return ViewDemos.alert();
      case 'inline-tabs':
        return [const TabBarDemo()];
      case 'tree-view':
        return [const TreeViewDemo()];
      case 'popover':
        return ViewDemos.popover();
      case 'icon':
        return ViewDemos.icon();

      // Navigation components
      case 'header':
        return NavigationDemos.header();
      case 'sidebar':
        return [const SidebarDemo()];
      case 'bottom-nav':
        return [const BottomNavDemo()];
      case 'dropdown-menu':
        return NavigationDemos.dropdownMenu();
      case 'mobile-menu':
        return NavigationDemos.mobileMenu();
      case 'mega-menu':
        return NavigationDemos.megaMenu();
      case 'breadcrumbs':
        return NavigationDemos.breadcrumbs();
      case 'pagination':
        return [const PaginationDemo()];

      // Feedback components
      case 'dialog':
        return FeedbackDemos.dialog();
      case 'alert-banner':
        return FeedbackDemos.alertBanner();

      // Form components
      case 'form':
        return FormDemos.form();
      case 'field':
        return FormDemos.field();
      case 'field-wrapper':
        return FormDemos.fieldWrapper();

      // Screen components
      case 'screen':
        return ScreenDemos.screen();

      // Authentication components
      case 'login-card':
        return AuthDemos.loginCard();
      case 'signup-card':
        return AuthDemos.signupCard();
      case 'forgot-password-card':
        return AuthDemos.forgotPasswordCard();
      case 'github-button':
        return AuthDemos.githubButton();
      case 'google-button':
        return AuthDemos.googleButton();
      case 'apple-button':
        return AuthDemos.appleButton();
      case 'auth-split-layout':
        return AuthDemos.authSplitLayout();
      case 'auth-branding-panel':
        return AuthDemos.authBrandingPanel();
      case 'password-policy':
        return AuthDemos.passwordPolicy();

      // Style Reference demos
      case 'display':
        return StyleDemos.display();
      case 'spacing':
        return StyleDemos.spacing();
      case 'typography-styles':
        return StyleDemos.typography();
      case 'colors':
        return StyleDemos.colors();
      case 'borders':
        return StyleDemos.borders();
      case 'effects':
        return StyleDemos.effects();

      default:
        return [
          ArcaneDiv(
            styles: const ArcaneStyleData(
              textColor: TextColor.muted,
              fontStyle: FontStyle.italic,
            ),
            children: [ArcaneText('Demo coming soon...')],
          ),
        ];
    }
  }
}
