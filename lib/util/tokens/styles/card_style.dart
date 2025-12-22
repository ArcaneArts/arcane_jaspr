import '../tokens.dart';

// =============================================================================
// CARD STYLE PRESETS
// =============================================================================

/// Card styling presets
/// Use like: ArcaneCard(style: CardStyle.elevated)
class CardStyle {
  final Map<String, String> styles;

  const CardStyle._(this.styles);

  /// Create a custom card style
  const CardStyle.custom(this.styles);

  /// Merge with additional styles
  Map<String, String> withOverrides(Map<String, String> overrides) {
    return {...styles, ...overrides};
  }

  /// Elevated card with shadow
  static const CardStyle elevated = CardStyle._({
    'background-color': ArcaneColors.card,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.border}',
    'box-shadow': ArcaneEffects.shadowMd,
  });

  /// Flat card without shadow
  static const CardStyle flat = CardStyle._({
    'background-color': ArcaneColors.card,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.border}',
    'box-shadow': ArcaneEffects.shadowNone,
  });

  /// Outlined card (border only)
  static const CardStyle outlined = CardStyle._({
    'background-color': ArcaneColors.transparent,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.border}',
  });

  /// Ghost card (no border, no background)
  static const CardStyle ghost = CardStyle._({
    'background-color': ArcaneColors.transparent,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': 'none',
  });

  /// Glass/frosted card
  static const CardStyle glass = CardStyle._({
    'background-color': ArcaneColors.onSurfaceAlpha05,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.onSurfaceAlpha10}',
    'backdrop-filter': ArcaneEffects.backdropBlur,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlur,
  });

  /// Interactive card (shows hover effect)
  static const CardStyle interactive = CardStyle._({
    'background-color': ArcaneColors.card,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.border}',
    'cursor': 'pointer',
  });

  /// Subtle card (minimal styling)
  static const CardStyle subtle = CardStyle._({
    'background-color': ArcaneColors.surfaceVariant,
    'border-radius': ArcaneRadius.lg,
    'transition': 'all ${ArcaneEffects.transitionNormal}',
    'border': '1px solid ${ArcaneColors.borderSubtle}',
  });
}
