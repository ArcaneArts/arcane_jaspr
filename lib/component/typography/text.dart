import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, FontStyle, StyleRule, Display, Position, Overflow, Cursor, Visibility, TextDecoration, TextTransform, FontFamily, WhiteSpace;

import '../../util/arcane.dart';
import '../../util/style_types/index.dart';

/// A text component with enum-based styling.
///
/// Provides a Flutter-like API for styling text with sensible defaults
/// and named constructors for common text styles.
///
/// Example:
/// ```dart
/// // Basic text
/// ArcaneText('Hello World')
///
/// // Styled text
/// ArcaneText(
///   'Welcome',
///   size: FontSize.xl,
///   weight: FontWeight.bold,
///   color: TextColor.primary,
/// )
///
/// // Using named constructors
/// ArcaneText.heading('Section Title')
/// ArcaneText.subheading('Subtitle')
/// ArcaneText.body('Body content goes here...')
/// ArcaneText.caption('Small helper text')
/// ArcaneText.code('const x = 42;')
/// ```
class ArcaneText extends StatelessComponent {
  /// The text content
  final String text;

  /// Font size preset
  final FontSize? size;

  /// Font weight
  final FontWeight? weight;

  /// Text color
  final TextColor? color;

  /// Custom text color (CSS value)
  final String? colorCustom;

  /// Text alignment
  final TextAlign? align;

  /// Line height
  final LineHeight? lineHeight;

  /// Letter spacing
  final LetterSpacing? letterSpacing;

  /// Text decoration (underline, etc.)
  final TextDecoration? decoration;

  /// Text transform (uppercase, etc.)
  final TextTransform? transform;

  /// Font family
  final FontFamily? family;

  /// Font style (italic, etc.)
  final FontStyle? fontStyle;

  /// Text overflow handling
  final TextOverflow? overflow;

  /// White space handling
  final WhiteSpace? whiteSpace;

  /// Maximum number of lines (enables truncation)
  final int? maxLines;

  /// Whether text is selectable
  final bool selectable;

  /// Full ArcaneStyleData for complete customization
  final ArcaneStyleData? style;

  /// HTML element to use (span by default)
  final String element;

  const ArcaneText(
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

  /// Page title (mega size, bold)
  const ArcaneText.pageTitle(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.mega,
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

  /// Section title (hero size, bold)
  const ArcaneText.sectionTitle(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.hero,
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

  /// Heading (xl3, bold)
  const ArcaneText.heading(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.xl3,
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

  /// Heading 2 (xl2, semibold)
  const ArcaneText.heading2(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.xl2,
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

  /// Heading 3 (xl, semibold)
  const ArcaneText.heading3(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.xl,
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

  /// Subheading (lg, medium weight)
  const ArcaneText.subheading(
    this.text, {
    this.color = TextColor.secondary,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.lg,
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

  /// Body text (base size, relaxed line height)
  const ArcaneText.body(
    this.text, {
    this.color = TextColor.muted,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.base,
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

  /// Body large (lg size, relaxed)
  const ArcaneText.bodyLarge(
    this.text, {
    this.color = TextColor.muted,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.lg,
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

  /// Body small (sm size)
  const ArcaneText.bodySmall(
    this.text, {
    this.color = TextColor.muted,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.sm,
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

  /// Label text (sm, medium weight)
  const ArcaneText.label(
    this.text, {
    this.color = TextColor.primary,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.sm,
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

  /// Caption/helper text (xs, subtle)
  const ArcaneText.caption(
    this.text, {
    this.color = TextColor.subtle,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.xs,
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

  /// Code/monospace text
  const ArcaneText.code(
    this.text, {
    this.color = TextColor.accent,
    this.align,
    this.style,
    super.key,
  })  : size = FontSize.sm,
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

  /// Link text (accent color, pointer cursor)
  const ArcaneText.link(
    this.text, {
    this.color = TextColor.accent,
    this.align,
    this.style,
    super.key,
  })  : size = null,
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

  /// Truncated text (single line with ellipsis)
  const ArcaneText.truncated(
    this.text, {
    this.size,
    this.weight,
    this.color,
    this.align,
    this.style,
    super.key,
  })  : overflow = TextOverflow.ellipsis,
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
  Component build(BuildContext context) {
    // Build text-specific styles
    final Map<String, String> textStyles = {};

    if (size != null) textStyles['font-size'] = size!.css;
    if (weight != null) textStyles['font-weight'] = weight!.css;
    if (color != null) textStyles['color'] = color!.css;
    if (colorCustom != null) textStyles['color'] = colorCustom!;
    if (align != null) textStyles['text-align'] = align!.css;
    if (lineHeight != null) textStyles['line-height'] = lineHeight!.css;
    if (letterSpacing != null) textStyles['letter-spacing'] = letterSpacing!.css;
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

    // Handle max lines (line clamp)
    if (maxLines != null && maxLines! > 0) {
      textStyles['display'] = '-webkit-box';
      textStyles['-webkit-line-clamp'] = '$maxLines';
      textStyles['-webkit-box-orient'] = 'vertical';
      textStyles['overflow'] = 'hidden';
    }

    // Merge with custom style if provided
    if (style != null) {
      textStyles.addAll(style!.toMap());
    }

    // Choose element based on type
    return _buildElement(textStyles);
  }

  Component _buildElement(Map<String, String> styles) {
    final content = [Component.text(text)];

    switch (element) {
      case 'h1':
        return h1(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'h2':
        return h2(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'h3':
        return h3(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'h4':
        return h4(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'h5':
        return h5(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'h6':
        return h6(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'p':
        return p(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'code':
        return code(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'pre':
        return pre(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'strong':
        return strong(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'em':
        return em(classes: 'arcane-text', styles: Styles(raw: styles), content);
      case 'small':
        return small(classes: 'arcane-text', styles: Styles(raw: styles), content);
      default:
        return span(classes: 'arcane-text', styles: Styles(raw: styles), content);
    }
  }
}

/// A rich text component that supports mixed styling.
///
/// Example:
/// ```dart
/// ArcaneRichText(
///   children: [
///     ArcaneTextSpan('Hello '),
///     ArcaneTextSpan('World', weight: FontWeight.bold, color: TextColor.accent),
///     ArcaneTextSpan('!'),
///   ],
/// )
/// ```
class ArcaneRichText extends StatelessComponent {
  /// The text spans
  final List<Component> children;

  /// Base text style applied to all spans
  final ArcaneStyleData? style;

  const ArcaneRichText({
    required this.children,
    this.style,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return span(
      classes: 'arcane-rich-text',
      styles: style?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A text span for use within ArcaneRichText.
class ArcaneTextSpan extends StatelessComponent {
  final String text;
  final FontSize? size;
  final FontWeight? weight;
  final TextColor? color;
  final String? colorCustom;
  final TextDecoration? decoration;
  final FontFamily? family;
  final FontStyle? fontStyle;
  final ArcaneStyleData? style;

  const ArcaneTextSpan(
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
  Component build(BuildContext context) {
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

    return span(
      styles: Styles(raw: spanStyles),
      [Component.text(text)],
    );
  }
}
