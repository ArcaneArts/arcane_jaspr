import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A spacing component that provides consistent gaps between elements.
///
/// Can be used horizontally or vertically based on context.
class Gutter extends StatelessComponent {
  /// The size of the gutter
  final GutterSize size;

  /// Whether to render as a horizontal gutter
  final bool horizontal;

  const Gutter({
    this.size = GutterSize.medium,
    this.horizontal = false,
    super.key,
  });

  const Gutter.small({this.horizontal = false, super.key})
      : size = GutterSize.small;

  const Gutter.medium({this.horizontal = false, super.key})
      : size = GutterSize.medium;

  const Gutter.large({this.horizontal = false, super.key})
      : size = GutterSize.large;

  const Gutter.xsmall({this.horizontal = false, super.key})
      : size = GutterSize.xsmall;

  const Gutter.xlarge({this.horizontal = false, super.key})
      : size = GutterSize.xlarge;

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final sizePx = size.resolve(theme.gutter);

    return div(
      classes: 'arcane-gutter',
      styles: Styles(raw: {
        if (horizontal) 'width': '${sizePx}px' else 'height': '${sizePx}px',
        'flex-shrink': '0',
      }),
      [],
    );
  }
}

/// Gutter size options
enum GutterSize {
  xsmall,
  small,
  medium,
  large,
  xlarge;

  double resolve(GutterTheme theme) {
    switch (this) {
      case GutterSize.xsmall:
        return theme.small / 2;
      case GutterSize.small:
        return theme.small;
      case GutterSize.medium:
        return theme.medium;
      case GutterSize.large:
        return theme.large;
      case GutterSize.xlarge:
        return theme.large * 1.5;
    }
  }
}

/// A flexible gap component that works like CSS gap
class Gap extends StatelessComponent {
  final double size;
  final bool horizontal;

  const Gap(this.size, {this.horizontal = false, super.key});

  const Gap.small({super.key})
      : size = 8,
        horizontal = false;

  const Gap.medium({super.key})
      : size = 16,
        horizontal = false;

  const Gap.large({super.key})
      : size = 24,
        horizontal = false;

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        if (horizontal) 'width': '${size}px' else 'height': '${size}px',
        'flex-shrink': '0',
      }),
      [],
    );
  }
}
