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
/// app to include arcane's fallback scripts. Packed galleries can use
/// [minimumTileArea] and [targetTileArea], measured as column span times row
/// span, to keep artwork at a fairer visual weight while aspect ratio chooses
/// its shape. Set [draggableTiles] to let users reposition tiles within the
/// gallery. Windows 95 uses its visible title bar as the pointer handle;
/// card-style themes use the tile surface. Dragging also requires the fallback
/// scripts. Give the gallery an [id] and reorderable tiles a stable
/// [ArcaneGalleryTile.dragId] to retain offsets across complete DOM replacement.
class ArcaneGallery extends StatelessWidget {
  /// Stable DOM/state id for preserving drag offsets across root rerenders.
  final String? id;
  final List<ArcaneGalleryTile> tiles;
  final String ariaLabel;
  final ArcaneGalleryLayout layout;
  final bool packing;
  final bool draggableTiles;
  final double dragKeyboardStep;
  final double dragInset;
  final double minColumnWidth;
  final int? minimumTileArea;
  final int? targetTileArea;
  final String classes;

  const ArcaneGallery({
    this.id,
    required this.tiles,
    required this.ariaLabel,
    this.layout = ArcaneGalleryLayout.masonry,
    this.packing = false,
    this.draggableTiles = false,
    this.dragKeyboardStep = 16,
    this.dragInset = 4,
    this.minColumnWidth = 220,
    this.minimumTileArea,
    this.targetTileArea,
    this.classes = '',
    super.key,
  }) : assert(dragKeyboardStep > 0 && dragKeyboardStep < double.infinity),
       assert(dragInset >= 0 && dragInset < double.infinity),
       assert(minimumTileArea == null || minimumTileArea > 0),
       assert(targetTileArea == null || targetTileArea > 0),
       assert(
         minimumTileArea == null ||
             targetTileArea == null ||
             minimumTileArea <= targetTileArea,
       );

  @override
  Widget build(BuildContext context) => context.renderers.gallery(
    GalleryProps(
      id: id,
      tiles: tiles,
      ariaLabel: ariaLabel,
      layout: layout,
      packing: packing,
      draggableTiles: draggableTiles,
      dragKeyboardStep: dragKeyboardStep,
      dragInset: dragInset,
      minColumnWidth: minColumnWidth,
      minimumTileArea: minimumTileArea,
      targetTileArea: targetTileArea,
      classes: classes,
    ),
  );
}
