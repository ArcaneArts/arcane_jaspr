import 'package:arcane_jaspr/flutter.dart';

import '../../util/arcane.dart';
import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

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

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ToolbarProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.gap = 8,
    this.padding,
    this.styles,
    this.decoration,
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
