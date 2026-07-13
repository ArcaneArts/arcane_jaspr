import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, FontStyle, StyleRule, Display, Position, Overflow, Cursor, Visibility, FlexWrap, WhiteSpace;

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';
import '../../util/appearance/colors.dart';
import '../../util/style_types/index.dart';

/// A flexible flow layout component that wraps children.
class Wrap extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final WrapAlignment wrapAlignment;
  final double gap;
  final double? rowGap;
  final double? columnGap;
  final bool reverse;

  const Wrap({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.wrapAlignment = WrapAlignment.start,
    this.gap = 8,
    this.rowGap,
    this.columnGap,
    this.reverse = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.flow(FlowProps(
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      wrapAlignment: wrapAlignment,
      gap: gap,
      rowGap: rowGap,
      columnGap: columnGap,
      reverse: reverse,
    ));
  }
}

/// A row layout component (horizontal flex).
class Row extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double gap;
  final Gap? gapSize;
  final ArcaneStyleData? style;

  const Row({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.gap = 0,
    this.gapSize,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (style == null && gapSize == null) {
      return context.renderers.row(RowProps(
        children: children,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        gap: gap,
      ));
    }

    final Map<String, String> baseStyles = {
      'display': 'flex',
      'flex-direction': 'row',
      'justify-content': mainAxisAlignment.css,
      'align-items': crossAxisAlignment.css,
      if (mainAxisSize == MainAxisSize.max) 'width': '100%',
    };

    if (gapSize != null) {
      baseStyles['gap'] = gapSize!.css;
    } else if (gap > 0) {
      baseStyles['gap'] = '${gap}px';
    }

    if (style != null) {
      baseStyles.addAll(style!.toMap());
    }

    return div(
      classes: 'arcane-row',
      styles: Styles(raw: baseStyles),
      children,
    );
  }
}

/// A column layout component (vertical flex).
class Column extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double gap;
  final Gap? gapSize;
  final ArcaneStyleData? style;

  const Column({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisSize = MainAxisSize.max,
    this.gap = 0,
    this.gapSize,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (style == null && gapSize == null) {
      return context.renderers.column(ColumnProps(
        children: children,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        gap: gap,
      ));
    }

    final Map<String, String> baseStyles = {
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': mainAxisAlignment.css,
      'align-items': crossAxisAlignment.css,
      if (mainAxisSize == MainAxisSize.max) 'height': '100%',
    };

    if (gapSize != null) {
      baseStyles['gap'] = gapSize!.css;
    } else if (gap > 0) {
      baseStyles['gap'] = '${gap}px';
    }

    if (style != null) {
      baseStyles.addAll(style!.toMap());
    }

    return div(
      classes: 'arcane-column',
      styles: Styles(raw: baseStyles),
      children,
    );
  }
}

/// A flexible spacer component.
class Spacer extends StatelessWidget {
  final int flex;

  const Spacer({this.flex = 1, super.key});

  @override
  Widget build(BuildContext context) {
    return context.renderers.spacer(SpacerProps(flex: flex));
  }
}

/// A center alignment component.
class Center extends StatelessWidget {
  final Widget child;

  const Center({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return context.renderers.center(CenterProps(child: child));
  }
}

/// An expanded component that fills available space.
class Expanded extends StatelessWidget {
  final Widget child;
  final int flex;

  const Expanded({required this.child, this.flex = 1, super.key});

  @override
  Widget build(BuildContext context) {
    return context.renderers.expanded(ExpandedProps(child: child, flex: flex));
  }
}

/// A padding wrapper component.
class Padding extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;

  const Padding({
    required this.padding,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.paddingWrapper(PaddingWrapperProps(
      padding: padding,
      child: child,
    ));
  }
}

/// A sized box component.
class SizedBox extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const SizedBox({this.width, this.height, this.child, super.key});

  const SizedBox.shrink({super.key})
      : width = 0,
        height = 0,
        child = null;

  const SizedBox.expand({super.key})
      : width = double.infinity,
        height = double.infinity,
        child = null;

  @override
  Widget build(BuildContext context) {
    return context.renderers.sizedBox(SizedBoxProps(
      width: width,
      height: height,
      child: child,
    ));
  }
}

/// A container component with styling options.
class Container extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Color? color;
  final BoxDecoration? decoration;
  final Alignment? alignment;

  /// Semantic HTML tag to render (e.g. `'nav'`, `'section'`, `'header'`).
  /// Defaults to a `div`.
  final String? tag;

  const Container({
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.alignment,
    this.tag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> styles = {};

    if (padding != null) styles['padding'] = padding!.padding;
    if (margin != null) styles['margin'] = margin!.margin;
    if (width != null) styles['width'] = '${width}px';
    if (height != null) styles['height'] = '${height}px';
    if (color != null) styles['background-color'] = color!.css;

    if (decoration != null) {
      if (decoration!.color != null) {
        styles['background-color'] = decoration!.color!.css;
      }
      if (decoration!.borderRadius != null) {
        styles['border-radius'] = decoration!.borderRadius!.css;
      }
      if (decoration!.border != null) {
        styles['border'] = decoration!.border!.css;
      }
      if (decoration!.boxShadow != null) {
        styles['box-shadow'] = decoration!.boxShadow!.map((shadow) => shadow.css).join(', ');
      }
    }

    if (alignment != null) {
      styles['display'] = 'flex';
      styles['justify-content'] = alignment!.cssJustifyContent;
      styles['align-items'] = alignment!.cssAlignItems;
    }

    final List<Widget> children =
        child != null ? <Widget>[child!] : const <Widget>[];
    final String elementTag = tag ?? 'div';
    // Keep the default 'div' path byte-identical to the prior output.
    if (elementTag == 'div') {
      return div(
        classes: 'arcane-container',
        styles: Styles(raw: styles),
        children,
      );
    }
    return Widget.element(
      tag: elementTag,
      classes: 'arcane-container',
      styles: Styles(raw: styles),
      children: children,
    );
  }
}

/// Box decoration for Container.
class BoxDecoration {
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const BoxDecoration({
    this.color,
    this.borderRadius,
    this.border,
    this.boxShadow,
  });
}

/// Border for BoxDecoration.
class Border {
  final Color color;
  final double width;
  final String style;

  const Border({
    required this.color,
    this.width = 1,
    this.style = 'solid',
  });

  const Border.all({
    required this.color,
    this.width = 1,
  }) : style = 'solid';

  String get css => '${width}px $style ${color.css}';
}
