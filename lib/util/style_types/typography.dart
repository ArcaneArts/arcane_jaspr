import '../tokens/tokens.dart';

/// Font size presets using a modular typographic scale.
///
/// Sizes are defined in rem units for accessibility (respects user
/// browser font size preferences).
///
/// ## Size Scale
///
/// | Value    | Size          | Use Case                    |
/// |----------|---------------|------------------------------|
/// | `xs`     | 12px / 0.75rem| Labels, captions            |
/// | `sm`     | 14px / 0.875rem| Secondary text, metadata   |
/// | `md`     | 15px / 0.9375rem| Standard UI text          |
/// | `base`   | 16px / 1rem   | Body text (default)         |
/// | `lg`     | 18px / 1.125rem| Large body, subheadings    |
/// | `xl`     | 20px / 1.25rem| Section headers             |
/// | `xl2`    | 24px / 1.5rem | H3 headings                 |
/// | `xl3`    | 32px / 2rem   | H2 headings                 |
/// | `xl4`    | 40px / 2.5rem | H1 headings                 |
/// | `xl5`    | 48px / 3rem   | Hero headings               |
/// | `hero`   | 56px / 3.5rem | Display text                |
/// | `mega`   | 72px / 4.5rem | Oversized display           |
///
/// ## Example
///
/// ```dart
/// ArcaneText(
///   'Welcome',
///   size: FontSize.xl3,        // H2 size
///   weight: FontWeight.w700,
/// )
/// ```
enum FontSize {
  /// Extra small (12px / 0.75rem)
  xs,

  /// Small (14px / 0.875rem)
  sm,

  /// Medium (15px / 0.9375rem)
  md,

  /// Base (16px / 1rem)
  base,

  /// Large (18px / 1.125rem)
  lg,

  /// Extra large (20px / 1.25rem)
  xl,

  /// 2x large (24px / 1.5rem)
  xl2,

  /// 3x large (32px / 2rem)
  xl3,

  /// 4x large (40px / 2.5rem)
  xl4,

  /// 5x large (48px / 3rem)
  xl5,

  /// Hero size (56px / 3.5rem)
  hero,

  /// Mega size (72px / 4.5rem)
  mega,

  /// Inherit from parent
  inherit;

  String get css => switch (this) {
        FontSize.xs => ArcaneTypography.fontXs,
        FontSize.sm => ArcaneTypography.fontSizeSm,
        FontSize.md => ArcaneTypography.fontSizeMd,
        FontSize.base => ArcaneTypography.fontSizeBase,
        FontSize.lg => ArcaneTypography.fontLg,
        FontSize.xl => ArcaneTypography.fontXl,
        FontSize.xl2 => ArcaneTypography.font2xl,
        FontSize.xl3 => ArcaneTypography.font3xl,
        FontSize.xl4 => ArcaneTypography.font4xl,
        FontSize.xl5 => ArcaneTypography.font5xl,
        FontSize.hero => ArcaneTypography.fontHero,
        FontSize.mega => ArcaneTypography.fontMega,
        FontSize.inherit => 'inherit',
      };
}

/// Line height presets for controlling vertical rhythm.
///
/// Proper line height improves readability, especially for longer text.
///
/// ## Line Height Scale
///
/// | Value     | Ratio | Use Case                        |
/// |-----------|-------|---------------------------------|
/// | `none`    | 1     | Single line, icons              |
/// | `tight`   | 1.1   | Headings, display text          |
/// | `snug`    | 1.25  | Short paragraphs                |
/// | `normal`  | 1.5   | Body text (default)             |
/// | `relaxed` | 1.7   | Long-form content               |
/// | `loose`   | 2     | Maximum readability             |
///
/// ## Example
///
/// ```dart
/// ArcaneText(
///   'Long paragraph...',
///   lineHeight: LineHeight.relaxed,  // Better for reading
/// )
/// ```
enum LineHeight {
  /// None (1)
  none,

  /// Tight (1.1)
  tight,

  /// Snug (1.25)
  snug,

  /// Normal (1.5)
  normal,

  /// Relaxed (1.7)
  relaxed,

  /// Loose (2)
  loose;

  String get css => switch (this) {
        LineHeight.none => '1',
        LineHeight.tight => ArcaneTypography.lineHeightTight,
        LineHeight.snug => ArcaneTypography.lineHeightSnug,
        LineHeight.normal => ArcaneTypography.lineHeightNormal,
        LineHeight.relaxed => ArcaneTypography.lineHeightRelaxed,
        LineHeight.loose => '2',
      };
}

/// Letter spacing presets
enum LetterSpacing {
  /// Tighter (-0.05em)
  tighter,

  /// Tight (-0.02em)
  tight,

  /// Normal (0)
  normal,

  /// Wide (0.05em)
  wide,

  /// Wider (0.1em)
  wider,

  /// Widest (0.2em)
  widest;

  String get css => switch (this) {
        LetterSpacing.tighter => '-0.05em',
        LetterSpacing.tight => ArcaneTypography.letterSpacingTight,
        LetterSpacing.normal => ArcaneTypography.letterSpacingNormal,
        LetterSpacing.wide => ArcaneTypography.letterSpacingWide,
        LetterSpacing.wider => ArcaneTypography.letterSpacingWidest,
        LetterSpacing.widest => '0.2em',
      };
}

/// Text decoration
enum TextDecoration {
  none,
  underline,
  overline,
  lineThrough;

  String get css => switch (this) {
        TextDecoration.none => 'none',
        TextDecoration.underline => 'underline',
        TextDecoration.overline => 'overline',
        TextDecoration.lineThrough => 'line-through',
      };
}

/// Text transform
enum TextTransform {
  none,
  uppercase,
  lowercase,
  capitalize;

  String get css => switch (this) {
        TextTransform.none => 'none',
        TextTransform.uppercase => 'uppercase',
        TextTransform.lowercase => 'lowercase',
        TextTransform.capitalize => 'capitalize',
      };
}

/// White space handling
enum WhiteSpace {
  normal,
  nowrap,
  pre,
  preWrap,
  preLine,
  breakSpaces;

  String get css => switch (this) {
        WhiteSpace.normal => 'normal',
        WhiteSpace.nowrap => 'nowrap',
        WhiteSpace.pre => 'pre',
        WhiteSpace.preWrap => 'pre-wrap',
        WhiteSpace.preLine => 'pre-line',
        WhiteSpace.breakSpaces => 'break-spaces',
      };
}

/// Word break
enum WordBreak {
  normal,
  breakAll,
  keepAll,
  breakWord;

  String get css => switch (this) {
        WordBreak.normal => 'normal',
        WordBreak.breakAll => 'break-all',
        WordBreak.keepAll => 'keep-all',
        WordBreak.breakWord => 'break-word',
      };
}

/// Font family presets for the Arcane design system.
///
/// The Arcane theme uses carefully selected font stacks for optimal
/// readability and brand consistency.
///
/// ## Font Families
///
/// | Value     | Stack                       | Use Case           |
/// |-----------|-----------------------------|--------------------|
/// | `sans`    | Akzidenz-GroteskPro, system | Body text, UI      |
/// | `heading` | ITCAvantGardeStd            | Headings, display  |
/// | `mono`    | JetBrains Mono              | Code, data         |
/// | `inherit` | inherit                     | From parent        |
///
/// ## Example
///
/// ```dart
/// ArcaneText(
///   'function myCode()',
///   fontFamily: FontFamily.mono,  // Monospace for code
/// )
/// ```
enum FontFamily {
  /// System sans-serif (Akzidenz-GroteskPro, etc.)
  sans,

  /// Heading font (ITCAvantGardeStd)
  heading,

  /// Monospace (JetBrains Mono, etc.)
  mono,

  /// Inherit from parent
  inherit;

  String get css => switch (this) {
        FontFamily.sans => ArcaneTypography.fontFamily,
        FontFamily.heading => ArcaneTypography.fontFamilyHeading,
        FontFamily.mono => ArcaneTypography.fontFamilyMono,
        FontFamily.inherit => 'inherit',
      };
}

/// Font style
enum FontStyle {
  normal,
  italic,
  oblique;

  String get css => switch (this) {
        FontStyle.normal => 'normal',
        FontStyle.italic => 'italic',
        FontStyle.oblique => 'oblique',
      };
}
