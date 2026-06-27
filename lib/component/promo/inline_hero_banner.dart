import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

/// An inline promotional banner that integrates with the hero section.
///
/// Can be displayed as a badge, ribbon, pill, or card style.
class ArcaneInlineHeroBanner extends StatefulWidget {
  final String message;
  final String? promoCode;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final PromoInlineHeroBannerStyle style;
  final bool dismissible;
  final Widget? icon;

  const ArcaneInlineHeroBanner({
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.style = PromoInlineHeroBannerStyle.pill,
    this.dismissible = true,
    this.icon,
    super.key,
  });

  @override
  State<ArcaneInlineHeroBanner> createState() => _ArcaneInlineHeroBannerState();
}

class _ArcaneInlineHeroBannerState extends State<ArcaneInlineHeroBanner> {
  bool _isDismissed = false;

  void _handleDismiss() {
    setState(() => _isDismissed = true);
    component.onDismiss?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) return const dom.div([]);

    return context.renderers.inlineHeroBanner(InlineHeroBannerProps(
      message: component.message,
      promoCode: component.promoCode,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: component.dismissible ? _handleDismiss : null,
      style: component.style,
      dismissible: component.dismissible,
      icon: component.icon,
    ));
  }
}

typedef AInlineHeroBanner = ArcaneInlineHeroBanner;
