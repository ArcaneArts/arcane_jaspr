import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/arcane.dart';

/// A panel component for action buttons, typically used in dialogs or footers.
///
/// Provides consistent spacing and alignment for button groups.
class ArcaneButtonPanel extends StatelessComponent {
  /// The button components
  final List<Component> children;

  /// Main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Gap between buttons
  final double gap;

  /// Whether to stack vertically on small screens
  final bool responsive;

  /// Padding around the panel
  final EdgeInsets? padding;

  const ArcaneButtonPanel({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.gap = 8,
    this.responsive = true,
    this.padding,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final EdgeInsets effectivePadding = padding ?? const EdgeInsets.symmetric(vertical: 8);

    return div(
      classes: 'arcane-button-panel',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'justify-content': mainAxisAlignment.css,
        'align-items': 'center',
        'gap': '${gap}px',
        'padding': effectivePadding.padding,
      }),
      children,
    );
  }
}

/// A toolbar component for a horizontal bar of actions
class ArcaneToolbar extends StatelessComponent {
  final List<Component> children;
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
  Component build(BuildContext context) {
    final EdgeInsets effectivePadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4);

    return div(
      classes: 'arcane-toolbar',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'row',
        'justify-content': mainAxisAlignment.css,
        'align-items': crossAxisAlignment.css,
        'gap': '${gap}px',
        'padding': effectivePadding.padding,
      }),
      children,
    );
  }
}

/// A group of related buttons or controls
class ArcaneButtonGroup extends StatelessComponent {
  final List<Component> children;
  final bool vertical;
  final double gap;

  const ArcaneButtonGroup({
    required this.children,
    this.vertical = false,
    this.gap = 0,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-button-group',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': vertical ? 'column' : 'row',
        if (gap > 0) 'gap': '${gap}px',
      }),
      children,
    );
  }
}
