⏺ User approved Claude's plan
⎿  Plan saved to: ~/.claude/plans/typed-bubbling-reef.md · /plan to edit
Plan: Comprehensive arcane_jaspr Documentation Site

     Overview

     Create a complete documentation site for the arcane_jaspr library covering 100% of its 235+ components with:
     - Live rendered component demos alongside copyable code snippets
     - Individual documentation for every component
     - Organized by category, prioritizing Core + Inputs first

     User Requirements

     - Live + Code: Show actual rendered components with copyable code
     - Individual: Every component gets its own documentation section
     - Priority: Core concepts, theming, styling, buttons, text fields first

     Component Page Template

     Each component documentation will follow this structure:

     ---
     title: ComponentName
     description: Brief description
     layout: docs
     ---

     # ComponentName

     Overview paragraph explaining what the component does.

     ## Basic Usage
     [Live demo of component]
     [Copyable code snippet]

     ## Properties
     | Property | Type | Default | Description |
     |----------|------|---------|-------------|
     | ...      | ...  | ...     | ...         |

     ## Variants
     [Live demos of each variant with code]

     ## Examples
     [Real-world usage patterns with code]

     Implementation Order

     Phase 1: Infrastructure (First Priority)

     Create the demo/documentation infrastructure:

     1. lib/components/code_block.dart - Code display with:
       - Syntax highlighting (via pre/code tags with classes)
       - Copy-to-clipboard button
       - Language label
     2. lib/components/component_demo.dart - Demo wrapper with:
       - Live rendered component area
       - Code snippet below with copy button
       - Optional title/description
     3. lib/components/props_table.dart - Property documentation:
       - Property name, type, description columns
       - Default value indication
       - Required vs optional marking
     4. Update lib/components/docs_sidebar.dart - Full navigation
     5. Update web/styles.css - Code block styling, demo containers

     Phase 2: Core + Inputs (User Priority)

     Core Concepts:
     - docs/concepts/theming.md - ArcaneTheme, AccentTheme, ThemeMode
     - docs/concepts/styling.md - ArcaneStyleData system
     - docs/concepts/tokens.md - Design tokens reference

     Style Enums (all 45+ documented):
     - docs/styles/ - One page per category with all enum values

     Input Components (18 components, each individually documented):
     - docs/inputs/arcane-button.md
     - docs/inputs/arcane-icon-button.md
     - docs/inputs/arcane-close-button.md
     - docs/inputs/arcane-fab.md
     - docs/inputs/arcane-text-input.md
     - docs/inputs/arcane-text-area.md
     - docs/inputs/arcane-search.md
     - docs/inputs/arcane-select.md
     - docs/inputs/arcane-checkbox.md
     - docs/inputs/arcane-radio.md
     - docs/inputs/arcane-toggle-switch.md
     - docs/inputs/arcane-slider.md
     - docs/inputs/arcane-range-slider.md
     - docs/inputs/arcane-toggle-button.md
     - docs/inputs/arcane-toggle-button-group.md
     - docs/inputs/arcane-cycle-button.md
     - docs/inputs/arcane-selector.md
     - docs/inputs/arcane-theme-toggle.md

     Phase 3: Layout & Typography

     Layout Components (35 components):
     - ArcaneDiv, ArcaneSection, ArcaneBox, ArcaneContainer, ArcaneCenter
     - ArcaneRow, ArcaneColumn, ArcaneFlow, ArcaneSpacer, ArcaneExpanded
     - ArcaneStack, ArcanePositioned, ArcanePadding
     - ArcaneGutter, ArcaneHeroSection, ArcaneCarpet
     - ArcaneTile, ArcaneCard (layout variant)
     - ArcaneButtonPanel, ArcaneButtonGroup
     - ArcaneRadioCards, ArcaneLogoCarousel, ArcaneLogoGrid
     - ArcaneTabs, ArcaneTabItem, ArcaneTabBar
     - ArcaneAuthLayout, ArcaneFooter
     - ArcaneDashboardLayout, ArcanePageBody

     Typography (10+ components):
     - ArcaneText, ArcaneSpan, ArcaneHeading, ArcaneParagraph
     - ArcaneHeadline, ArcaneSubheadline, ArcaneBodyText
     - ArcaneGradientText, ArcaneGlowText, ArcaneRichText
     - ArcaneCodeSnippet, ArcaneInlineCode, ArcanePre

     Phase 4: View Components (60+ components)

     Cards: ArcaneCard, ArcaneGlassCard, ArcaneStructuredCard, ArcaneFeatureCard, ArcanePricingCard, ArcaneTestimonialCard, ArcaneIntegrationCard, 
     ArcaneGameTile

     Display: ArcaneAvatar, ArcaneAvatarGroup, ArcaneBadge, ArcaneBar, ArcaneGlass, ArcaneDivider, ArcaneVerticalDivider

     Data: ArcaneDataTable, ArcaneStaticTable, ArcaneTimeline, ArcaneTimelineItem, ArcaneKeyValueTable

     Indicators: ArcaneProgressBar, ArcaneRatingStars, ArcaneStatusIndicator, ArcaneStatusBadge

     States: ArcaneLoadingState, ArcaneEmptyState, ArcaneErrorState

     Loaders: ArcaneLoader, ArcaneLoadingSpinner, ArcaneDotsLoader, ArcanePulseLoader, ArcaneCircularProgress

     Other: ArcaneExpander, ArcaneSkeleton, ArcaneChip, ArcaneChipGroup, ArcaneAnimatedCounter, ArcaneMetricDisplay

     Phase 5: Navigation (12+ components)

     - ArcaneHeader, ArcaneNavItem, ArcaneNavLink, ArcaneNavTile
     - ArcaneSidebar, ArcaneSidebarGroup, ArcaneSidebarItem
     - ArcaneBottomNavigationBar, ArcaneBottomNavItem, ArcaneBottomBar
     - ArcaneDropdownMenu, ArcaneDropdownItem
     - ArcaneMobileMenu, ArcaneMobileNavItem, ArcaneHamburgerButton
     - ArcaneMegaMenu, ArcaneMegaMenuSection

     Phase 6: Feedback & Dialogs (12+ components)

     - ArcaneDialog, ArcaneAlertDialog, ArcaneConfirmDialog, ArcaneTextInputDialog
     - ArcaneToast, ArcaneToastContainer
     - ArcaneAlertBanner, ArcaneTooltip, ArcaneTooltipCustom, ArcaneInfoTooltip
     - ArcaneAccordion, ArcaneAccordionItem, ArcaneFaqAccordion
     - ArcaneSheet, ArcaneBackToTop, ArcaneScrollProgress

     Phase 7: Forms & Screens

     Forms: ArcaneForm, ArcaneFormSection, ArcaneField, ArcaneFieldWrapper, ArcaneInputGroup, ArcaneNewsletterForm, ArcaneWaitlistForm

     Screens: ArcaneScreen, ArcaneFillScreen, ArcaneFullScreen, ArcaneNavigationScreen, ArcaneWindow, ArcaneResponsiveScaffold

     Phase 8: Specialized & HTML Components

     Specialized: ArcaneGameSelector, ArcanePricingGrid, ArcaneIntegrationGrid, ArcaneSettingsSection, ArcaneSocialLinks, ArcaneTerminal

     HTML Wrappers: All 18 HTML wrapper components with their Arcane styling capabilities

     Critical Files

     - arcane_codex_web/lib/components/docs_sidebar.dart - Navigation structure
     - arcane_codex_web/lib/components/code_block.dart - Code display (NEW)
     - arcane_codex_web/lib/components/component_demo.dart - Demo wrapper (NEW)
     - arcane_codex_web/lib/components/props_table.dart - Props table (NEW)
     - arcane_codex_web/lib/layouts/arcane_docs_layout.dart - Page layout
     - arcane_codex_web/web/styles.css - Code block styling
     - 100+ content markdown files in arcane_codex_web/content/docs/

     Estimated Scope

     - ~235 individual component documentation pages
     - ~45 style enum reference entries
     - 3 core concept guides
     - Infrastructure components (code_block, component_demo, props_table)
     - Comprehensive sidebar navigation