import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// Bottom floating banner that slides up with optional countdown timer.
///
/// Great for limited-time offers and flash sales.
class ArcaneBottomFloatingBanner extends StatefulWidget {
  final String title;
  final String message;
  final String? promoCode;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final Duration? countdownDuration;
  final DateTime? expiresAt;
  final int delayMs;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneBottomFloatingBanner({
    required this.title,
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.countdownDuration,
    this.expiresAt,
    this.delayMs = 2000,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  State<ArcaneBottomFloatingBanner> createState() =>
      _ArcaneBottomFloatingBannerState();
}

class _ArcaneBottomFloatingBannerState
    extends State<ArcaneBottomFloatingBanner> {
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

    return context.renderers.bottomFloatingBanner(BottomFloatingBannerProps(
      title: component.title,
      message: component.message,
      promoCode: component.promoCode,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      countdownDuration: component.countdownDuration,
      expiresAt: component.expiresAt,
      delayMs: component.delayMs,
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}

typedef ABottomFloatingBanner = ArcaneBottomFloatingBanner;
