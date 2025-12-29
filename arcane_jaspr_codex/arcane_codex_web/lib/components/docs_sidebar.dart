import 'package:arcane_jaspr/arcane_jaspr.dart';

import '../utils/constants.dart';

/// Documentation sidebar with collapsible navigation groups
class DocsSidebar extends StatelessComponent {
  final String currentPath;

  const DocsSidebar({
    super.key,
    required this.currentPath,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneScrollRail(
      width: '280px',
      topOffset: '0px',
      showBorder: true,
      padding: '0',
      scrollPersistenceId: 'docs-sidebar',
      children: [
        // Header
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            borderBottom: BorderPreset.subtle,
            background: Background.surfaceVariant,
          ),
          children: [
            ArcaneLink(
              href: '${AppConstants.baseUrl}/',
              styles: const ArcaneStyleData(
                textDecoration: TextDecoration.none,
              ),
              child: ArcaneDiv(
                styles: const ArcaneStyleData(
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.lg,
                  textColor: TextColor.primary,
                ),
                children: [ArcaneText(AppConstants.siteName)],
              ),
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.sm,
                textColor: TextColor.muted,
                margin: MarginPreset.topXs,
              ),
              children: [const ArcaneText('Documentation')],
            ),
          ],
        ),

        // Navigation
        ArcaneNav(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.sm,
          ),
          children: [
            // Getting Started section (always expanded, not collapsible)
            _buildFixedSection('Getting Started', [
              _buildNavItem(label: 'Introduction', href: '/docs'),
              _buildNavItem(label: 'Why Jaspr?', href: '/docs/why-jaspr'),
              _buildNavItem(label: 'Installation', href: '/docs/installation'),
              _buildNavItem(label: 'Quick Start', href: '/docs/quick-start'),
              _buildNavItem(label: 'Theming', href: '/docs/concepts/theming'),
              _buildNavItem(label: 'Styling', href: '/docs/concepts/styling'),
              _buildNavItem(label: 'Design Tokens', href: '/docs/concepts/tokens'),
              _buildNavItem(label: 'Component Aliases', href: '/docs/concepts/aliases'),
            ]),

            // Style Reference section
            _buildCollapsibleSection('Style Reference', [
              _buildNavItem(label: 'Display & Layout', href: '/docs/styles/display'),
              _buildNavItem(label: 'Spacing', href: '/docs/styles/spacing'),
              _buildNavItem(label: 'Typography', href: '/docs/styles/typography'),
              _buildNavItem(label: 'Colors', href: '/docs/styles/colors'),
              _buildNavItem(label: 'Borders', href: '/docs/styles/borders'),
              _buildNavItem(label: 'Effects', href: '/docs/styles/effects'),
            ], defaultOpen: _sectionContainsPath('styles')),

            // Input Components section
            _buildCollapsibleSection('Inputs', [
              _buildNavItem(label: 'ArcaneButton', href: '/docs/inputs/arcane-button'),
              _buildNavItem(label: 'ArcaneIconButton', href: '/docs/inputs/arcane-icon-button'),
              _buildNavItem(label: 'ArcaneCloseButton', href: '/docs/inputs/arcane-close-button'),
              _buildNavItem(label: 'ArcaneFAB', href: '/docs/inputs/arcane-fab'),
              _buildNavItem(label: 'ArcaneCtaLink', href: '/docs/inputs/arcane-cta-link'),
              _buildNavItem(label: 'ArcaneTextInput', href: '/docs/inputs/arcane-text-input'),
              _buildNavItem(label: 'ArcaneTextArea', href: '/docs/inputs/arcane-text-area'),
              _buildNavItem(label: 'ArcaneSearch', href: '/docs/inputs/arcane-search'),
              _buildNavItem(label: 'ArcaneSearchBar', href: '/docs/inputs/arcane-search-bar'),
              _buildNavItem(label: 'ArcaneSelect', href: '/docs/inputs/arcane-select'),
              _buildNavItem(label: 'ArcaneCheckbox', href: '/docs/inputs/arcane-checkbox'),
              _buildNavItem(label: 'ArcaneRadio', href: '/docs/inputs/arcane-radio'),
              _buildNavItem(label: 'ArcaneRadioGroup', href: '/docs/inputs/arcane-radio-group'),
              _buildNavItem(label: 'ArcaneToggleSwitch', href: '/docs/inputs/arcane-toggle-switch'),
              _buildNavItem(label: 'ArcaneSlider', href: '/docs/inputs/arcane-slider'),
              _buildNavItem(label: 'ArcaneRangeSlider', href: '/docs/inputs/arcane-range-slider'),
              _buildNavItem(label: 'ArcaneToggleButton', href: '/docs/inputs/arcane-toggle-button'),
              _buildNavItem(label: 'ArcaneToggleButtonGroup', href: '/docs/inputs/arcane-toggle-button-group'),
              _buildNavItem(label: 'ArcaneCycleButton', href: '/docs/inputs/arcane-cycle-button'),
              _buildNavItem(label: 'ArcaneSelector', href: '/docs/inputs/arcane-selector'),
              _buildNavItem(label: 'ArcaneThemeToggle', href: '/docs/inputs/arcane-theme-toggle'),
              _buildNavItem(label: 'ArcaneTagInput', href: '/docs/inputs/arcane-tag-input'),
              _buildNavItem(label: 'ArcaneNumberInput', href: '/docs/inputs/arcane-number-input'),
              _buildNavItem(label: 'ArcaneFileUpload', href: '/docs/inputs/arcane-file-upload'),
              _buildNavItem(label: 'ArcaneColorInput', href: '/docs/inputs/arcane-color-input'),
              _buildNavItem(label: 'ArcaneMutableText', href: '/docs/inputs/arcane-mutable-text'),
              _buildNavItem(label: 'ArcaneOtpInput', href: '/docs/inputs/arcane-otp-input'),
              _buildNavItem(label: 'ArcaneCombobox', href: '/docs/inputs/arcane-combobox'),
              _buildNavItem(label: 'ArcaneCalendar', href: '/docs/inputs/arcane-calendar'),
              _buildNavItem(label: 'ArcaneDatePicker', href: '/docs/inputs/arcane-date-picker'),
            ], defaultOpen: _sectionContainsPath('inputs')),

            // Layout Components section
            _buildCollapsibleSection('Layout', [
              _buildNavItem(label: 'ArcaneDiv', href: '/docs/layout/arcane-div'),
              _buildNavItem(label: 'ArcaneRow', href: '/docs/layout/arcane-row'),
              _buildNavItem(label: 'ArcaneColumn', href: '/docs/layout/arcane-column'),
              _buildNavItem(label: 'ArcaneContainer', href: '/docs/layout/arcane-container'),
              _buildNavItem(label: 'ArcaneSection', href: '/docs/layout/arcane-section'),
              _buildNavItem(label: 'ArcaneSectionHeader', href: '/docs/layout/arcane-section-header'),
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
              _buildNavItem(label: 'ArcaneFooterColumn', href: '/docs/layout/arcane-footer-column'),
              _buildNavItem(label: 'ArcaneAuthLayout', href: '/docs/layout/arcane-auth-layout'),
              _buildNavItem(label: 'ArcaneDashboardLayout', href: '/docs/layout/arcane-dashboard-layout'),
              _buildNavItem(label: 'ArcanePageBody', href: '/docs/layout/arcane-page-body'),
              _buildNavItem(label: 'ArcaneDrawer', href: '/docs/layout/arcane-drawer'),
              _buildNavItem(label: 'ArcaneScrollArea', href: '/docs/layout/arcane-scroll-area'),
              _buildNavItem(label: 'ArcaneAspectRatio', href: '/docs/layout/arcane-aspect-ratio'),
              _buildNavItem(label: 'ArcaneResizable', href: '/docs/layout/arcane-resizable'),
            ], defaultOpen: _sectionContainsPath('layout')),

            // Typography Components section
            _buildCollapsibleSection('Typography', [
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
              _buildNavItem(label: 'ArcaneCodeBlock', href: '/docs/typography/arcane-pre'),
            ], defaultOpen: _sectionContainsPath('typography')),

            // View Components section
            _buildCollapsibleSection('View', [
              _buildNavItem(label: 'ArcaneIcon', href: '/docs/view/arcane-icon'),
              _buildNavItem(label: 'ArcaneAvatar', href: '/docs/view/arcane-avatar'),
              _buildNavItem(label: 'ArcaneBadge', href: '/docs/view/arcane-badge'),
              _buildNavItem(label: 'ArcaneChip', href: '/docs/view/arcane-chip'),
              _buildNavItem(label: 'ArcaneDivider', href: '/docs/view/arcane-divider'),
              _buildNavItem(label: 'ArcaneSeparator', href: '/docs/view/arcane-separator'),
              _buildNavItem(label: 'ArcaneProgressBar', href: '/docs/view/arcane-progress-bar'),
              _buildNavItem(label: 'ArcaneLoader', href: '/docs/view/arcane-loader'),
              _buildNavItem(label: 'ArcaneSkeleton', href: '/docs/view/arcane-skeleton'),
              _buildNavItem(label: 'ArcaneEmptyState', href: '/docs/view/arcane-empty-state'),
              _buildNavItem(label: 'ArcaneDataTable', href: '/docs/view/arcane-data-table'),
              _buildNavItem(label: 'ArcaneTimeline', href: '/docs/view/arcane-timeline'),
              _buildNavItem(label: 'ArcaneSteps', href: '/docs/view/arcane-steps'),
              _buildNavItem(label: 'ArcaneStatDisplay', href: '/docs/view/arcane-stat-display'),
              _buildNavItem(label: 'ArcaneAuthorCard', href: '/docs/view/arcane-author-card'),
              _buildNavItem(label: 'ArcaneFeatureCard', href: '/docs/view/arcane-feature-card'),
              _buildNavItem(label: 'ArcaneCheckList', href: '/docs/view/arcane-check-list'),
              _buildNavItem(label: 'ArcaneCodeWindow', href: '/docs/view/arcane-code-window'),
              _buildNavItem(label: 'ArcaneTooltip', href: '/docs/view/arcane-tooltip'),
              _buildNavItem(label: 'ArcaneAccordion', href: '/docs/view/arcane-accordion'),
              _buildNavItem(label: 'ArcaneToast', href: '/docs/view/arcane-toast'),
              _buildNavItem(label: 'ArcaneCallout', href: '/docs/view/arcane-callout'),
              _buildNavItem(label: 'ArcaneKbd', href: '/docs/view/arcane-kbd'),
              _buildNavItem(label: 'ArcaneMeter', href: '/docs/view/arcane-meter'),
              _buildNavItem(label: 'ArcaneAlert', href: '/docs/view/arcane-alert'),
              _buildNavItem(label: 'ArcaneInlineTabs', href: '/docs/view/arcane-inline-tabs'),
              _buildNavItem(label: 'ArcaneTreeView', href: '/docs/view/arcane-tree-view'),
              _buildNavItem(label: 'ArcanePopover', href: '/docs/view/arcane-popover'),
              _buildNavItem(label: 'ArcaneHovercard', href: '/docs/view/arcane-hovercard'),
              _buildNavItem(label: 'ArcaneExpander', href: '/docs/view/arcane-expander'),
              _buildNavItem(label: 'ArcaneFadeEdge', href: '/docs/view/arcane-fade-edge'),
              _buildNavItem(label: 'ArcaneMarquee', href: '/docs/view/arcane-marquee'),
              _buildNavItem(label: 'ArcaneSvg', href: '/docs/view/arcane-svg'),
            ], defaultOpen: _sectionContainsPath('view')),

            // Navigation Components section
            _buildCollapsibleSection('Navigation', [
              _buildNavItem(label: 'ArcaneHeader', href: '/docs/navigation/arcane-header'),
              _buildNavItem(label: 'ArcaneSidebar', href: '/docs/navigation/arcane-sidebar'),
              _buildNavItem(label: 'ArcaneBottomNav', href: '/docs/navigation/arcane-bottom-nav'),
              _buildNavItem(label: 'ArcaneDropdownMenu', href: '/docs/navigation/arcane-dropdown-menu'),
              _buildNavItem(label: 'ArcaneMobileMenu', href: '/docs/navigation/arcane-mobile-menu'),
              _buildNavItem(label: 'ArcaneMegaMenu', href: '/docs/navigation/arcane-mega-menu'),
              _buildNavItem(label: 'ArcaneBreadcrumbs', href: '/docs/navigation/arcane-breadcrumbs'),
              _buildNavItem(label: 'ArcanePagination', href: '/docs/navigation/arcane-pagination'),
              _buildNavItem(label: 'ArcaneContextMenu', href: '/docs/navigation/arcane-context-menu'),
              _buildNavItem(label: 'ArcaneMenubar', href: '/docs/navigation/arcane-menubar'),
            ], defaultOpen: _sectionContainsPath('navigation')),

            // Feedback Components section
            _buildCollapsibleSection('Feedback', [
              _buildNavItem(label: 'ArcaneDialog', href: '/docs/feedback/arcane-dialog'),
              _buildNavItem(label: 'ArcaneAlertBanner', href: '/docs/feedback/arcane-alert-banner'),
              _buildNavItem(label: 'ArcaneStatusBadge', href: '/docs/feedback/arcane-status-badge'),
              _buildNavItem(label: 'ArcaneCommand', href: '/docs/feedback/arcane-command'),
            ], defaultOpen: _sectionContainsPath('feedback')),

            // Forms section
            _buildCollapsibleSection('Forms', [
              _buildNavItem(label: 'ArcaneForm', href: '/docs/forms/arcane-form'),
              _buildNavItem(label: 'ArcaneField', href: '/docs/forms/arcane-field'),
              _buildNavItem(label: 'ArcaneFieldWrapper', href: '/docs/forms/arcane-field-wrapper'),
            ], defaultOpen: _sectionContainsPath('forms')),

            // Authentication section
            _buildCollapsibleSection('Authentication', [
              _buildNavItem(label: 'ArcaneLoginCard', href: '/docs/auth/arcane-login-card'),
              _buildNavItem(label: 'ArcaneSignupCard', href: '/docs/auth/arcane-signup-card'),
              _buildNavItem(label: 'ArcaneForgotPasswordCard', href: '/docs/auth/arcane-forgot-password-card'),
              _buildNavItem(label: 'Social Sign-In Buttons', href: '/docs/auth/social-buttons'),
              _buildNavItem(label: 'AuthSplitLayout', href: '/docs/auth/auth-split-layout'),
              _buildNavItem(label: 'AuthBrandingPanel', href: '/docs/auth/auth-branding-panel'),
              _buildNavItem(label: 'PasswordPolicy', href: '/docs/auth/password-policy'),
            ], defaultOpen: _sectionContainsPath('auth')),

            // Screens section
            _buildCollapsibleSection('Screens', [
              _buildNavItem(label: 'ArcaneScreen', href: '/docs/screens/arcane-screen'),
            ], defaultOpen: _sectionContainsPath('screens')),

            // Guides section
            _buildCollapsibleSection('Guides', [
              _buildNavItem(label: 'Deployment', href: '/guides/deployment'),
            ], defaultOpen: currentPath.startsWith('/guides')),
          ],
        ),
      ],
    );
  }

  bool _sectionContainsPath(String section) {
    return currentPath.startsWith('/docs/$section');
  }

  /// Build a fixed section that's always expanded (no toggle)
  Component _buildFixedSection(String title, List<Component> items) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomSm,
      ),
      children: [
        // Section header (not clickable)
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            fontSize: FontSize.xs,
            fontWeight: FontWeight.w700,
            textTransform: TextTransform.uppercase,
            letterSpacing: LetterSpacing.wide,
            padding: PaddingPreset.smMd,
            background: Background.surfaceVariant,
            borderRadius: Radius.sm,
            textColor: TextColor.onSurface,
          ),
          children: [
            ArcaneRow(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneText(title),
                // Item count badge
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.xs,
                    textColor: TextColor.muted,
                    background: Background.surface,
                    padding: PaddingPreset.xs,
                    borderRadius: Radius.full,
                  ),
                  children: [ArcaneText('${items.length}')],
                ),
              ],
            ),
          ],
        ),
        // Items (always visible)
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.horizontalSm,
            margin: MarginPreset.topXs,
          ),
          children: items,
        ),
      ],
    );
  }

  /// Build a collapsible section using ArcaneDisclosure
  Component _buildCollapsibleSection(String title, List<Component> items, {bool defaultOpen = false}) {
    final itemCount = items.length;

    return ArcaneDisclosure.minimal(
      open: defaultOpen,
      summary: ArcaneRow(
        gapSize: Gap.sm,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.xs,
              fontWeight: FontWeight.w700,
              textTransform: TextTransform.uppercase,
              letterSpacing: LetterSpacing.wide,
              textColor: TextColor.onSurface,
            ),
            children: [ArcaneText(title)],
          ),
          // Item count badge
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.xs,
              textColor: TextColor.muted,
              background: Background.surface,
              padding: PaddingPreset.xs,
              borderRadius: Radius.full,
            ),
            children: [ArcaneText('$itemCount')],
          ),
        ],
      ),
      child: ArcaneColumn(
        children: items,
      ),
    );
  }

  /// Build a navigation item that links to a page
  Component _buildNavItem({
    required String label,
    required String href,
  }) {
    final fullHref = '${AppConstants.baseUrl}$href';
    final isActive = currentPath == href || currentPath == '$href/';

    return ArcaneLink(
      href: fullHref,
      styles: ArcaneStyleData(
        display: Display.flex,
        gap: Gap.sm,
        fontSize: FontSize.sm,
        borderRadius: Radius.md,
        margin: MarginPreset.bottomXs,
        transition: Transition.allFast,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDecoration: TextDecoration.none,
        padding: PaddingPreset.buttonSm,
        textColor: isActive ? TextColor.accent : TextColor.onSurfaceVariant,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        background: isActive ? Background.accentContainer : Background.transparent,
        borderLeft: isActive ? BorderPreset.accent : BorderPreset.none,
        borderLeftWidth: BorderWidth.thick,
      ),
      child: ArcaneSpan(child: ArcaneText(label)),
    );
  }
}
