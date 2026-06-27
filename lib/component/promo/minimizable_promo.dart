import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

/// A promo drawer that slides in from the right edge.
///
/// When minimized, only a slim tab is visible. Click to expand the full panel.
class ArcaneMinimizablePromo extends StatefulWidget {
  final String title;
  final String message;
  final String? promoCode;
  final String? discount;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final String tabLabel;
  final int delayMs;

  const ArcaneMinimizablePromo({
    required this.title,
    required this.message,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.tabLabel = 'DEAL',
    this.delayMs = 2000,
    super.key,
  });

  @override
  State<ArcaneMinimizablePromo> createState() => _ArcaneMinimizablePromoState();
}

class _ArcaneMinimizablePromoState extends State<ArcaneMinimizablePromo> {
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

    return context.renderers.minimizablePromo(MinimizablePromoProps(
      title: component.title,
      message: component.message,
      promoCode: component.promoCode,
      discount: component.discount,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      tabLabel: component.tabLabel,
      delayMs: component.delayMs,
    ));
  }
}

typedef AMinimizablePromo = ArcaneMinimizablePromo;
