import 'package:jaspr/jaspr.dart';

enum GutterSize {
  xsmall(4),
  small(8),
  medium(16),
  large(24),
  xlarge(32);

  final double pixels;
  const GutterSize(this.pixels);
}

/// Gutter/spacing component properties.
class GutterProps {
  final GutterSize size;
  final bool horizontal;

  const GutterProps({this.size = GutterSize.medium, this.horizontal = false});
}

/// Gap component properties.
class GapProps {
  final double size;
  final bool horizontal;

  const GapProps(this.size, {this.horizontal = false});
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for gutter/spacing components.
mixin GutterRendererContract {
  Component gutter(GutterProps props);
  Component gap(GapProps props);
}
