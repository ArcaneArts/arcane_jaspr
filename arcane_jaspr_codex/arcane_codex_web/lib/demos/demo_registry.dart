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
        return InputDemos.search();
      case 'select':
        return InputDemos.select();
      case 'checkbox':
        return InputDemos.checkbox();
      case 'radio':
        return InputDemos.radio();
      case 'toggle-switch':
        return InputDemos.toggleSwitch();
      case 'slider':
        return InputDemos.slider();
      case 'range-slider':
        return InputDemos.rangeSlider();
      case 'toggle-button':
        return InputDemos.toggleButton();
      case 'toggle-button-group':
        return InputDemos.toggleButtonGroup();
      case 'cycle-button':
        return InputDemos.cycleButton();
      case 'selector':
        return InputDemos.selector();
      case 'theme-toggle':
        return InputDemos.themeToggle(isDark, onThemeToggle);

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
        return ViewDemos.progressBar();
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
        return ViewDemos.accordion();
      case 'toast':
        return ViewDemos.toast();

      // Navigation components
      case 'header':
        return NavigationDemos.header();
      case 'sidebar':
        return NavigationDemos.sidebar();
      case 'bottom-nav':
        return NavigationDemos.bottomNav();
      case 'dropdown-menu':
        return NavigationDemos.dropdownMenu();
      case 'mobile-menu':
        return NavigationDemos.mobileMenu();
      case 'mega-menu':
        return NavigationDemos.megaMenu();

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
