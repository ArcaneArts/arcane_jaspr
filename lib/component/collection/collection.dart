import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;


/// A versatile collection widget for managing and displaying groups of items.
///
/// The [Collection] widget serves as a flexible container for rendering lists
/// of components, supporting both static children and dynamic builder patterns.
/// It is designed for use in scrollable views or as part of larger compositions.
class ArcaneCollection extends StatelessComponent {
  /// The list of static child components to render.
  final List<Component> children;

  /// An optional builder function for dynamically generating children.
  final Component Function(BuildContext context, int index)? builder;

  /// The total number of children when using a builder.
  final int? childCount;

  /// Layout direction (vertical or horizontal).
  final Axis direction;

  /// Gap between items.
  final double gap;

  /// Whether to wrap items in a scrollable container.
  final bool scrollable;

  /// Padding around the collection.
  final String? padding;

  /// Default constructor for creating a [Collection] with static children.
  const ArcaneCollection({
    super.key,
    this.children = const [],
    this.direction = Axis.vertical,
    this.gap = 0,
    this.scrollable = false,
    this.padding,
  })  : builder = null,
        childCount = null;

  /// Creates a [Collection] using a builder for dynamic child generation.
  const ArcaneCollection.builder({
    super.key,
    required this.builder,
    required this.childCount,
    this.direction = Axis.vertical,
    this.gap = 0,
    this.scrollable = false,
    this.padding,
  }) : children = const [];

  @override
  Component build(BuildContext context) {
    final List<Component> items = builder != null
        ? List.generate(childCount ?? 0, (i) => builder!(context, i))
        : children;

    final Map<String, String> containerStyles = {
      'display': 'flex',
      'flex-direction': direction == Axis.vertical ? 'column' : 'row',
      if (gap > 0) 'gap': '${gap}px',
      if (padding != null) 'padding': padding!,
    };

    if (scrollable) {
      containerStyles['overflow'] =
          direction == Axis.vertical ? 'auto' : 'auto';
      containerStyles['max-height'] =
          direction == Axis.vertical ? '100%' : 'none';
      containerStyles['max-width'] =
          direction == Axis.horizontal ? '100%' : 'none';
    }

    return div(
      classes: 'arcane-collection',
      styles: Styles(raw: containerStyles),
      items,
    );
  }
}

/// Axis direction for layouts.
enum Axis {
  horizontal,
  vertical,
}

/// A list view component for displaying scrollable lists.
class ArcaneListView extends StatelessComponent {
  /// Children to display in the list.
  final List<Component> children;

  /// Builder for dynamic list generation.
  final Component Function(BuildContext context, int index)? builder;

  /// Number of items when using builder.
  final int? itemCount;

  /// Gap between items.
  final double gap;

  /// Padding around the list.
  final String? padding;

  /// Whether the list scrolls horizontally.
  final bool horizontal;

  const ArcaneListView({
    super.key,
    this.children = const [],
    this.gap = 0,
    this.padding,
    this.horizontal = false,
  })  : builder = null,
        itemCount = null;

  const ArcaneListView.builder({
    super.key,
    required this.builder,
    required this.itemCount,
    this.gap = 0,
    this.padding,
    this.horizontal = false,
  }) : children = const [];

  @override
  Component build(BuildContext context) {
    final List<Component> items = builder != null
        ? List.generate(itemCount ?? 0, (i) => builder!(context, i))
        : children;

    return div(
      classes: 'arcane-list-view',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': horizontal ? 'row' : 'column',
        'gap': '${gap}px',
        'overflow-y': horizontal ? 'hidden' : 'auto',
        'overflow-x': horizontal ? 'auto' : 'hidden',
        if (padding != null) 'padding': padding!,
      }),
      items,
    );
  }
}

/// A grid layout component for displaying items in a grid.
class ArcaneGridView extends StatelessComponent {
  /// Children to display in the grid.
  final List<Component> children;

  /// Builder for dynamic grid generation.
  final Component Function(BuildContext context, int index)? builder;

  /// Number of items when using builder.
  final int? itemCount;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Gap between grid items.
  final double gap;

  /// Padding around the grid.
  final String? padding;

  /// Minimum item width for auto-fit columns.
  final double? minItemWidth;

  const ArcaneGridView({
    super.key,
    this.children = const [],
    this.crossAxisCount = 2,
    this.gap = 16,
    this.padding,
    this.minItemWidth,
  })  : builder = null,
        itemCount = null;

  const ArcaneGridView.builder({
    super.key,
    required this.builder,
    required this.itemCount,
    this.crossAxisCount = 2,
    this.gap = 16,
    this.padding,
    this.minItemWidth,
  }) : children = const [];

  @override
  Component build(BuildContext context) {
    final List<Component> items = builder != null
        ? List.generate(itemCount ?? 0, (i) => builder!(context, i))
        : children;

    final String gridTemplateColumns = minItemWidth != null
        ? 'repeat(auto-fit, minmax(${minItemWidth}px, 1fr))'
        : 'repeat($crossAxisCount, 1fr)';

    return div(
      classes: 'arcane-grid-view',
      styles: Styles(raw: {
        'display': 'grid',
        'grid-template-columns': gridTemplateColumns,
        'gap': '${gap}px',
        if (padding != null) 'padding': padding!,
      }),
      items,
    );
  }
}

/// A masonry-style layout component.
class ArcaneMasonryGrid extends StatelessComponent {
  /// Children to display.
  final List<Component> children;

  /// Number of columns.
  final int columns;

  /// Gap between items.
  final double gap;

  /// Padding around the grid.
  final String? padding;

  const ArcaneMasonryGrid({
    super.key,
    required this.children,
    this.columns = 2,
    this.gap = 16,
    this.padding,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-masonry-grid',
      styles: Styles(raw: {
        'column-count': '$columns',
        'column-gap': '${gap}px',
        if (padding != null) 'padding': padding!,
      }),
      [
        for (final child in children)
          div(
            styles: Styles(raw: {
              'break-inside': 'avoid',
              'margin-bottom': '${gap}px',
            }),
            [child],
          ),
      ],
    );
  }
}

/// A simple repeater component for generating repeated elements.
class ArcaneRepeater extends StatelessComponent {
  /// Number of times to repeat.
  final int count;

  /// Builder for each item.
  final Component Function(BuildContext context, int index) builder;

  const ArcaneRepeater({
    super.key,
    required this.count,
    required this.builder,
  });

  @override
  Component build(BuildContext context) {
    return Component.fragment(
      List.generate(count, (i) => builder(context, i)),
    );
  }
}
