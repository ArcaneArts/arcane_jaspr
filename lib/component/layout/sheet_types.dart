/// Sheet position (edge from which it slides)
enum SheetPosition {
  /// Slides up from bottom
  bottom,

  /// Slides down from top
  top,

  /// Slides in from right (action sheet style)
  end,

  /// Slides in from left
  start,
}

/// Sheet size variants
enum SheetSize {
  /// Compact - fits content
  auto,

  /// Small (30% viewport)
  sm,

  /// Medium (50% viewport)
  md,

  /// Large (70% viewport)
  lg,

  /// Nearly full (90% viewport)
  xl,

  /// Full viewport
  full,
}
