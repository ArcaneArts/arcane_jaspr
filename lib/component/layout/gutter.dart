import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';

/// Gutter size options
enum GutterSize {
  xsmall(4),
  small(8),
  medium(16),
  large(24),
  xlarge(32);

  final double pixels;
  const GutterSize(this.pixels);
}

/// A spacing component that provides consistent gaps between elements.
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

  const Gutter.xsmall({this.horizontal = false, super.key}) : size = GutterSize.xsmall;
  const Gutter.small({this.horizontal = false, super.key}) : size = GutterSize.small;
  const Gutter.medium({this.horizontal = false, super.key}) : size = GutterSize.medium;
  const Gutter.large({this.horizontal = false, super.key}) : size = GutterSize.large;
  const Gutter.xlarge({this.horizontal = false, super.key}) : size = GutterSize.xlarge;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-gutter',
      styles: Styles(raw: {
        if (horizontal) 'width': '${size.pixels}px' else 'height': '${size.pixels}px',
        'flex-shrink': '0',
      }),
      [],
    );
  }
}

/// A flexible gap component
class Gap extends StatelessComponent {
  final double size;
  final bool horizontal;

  const Gap(this.size, {this.horizontal = false, super.key});

  const Gap.xs({super.key}) : size = 4, horizontal = false;
  const Gap.sm({super.key}) : size = 8, horizontal = false;
  const Gap.md({super.key}) : size = 16, horizontal = false;
  const Gap.lg({super.key}) : size = 24, horizontal = false;
  const Gap.xl({super.key}) : size = 32, horizontal = false;

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
