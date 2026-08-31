/// Font size presets using rem units
enum FontSize {
  xxs,
  xs,
  sm,
  md,
  base,
  lg,
  xl,
  xl2,
  xl3,
  xl4,
  xl5,
  hero,
  mega,
  inherit;

  String get css => switch (this) {
    FontSize.xxs => '0.625rem',
    FontSize.xs => '0.75rem',
    FontSize.sm => '0.875rem',
    FontSize.md => '0.9375rem',
    FontSize.base => '1rem',
    FontSize.lg => '1.125rem',
    FontSize.xl => '1.25rem',
    FontSize.xl2 => '1.5rem',
    FontSize.xl3 => '2rem',
    FontSize.xl4 => '2.5rem',
    FontSize.xl5 => '3rem',
    FontSize.hero => '3.5rem',
    FontSize.mega => '4.5rem',
    FontSize.inherit => 'inherit',
  };
}

/// Line height presets
enum LineHeight {
  none,
  tight,
  snug,
  normal,
  relaxed,
  loose;

  String get css => switch (this) {
    LineHeight.none => '1',
    LineHeight.tight => '1.1',
    LineHeight.snug => '1.25',
    LineHeight.normal => '1.5',
    LineHeight.relaxed => '1.625',
    LineHeight.loose => '2',
  };
}

/// Letter spacing presets
enum LetterSpacing {
  tighter,
  tight,
  normal,
  wide,
  wider,
  widest;

  String get css => switch (this) {
    LetterSpacing.tighter => '-0.05em',
    LetterSpacing.tight => '-0.025em',
    LetterSpacing.normal => '0',
    LetterSpacing.wide => '0.025em',
    LetterSpacing.wider => '0.05em',
    LetterSpacing.widest => '0.2em',
  };
}

/// Text decoration values
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

/// Text transform values
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

/// White space handling values
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

/// Word break values
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

/// Font family presets
enum FontFamily {
  sans,
  heading,
  mono,
  inherit;

  String get css => switch (this) {
    FontFamily.sans => "var(--font-sans, 'Akzidenz-GroteskPro')",
    FontFamily.heading => "var(--font-heading, 'ITCAvantGardeStd')",
    FontFamily.mono => "var(--font-mono, 'Hack')",
    FontFamily.inherit => 'inherit',
  };
}

/// Font style values
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
