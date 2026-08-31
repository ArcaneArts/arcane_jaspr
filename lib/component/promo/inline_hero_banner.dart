import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/flutter.dart';
import '../view/icon.dart';

import '../../core/theme_provider.dart';

/// A flat inline announcement that integrates with the hero section.
class ArcaneInlineHeroBanner extends StatefulWidget {
  final String message;
  final String? ctaText;
  final String? ctaHref;
  final void Function()? onCtaClick;
  final void Function()? onDismiss;
  final bool dismissible;
  final ArcaneGlyph? icon;

  const ArcaneInlineHeroBanner({
    required this.message,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.dismissible = true,
    this.icon,
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

    return context.renderers.inlineHeroBanner(
      InlineHeroBannerProps(
        message: component.message,
        ctaText: component.ctaText,
        ctaHref: component.ctaHref,
        onCtaClick: component.onCtaClick,
        onDismiss: component.dismissible ? _handleDismiss : null,
        dismissible: component.dismissible,
        icon: component.icon,
      ),
    );
  }
}

typedef AInlineHeroBanner = ArcaneInlineHeroBanner;
