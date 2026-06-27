import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

export '../../core/props/button_panel_props.dart';

/// A panel component for action buttons, typically used in dialogs or footers.
class ButtonPanel extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final double gap;
  final bool responsive;
  final EdgeInsets? padding;

  const ButtonPanel({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.gap = 8,
    this.responsive = true,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.buttonPanel(ButtonPanelProps(
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      gap: gap,
      responsive: responsive,
      padding: padding,
    ));
  }
}

/// A toolbar component for a horizontal bar of actions.
class ArcaneToolbar extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double gap;
  final EdgeInsets? padding;

  const ArcaneToolbar({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.gap = 8,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.toolbar(ToolbarProps(
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      gap: gap,
      padding: padding,
    ));
  }
}

/// A group of related buttons or controls.
class ButtonGroup extends StatelessWidget {
  final List<Widget> children;
  final bool vertical;
  final double spacing;

  const ButtonGroup({
    required this.children,
    this.vertical = false,
    this.spacing = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.buttonGroup(ButtonGroupProps(
      children: children,
      vertical: vertical,
      spacing: spacing,
    ));
  }
}
