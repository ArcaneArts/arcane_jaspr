import 'package:arcane_jaspr/core/props/gallery_props.dart';
import 'package:arcane_jaspr/core/rendering/base/gallery_render_base.dart';

/// Shadcn gallery renderer.
///
/// Mirrors the shadcn card idiom (`ShadcnCard`): a clean bordered surface on
/// `--card` with the `--shadow-xs` ambient shadow and the theme `--radius`.
class ShadcnGallery extends GalleryRenderBase {
  const ShadcnGallery(super.props, {super.key});

  @override
  String get surfaceClass => 'shadcn-gallery';

  @override
  String get tileClass => 'shadcn-gallery-tile';

  // rounded-lg border bg-card text-card-foreground shadow-sm
  @override
  Map<String, String> tileStyles(ArcaneGalleryTile tile) =>
      const <String, String>{
        'background': 'var(--card)',
        'color': 'var(--card-foreground)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius, 0.5rem)',
        'box-shadow': 'var(--shadow-xs)',
      };
}
