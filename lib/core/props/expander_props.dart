import 'package:arcane_jaspr/flutter.dart';

import '../../util/arcane.dart';

/// Expander component properties.
class ExpanderProps {
  final Widget header;
  final Widget child;
  final bool initiallyExpanded;
  final void Function(bool expanded)? onExpansionChanged;
  final Widget? leading;
  final bool showIcon;
  final EdgeInsets? contentPadding;
  final bool maintainState;

  const ExpanderProps({
    required this.header,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.leading,
    this.showIcon = true,
    this.contentPadding,
    this.maintainState = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for expander components.
mixin ExpanderRendererContract {
  Widget expander(ExpanderProps props);
}
