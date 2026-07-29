library;

/// Pixel-art palettes available for the Windows loader.
///
/// The active [Win95Stylesheet] owns this choice, so standalone spinners,
/// loading buttons, authentication guards, selects, and toasts all use the
/// same loader without per-component configuration.
enum Win95LoaderPalette {
  /// Black-and-white Windows hourglass.
  win98,

  /// Amber monochrome terminal hourglass.
  amber,

  /// Green Game Boy hourglass.
  gameboy,
}
