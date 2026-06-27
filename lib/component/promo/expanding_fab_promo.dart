import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

/// A floating action button that expands to reveal a promo.
///
/// Minimally intrusive - user initiates the interaction.
class ArcaneExpandingFabPromo extends StatefulWidget {
  final String title;
  final String message;
  final String? promoCode;
  final String? discount;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final Widget? icon;

  const ArcaneExpandingFabPromo({
    required this.title,
    required this.message,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.icon,
    super.key,
  });

  @override
  State<ArcaneExpandingFabPromo> createState() =>
      _ArcaneExpandingFabPromoState();
}

class _ArcaneExpandingFabPromoState extends State<ArcaneExpandingFabPromo> {
  bool _isDismissed = false;

  void _handleDismiss() {
    setState(() => _isDismissed = true);
    component.onDismiss?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) return const dom.div([]);

    return context.renderers.expandingFabPromo(ExpandingFabPromoProps(
      title: component.title,
      message: component.message,
      promoCode: component.promoCode,
      discount: component.discount,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      icon: component.icon,
    ));
  }
}

typedef AExpandingFabPromo = ArcaneExpandingFabPromo;
