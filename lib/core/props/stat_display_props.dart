import 'package:arcane_jaspr/flutter.dart';

enum StatDisplayLayout {
  vertical,
  horizontal,
}

/// Stat display component properties.
class StatDisplayProps {
  final String value;
  final String label;
  final StatDisplayLayout layout;
  final String? valueColor;
  final String? labelColor;
  final String? valueFontSize;
  final String? labelFontSize;
  final String? textAlign;

  const StatDisplayProps({
    required this.value,
    required this.label,
    this.layout = StatDisplayLayout.vertical,
    this.valueColor,
    this.labelColor,
    this.valueFontSize,
    this.labelFontSize,
    this.textAlign,
  });
}

/// Stat row component properties.
class StatRowProps {
  final List<Widget> stats;
  final String? gap;
  final bool wrap;
  final String? justifyContent;

  const StatRowProps({
    required this.stats,
    this.gap,
    this.wrap = true,
    this.justifyContent,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for stat display components.
mixin StatDisplayRendererContract {
  Widget statDisplay(StatDisplayProps props);
  Widget statRow(StatRowProps props);
}
