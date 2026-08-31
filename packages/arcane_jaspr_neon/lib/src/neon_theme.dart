library;

/// The single supported Neon palette.
///
/// Green is the only chromatic design token. Surfaces, borders, and supporting
/// text are derived from a neutral grayscale by the stylesheet.
enum NeonTheme {
  green(color: 0xFF059669);

  /// Primary brand and interaction color.
  final int color;

  const NeonTheme({required this.color});
}
