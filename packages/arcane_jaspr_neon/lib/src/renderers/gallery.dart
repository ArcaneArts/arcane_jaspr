import 'package:arcane_jaspr/core/props/gallery_props.dart';
import 'package:arcane_jaspr/core/rendering/base/gallery_render_base.dart';

/// Neon gallery renderer.
///
/// Uses the same flat, neutral surface treatment as the rest of Neon.
class NeonGallery extends GalleryRenderBase {
  const NeonGallery(super.props, {super.key});

  @override
  String get surfaceClass => 'neon-gallery';

  @override
  String get tileClass => 'neon-gallery-tile';

  @override
  Map<String, String> tileStyles(ArcaneGalleryTile tile) =>
      const <String, String>{
        'background': 'var(--card)',
        'color': 'var(--card-foreground)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-md)',
      };
}
