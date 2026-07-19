import 'package:arcane_jaspr/core/props/gallery_props.dart';
import 'package:arcane_jaspr/core/rendering/base/gallery_render_base.dart';

/// Neon gallery renderer.
///
/// Mirrors the neon card idiom (`.neon-card`): a dark `--card` surface with a
/// primary-tinted edge and the signature neon glow carried by `box-shadow`
/// (`--neon-glow-sm`, falling back to the ambient `--shadow-sm`).
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
        'border':
            '1px solid color-mix(in srgb, var(--primary) 40%, var(--border))',
        'border-radius': 'var(--radius-lg, 0.75rem)',
        'box-shadow': 'var(--neon-glow-sm, var(--shadow-sm))',
      };
}
