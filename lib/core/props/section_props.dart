import 'package:arcane_jaspr/flutter.dart';

/// Section component properties.
class SectionProps {
  final String? header;
  final Widget? headerComponent;
  final List<Widget> children;
  final bool showDivider;
  final String? padding;
  final String? gap;
  final bool card;

  const SectionProps({
    this.header,
    this.headerComponent,
    required this.children,
    this.showDivider = false,
    this.padding,
    this.gap,
    this.card = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for section components.
mixin SectionRendererContract {
  Widget section(SectionProps props);
}
