import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// A section component for grouping related content with an optional header.
///
/// Provides consistent spacing and styling for content groups.
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
    final theme = ArcaneTheme.of(context);
    final effectivePadding = padding ?? const EdgeInsets.all(16);

    final headerWidget = headerComponent ??
        (header != null
            ? div(
                classes: 'arcane-section-header',
                styles: Styles(raw: {
                  'font-size': '0.875rem',
                  'font-weight': '600',
                  'color': 'var(--arcane-on-surface-variant)',
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'margin-bottom': '${gap}px',
                }),
                [Component.text(header!)],
              )
            : null);

    final dividerWidget = showDivider && headerWidget != null
        ? div(
            classes: 'arcane-section-divider',
            styles: Styles(raw: {
              'height': '1px',
              'background-color': 'var(--arcane-outline-variant)',
              'margin-bottom': '${gap}px',
            }),
            [],
          )
        : null;

    final content = div(
        classes: 'arcane-section-content',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '${gap}px',
        }),
        children);

    final sectionChildren = <Component>[
      if (headerWidget != null) headerWidget,
      if (dividerWidget != null) dividerWidget,
      content,
    ];

    if (card) {
      return div(
        classes: 'arcane-section arcane-section-card',
        styles: Styles(raw: {
          'padding': effectivePadding.padding,
          'background-color': 'var(--arcane-surface)',
          'border-radius': theme.borderRadiusCss,
          'border': '1px solid var(--arcane-outline-variant)',
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
