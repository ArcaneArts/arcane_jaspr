import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

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
  final PromoInlineHeroBannerStyle variant;
  final bool dismissible;
  final Widget? icon;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ArcaneInlineHeroBanner({
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.variant = PromoInlineHeroBannerStyle.pill,
    this.dismissible = true,
    this.icon,
    this.styles,
    this.decoration,
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
      variant: component.variant,
      dismissible: component.dismissible,
      icon: component.icon,
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}

typedef AInlineHeroBanner = ArcaneInlineHeroBanner;
