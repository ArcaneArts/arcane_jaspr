/// Centralized design tokens for Arcane Jaspr
/// All values are static const strings that reference CSS variables for theme reactivity
/// or provide consistent static values for spacing, typography, etc.

// =============================================================================
// COLORS
// =============================================================================

/// Color tokens referencing CSS variables for dynamic theming
class ArcaneColors {
  ArcaneColors._();

  // ---------------------------------------------------------------------------
  // Brand/Accent Colors (theme-reactive via CSS variables)
  // ---------------------------------------------------------------------------

  /// Primary accent color
  static const String accent = 'var(--arcane-accent)';

  /// Accent color on hover
  static const String accentHover = 'var(--arcane-accent-hover)';

  /// Accent container/background
  static const String accentContainer = 'var(--arcane-accent-container)';

  /// Text on accent backgrounds
  static const String accentForeground = 'var(--arcane-accent-foreground)';

  // ---------------------------------------------------------------------------
  // Semantic Status Colors
  // ---------------------------------------------------------------------------

  /// Success/positive state
  static const String success = 'var(--arcane-success)';
  static const String successForeground = 'var(--arcane-success-foreground)';
  static const String successHover = 'var(--arcane-success-hover)';
  static const String successContainer = 'var(--arcane-success-container)';

  /// Warning/caution state
  static const String warning = 'var(--arcane-warning)';
  static const String warningForeground = 'var(--arcane-warning-foreground)';

  /// Error/destructive state
  static const String error = 'var(--arcane-destructive)';
  static const String errorForeground = 'var(--arcane-destructive-foreground)';

  /// Informational state
  static const String info = 'var(--arcane-info)';
  static const String infoForeground = 'var(--arcane-info-foreground)';

  // ---------------------------------------------------------------------------
  // Surface/Background Colors
  // ---------------------------------------------------------------------------

  /// Main background
  static const String background = 'var(--arcane-background)';

  /// Primary surface
  static const String surface = 'var(--arcane-surface)';

  /// Variant surface (slightly different from primary)
  static const String surfaceVariant = 'var(--arcane-surface-variant)';

  /// Card/elevated surface background
  static const String card = 'var(--arcane-card)';

  /// Card foreground/text
  static const String cardForeground = 'var(--arcane-card-foreground)';

  /// Input field background
  static const String input = 'var(--arcane-input)';

  /// Input field foreground
  static const String inputForeground = 'var(--arcane-input-foreground)';

  // ---------------------------------------------------------------------------
  // Text Colors
  // ---------------------------------------------------------------------------

  /// Text on background
  static const String onBackground = 'var(--arcane-on-background)';

  /// Text on surface
  static const String onSurface = 'var(--arcane-on-surface)';

  /// Text on surface variant
  static const String onSurfaceVariant = 'var(--arcane-on-surface-variant)';

  /// Muted/secondary text
  static const String muted = 'var(--arcane-muted)';

  /// Muted foreground text
  static const String mutedForeground = 'var(--arcane-muted-foreground)';

  // ---------------------------------------------------------------------------
  // Border Colors
  // ---------------------------------------------------------------------------

  /// Primary border
  static const String border = 'var(--arcane-border)';

  /// Subtle border
  static const String borderSubtle = 'var(--arcane-border-subtle)';

  /// Focus ring color
  static const String ring = 'var(--arcane-ring)';

  // ---------------------------------------------------------------------------
  // Special
  // ---------------------------------------------------------------------------

  /// Transparent
  static const String transparent = 'transparent';

  /// Pure white
  static const String white = '#FFFFFF';

  /// Pure black
  static const String black = '#000000';

  // ---------------------------------------------------------------------------
  // Overlay/Modal Colors
  // ---------------------------------------------------------------------------

  /// Background overlay (for modals/dialogs)
  static const String backgroundOverlay = 'rgba(0, 0, 0, 0.6)';

  /// Tooltip background
  static const String tooltip = 'var(--arcane-tooltip)';

  /// Tooltip text
  static const String tooltipForeground = 'var(--arcane-tooltip-foreground)';

  /// Code block background
  static const String codeBackground = 'var(--arcane-code-background)';

  // ---------------------------------------------------------------------------
  // Extended Background Colors
  // ---------------------------------------------------------------------------

  /// Secondary background
  static const String backgroundSecondary = 'var(--arcane-background-secondary)';

  /// Tertiary background
  static const String backgroundTertiary = 'var(--arcane-background-tertiary)';

  /// Card hover state
  static const String cardHover = 'var(--arcane-card-hover)';

  /// Alternate card background
  static const String cardAlt = 'var(--arcane-card-alt)';

  /// Navbar background (with transparency)
  static const String navbar = 'var(--arcane-navbar)';

  // ---------------------------------------------------------------------------
  // Extended Border Colors
  // ---------------------------------------------------------------------------

  /// Medium border (more visible than subtle)
  static const String borderMedium = 'rgba(255, 255, 255, 0.1)';

  /// Light border (most visible)
  static const String borderLight = 'rgba(255, 255, 255, 0.15)';

  // ---------------------------------------------------------------------------
  // Extended Text Colors
  // ---------------------------------------------------------------------------

  /// Subtle text (less visible than muted)
  static const String textSubtle = 'var(--arcane-text-subtle)';

  /// Faint text (least visible)
  static const String textFaint = 'var(--arcane-text-faint)';

  // ---------------------------------------------------------------------------
  // Neon/Gaming Colors
  // ---------------------------------------------------------------------------

  /// Neon pink
  static const String neonPink = '#EC4899';

  /// Neon cyan
  static const String neonCyan = '#06B6D4';

  /// Neon purple
  static const String neonPurple = '#8B5CF6';

  /// Neon green
  static const String neonGreen = '#10B981';

  /// Neon orange
  static const String neonOrange = '#F97316';

  // ---------------------------------------------------------------------------
  // Window/Terminal Dot Colors
  // ---------------------------------------------------------------------------

  /// Window close button (red)
  static const String windowDotRed = '#EF4444';

  /// Window minimize button (yellow)
  static const String windowDotYellow = '#F59E0B';

  /// Window maximize button (green)
  static const String windowDotGreen = '#10B981';

  // ---------------------------------------------------------------------------
  // Game-Specific Colors
  // ---------------------------------------------------------------------------

  /// Minecraft green
  static const String minecraftGreen = '#62B247';

  /// Rust orange
  static const String rustOrange = '#CE422B';

  /// ARK blue
  static const String arkBlue = '#6EC8E4';

  /// Valheim gold
  static const String valheimGold = '#D4A843';

  /// CS2 orange
  static const String cs2Orange = '#DE9B35';

  /// Terraria green
  static const String terrariaGreen = '#29A629';

  // ---------------------------------------------------------------------------
  // Core Color Scheme (Material-style)
  // ---------------------------------------------------------------------------

  static const String primary = 'var(--arcane-primary)';
  static const String onPrimary = 'var(--arcane-on-primary)';
  static const String primaryContainer = 'var(--arcane-primary-container)';
  static const String onPrimaryContainer = 'var(--arcane-on-primary-container)';

  static const String secondary = 'var(--arcane-secondary)';
  static const String onSecondary = 'var(--arcane-on-secondary)';
  static const String secondaryContainer = 'var(--arcane-secondary-container)';
  static const String onSecondaryContainer = 'var(--arcane-on-secondary-container)';

  static const String tertiary = 'var(--arcane-tertiary)';
  static const String onTertiary = 'var(--arcane-on-tertiary)';
  static const String tertiaryContainer = 'var(--arcane-tertiary-container)';
  static const String onTertiaryContainer = 'var(--arcane-on-tertiary-container)';

  static const String outline = 'var(--arcane-outline)';
  static const String outlineVariant = 'var(--arcane-outline-variant)';

  static const String shadow = 'var(--arcane-shadow)';
  static const String scrim = 'var(--arcane-scrim)';

  static const String inverseSurface = 'var(--arcane-inverse-surface)';
  static const String onInverseSurface = 'var(--arcane-on-inverse-surface)';
  static const String surfaceTint = 'var(--arcane-surface-tint)';
}

// =============================================================================
// SPACING
// =============================================================================

/// Spacing tokens for consistent padding, margin, and gap values
class ArcaneSpacing {
  ArcaneSpacing._();

  /// No spacing (0)
  static const String none = '0';

  /// Extra small (4px)
  static const String xs = '4px';

  /// Small (8px)
  static const String sm = '8px';

  /// Medium (16px)
  static const String md = '16px';

  /// Large (24px)
  static const String lg = '24px';

  /// Extra large (32px)
  static const String xl = '32px';

  /// 2x Extra large (48px)
  static const String xxl = '48px';

  /// 3x Extra large (64px)
  static const String xxxl = '64px';

  /// Huge (96px)
  static const String huge = '96px';

  /// Massive (120px)
  static const String massive = '120px';

  // ---------------------------------------------------------------------------
  // Numeric values for calculations
  // ---------------------------------------------------------------------------

  static const double xsNum = 4;
  static const double smNum = 8;
  static const double mdNum = 16;
  static const double lgNum = 24;
  static const double xlNum = 32;
  static const double xxlNum = 48;
  static const double xxxlNum = 64;
  static const double hugeNum = 96;
  static const double massiveNum = 120;

  // ---------------------------------------------------------------------------
  // Section-specific
  // ---------------------------------------------------------------------------

  /// Vertical section padding
  static const String sectionY = '80px';

  /// Hero section vertical padding
  static const String heroY = '120px';
}

// =============================================================================
// TYPOGRAPHY
// =============================================================================

/// Typography tokens for font sizes, weights, and line heights
class ArcaneTypography {
  ArcaneTypography._();

  // ---------------------------------------------------------------------------
  // Font Families
  // ---------------------------------------------------------------------------

  /// System/inherit font family (body text)
  static const String fontFamily =
      "'Akzidenz-GroteskPro', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif";

  /// Heading font family
  static const String fontFamilyHeading =
      "'ITCAvantGardeStd', 'Akzidenz-GroteskPro', -apple-system, BlinkMacSystemFont, sans-serif";

  /// Monospace font family
  static const String fontFamilyMono =
      "'JetBrains Mono', 'Fira Code', 'Consolas', monospace";

  // ---------------------------------------------------------------------------
  // Font Sizes
  // ---------------------------------------------------------------------------

  /// Extra small (12px / 0.75rem)
  static const String fontXs = '0.75rem';

  /// Small (13px / 0.8125rem)
  static const String fontSm = '0.8125rem';

  /// Medium (14px / 0.875rem)
  static const String fontMd = '0.875rem';

  /// Base (15px / 0.9375rem)
  static const String fontBase = '0.9375rem';

  /// Regular (16px / 1rem)
  static const String fontReg = '1rem';

  /// Large (18px / 1.125rem)
  static const String fontLg = '1.125rem';

  /// Extra large (20px / 1.25rem)
  static const String fontXl = '1.25rem';

  /// 2x large (24px / 1.5rem)
  static const String font2xl = '1.5rem';

  /// 3x large (32px / 2rem)
  static const String font3xl = '2rem';

  /// 4x large (40px / 2.5rem)
  static const String font4xl = '2.5rem';

  /// 5x large (48px / 3rem)
  static const String font5xl = '3rem';

  /// Hero size (56px / 3.5rem)
  static const String fontHero = '3.5rem';

  /// Mega size (72px / 4.5rem)
  static const String fontMega = '4.5rem';

  // ---------------------------------------------------------------------------
  // Font Size Aliases (compatibility with alternate naming)
  // ---------------------------------------------------------------------------

  static const String fontSizeXs = fontXs;
  static const String fontSizeSm = '0.875rem'; // 14px (qualitynode standard)
  static const String fontSizeMd = '0.9375rem'; // 15px (qualitynode standard)
  static const String fontSizeBase = '1rem'; // 16px (qualitynode standard)
  static const String fontSizeLg = fontLg;
  static const String fontSizeXl = fontXl;
  static const String fontSize2xl = font2xl;
  static const String fontSize3xl = font3xl;
  static const String fontSize4xl = font4xl;
  static const String fontSize5xl = font5xl;
  static const String fontSizeHero = fontHero;
  static const String fontSizeMega = fontMega;

  // ---------------------------------------------------------------------------
  // Font Weights
  // ---------------------------------------------------------------------------

  /// Normal weight (400)
  static const String weightNormal = '400';

  /// Medium weight (500)
  static const String weightMedium = '500';

  /// Semibold weight (600)
  static const String weightSemibold = '600';

  /// Bold weight (700)
  static const String weightBold = '700';

  /// Extra bold weight (800)
  static const String weightExtrabold = '800';

  // ---------------------------------------------------------------------------
  // Font Weight Aliases (compatibility with alternate naming)
  // ---------------------------------------------------------------------------

  static const String fontWeightNormal = weightNormal;
  static const String fontWeightMedium = weightMedium;
  static const String fontWeightSemibold = weightSemibold;
  static const String fontWeightBold = weightBold;
  static const String fontWeightExtrabold = weightExtrabold;

  // ---------------------------------------------------------------------------
  // Line Heights
  // ---------------------------------------------------------------------------

  /// Tight (1.1)
  static const String lineHeightTight = '1.1';

  /// Snug (1.25)
  static const String lineHeightSnug = '1.25';

  /// Normal (1.5)
  static const String lineHeightNormal = '1.5';

  /// Relaxed (1.7)
  static const String lineHeightRelaxed = '1.7';

  /// Alias for lineHeightNormal
  static const String leadingNormal = lineHeightNormal;

  /// Alias for lineHeightRelaxed
  static const String leadingRelaxed = lineHeightRelaxed;

  // ---------------------------------------------------------------------------
  // Letter Spacing
  // ---------------------------------------------------------------------------

  /// Tight letter spacing
  static const String letterSpacingTight = '-0.02em';

  /// Normal letter spacing
  static const String letterSpacingNormal = '0';

  /// Wide letter spacing
  static const String letterSpacingWide = '0.05em';

  /// Widest letter spacing
  static const String letterSpacingWidest = '0.1em';
}

// =============================================================================
// BORDER RADIUS
// =============================================================================

/// Border radius tokens (reference CSS variables for consistent theming)
class ArcaneRadius {
  ArcaneRadius._();

  /// No radius (0)
  static const String none = '0';

  /// Extra small radius
  static const String xs = '4px';

  /// Small radius (theme-reactive)
  static const String sm = 'var(--arcane-radius-sm)';

  /// Medium radius (theme-reactive)
  static const String md = 'var(--arcane-radius-md)';

  /// Large radius (theme-reactive)
  static const String lg = 'var(--arcane-radius-lg)';

  /// Extra large radius (theme-reactive)
  static const String xl = 'var(--arcane-radius-xl)';

  /// 2x Extra large radius (theme-reactive)
  static const String xxl = 'var(--arcane-radius-2xl)';

  /// Full/pill radius
  static const String full = 'var(--arcane-radius-full)';

  /// Circle (50%)
  static const String circle = '50%';

  // ---------------------------------------------------------------------------
  // Static fallbacks (for non-themed contexts)
  // ---------------------------------------------------------------------------

  static const String smStatic = '6px';
  static const String mdStatic = '8px';
  static const String lgStatic = '12px';
  static const String xlStatic = '16px';
  static const String xxlStatic = '24px';
  static const String fullStatic = '9999px';
}

// =============================================================================
// EFFECTS (Shadows, Transitions, Transforms)
// =============================================================================

/// Effect tokens for shadows, transitions, and animations
class ArcaneEffects {
  ArcaneEffects._();

  // ---------------------------------------------------------------------------
  // Transitions
  // ---------------------------------------------------------------------------

  /// Fast transition (150ms)
  static const String transitionFast = 'var(--arcane-transition-fast)';

  /// Normal transition (200ms)
  static const String transitionNormal = 'var(--arcane-transition)';

  /// Alias for transitionNormal
  static const String transition = transitionNormal;

  /// Slow transition (300ms)
  static const String transitionSlow = 'var(--arcane-transition-slow)';

  /// Bounce transition
  static const String transitionBounce =
      '0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';

  // ---------------------------------------------------------------------------
  // Shadows
  // ---------------------------------------------------------------------------

  /// No shadow
  static const String shadowNone = 'none';

  /// Extra small shadow
  static const String shadowXs = 'var(--arcane-shadow-xs)';

  /// Small shadow
  static const String shadowSm = 'var(--arcane-shadow-sm)';

  /// Medium shadow (default)
  static const String shadowMd = 'var(--arcane-shadow)';

  /// Large shadow
  static const String shadowLg = 'var(--arcane-shadow-lg)';

  /// Extra large shadow
  static const String shadowXl = 'var(--arcane-shadow-xl)';

  // ---------------------------------------------------------------------------
  // Static shadow fallbacks
  // ---------------------------------------------------------------------------

  static const String shadowSmStatic = '0 1px 2px rgba(0, 0, 0, 0.05)';
  static const String shadowMdStatic =
      '0 4px 6px -1px rgba(0, 0, 0, 0.2), 0 2px 4px -1px rgba(0, 0, 0, 0.1)';

  /// Card shadow (alias for shadowMdStatic)
  static const String shadowCard = shadowMdStatic;
  static const String shadowLgStatic =
      '0 10px 15px -3px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)';
  static const String shadowXlStatic =
      '0 20px 25px -5px rgba(0, 0, 0, 0.2), 0 10px 10px -5px rgba(0, 0, 0, 0.1)';

  // ---------------------------------------------------------------------------
  // Glow effects
  // ---------------------------------------------------------------------------

  /// Accent glow
  static const String glowAccent =
      '0 0 20px var(--arcane-accent), 0 0 40px var(--arcane-accent-container)';

  /// Success glow
  static const String glowSuccess =
      '0 0 20px var(--arcane-success), 0 0 40px rgba(16, 185, 129, 0.1)';

  /// Error glow
  static const String glowError =
      '0 0 20px var(--arcane-destructive), 0 0 40px rgba(239, 68, 68, 0.1)';

  // ---------------------------------------------------------------------------
  // Gaming/Neon Glows
  // ---------------------------------------------------------------------------

  /// Primary/Green glow (gaming)
  static const String glowPrimary =
      '0 0 20px rgba(16, 185, 129, 0.3), 0 0 40px rgba(16, 185, 129, 0.1)';

  /// Green glow
  static const String glowGreen =
      '0 0 20px rgba(16, 185, 129, 0.3), 0 0 40px rgba(16, 185, 129, 0.1)';

  /// Cyan glow
  static const String glowCyan =
      '0 0 20px rgba(6, 182, 212, 0.3), 0 0 40px rgba(6, 182, 212, 0.1)';

  /// Purple glow
  static const String glowPurple =
      '0 0 20px rgba(139, 92, 246, 0.3), 0 0 40px rgba(139, 92, 246, 0.1)';

  /// Orange glow
  static const String glowOrange =
      '0 0 20px rgba(249, 115, 22, 0.3), 0 0 40px rgba(249, 115, 22, 0.1)';

  /// Pink glow
  static const String glowPink =
      '0 0 20px rgba(236, 72, 153, 0.3), 0 0 40px rgba(236, 72, 153, 0.1)';

  // ---------------------------------------------------------------------------
  // Backdrop effects
  // ---------------------------------------------------------------------------

  /// Backdrop blur
  static const String backdropBlur = 'blur(12px)';

  /// Strong backdrop blur
  static const String backdropBlurStrong = 'blur(20px)';

  // ---------------------------------------------------------------------------
  // Hover transforms
  // ---------------------------------------------------------------------------

  /// Lift on hover
  static const String hoverLift = 'translateY(-4px)';

  /// Scale on hover
  static const String hoverScale = 'scale(1.02)';

  /// Subtle scale
  static const String hoverScaleSubtle = 'scale(1.01)';
}

// =============================================================================
// LAYOUT
// =============================================================================

/// Layout tokens for container widths, heights, and dimensions
class ArcaneLayout {
  ArcaneLayout._();

  // ---------------------------------------------------------------------------
  // Max Widths
  // ---------------------------------------------------------------------------

  /// Full width container (1440px)
  static const String maxWidthFull = '1440px';

  /// Main container (1280px)
  static const String maxWidthContainer = '1280px';

  /// Content area (1024px)
  static const String maxWidthContent = '1024px';

  /// Narrow content (768px)
  static const String maxWidthNarrow = '768px';

  /// Text column (640px)
  static const String maxWidthText = '640px';

  /// Form width (480px)
  static const String maxWidthForm = '480px';

  /// Card width (400px)
  static const String maxWidthCard = '400px';

  // ---------------------------------------------------------------------------
  // Component Heights
  // ---------------------------------------------------------------------------

  /// Header height
  static const String headerHeight = '72px';

  /// Sidebar width (expanded)
  static const String sidebarWidth = '280px';

  /// Sidebar width (collapsed)
  static const String sidebarCollapsed = '72px';

  /// Bottom nav height
  static const String bottomNavHeight = '64px';

  // ---------------------------------------------------------------------------
  // Input Heights
  // ---------------------------------------------------------------------------

  /// Small input height
  static const String inputHeightSm = '32px';

  /// Medium input height
  static const String inputHeightMd = '40px';

  /// Large input height
  static const String inputHeightLg = '48px';

  // ---------------------------------------------------------------------------
  // Button Heights
  // ---------------------------------------------------------------------------

  /// Small button height
  static const String buttonHeightSm = '32px';

  /// Medium button height
  static const String buttonHeightMd = '40px';

  /// Large button height
  static const String buttonHeightLg = '48px';
}

// =============================================================================
// Z-INDEX
// =============================================================================

/// Z-index tokens for layering
class ArcaneZIndex {
  ArcaneZIndex._();

  /// Dropdown menus
  static const String dropdown = '1000';

  /// Sticky elements
  static const String sticky = '1020';

  /// Fixed elements
  static const String fixed = '1030';

  /// Floating action button
  static const String fab = '1035';

  /// Modal backdrop
  static const String modalBackdrop = '1040';

  /// Modal content
  static const String modal = '1050';

  /// Popover
  static const String popover = '1060';

  /// Tooltip
  static const String tooltip = '1070';

  /// Toast notifications
  static const String toast = '1080';
}
