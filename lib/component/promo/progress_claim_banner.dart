import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

/// A banner showing how many people have claimed an offer.
///
/// Creates urgency through social proof and scarcity.
class ArcaneProgressClaimBanner extends StatefulWidget {
  final String title;
  final String message;
  final String? promoCode;
  final int claimedCount;
  final int totalCount;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final int delayMs;
  final bool simulateProgress;

  const ArcaneProgressClaimBanner({
    required this.title,
    required this.message,
    required this.claimedCount,
    required this.totalCount,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.delayMs = 2000,
    this.simulateProgress = true,
    super.key,
  });

  @override
  State<ArcaneProgressClaimBanner> createState() =>
      _ArcaneProgressClaimBannerState();
}

class _ArcaneProgressClaimBannerState extends State<ArcaneProgressClaimBanner> {
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

    return context.renderers.progressClaimBanner(ProgressClaimBannerProps(
      title: component.title,
      message: component.message,
      promoCode: component.promoCode,
      claimedCount: component.claimedCount,
      totalCount: component.totalCount,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      delayMs: component.delayMs,
      simulateProgress: component.simulateProgress,
    ));
  }
}

typedef AProgressClaimBanner = ArcaneProgressClaimBanner;
