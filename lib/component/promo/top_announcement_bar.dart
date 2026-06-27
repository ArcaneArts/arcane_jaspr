import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

/// A thin sticky announcement bar at the top of the page.
///
/// Shows promo message with optional CTA button and dismiss functionality.
class ArcaneTopAnnouncementBar extends StatefulWidget {
  final String message;
  final String? promoCode;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final bool showCopyButton;

  const ArcaneTopAnnouncementBar({
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.showCopyButton = true,
    super.key,
  });

  @override
  State<ArcaneTopAnnouncementBar> createState() =>
      _ArcaneTopAnnouncementBarState();
}

class _ArcaneTopAnnouncementBarState extends State<ArcaneTopAnnouncementBar> {
  bool _isDismissed = false;

  void _handleDismiss() {
    setState(() => _isDismissed = true);
    component.onDismiss?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) return const dom.div([]);

    return context.renderers.topAnnouncementBar(TopAnnouncementBarProps(
      message: component.message,
      promoCode: component.promoCode,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      showCopyButton: component.showCopyButton,
    ));
  }
}

typedef ATopAnnouncementBar = ArcaneTopAnnouncementBar;
