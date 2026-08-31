import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

export '../../core/props/flexi_cards_props.dart';

/// Interactive card group where hovering magnifies focused card while shrinking others.
class ArcaneFlexiCards extends StatelessWidget {
  final List<FlexiCardItem> items;
  final double collapsedFlex;
  final double expandedFlex;
  final bool scaleHeight;
  final double heightScaleFactor;
  final String gap;
  final String minCardWidth;
  final int transitionDuration;
  final String? heightPreLock;
  final String? heightPostLock;
  final String? widthPreLock;
  final String? widthPostLock;

  const ArcaneFlexiCards({
    required this.items,
    this.collapsedFlex = 1.0,
    this.expandedFlex = 2.0,
    this.scaleHeight = false,
    this.heightScaleFactor = 1.05,
    this.gap = '1.5rem',
    this.minCardWidth = '200px',
    this.transitionDuration = 300,
    this.heightPreLock,
    this.heightPostLock,
    this.widthPreLock,
    this.widthPostLock,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.flexiCards(
      FlexiCardsProps(
        items: items,
        collapsedFlex: collapsedFlex,
        expandedFlex: expandedFlex,
        scaleHeight: scaleHeight,
        heightScaleFactor: heightScaleFactor,
        gap: gap,
        minCardWidth: minCardWidth,
        transitionDuration: transitionDuration,
        heightPreLock: heightPreLock,
        heightPostLock: heightPostLock,
        widthPreLock: widthPreLock,
        widthPostLock: widthPostLock,
      ),
    );
  }
}

/// Simpler flexi cards variant using CSS :hover without state management.
class ArcaneFlexiCardsSimple extends StatelessWidget {
  final List<FlexiCardItem> items;
  final String gap;

  const ArcaneFlexiCardsSimple({
    required this.items,
    this.gap = '1.5rem',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.flexiCardsSimple(
      FlexiCardsSimpleProps(items: items, gap: gap),
    );
  }
}
