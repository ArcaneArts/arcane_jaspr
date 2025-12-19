import '../tokens.dart';

// =============================================================================
// FAB STYLE PRESETS
// =============================================================================

/// FAB (Floating Action Button) styling presets
/// Use like: FAB(style: FABStyle.primary)
class FABStyle {
  final Map<String, String> base;

  const FABStyle._({required this.base});

  /// Primary FAB
  static const FABStyle primary = FABStyle._(
    base: {
      'background-color': ArcaneColors.accent,
      'color': ArcaneColors.accentForeground,
    },
  );

  /// Secondary FAB
  static const FABStyle secondary = FABStyle._(
    base: {
      'background-color': ArcaneColors.secondaryContainer,
      'color': ArcaneColors.onSecondaryContainer,
    },
  );

  /// Tertiary FAB
  static const FABStyle tertiary = FABStyle._(
    base: {
      'background-color': ArcaneColors.tertiaryContainer,
      'color': ArcaneColors.onTertiaryContainer,
    },
  );

  /// Surface FAB
  static const FABStyle surface = FABStyle._(
    base: {
      'background-color': ArcaneColors.surface,
      'color': ArcaneColors.onSurface,
      'border': '1px solid ${ArcaneColors.border}',
    },
  );

  /// Success FAB
  static const FABStyle success = FABStyle._(
    base: {
      'background-color': ArcaneColors.success,
      'color': ArcaneColors.successForeground,
    },
  );

  /// Destructive FAB
  static const FABStyle destructive = FABStyle._(
    base: {
      'background-color': ArcaneColors.error,
      'color': ArcaneColors.errorForeground,
    },
  );
}
