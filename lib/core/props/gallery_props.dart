import 'package:arcane_jaspr/flutter.dart';

/// How an [ArcaneGallery] arranges its tiles.
enum ArcaneGalleryLayout {
  /// Variable-height masonry (aspect-ratio-driven row spans). Squared-off
  /// bottoms come from the opt-in packing script when enabled.
  masonry,

  /// Uniform aspect-locked grid cells.
  grid,
}

/// The primary media of a gallery tile.
///
/// [aspectRatio] (width / height) is REQUIRED — it drives the masonry row span
/// and the reserved-space box, so the layout is stable before images load. The
/// remaining fields feed the default `<img>` the render base emits; a consumer
/// that renders its own media element (canvas, protected-media blob, video)
/// passes [ArcaneGalleryTile.mediaChild] instead and only [aspectRatio] here.
class ArcaneGalleryMedia {
  final double aspectRatio;
  final String? src;
  final String? srcset;
  final String? thumbHash;
  final String alt;

  const ArcaneGalleryMedia({
    required this.aspectRatio,
    this.src,
    this.srcset,
    this.thumbHash,
    this.alt = '',
  });
}

/// One tile in an [ArcaneGallery]. Arcane owns the themed frame, the title/meta
/// placement, and the layout; the consumer fills the app-specific slots.
class ArcaneGalleryTile {
  /// Layout + default-image descriptor. Its [ArcaneGalleryMedia.aspectRatio] is
  /// always used; its image fields are used only when [mediaChild] is null.
  final ArcaneGalleryMedia media;

  /// Custom media element replacing the default `<img>` (e.g. a canvas or a
  /// hover-preview video). Sized by [media]'s aspect ratio.
  final Widget? mediaChild;

  /// The tile caption. Rendered as the win95 window title bar; the card-style
  /// themes (shadcn, neubrutalism, neon) suppress the visible caption for a
  /// clean media-only tile and expose it via the tile's `aria-label` instead.
  final String? title;

  /// Secondary line (author, subtitle).
  final String? meta;

  /// Wraps the tile in an `<a>` when set.
  final String? href;
  final void Function()? onTap;

  /// Slot: corner badges rendered over the media.
  final List<Widget> overlay;

  /// Slot: a stats / actions row under the media.
  final Widget? footer;

  final String classes;
  final Map<String, String> attributes;

  const ArcaneGalleryTile({
    required this.media,
    this.mediaChild,
    this.title,
    this.meta,
    this.href,
    this.onTap,
    this.overlay = const <Widget>[],
    this.footer,
    this.classes = '',
    this.attributes = const <String, String>{},
  });
}

/// Properties for the gallery surface, passed to `context.renderers.gallery`.
class GalleryProps {
  final List<ArcaneGalleryTile> tiles;
  final String ariaLabel;
  final ArcaneGalleryLayout layout;

  /// Opt-in ratio-aware packing (squared-off bottoms) via the fallback script.
  final bool packing;

  /// The `minmax()` minimum column width in px for the CSS-grid base.
  final double minColumnWidth;

  final String classes;

  const GalleryProps({
    required this.tiles,
    required this.ariaLabel,
    this.layout = ArcaneGalleryLayout.masonry,
    this.packing = false,
    this.minColumnWidth = 220,
    this.classes = '',
  });
}

/// Renderer contract for the gallery component.
mixin GalleryRendererContract {
  Widget gallery(GalleryProps props);
}
