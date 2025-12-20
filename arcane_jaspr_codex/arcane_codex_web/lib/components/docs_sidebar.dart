import 'package:arcane_jaspr/arcane_jaspr.dart';

import '../utils/constants.dart';

/// Documentation sidebar with navigation groups
class DocsSidebar extends StatelessComponent {
  final String currentPath;

  const DocsSidebar({
    super.key,
    required this.currentPath,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneAside(
      styles: const ArcaneStyleData(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        widthCustom: '280px',
        minHeight: '100vh',
        flexShrink: 0,
        raw: {
          'background': 'var(--background-secondary)',
          'border-right': '1px solid var(--border-primary)',
        },
      ),
      children: [
        // Header
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.lg,
            borderBottom: BorderPreset.subtle,
          ),
          children: [
            a(
              href: '/',
              [
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.lg,
                    textColor: TextColor.primary,
                  ),
                  children: [ArcaneText(AppConstants.siteName)],
                ),
              ],
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.sm,
                textColor: TextColor.muted,
              ),
              children: [const ArcaneText('Documentation')],
            ),
          ],
        ),

        // Navigation
        ArcaneNav(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            flexGrow: 1,
            overflowY: OverflowAxis.auto,
          ),
          children: [
            // Getting Started section
            _buildNavSection('Getting Started', [
              _buildNavItem(label: 'Introduction', href: '/docs'),
              _buildNavItem(label: 'Installation', href: '/docs/installation'),
              _buildNavItem(label: 'Quick Start', href: '/docs/quick-start'),
            ]),

            // Core Concepts section
            _buildNavSection('Core Concepts', [
              _buildNavItem(label: 'Theming', href: '/docs/concepts/theming'),
              _buildNavItem(label: 'Styling', href: '/docs/concepts/styling'),
              _buildNavItem(label: 'Design Tokens', href: '/docs/concepts/tokens'),
            ]),

            // Style Reference section
            _buildNavSection('Style Reference', [
              _buildNavItem(label: 'Display & Layout', href: '/docs/styles/display'),
              _buildNavItem(label: 'Spacing', href: '/docs/styles/spacing'),
              _buildNavItem(label: 'Typography', href: '/docs/styles/typography'),
              _buildNavItem(label: 'Colors', href: '/docs/styles/colors'),
              _buildNavItem(label: 'Borders', href: '/docs/styles/borders'),
              _buildNavItem(label: 'Effects', href: '/docs/styles/effects'),
            ]),

            // Input Components section
            _buildNavSection('Inputs', [
              _buildNavItem(label: 'ArcaneButton', href: '/docs/inputs/arcane-button'),
              _buildNavItem(label: 'ArcaneIconButton', href: '/docs/inputs/arcane-icon-button'),
              _buildNavItem(label: 'ArcaneCloseButton', href: '/docs/inputs/arcane-close-button'),
              _buildNavItem(label: 'ArcaneFAB', href: '/docs/inputs/arcane-fab'),
              _buildNavItem(label: 'ArcaneTextInput', href: '/docs/inputs/arcane-text-input'),
              _buildNavItem(label: 'ArcaneTextArea', href: '/docs/inputs/arcane-text-area'),
              _buildNavItem(label: 'ArcaneSearch', href: '/docs/inputs/arcane-search'),
              _buildNavItem(label: 'ArcaneSelect', href: '/docs/inputs/arcane-select'),
              _buildNavItem(label: 'ArcaneCheckbox', href: '/docs/inputs/arcane-checkbox'),
              _buildNavItem(label: 'ArcaneRadio', href: '/docs/inputs/arcane-radio'),
              _buildNavItem(label: 'ArcaneToggleSwitch', href: '/docs/inputs/arcane-toggle-switch'),
              _buildNavItem(label: 'ArcaneSlider', href: '/docs/inputs/arcane-slider'),
              _buildNavItem(label: 'ArcaneRangeSlider', href: '/docs/inputs/arcane-range-slider'),
              _buildNavItem(label: 'ArcaneToggleButton', href: '/docs/inputs/arcane-toggle-button'),
              _buildNavItem(label: 'ArcaneToggleButtonGroup', href: '/docs/inputs/arcane-toggle-button-group'),
              _buildNavItem(label: 'ArcaneCycleButton', href: '/docs/inputs/arcane-cycle-button'),
              _buildNavItem(label: 'ArcaneSelector', href: '/docs/inputs/arcane-selector'),
              _buildNavItem(label: 'ArcaneThemeToggle', href: '/docs/inputs/arcane-theme-toggle'),
            ]),

            // Layout Components section
            _buildNavSection('Layout', [
              _buildNavItem(label: 'ArcaneDiv', href: '/docs/layout/arcane-div'),
              _buildNavItem(label: 'ArcaneRow', href: '/docs/layout/arcane-row'),
              _buildNavItem(label: 'ArcaneColumn', href: '/docs/layout/arcane-column'),
              _buildNavItem(label: 'ArcaneContainer', href: '/docs/layout/arcane-container'),
              _buildNavItem(label: 'ArcaneSection', href: '/docs/layout/arcane-section'),
              _buildNavItem(label: 'ArcaneBox', href: '/docs/layout/arcane-box'),
              _buildNavItem(label: 'ArcaneCenter', href: '/docs/layout/arcane-center'),
              _buildNavItem(label: 'ArcaneFlow', href: '/docs/layout/arcane-flow'),
              _buildNavItem(label: 'ArcaneSpacer', href: '/docs/layout/arcane-spacer'),
              _buildNavItem(label: 'ArcaneExpanded', href: '/docs/layout/arcane-expanded'),
              _buildNavItem(label: 'ArcaneStack', href: '/docs/layout/arcane-stack'),
              _buildNavItem(label: 'ArcanePositioned', href: '/docs/layout/arcane-positioned'),
              _buildNavItem(label: 'ArcanePadding', href: '/docs/layout/arcane-padding'),
              _buildNavItem(label: 'ArcaneGutter', href: '/docs/layout/arcane-gutter'),
              _buildNavItem(label: 'ArcaneCard', href: '/docs/layout/arcane-card'),
              _buildNavItem(label: 'ArcaneTabs', href: '/docs/layout/arcane-tabs'),
              _buildNavItem(label: 'ArcaneTile', href: '/docs/layout/arcane-tile'),
              _buildNavItem(label: 'ArcaneButtonGroup', href: '/docs/layout/arcane-button-group'),
              _buildNavItem(label: 'ArcaneHeroSection', href: '/docs/layout/arcane-hero-section'),
              _buildNavItem(label: 'ArcaneFooter', href: '/docs/layout/arcane-footer'),
              _buildNavItem(label: 'ArcaneAuthLayout', href: '/docs/layout/arcane-auth-layout'),
              _buildNavItem(label: 'ArcaneDashboardLayout', href: '/docs/layout/arcane-dashboard-layout'),
              _buildNavItem(label: 'ArcanePageBody', href: '/docs/layout/arcane-page-body'),
            ]),

            // Typography Components section
            _buildNavSection('Typography', [
              _buildNavItem(label: 'ArcaneText', href: '/docs/typography/arcane-text'),
              _buildNavItem(label: 'ArcaneHeading', href: '/docs/typography/arcane-heading'),
              _buildNavItem(label: 'ArcaneHeadline', href: '/docs/typography/arcane-headline'),
              _buildNavItem(label: 'ArcaneSubheadline', href: '/docs/typography/arcane-subheadline'),
              _buildNavItem(label: 'ArcaneParagraph', href: '/docs/typography/arcane-paragraph'),
              _buildNavItem(label: 'ArcaneSpan', href: '/docs/typography/arcane-span'),
              _buildNavItem(label: 'ArcaneGradientText', href: '/docs/typography/arcane-gradient-text'),
              _buildNavItem(label: 'ArcaneGlowText', href: '/docs/typography/arcane-glow-text'),
              _buildNavItem(label: 'ArcaneRichText', href: '/docs/typography/arcane-rich-text'),
              _buildNavItem(label: 'ArcaneCodeSnippet', href: '/docs/typography/arcane-code-snippet'),
              _buildNavItem(label: 'ArcaneInlineCode', href: '/docs/typography/arcane-inline-code'),
              _buildNavItem(label: 'ArcanePre', href: '/docs/typography/arcane-pre'),
            ]),

            // View Components section
            _buildNavSection('View', [
              _buildNavItem(label: 'ArcaneAvatar', href: '/docs/view/arcane-avatar'),
              _buildNavItem(label: 'ArcaneBadge', href: '/docs/view/arcane-badge'),
              _buildNavItem(label: 'ArcaneChip', href: '/docs/view/arcane-chip'),
              _buildNavItem(label: 'ArcaneDivider', href: '/docs/view/arcane-divider'),
              _buildNavItem(label: 'ArcaneProgressBar', href: '/docs/view/arcane-progress-bar'),
              _buildNavItem(label: 'ArcaneLoader', href: '/docs/view/arcane-loader'),
              _buildNavItem(label: 'ArcaneSkeleton', href: '/docs/view/arcane-skeleton'),
              _buildNavItem(label: 'ArcaneEmptyState', href: '/docs/view/arcane-empty-state'),
              _buildNavItem(label: 'ArcaneDataTable', href: '/docs/view/arcane-data-table'),
              _buildNavItem(label: 'ArcaneTimeline', href: '/docs/view/arcane-timeline'),
              _buildNavItem(label: 'ArcaneFeatureCard', href: '/docs/view/arcane-feature-card'),
              _buildNavItem(label: 'ArcaneTooltip', href: '/docs/view/arcane-tooltip'),
              _buildNavItem(label: 'ArcaneAccordion', href: '/docs/view/arcane-accordion'),
              _buildNavItem(label: 'ArcaneToast', href: '/docs/view/arcane-toast'),
            ]),

            // Navigation Components section
            _buildNavSection('Navigation', [
              _buildNavItem(label: 'ArcaneHeader', href: '/docs/navigation/arcane-header'),
              _buildNavItem(label: 'ArcaneSidebar', href: '/docs/navigation/arcane-sidebar'),
              _buildNavItem(label: 'ArcaneBottomNav', href: '/docs/navigation/arcane-bottom-nav'),
              _buildNavItem(label: 'ArcaneDropdownMenu', href: '/docs/navigation/arcane-dropdown-menu'),
              _buildNavItem(label: 'ArcaneMobileMenu', href: '/docs/navigation/arcane-mobile-menu'),
              _buildNavItem(label: 'ArcaneMegaMenu', href: '/docs/navigation/arcane-mega-menu'),
            ]),

            // Feedback Components section
            _buildNavSection('Feedback', [
              _buildNavItem(label: 'ArcaneDialog', href: '/docs/feedback/arcane-dialog'),
              _buildNavItem(label: 'ArcaneToast', href: '/docs/feedback/arcane-toast'),
              _buildNavItem(label: 'ArcaneAlertBanner', href: '/docs/feedback/arcane-alert-banner'),
              _buildNavItem(label: 'ArcaneTooltip', href: '/docs/feedback/arcane-tooltip'),
              _buildNavItem(label: 'ArcaneAccordion', href: '/docs/feedback/arcane-accordion'),
            ]),

            // Forms section
            _buildNavSection('Forms', [
              _buildNavItem(label: 'ArcaneForm', href: '/docs/forms/arcane-form'),
              _buildNavItem(label: 'ArcaneField', href: '/docs/forms/arcane-field'),
              _buildNavItem(label: 'ArcaneFieldWrapper', href: '/docs/forms/arcane-field-wrapper'),
            ]),

            // Screens section
            _buildNavSection('Screens', [
              _buildNavItem(label: 'ArcaneScreen', href: '/docs/screens/arcane-screen'),
              _buildNavItem(label: 'ArcaneDashboardLayout', href: '/docs/screens/arcane-dashboard-layout'),
              _buildNavItem(label: 'ArcaneAuthLayout', href: '/docs/screens/arcane-auth-layout'),
            ]),

            // Guides section
            _buildNavSection('Guides', [
              _buildNavItem(label: 'Deployment', href: '/guides/deployment'),
            ]),
          ],
        ),
      ],
    );
  }

  Component _buildNavSection(String title, List<Component> items) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomLg,
      ),
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            fontSize: FontSize.xs,
            fontWeight: FontWeight.w600,
            textColor: TextColor.muted,
            margin: MarginPreset.bottomSm,
            textTransform: TextTransform.uppercase,
            letterSpacing: LetterSpacing.wide,
            raw: {
              'padding': '0 12px',
            },
          ),
          children: [ArcaneText(title)],
        ),
        ...items,
      ],
    );
  }

  /// Build a navigation item that links to a page
  Component _buildNavItem({
    required String label,
    required String href,
  }) {
    final isActive = currentPath == href || currentPath == '$href/';

    return ArcaneLink(
      href: href,
      styles: ArcaneStyleData(
        display: Display.flex,
        gap: Gap.sm,
        fontSize: FontSize.sm,
        borderRadius: Radius.md,
        margin: MarginPreset.bottomXs,
        transition: Transition.allFast,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDecoration: TextDecoration.none,
        textColor: isActive ? TextColor.primary : TextColor.muted,
        fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
        raw: {
          'padding': '8px 12px',
          'background': isActive ? 'var(--glow-light, rgba(5, 150, 105, 0.1))' : 'transparent',
          'border': isActive
              ? '1px solid var(--border-accent, rgba(5, 150, 105, 0.25))'
              : '1px solid transparent',
        },
      ),
      child: ArcaneSpan(child: ArcaneText(label)),
    );
  }
}
