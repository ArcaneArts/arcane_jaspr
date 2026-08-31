/// Color variants for semantic meaning.
enum ColorVariant { primary, secondary, destructive, success, warning, info }

/// Style variants for visual treatment.
enum StyleVariant {
  solid,
  outline,
  ghost,
  link,

  /// Soft/subtle variant with muted background and border.
  /// Ideal for compact display labels such as "Pre-installed".
  soft,
}
