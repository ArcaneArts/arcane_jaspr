import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

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

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

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
    this.styles,
    this.decoration,
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
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}

typedef AExpandingFabPromo = ArcaneExpandingFabPromo;
