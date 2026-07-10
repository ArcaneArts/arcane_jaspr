import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// A corner toast-style promo notification that slides in from a corner.
///
/// Less intrusive than a modal, great for subtle promotions.
class ArcaneCornerPromoToast extends StatefulWidget {
  final String title;
  final String message;
  final String? promoCode;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final PromoCornerPosition position;
  final int delayMs;
  final Widget? icon;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ArcaneCornerPromoToast({
    required this.title,
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.position = PromoCornerPosition.bottomRight,
    this.delayMs = 3000,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  State<ArcaneCornerPromoToast> createState() => _ArcaneCornerPromoToastState();
}

class _ArcaneCornerPromoToastState extends State<ArcaneCornerPromoToast> {
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

    return context.renderers.cornerPromoToast(CornerPromoToastProps(
      title: component.title,
      message: component.message,
      promoCode: component.promoCode,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      position: component.position,
      delayMs: component.delayMs,
      icon: component.icon,
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}

typedef ACornerPromoToast = ArcaneCornerPromoToast;
