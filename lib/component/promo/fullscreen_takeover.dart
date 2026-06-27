import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

/// A dramatic full-screen takeover for major promotions.
///
/// Use very sparingly - only for major sales events or first-time visitors.
class ArcaneFullscreenTakeover extends StatefulWidget {
  final String headline;
  final String subheadline;
  final String? description;
  final String? promoCode;
  final String? discount;
  final String? ctaText;
  final String? ctaHref;
  final String? secondaryCtaText;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final int delayMs;
  final Duration? countdownDuration;

  const ArcaneFullscreenTakeover({
    required this.headline,
    required this.subheadline,
    this.description,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.secondaryCtaText,
    this.onCtaClick,
    this.onDismiss,
    this.delayMs = 2000,
    this.countdownDuration,
    super.key,
  });

  @override
  State<ArcaneFullscreenTakeover> createState() =>
      _ArcaneFullscreenTakeoverState();
}

class _ArcaneFullscreenTakeoverState extends State<ArcaneFullscreenTakeover> {
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

    return context.renderers.fullscreenTakeover(FullscreenTakeoverProps(
      headline: component.headline,
      subheadline: component.subheadline,
      description: component.description,
      promoCode: component.promoCode,
      discount: component.discount,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      secondaryCtaText: component.secondaryCtaText,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      delayMs: component.delayMs,
      countdownDuration: component.countdownDuration,
    ));
  }
}

typedef AFullscreenTakeover = ArcaneFullscreenTakeover;
