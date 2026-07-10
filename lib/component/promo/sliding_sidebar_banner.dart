import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// A vertical sidebar banner that slides in from the edge of the screen.
///
/// Great for detailed promotions with more content space.
class ArcaneSlidingSidebarBanner extends StatefulWidget {
  final String title;
  final String message;
  final String? subtitle;
  final String? promoCode;
  final String? discount;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final PromoSidebarPosition position;
  final int delayMs;
  final List<String>? features;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneSlidingSidebarBanner({
    required this.title,
    required this.message,
    this.subtitle,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.position = PromoSidebarPosition.right,
    this.delayMs = 3000,
    this.features,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  State<ArcaneSlidingSidebarBanner> createState() =>
      _ArcaneSlidingSidebarBannerState();
}

class _ArcaneSlidingSidebarBannerState
    extends State<ArcaneSlidingSidebarBanner> {
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

    return context.renderers.slidingSidebarBanner(SlidingSidebarBannerProps(
      title: component.title,
      message: component.message,
      subtitle: component.subtitle,
      promoCode: component.promoCode,
      discount: component.discount,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      position: component.position,
      delayMs: component.delayMs,
      features: component.features,
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}

typedef ASlidingSidebarBanner = ArcaneSlidingSidebarBanner;
