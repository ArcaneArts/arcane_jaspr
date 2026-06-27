import 'package:arcane_jaspr/flutter.dart';

/// Card section component properties.
class CardSectionProps {
  final String? header;
  final Widget? headerComponent;
  final List<Widget> children;
  final String? padding;
  final String? radius;
  final String? gap;
  final List<Widget>? trailing;

  const CardSectionProps({
    this.header,
    this.headerComponent,
    required this.children,
    this.padding,
    this.radius,
    this.gap,
    this.trailing,
  });
}

/// List card component properties.
class ListCardProps {
  final String? header;
  final List<Widget> children;
  final String? radius;
  final bool divided;

  const ListCardProps({
    this.header,
    required this.children,
    this.radius,
    this.divided = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for card section components.
mixin CardSectionRendererContract {
  Widget cardSection(CardSectionProps props);
  Widget listCard(ListCardProps props);
}
