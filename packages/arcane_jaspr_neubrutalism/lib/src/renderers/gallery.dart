import 'package:arcane_jaspr/core/props/gallery_props.dart';
import 'package:arcane_jaspr/core/rendering/base/gallery_render_base.dart';

/// Neubrutalism gallery renderer.
///
/// Mirrors the neubrutalism card idiom (`NeubrutalismCard`): a chunky paper
/// tile with a thick ink border, a hard offset drop shadow, and squared-off
/// corners.
class NeubrutalismGallery extends GalleryRenderBase {
  const NeubrutalismGallery(super.props, {super.key});

  @override
  String get surfaceClass => 'neubrutalism-gallery';

  @override
  String get tileClass => 'neubrutalism-gallery-tile';

  @override
  Map<String, String> tileStyles(ArcaneGalleryTile tile) =>
      const <String, String>{
        'background': 'var(--nb-paper, var(--card))',
        'color': 'var(--card-foreground)',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'border-radius': '0',
        'box-shadow':
            'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      };
}
