import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// Full-screen modal popup for high-priority promotions.
///
/// Use sparingly - best for first-time visitors or major sales events.
class ArcanePromoModal extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? description;
  final String? promoCode;
  final String? discount;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final int delayMs;
  final Duration? countdownDuration;
  final Widget? heroImage;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcanePromoModal({
    required this.title,
    required this.subtitle,
    this.description,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.delayMs = 1000,
    this.countdownDuration,
    this.heroImage,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  State<ArcanePromoModal> createState() => _ArcanePromoModalState();
}

class _ArcanePromoModalState extends State<ArcanePromoModal> {
  bool _isVisible = false;
  bool _isDismissed = false;

  @override
  void initState() {
    super.initState();
    _scheduleAppear();
  }

  void _scheduleAppear() {
    Future<void>.delayed(Duration(milliseconds: component.delayMs), () {
      if (mounted && !_isDismissed) {
        setState(() => _isVisible = true);
      }
    });
  }

  void _handleDismiss() {
    setState(() {
      _isVisible = false;
      _isDismissed = true;
    });
    component.onDismiss?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed || !_isVisible) return const dom.div([]);

    return context.renderers.promoModal(PromoModalProps(
      title: component.title,
      subtitle: component.subtitle,
      description: component.description,
      promoCode: component.promoCode,
      discount: component.discount,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      delayMs: component.delayMs,
      countdownDuration: component.countdownDuration,
      heroImage: component.heroImage,
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}

typedef APromoModal = ArcanePromoModal;
