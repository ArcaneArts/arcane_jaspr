import '../tokens/tokens.dart';

/// Single-value spacing for uniform padding/margin
enum Spacing {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl,
  huge,
  massive;

  String get css => switch (this) {
        Spacing.none => ArcaneSpacing.none,
        Spacing.xs => ArcaneSpacing.xs,
        Spacing.sm => ArcaneSpacing.sm,
        Spacing.md => ArcaneSpacing.md,
        Spacing.lg => ArcaneSpacing.lg,
        Spacing.xl => ArcaneSpacing.xl,
        Spacing.xxl => ArcaneSpacing.xxl,
        Spacing.xxxl => ArcaneSpacing.xxxl,
        Spacing.huge => ArcaneSpacing.huge,
        Spacing.massive => ArcaneSpacing.massive,
      };

  double get value => switch (this) {
        Spacing.none => 0,
        Spacing.xs => ArcaneSpacing.xsNum,
        Spacing.sm => ArcaneSpacing.smNum,
        Spacing.md => ArcaneSpacing.mdNum,
        Spacing.lg => ArcaneSpacing.lgNum,
        Spacing.xl => ArcaneSpacing.xlNum,
        Spacing.xxl => ArcaneSpacing.xxlNum,
        Spacing.xxxl => ArcaneSpacing.xxxlNum,
        Spacing.huge => ArcaneSpacing.hugeNum,
        Spacing.massive => ArcaneSpacing.massiveNum,
      };
}

/// Compound padding presets for common patterns (vertical_horizontal)
enum PaddingPreset {
  /// No padding
  none,

  /// 4px all sides
  xs,

  /// 8px all sides
  sm,

  /// 16px all sides
  md,

  /// 24px all sides
  lg,

  /// 32px all sides
  xl,

  /// 48px all sides
  xxl,

  /// 64px all sides
  xxxl,

  /// 4px vertical, 16px horizontal
  xsMd,

  /// 8px vertical, 16px horizontal
  smMd,

  /// 16px vertical, 24px horizontal
  mdLg,

  /// 24px vertical, 32px horizontal
  lgXl,

  /// 4px vertical, 8px horizontal (small buttons)
  xsSm,

  /// 6px vertical, 12px horizontal (button small)
  buttonSm,

  /// 10px vertical, 16px horizontal (button medium)
  buttonMd,

  /// 12px vertical, 24px horizontal (button large)
  buttonLg,

  /// 16px vertical, 32px horizontal (card)
  card,

  /// 24px vertical, 48px horizontal (section)
  section,

  /// 80px vertical, 24px horizontal (page section)
  sectionY,

  /// 120px vertical, 24px horizontal (hero section)
  heroY,

  /// 96px vertical only (carousel sections, no horizontal padding)
  hugeY,

  /// 8px horizontal only
  horizontalSm,

  /// 16px horizontal only
  horizontalMd,

  /// 24px horizontal only
  horizontalLg,

  /// 16px vertical only
  verticalMd,

  /// 24px vertical only
  verticalLg,

  /// 8px top padding only
  topSm,

  /// 16px top padding only
  topMd,

  /// 24px top padding only
  topLg,

  /// 8px vertical, 24px horizontal (small-large)
  smLg,

  /// 12px vertical, 32px horizontal (medium-xl)
  mdXl,

  /// 32px horizontal only
  horizontalXl,

  /// 16px bottom only
  bottomMd,

  /// 2px vertical, 8px horizontal (badge/tag)
  badge,

  /// 2px vertical, 6px horizontal (inline code)
  inlineCode,

  /// 4px vertical, 12px horizontal (chip)
  chip;

  String get css => switch (this) {
        PaddingPreset.none => ArcaneSpacing.none,
        PaddingPreset.xs => ArcaneSpacing.xs,
        PaddingPreset.sm => ArcaneSpacing.sm,
        PaddingPreset.md => ArcaneSpacing.md,
        PaddingPreset.lg => ArcaneSpacing.lg,
        PaddingPreset.xl => ArcaneSpacing.xl,
        PaddingPreset.xxl => ArcaneSpacing.xxl,
        PaddingPreset.xxxl => ArcaneSpacing.xxxl,
        PaddingPreset.xsMd => '${ArcaneSpacing.xs} ${ArcaneSpacing.md}',
        PaddingPreset.smMd => '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        PaddingPreset.mdLg => '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
        PaddingPreset.lgXl => '${ArcaneSpacing.lg} ${ArcaneSpacing.xl}',
        PaddingPreset.xsSm => '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
        PaddingPreset.buttonSm => '6px 12px',
        PaddingPreset.buttonMd => '10px 16px',
        PaddingPreset.buttonLg => '12px 24px',
        PaddingPreset.card => '${ArcaneSpacing.md} ${ArcaneSpacing.xl}',
        PaddingPreset.section => '${ArcaneSpacing.lg} ${ArcaneSpacing.xxl}',
        PaddingPreset.sectionY => '${ArcaneSpacing.sectionY} ${ArcaneSpacing.lg}',
        PaddingPreset.heroY => '${ArcaneSpacing.heroY} ${ArcaneSpacing.lg}',
        PaddingPreset.hugeY => '${ArcaneSpacing.huge} 0',
        PaddingPreset.horizontalSm => '0 ${ArcaneSpacing.sm}',
        PaddingPreset.horizontalMd => '0 ${ArcaneSpacing.md}',
        PaddingPreset.horizontalLg => '0 ${ArcaneSpacing.lg}',
        PaddingPreset.verticalMd => '${ArcaneSpacing.md} 0',
        PaddingPreset.verticalLg => '${ArcaneSpacing.lg} 0',
        PaddingPreset.topSm => '${ArcaneSpacing.sm} 0 0 0',
        PaddingPreset.topMd => '${ArcaneSpacing.md} 0 0 0',
        PaddingPreset.topLg => '${ArcaneSpacing.lg} 0 0 0',
        PaddingPreset.smLg => '${ArcaneSpacing.sm} ${ArcaneSpacing.lg}',
        PaddingPreset.mdXl => '${ArcaneSpacing.md} ${ArcaneSpacing.xl}',
        PaddingPreset.horizontalXl => '0 ${ArcaneSpacing.xl}',
        PaddingPreset.bottomMd => '0 0 ${ArcaneSpacing.md} 0',
        PaddingPreset.badge => '2px 8px',
        PaddingPreset.inlineCode => '2px 6px',
        PaddingPreset.chip => '4px 12px',
      };
}

/// Compound margin presets for common patterns
enum MarginPreset {
  /// No margin
  none,

  /// 4px all sides
  xs,

  /// 8px all sides
  sm,

  /// 16px all sides
  md,

  /// 24px all sides
  lg,

  /// 32px all sides
  xl,

  /// Auto horizontal (centering)
  autoX,

  /// Auto vertical
  autoY,

  /// Auto all (center both axes)
  auto,

  /// 8px top only
  topSm,

  /// 16px top only
  topMd,

  /// 24px top only
  topLg,

  /// 4px bottom only
  bottomXs,

  /// 8px bottom only
  bottomSm,

  /// 16px bottom only
  bottomMd,

  /// 24px bottom only
  bottomLg,

  /// 32px bottom only
  bottomXl,

  /// 48px bottom only
  bottomXxl,

  /// 64px bottom only
  bottomXxxl,

  /// 4px top only
  topXs,

  /// 32px top only
  topXl,

  /// 48px top only
  topXxl,

  /// 8px vertical
  verticalSm,

  /// 16px vertical
  verticalMd,

  /// 24px vertical
  verticalLg,

  /// 32px vertical
  verticalXl,

  /// 8px horizontal
  horizontalSm,

  /// 16px horizontal
  horizontalMd,

  /// 24px horizontal
  horizontalLg,

  /// 8px right only
  rightSm,

  /// 16px right only
  rightMd,

  /// 24px right only
  rightLg,

  /// 8px left only
  leftSm,

  /// 16px left only
  leftMd,

  /// 24px left only
  leftLg,

  /// Centered horizontally with 16px bottom margin
  centerBottomMd,

  /// Centered horizontally with 24px bottom margin
  centerBottomLg,

  /// Centered horizontally with 32px bottom margin
  centerBottomXl,

  /// Centered horizontally with 48px bottom margin
  centerBottomXxl;

  String get css => switch (this) {
        MarginPreset.none => ArcaneSpacing.none,
        MarginPreset.xs => ArcaneSpacing.xs,
        MarginPreset.sm => ArcaneSpacing.sm,
        MarginPreset.md => ArcaneSpacing.md,
        MarginPreset.lg => ArcaneSpacing.lg,
        MarginPreset.xl => ArcaneSpacing.xl,
        MarginPreset.autoX => '0 auto',
        MarginPreset.autoY => 'auto 0',
        MarginPreset.auto => 'auto',
        MarginPreset.topXs => '${ArcaneSpacing.xs} 0 0 0',
        MarginPreset.topSm => '${ArcaneSpacing.sm} 0 0 0',
        MarginPreset.topMd => '${ArcaneSpacing.md} 0 0 0',
        MarginPreset.topLg => '${ArcaneSpacing.lg} 0 0 0',
        MarginPreset.topXl => '${ArcaneSpacing.xl} 0 0 0',
        MarginPreset.topXxl => '${ArcaneSpacing.xxl} 0 0 0',
        MarginPreset.bottomXs => '0 0 ${ArcaneSpacing.xs} 0',
        MarginPreset.bottomSm => '0 0 ${ArcaneSpacing.sm} 0',
        MarginPreset.bottomMd => '0 0 ${ArcaneSpacing.md} 0',
        MarginPreset.bottomLg => '0 0 ${ArcaneSpacing.lg} 0',
        MarginPreset.bottomXl => '0 0 ${ArcaneSpacing.xl} 0',
        MarginPreset.bottomXxl => '0 0 ${ArcaneSpacing.xxl} 0',
        MarginPreset.bottomXxxl => '0 0 ${ArcaneSpacing.xxxl} 0',
        MarginPreset.verticalSm => '${ArcaneSpacing.sm} 0',
        MarginPreset.verticalMd => '${ArcaneSpacing.md} 0',
        MarginPreset.verticalLg => '${ArcaneSpacing.lg} 0',
        MarginPreset.verticalXl => '${ArcaneSpacing.xl} 0',
        MarginPreset.horizontalSm => '0 ${ArcaneSpacing.sm}',
        MarginPreset.horizontalMd => '0 ${ArcaneSpacing.md}',
        MarginPreset.horizontalLg => '0 ${ArcaneSpacing.lg}',
        MarginPreset.rightSm => '0 ${ArcaneSpacing.sm} 0 0',
        MarginPreset.rightMd => '0 ${ArcaneSpacing.md} 0 0',
        MarginPreset.rightLg => '0 ${ArcaneSpacing.lg} 0 0',
        MarginPreset.leftSm => '0 0 0 ${ArcaneSpacing.sm}',
        MarginPreset.leftMd => '0 0 0 ${ArcaneSpacing.md}',
        MarginPreset.leftLg => '0 0 0 ${ArcaneSpacing.lg}',
        MarginPreset.centerBottomMd => '0 auto ${ArcaneSpacing.md} auto',
        MarginPreset.centerBottomLg => '0 auto ${ArcaneSpacing.lg} auto',
        MarginPreset.centerBottomXl => '0 auto ${ArcaneSpacing.xl} auto',
        MarginPreset.centerBottomXxl => '0 auto ${ArcaneSpacing.xxl} auto',
      };
}

/// Gap presets for flex/grid layouts
enum Gap {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl;

  String get css => switch (this) {
        Gap.none => ArcaneSpacing.none,
        Gap.xs => ArcaneSpacing.xs,
        Gap.sm => ArcaneSpacing.sm,
        Gap.md => ArcaneSpacing.md,
        Gap.lg => ArcaneSpacing.lg,
        Gap.xl => ArcaneSpacing.xl,
        Gap.xxl => ArcaneSpacing.xxl,
        Gap.xxxl => ArcaneSpacing.xxxl,
      };

  double get value => switch (this) {
        Gap.none => 0,
        Gap.xs => ArcaneSpacing.xsNum,
        Gap.sm => ArcaneSpacing.smNum,
        Gap.md => ArcaneSpacing.mdNum,
        Gap.lg => ArcaneSpacing.lgNum,
        Gap.xl => ArcaneSpacing.xlNum,
        Gap.xxl => ArcaneSpacing.xxlNum,
        Gap.xxxl => ArcaneSpacing.xxxlNum,
      };
}
