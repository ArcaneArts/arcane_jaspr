import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart'
    hide
        BuildContext,
        InheritedComponent,
        Key,
        State,
        StatefulComponent,
        StatelessComponent,
        UniqueKey,
        ValueKey,
        runApp;
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight,
        FontStyle,
        StyleRule,
        Display,
        Position,
        Overflow,
        Cursor,
        Visibility,
        TextDecoration,
        TextTransform,
        FontFamily,
        WhiteSpace;

import '../../util/arcane.dart';
import '../../util/style_types/index.dart';

/// Text component with enum-based styling.
class Text extends StatelessWidget {
  final String text;
  final FontSize? size;
  final FontWeight? weight;
  final TextColor? color;
  final String? colorCustom;
  final TextAlign? align;
  final LineHeight? lineHeight;
  final LetterSpacing? letterSpacing;
  final TextDecoration? decoration;
  final TextTransform? transform;
  final FontFamily? family;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final WhiteSpace? whiteSpace;
  final int? maxLines;
  final bool selectable;
  final ArcaneStyleData? style;
  final String element;

  const Text(
    this.text, {
    this.size,
    this.weight,
    this.color,
    this.colorCustom,
    this.align,
    this.lineHeight,
    this.letterSpacing,
    this.decoration,
    this.transform,
    this.family,
    this.fontStyle,
    this.overflow,
    this.whiteSpace,
    this.maxLines,
    this.selectable = true,
    this.style,
    this.element = 'span',
    super.key,
  });

  const Text.pageTitle(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.mega,
       weight = FontWeight.bold,
       lineHeight = LineHeight.tight,
       letterSpacing = LetterSpacing.tight,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'h1';

  const Text.sectionTitle(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.hero,
       weight = FontWeight.bold,
       lineHeight = LineHeight.tight,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'h2';

  const Text.heading(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.xl3,
       weight = FontWeight.bold,
       lineHeight = LineHeight.tight,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'h2';

  const Text.heading2(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.xl2,
       weight = FontWeight.w600,
       lineHeight = LineHeight.snug,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'h3';

  const Text.heading3(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.xl,
       weight = FontWeight.w600,
       lineHeight = LineHeight.snug,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'h4';

  const Text.subheading(
    this.text, {
    this.color = TextColor.secondary,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.lg,
       weight = FontWeight.w500,
       lineHeight = LineHeight.normal,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'p';

  const Text.body(
    this.text, {
    this.color = TextColor.muted,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.base,
       weight = null,
       lineHeight = LineHeight.relaxed,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'p';

  const Text.bodyLarge(
    this.text, {
    this.color = TextColor.muted,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.lg,
       weight = null,
       lineHeight = LineHeight.relaxed,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'p';

  const Text.bodySmall(
    this.text, {
    this.color = TextColor.muted,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.sm,
       weight = null,
       lineHeight = LineHeight.normal,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'p';

  const Text.label(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.sm,
       weight = FontWeight.w500,
       lineHeight = null,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'span';

  const Text.caption(
    this.text, {
    this.color = TextColor.subtle,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.xs,
       weight = null,
       lineHeight = null,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'span';

  const Text.code(
    this.text, {
    this.color = TextColor.accent,
    this.align,
    this.style,
    super.key,
  }) : size = FontSize.sm,
       weight = null,
       lineHeight = null,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = FontFamily.mono,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'code';

  const Text.link(
    this.text, {
    this.color = TextColor.accent,
    this.align,
    this.style,
    super.key,
  }) : size = null,
       weight = null,
       lineHeight = null,
       letterSpacing = null,
       colorCustom = null,
       decoration = TextDecoration.none,
       transform = null,
       family = null,
       fontStyle = null,
       overflow = null,
       whiteSpace = null,
       maxLines = null,
       selectable = true,
       element = 'span';

  const Text.truncated(
    this.text, {
    this.size,
    this.weight,
    this.color,
    this.align,
    this.style,
    super.key,
  }) : overflow = TextOverflow.ellipsis,
       whiteSpace = WhiteSpace.nowrap,
       maxLines = 1,
       lineHeight = null,
       letterSpacing = null,
       colorCustom = null,
       decoration = null,
       transform = null,
       family = null,
       fontStyle = null,
       selectable = true,
       element = 'span';

  @override
  Widget build(BuildContext context) {
    final Map<String, String> textStyles = {};

    if (size != null) textStyles['font-size'] = size!.css;
    if (weight != null) textStyles['font-weight'] = weight!.css;
    if (color != null) textStyles['color'] = color!.css;
    if (colorCustom != null) textStyles['color'] = colorCustom!;
    if (align != null) textStyles['text-align'] = align!.css;
    if (lineHeight != null) textStyles['line-height'] = lineHeight!.css;
    if (letterSpacing != null)
      textStyles['letter-spacing'] = letterSpacing!.css;
    if (decoration != null) textStyles['text-decoration'] = decoration!.css;
    if (transform != null) textStyles['text-transform'] = transform!.css;
    if (family != null) textStyles['font-family'] = family!.css;
    if (fontStyle != null) textStyles['font-style'] = fontStyle!.css;
    if (overflow != null) textStyles['text-overflow'] = overflow!.css;
    if (whiteSpace != null) textStyles['white-space'] = whiteSpace!.css;

    if (!selectable) {
      textStyles['user-select'] = 'none';
      textStyles['-webkit-user-select'] = 'none';
    }

    if (maxLines != null && maxLines! > 0) {
      textStyles['display'] = '-webkit-box';
      textStyles['-webkit-line-clamp'] = '$maxLines';
      textStyles['-webkit-box-orient'] = 'vertical';
      textStyles['overflow'] = 'hidden';
    }

    if (style != null) {
      textStyles.addAll(style!.toMap());
    }

    return _buildElement(textStyles);
  }

  Widget _buildElement(Map<String, String> styles) {
    final content = [Component.text(text)];

    switch (element) {
      case 'h1':
        return h1(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'h2':
        return h2(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'h3':
        return h3(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'h4':
        return h4(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'h5':
        return h5(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'h6':
        return h6(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'p':
        return p(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'code':
        return code(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'pre':
        return pre(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'strong':
        return strong(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'em':
        return em(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      case 'small':
        return small(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
      default:
        return span(
          classes: 'arcane-text',
          styles: Styles(raw: styles),
          content,
        );
    }
  }
}

/// Rich text component supporting mixed styling.
class RichText extends StatelessWidget {
  final List<Widget> children;
  final ArcaneStyleData? style;

  const RichText({required this.children, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return span(
      classes: 'arcane-rich-text',
      styles: style?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Text span for use within RichText.
class TextSpan extends StatelessWidget {
  final String text;
  final FontSize? size;
  final FontWeight? weight;
  final TextColor? color;
  final String? colorCustom;
  final TextDecoration? decoration;
  final FontFamily? family;
  final FontStyle? fontStyle;
  final ArcaneStyleData? style;

  const TextSpan(
    this.text, {
    this.size,
    this.weight,
    this.color,
    this.colorCustom,
    this.decoration,
    this.family,
    this.fontStyle,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> spanStyles = {};

    if (size != null) spanStyles['font-size'] = size!.css;
    if (weight != null) spanStyles['font-weight'] = weight!.css;
    if (color != null) spanStyles['color'] = color!.css;
    if (colorCustom != null) spanStyles['color'] = colorCustom!;
    if (decoration != null) spanStyles['text-decoration'] = decoration!.css;
    if (family != null) spanStyles['font-family'] = family!.css;
    if (fontStyle != null) spanStyles['font-style'] = fontStyle!.css;

    if (style != null) {
      spanStyles.addAll(style!.toMap());
    }

    return span(styles: Styles(raw: spanStyles), [Component.text(text)]);
  }
}
