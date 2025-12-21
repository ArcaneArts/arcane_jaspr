# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0]

### Added

#### Authentication System
- `ArcaneAuthProvider` - Context provider for Firebase authentication
- `AuthGuard` - Route protection for authenticated users
- `GuestGuard` - Route protection for unauthenticated users (login/signup pages)
- `JasprAuthService` - Firebase Auth service via JS interop

#### Auth UI Components
- `ArcaneLoginCard` - Complete login form with email/password and social options
- `ArcaneSignupCard` - Registration form with terms acceptance and password policy
- `ArcaneForgotPasswordCard` - Password reset request form

#### Social Sign-in Buttons
- `GithubSignInButton` - GitHub OAuth button
- `GoogleSignInButton` - Google OAuth button
- `AppleSignInButton` - Apple Sign-In button

#### Auth Layouts
- `AuthSplitLayout` - Two-column layout for auth pages (branding + form)
- `AuthBrandingPanel` - Branding content panel with tagline, features, testimonials

#### Auth Form Primitives
- `AuthInput` - Styled input for auth forms
- `AuthButton` - Submit button for auth forms
- `AuthDivider` - "or continue with" divider
- `AuthSocialRow` - Row of social sign-in buttons
- `AuthFormCard` - Card container for auth forms

#### Auth Utilities
- `PasswordPolicy` - Password validation with presets (weak, medium, strong)
- `AuthState` - Authentication state container
- `AuthUser` - Authenticated user model
- `AuthMethod` - Enum for auth methods (email, github, google, apple, anonymous)
- `AuthStatus` - Enum for auth status (unknown, loading, authenticated, unauthenticated, error)

#### Context Extensions
- `context.authState` - Access current auth state
- `context.currentUser` - Access current user
- `context.isAuthenticated` - Check authentication status
- `context.signInWithGitHub()` - Trigger GitHub OAuth
- `context.signInWithGoogle()` - Trigger Google OAuth
- `context.signInWithApple()` - Trigger Apple Sign-In
- `context.signOut()` - Sign out current user

### Changed
- Added `web: ^1.1.1` dependency for Firebase JS interop
- Added `http: ^1.6.0` dependency for auth API calls
- Updated documentation with authentication section
- Added auth demos to codex documentation site

### Documentation
- Rewrote root README with comprehensive component and auth documentation
- Created codex root README
- Expanded codex web README with detailed project structure
- Added authentication section to docs sidebar
- Added auth component demos

### Tests
- Added `auth_test.dart` with 45+ tests covering:
  - PasswordPolicy (weak, medium, strong presets and custom)
  - AuthMethod enum
  - AuthStatus enum
  - AuthUser class
  - AuthState class

## [2.0.0]

### Breaking Changes

All components now use the `Arcane*` prefix consistently. This is a breaking change that removes backwards compatibility.

**Migration Guide:**

Components have been renamed from their short names to the full `Arcane*` prefix. Examples:
- `Button` → `ArcaneButton`
- `Card` → `ArcaneCard`
- `Div` → `ArcaneDiv`
- `Heading` → `ArcaneHeading`
- `Section` → `ArcaneSection`
- `Box` → `ArcaneBox`
- `Row` → `ArcaneRow`
- `Column` → `ArcaneColumn`
- `Checkbox` → `ArcaneCheckbox`
- `Slider` → `ArcaneSlider`
- `Search` → `ArcaneSearch`
- `Toast` → `ArcaneToast`
- `Bar` → `ArcaneBar`
- `Glass` → `ArcaneGlass`
- `Screen` → `ArcaneScreen`
- ... and all other components

### Added

- `aliases.dart` - Shorthand `A*` typedefs for all components (e.g., `AButton = ArcaneButton`)
  - Import with `import 'package:arcane_jaspr/aliases.dart';`
  - Provides shorter names while keeping `Arcane*` as the primary API

### Changed

- Renamed all components to use consistent `Arcane*` prefix
- HTML element wrappers now use `Arcane*` prefix:
  - `Div` → `ArcaneDiv`
  - `Nav` → `ArcaneNav`
  - `Aside` → `ArcaneAside`
  - `Heading` → `ArcaneHeading`
  - `Paragraph` → `ArcaneParagraph`
  - `Main` → `ArcaneMain`
  - `HtmlSection` → `ArcaneHtmlSection`
  - `HtmlFooter` → `ArcaneHtmlFooter`
  - `Blockquote` → `ArcaneBlockquote`
  - `Pre` → `ArcanePre`
- Layout components renamed:
  - `Box` → `ArcaneBox`
  - `Row` → `ArcaneRow`
  - `Column` → `ArcaneColumn`
  - `Section` → `ArcaneSection`
  - `Gutter` → `ArcaneGutter`
  - `Flow` → `ArcaneFlow`
  - `ButtonPanel` → `ArcaneButtonPanel`
  - `CenterBody` → `ArcaneCenterBody`
- Input components renamed:
  - `Checkbox` → `ArcaneCheckbox`
  - `Radio` → `ArcaneRadio`
  - `Slider` → `ArcaneSlider`
  - `RangeSlider` → `ArcaneRangeSlider`
  - `ToggleSwitch` → `ArcaneToggleSwitch`
  - `Search` → `ArcaneSearch`
  - `Selector` → `ArcaneSelector`
  - `CycleButton` → `ArcaneCycleButton`
  - `FAB` → `ArcaneFAB`
  - `ThemeToggle` → `ArcaneThemeToggle`
- View components renamed:
  - `Bar` → `ArcaneBar`
  - `Glass` → `ArcaneGlass`
  - `Expander` → `ArcaneExpander`
  - `Accordion` → `ArcaneAccordion`
  - `Tooltip` → `ArcaneTooltip`
  - `Toast` → `ArcaneToast`
  - `StaticTable` → `ArcaneStaticTable`
  - `Timeline` → `ArcaneTimeline`
  - `Stepper` → `ArcaneStepper`
- Navigation components renamed:
  - `Sidebar` → `ArcaneSidebar`
  - `SidebarItem` → `ArcaneSidebarItem`
  - `BottomNavigationBar` → `ArcaneBottomNavigationBar`
  - `BottomNavItem` → `ArcaneBottomNavItem`
- Screen components renamed:
  - `Screen` → `ArcaneScreen`
  - `FillScreen` → `ArcaneFillScreen`
- Dialog/Feedback components renamed:
  - `ConfirmDialog` → `ArcaneConfirmDialog`
  - `AlertDialog` → `ArcaneAlertDialog`
- Collection components renamed:
  - `Collection` → `ArcaneCollection`
  - `ListView` → `ArcaneListView`
  - `GridView` → `ArcaneGridView`
  - `MasonryGrid` → `ArcaneMasonryGrid`
  - `CardCarousel` → `ArcaneCardCarousel`

## [1.0.0]

### Added

#### Core
- `ArcaneApp` - Main application wrapper with theme support
- `ArcaneTheme` - Theming system with Supabase-style dark-first design
- `ContrastedColorScheme` - Comprehensive color scheme with accent themes (violet, green, orange)

#### Input Components
- `ArcaneButton` - Primary button with multiple variants and sizes
- `ArcaneIconButton` - Icon-only button with hover states
- `Checkbox` - Styled checkbox input
- `CycleButton` - Button that cycles through options
- `FAB` - Floating action button
- `Search` - Search input with icon
- `Selector` - Dropdown selector component
- `Slider` - Range slider input
- `TextInput` - Text input field with validation support
- `ThemeToggle` - Dark/light mode toggle
- `ToggleSwitch` - On/off toggle switch

#### View Components
- `AnimatedCounter` - Animated number counter
- `Avatar` - User avatar with fallback initials
- `Badge` - Status badges with variants
- `Bar` - Horizontal bar component
- `ArcaneCard` - Card container with hover effects
- `CardSection` - Section within a card
- `CenterBody` - Centered content wrapper
- `Chip` - Tag/chip component
- `CodeSnippet` - Syntax-highlighted code block
- `DataTable` - Interactive data table
- `Divider` - Horizontal/vertical divider
- `Expander` - Expandable/collapsible content
- `FeatureCard` - Feature showcase card
- `GameTile` - Game server tile with status indicators
- `Glass` - Glassmorphism container
- `GradientText` - Text with gradient color
- `IntegrationCard` - Integration showcase card
- `PricingCard` - Pricing tier card
- `ProgressBar` - Progress indicator bar
- `RatingStars` - Star rating display
- `Skeleton` - Loading skeleton placeholder
- `SocialIcons` - Social media icon links
- `StatCard` - Statistics display card
- `StaticTable` - Simple static table
- `StatusIndicator` - Online/offline status dot
- `Stepper` - Multi-step progress indicator
- `TestimonialCard` - Customer testimonial card
- `Tile` - Clickable tile component
- `Timeline` - Vertical timeline display

#### Layout Components
- `ButtonPanel` - Row/column of buttons
- `Carpet` - Full-width background section
- `CTABanner` - Call-to-action banner
- `Flow` - Flexbox flow layout
- `Footer` - Page footer with links
- `Gutter` - Spacing/margin utility
- `HeroSection` - Hero banner section
- `LogoCarousel` - Scrolling logo carousel
- `RadioCards` - Radio button card selector
- `Section` - Page section wrapper
- `ArcaneTabs` - Tabbed content container

#### Navigation Components
- `BottomNavigationBar` - Mobile bottom nav
- `DropdownMenu` - Dropdown menu with items
- `Header` - Page header/navbar
- `MobileMenu` - Responsive mobile menu
- `Sidebar` - Side navigation panel

#### Screen Components
- `Screen` - Base screen wrapper
- `FillScreen` - Full-height screen
- `NavigationScreen` - Screen with navigation

#### Dialog Components
- `ArcaneDialog` - Modal dialog
- `ConfirmDialog` - Confirmation dialog
- `TextInputDialog` - Text input modal
- `Toast` - Toast notification

#### Feedback Components
- `AlertBanner` - Alert/notification banner
- `Loader` - Loading spinner
- `Tooltip` - Hover tooltip

#### Form Components
- `Field` - Form field with label
- `FieldWrapper` - Field container with validation
- `FormProvider` - Form state management
- `NewsletterForm` - Email signup form

#### Interactive Components
- `Accordion` - Collapsible accordion panels
- `BackToTop` - Scroll to top button

#### Typography
- `Headline` - Styled heading component

#### Collection Components
- `CardCarousel` - Horizontally scrolling cards
- `Collection` - Grid/list collection view

#### Design Tokens
- `ArcaneTokens` - Spacing, radius, shadows, transitions
- `CommonStyles` - Reusable style maps
- `StylePresets` - Pre-built component styles
- Button, Card, Badge, Chip, Input, FAB, IconButton, Alert, Progress, Control styles

#### Utilities
- `ArcaneStyles` - Style helper utilities
- Color utilities and extensions
