import 'package:arcane_jaspr/flutter.dart';

/// Flexi card item data.
class FlexiCardItem {
  final Widget icon;
  final String shortText;
  final String longText;
  final Widget? header;
  final Widget? footer;
  final void Function()? onTap;
  final String? href;

  const FlexiCardItem({
    required this.icon,
    required this.shortText,
    required this.longText,
    this.header,
    this.footer,
    this.onTap,
    this.href,
  });
}

/// FlexiCards component properties.
class FlexiCardsProps {
  final List<FlexiCardItem> items;
  final double collapsedFlex;
  final double expandedFlex;
  final bool scaleHeight;
  final double heightScaleFactor;
  final String gap;
  final String minCardWidth;
  final int transitionDuration;
  final bool expandLongTextOnHover;
  final String? heightPreLock;
  final String? heightPostLock;
  final String? widthPreLock;
  final String? widthPostLock;

  const FlexiCardsProps({
    required this.items,
    this.collapsedFlex = 1.0,
    this.expandedFlex = 2.0,
    this.scaleHeight = false,
    this.heightScaleFactor = 1.05,
    this.gap = '1.5rem',
    this.minCardWidth = '200px',
    this.transitionDuration = 300,
    this.expandLongTextOnHover = true,
    this.heightPreLock,
    this.heightPostLock,
    this.widthPreLock,
    this.widthPostLock,
  });
}

/// FlexiCards simple component properties.
class FlexiCardsSimpleProps {
  final List<FlexiCardItem> items;
  final String gap;

  const FlexiCardsSimpleProps({
    required this.items,
    this.gap = '1.5rem',
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for flexi cards components.
mixin FlexiCardsRendererContract {
  Widget flexiCards(FlexiCardsProps props);
  Widget flexiCardsSimple(FlexiCardsSimpleProps props);
}
