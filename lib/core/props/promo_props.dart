import 'package:arcane_jaspr/flutter.dart';
import '../../component/view/icon.dart';

/// Props for the single flat announcement surface supported by Arcane.
class TopAnnouncementBarProps {
  final String message;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;

  const TopAnnouncementBarProps({
    required this.message,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
  });
}

/// Props for a flat, in-flow announcement row.
class InlineHeroBannerProps {
  final String message;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final bool dismissible;
  final ArcaneGlyph? icon;

  const InlineHeroBannerProps({
    required this.message,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.dismissible = true,
    this.icon,
  });
}

mixin PromoRendererContract {
  Widget topAnnouncementBar(TopAnnouncementBarProps props);

  Widget inlineHeroBanner(InlineHeroBannerProps props);
}
