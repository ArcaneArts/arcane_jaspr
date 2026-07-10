import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// A scrolling marquee-style announcement bar.
///
/// Great for creating urgency with continuous movement.
class ArcaneMarqueeTickerBar extends StatefulWidget {
  final List<String> messages;
  final String? promoCode;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final bool showAtBottom;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const ArcaneMarqueeTickerBar({
    required this.messages,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.showAtBottom = false,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  State<ArcaneMarqueeTickerBar> createState() => _ArcaneMarqueeTickerBarState();
}

class _ArcaneMarqueeTickerBarState extends State<ArcaneMarqueeTickerBar> {
  bool _isDismissed = false;

  void _handleDismiss() {
    setState(() => _isDismissed = true);
    component.onDismiss?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) return const dom.div([]);

    return context.renderers.marqueeTickerBar(MarqueeTickerBarProps(
      messages: component.messages,
      promoCode: component.promoCode,
      ctaText: component.ctaText,
      ctaHref: component.ctaHref,
      onCtaClick: component.onCtaClick,
      onDismiss: _handleDismiss,
      showAtBottom: component.showAtBottom,
      styles: component.styles,
      decoration: component.decoration,
    ));
  }
}

typedef AMarqueeTickerBar = ArcaneMarqueeTickerBar;
