import 'package:arcane_jaspr/flutter.dart';

import '../../util/arcane.dart';

/// Button panel component properties.
class ButtonPanelProps {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final double gap;
  final bool responsive;
  final EdgeInsets? padding;

  const ButtonPanelProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.gap = 8,
    this.responsive = true,
    this.padding,
  });
}

/// Toolbar component properties.
class ToolbarProps {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double gap;
  final EdgeInsets? padding;

  const ToolbarProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.gap = 8,
    this.padding,
  });
}

/// Button group component properties.
class ButtonGroupProps {
  final List<Widget> children;
  final bool vertical;
  final double spacing;

  const ButtonGroupProps({
    required this.children,
    this.vertical = false,
    this.spacing = 8,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for button panel components.
mixin ButtonPanelRendererContract {
  Widget buttonPanel(ButtonPanelProps props);
  Widget toolbar(ToolbarProps props);
  Widget buttonGroup(ButtonGroupProps props);
}
