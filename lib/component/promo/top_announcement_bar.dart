import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

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

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneTopAnnouncementBar({
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.showCopyButton = true,
    this.styles,
    this.decoration,
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
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}

typedef ATopAnnouncementBar = ArcaneTopAnnouncementBar;
