import 'package:arcane_jaspr/flutter.dart';

import '../../core/props/gallery_props.dart';
import '../../core/theme_provider.dart';

export '../../core/props/gallery_props.dart'
    show ArcaneGalleryMedia, ArcaneGalleryTile, ArcaneGalleryLayout;

/// A themeable masonry gallery of media tiles.
///
/// The active stylesheet decides the tile FRAME and the surface: Windows 95
/// renders titled windows on a teal desktop, shadcn renders clean cards,
/// neubrutalism renders hard-shadow blocks, neon renders glow frames. Arcane
/// owns the frame, the title/meta placement, and the layout; the consumer fills
/// the media ([ArcaneGalleryTile.mediaChild] or [ArcaneGalleryMedia.src]) and
/// the app-specific slots ([ArcaneGalleryTile.overlay], [ArcaneGalleryTile.footer]).
///
/// Layout is CSS-grid masonry by default (works with zero JS). Set [packing] to
/// enable the opt-in ratio-aware packer (squared-off bottoms) — it requires the
/// app to include arcane's fallback scripts.
class ArcaneGallery extends StatelessWidget {
  final List<ArcaneGalleryTile> tiles;
  final String ariaLabel;
  final ArcaneGalleryLayout layout;
  final bool packing;
  final double minColumnWidth;
  final String classes;

  const ArcaneGallery({
    required this.tiles,
    required this.ariaLabel,
    this.layout = ArcaneGalleryLayout.masonry,
    this.packing = false,
    this.minColumnWidth = 220,
    this.classes = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) => context.renderers.gallery(
        GalleryProps(
          tiles: tiles,
          ariaLabel: ariaLabel,
          layout: layout,
          packing: packing,
          minColumnWidth: minColumnWidth,
          classes: classes,
        ),
      );
}
