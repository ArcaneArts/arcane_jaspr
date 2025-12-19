import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';

/// A section component for grouping related content with an optional header.
class Section extends StatelessComponent {
  /// Optional section header text
  final String? header;

  /// Optional header component (overrides header text)
  final Component? headerComponent;

  /// The child components
  final List<Component> children;

  /// Whether to show a divider after the header
  final bool showDivider;

  /// Custom padding
  final EdgeInsets? padding;

  /// Gap between children
  final double gap;

  /// Whether this is a card-style section
  final bool card;

  const Section({
    this.header,
    this.headerComponent,
    required this.children,
    this.showDivider = false,
    this.padding,
    this.gap = 12,
    this.card = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final EdgeInsets effectivePadding = padding ?? const EdgeInsets.all(16);

    final Component? headerWidget = headerComponent ??
        (header != null
            ? div(
                classes: 'arcane-section-header',
                styles: Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': ArcaneColors.muted,
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'margin-bottom': '${gap}px',
                }),
                [text(header!)],
              )
            : null);

    final Component? dividerWidget = showDivider && headerWidget != null
        ? div(
            classes: 'arcane-section-divider',
            styles: Styles(raw: {
              'height': '1px',
              'background-color': ArcaneColors.border,
              'margin-bottom': '${gap}px',
            }),
            [],
          )
        : null;

    final Component content = div(
        classes: 'arcane-section-content',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '${gap}px',
        }),
        children);

    final List<Component> sectionChildren = <Component>[
      if (headerWidget != null) headerWidget,
      if (dividerWidget != null) dividerWidget,
      content,
    ];

    if (card) {
      return div(
        classes: 'arcane-section arcane-section-card',
        styles: Styles(raw: {
          'padding': effectivePadding.padding,
          'background-color': ArcaneColors.surface,
          'border-radius': ArcaneRadius.lg,
          'border': '1px solid ${ArcaneColors.border}',
        }),
        sectionChildren,
      );
    } else {
      return div(
        classes: 'arcane-section',
        styles: Styles(raw: {
          'padding': effectivePadding.padding,
        }),
        sectionChildren,
      );
    }
  }
}

/// A sliver-style section for use in scrollable lists
class SliverSection extends StatelessComponent {
  final String? header;
  final Component? headerComponent;
  final List<Component> children;
  final double gap;

  const SliverSection({
    this.header,
    this.headerComponent,
    required this.children,
    this.gap = 12,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Section(
      header: header,
      headerComponent: headerComponent,
      gap: gap,
      children: children,
    );
  }
}
