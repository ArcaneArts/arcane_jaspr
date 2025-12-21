/// Arcane Jaspr - A Jaspr port of the Arcane UI component library
/// Supabase-inspired design with switchable accent colors
library arcane_jaspr;

// Re-export Jaspr core for convenience
export 'package:jaspr/jaspr.dart';

// Re-export Jaspr DOM for HTML elements (div, span, button, text, etc.)
// Hide types that conflict with our custom implementations
export 'package:jaspr/dom.dart'
    hide
        Color,
        ColorScheme,
        Colors,
        Selector,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight,
        FontStyle,
        Visibility,
        Display,
        Position,
        Overflow,
        Cursor,
        // Additional hides for style_types enums
        FlexDirection,
        TextDecoration,
        Transition,
        FontFamily,
        Radius,
        JustifyContent,
        AlignItems,
        PointerEvents,
        ZIndex,
        Transform,
        Opacity,
        Shadow,
        FlexWrap,
        WhiteSpace,
        Spacing,
        TextTransform;

// ============================================================================
// Utilities
// ============================================================================
export 'util/appearance/colors.dart';
export 'util/appearance/color_scheme.dart';
export 'util/appearance/theme.dart';
export 'util/arcane.dart';
export 'util/tools/styles.dart';

// ============================================================================
// Design Tokens & Style Presets
// ============================================================================
export 'util/tokens/tokens.dart';
export 'util/tokens/style_presets.dart';
export 'util/tokens/common_styles.dart';

// ============================================================================
// Enum-Based Style Types (Flutter-like declarative styling)
// ============================================================================
export 'util/style_types/index.dart' hide BorderStyle, AlignSelf, UserSelect;

// ============================================================================
// Support components
// ============================================================================
export 'component/support/app.dart';

// ============================================================================
// Typography components
// ============================================================================
export 'component/typography/headline.dart';
export 'component/typography/text.dart' hide Text;

// ============================================================================
// Layout components
// ============================================================================
export 'component/layout/section.dart';
export 'component/layout/gutter.dart' hide Gap;
export 'component/layout/flow.dart';
export 'component/layout/carpet.dart';
export 'component/layout/button_panel.dart';
export 'component/layout/radio_cards.dart';
export 'component/layout/tabs.dart';
export 'component/layout/hero_section.dart' hide EdgeInsets;
export 'component/layout/footer.dart';
export 'component/layout/logo_carousel.dart';
export 'component/layout/cta_banner.dart';
export 'component/layout/dashboard_layout.dart';
export 'component/layout/auth_layout.dart';

// ============================================================================
// Input components
// ============================================================================
export 'component/input/button.dart';
export 'component/input/icon_button.dart';
export 'component/input/cycle_button.dart';
export 'component/input/search.dart';
export 'component/input/selector.dart';
export 'component/input/fab.dart';
export 'component/input/toggle_switch.dart';
export 'component/input/text_input.dart' hide TextInput;
export 'component/input/slider.dart';
export 'component/input/checkbox.dart';
export 'component/input/theme_toggle.dart';

// ============================================================================
// View components
// ============================================================================
export 'component/view/bar.dart';
export 'component/view/glass.dart';
export 'component/view/card.dart';
export 'component/view/card_section.dart';
export 'component/view/tile.dart';
export 'component/view/expander.dart' hide AccordionItem, Accordion, ArcaneAccordionItem, ArcaneAccordion;
export 'component/view/center_body.dart';
export 'component/view/data_table.dart';
export 'component/view/static_table.dart';
export 'component/view/badge.dart';
export 'component/view/feature_card.dart';
export 'component/view/pricing_card.dart';
export 'component/view/testimonial_card.dart' hide ArcaneRatingStars;
export 'component/view/integration_card.dart';
export 'component/view/game_tile.dart';
export 'component/view/divider.dart' hide Divider, ArcaneDivider;
export 'component/view/code_snippet.dart';
export 'component/view/avatar.dart';
export 'component/view/progress_bar.dart';
export 'component/view/rating_stars.dart';
export 'component/view/stat_card.dart';
export 'component/view/timeline.dart';
export 'component/view/stepper.dart';
export 'component/view/skeleton.dart';
export 'component/view/chip.dart' hide ArcaneChip, ArcaneChipGroup;
export 'component/view/status_indicator.dart';
export 'component/view/animated_counter.dart';
export 'component/view/gradient_text.dart';
export 'component/view/social_icons.dart' hide ArcaneSocialIcon;
export 'component/view/settings_section.dart';

// ============================================================================
// Navigation components
// ============================================================================
export 'component/navigation/sidebar.dart';
export 'component/navigation/bottom_navigation_bar.dart';
export 'component/navigation/header.dart';
export 'component/navigation/dropdown_menu.dart';
export 'component/navigation/mobile_menu.dart';

// ============================================================================
// Screen components
// ============================================================================
export 'component/screen/screen.dart';
export 'component/screen/fill_screen.dart';
export 'component/screen/navigation_screen.dart';

// ============================================================================
// Dialog components
// ============================================================================
export 'component/dialog/dialog.dart';
export 'component/dialog/confirm.dart';
export 'component/dialog/text.dart';
export 'component/dialog/toast.dart';

// ============================================================================
// Form components
// ============================================================================
export 'component/form/field.dart';
export 'component/form/field_wrapper.dart';
export 'component/form/provider.dart';
export 'component/form/newsletter_form.dart';

// ============================================================================
// Feedback components
// ============================================================================
export 'component/feedback/alert_banner.dart' hide ArcaneProgressBar, ArcaneLoader;
export 'component/feedback/tooltip.dart';
export 'component/feedback/loader.dart';

// ============================================================================
// Interactive components
// ============================================================================
export 'component/interactive/accordion.dart';
export 'component/interactive/back_to_top.dart';

// ============================================================================
// Collection components
// ============================================================================
export 'component/collection/collection.dart' hide Axis;
export 'component/collection/card_carousel.dart' hide CardCarouselTheme;
export 'component/collection/infinite_carousel.dart';

// ============================================================================
// HTML wrapper components (Flutter-like API for HTML elements)
// ============================================================================
export 'component/html/arcane_button.dart';
export 'component/html/arcane_image.dart';
export 'component/html/arcane_input.dart';
export 'component/html/arcane_label.dart';
export 'component/html/arcane_link.dart';
export 'component/html/arcane_span.dart';
export 'component/html/arcane_text.dart' hide ArcaneText;
export 'component/html/aside.dart';
export 'component/html/blockquote.dart';
export 'component/html/div.dart';
export 'component/html/footer.dart' show ArcaneHtmlFooter;
export 'component/html/header.dart' hide Header, ArcaneHeader;
export 'component/html/heading.dart';
export 'component/html/list.dart';
export 'component/html/main_element.dart';
export 'component/html/nav.dart';
export 'component/html/paragraph.dart';
export 'component/html/pre.dart';
export 'component/html/section.dart';
export 'component/html/table.dart';

// ============================================================================
// Authentication - Service & State
// ============================================================================
export 'service/auth_state.dart';
export 'service/auth_service.dart';

// ============================================================================
// Authentication - Provider & Guards
// ============================================================================
export 'provider/auth_provider.dart';
export 'provider/auth_guard.dart';

// ============================================================================
// Authentication - Components
// ============================================================================
export 'component/auth/login_card.dart';
export 'component/auth/signup_card.dart';
export 'component/auth/forgot_password_card.dart';

// ============================================================================
// Authentication - Social Sign-In Buttons
// ============================================================================
export 'component/button/social_button.dart';
export 'component/button/github_button.dart';
export 'component/button/google_button.dart';
export 'component/button/apple_button.dart';

// ============================================================================
// Authentication - Form Components
// ============================================================================
export 'component/form/auth/auth_input.dart';
export 'component/form/auth/auth_button.dart';
export 'component/form/auth/auth_divider.dart';
export 'component/form/auth/auth_social_row.dart';
export 'component/form/auth/auth_form_card.dart';

// ============================================================================
// Authentication - Layout & View
// ============================================================================
export 'component/layout/auth_split_layout.dart';
export 'component/view/auth_branding_panel.dart';

// ============================================================================
// Authentication - Utilities
// ============================================================================
export 'util/auth/password_policy.dart';
