import 'package:jaspr/jaspr.dart';
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
        WhiteSpace,
        Radius,
        events;

import '../../util/style_types/index.dart';

/// Style presets for ArcaneCodeBlock
enum CodeBlockStyle {
  /// Raw/unstyled - just the pre element
  raw,

  /// Code block with background, padding, border radius
  code,

  /// Minimal code - monospace font, no background
  minimal,

  /// Inline-like - compact, no margins
  inline,

  /// Terminal style - dark background, green text
  terminal,
}

/// A code block component for displaying preformatted text, code, or terminal output.
///
/// This wraps the HTML `<pre>` element with sensible defaults and style presets.
/// Use [style] for quick presets or [styles] for full customization.
///
/// Example with preset:
/// ```dart
/// ArcaneCodeBlock(
///   style: CodeBlockStyle.code,
///   children: [ArcaneText('const x = 42;')],
/// )
/// ```
///
/// Example with factory constructor:
/// ```dart
/// ArcaneCodeBlock.code(
///   children: [ArcaneText('const x = 42;')],
/// )
/// ```
///
/// Example with custom styling:
/// ```dart
/// ArcaneCodeBlock(
///   styles: ArcaneStyleData(
///     background: Background.code,
///     padding: PaddingPreset.md,
///     fontFamily: FontFamily.mono,
///   ),
///   children: [ArcaneText('const x = 42;')],
/// )
/// ```
class ArcaneCodeBlock extends StatelessComponent {
  /// The children of the code block
  final List<Component> children;

  /// Quick style preset (applied before [styles])
  final CodeBlockStyle style;

  /// Optional styling using ArcaneStyleData (merged with preset)
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const ArcaneCodeBlock({
    required this.children,
    this.style = CodeBlockStyle.raw,
    this.styles,
    this.classes,
    this.id,
    this.attributes,
    super.key,
  });

  /// Create a styled code block with background, padding, and border
  const factory ArcaneCodeBlock.code({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) = _ArcaneCodeBlockCode;

  /// Create a terminal styled code block with dark background and green text
  const factory ArcaneCodeBlock.terminal({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) = _ArcaneCodeBlockTerminal;

  ArcaneStyleData _getPresetStyles() {
    return switch (style) {
      CodeBlockStyle.raw => const ArcaneStyleData(),
      CodeBlockStyle.code => const ArcaneStyleData(
          margin: MarginPreset.none,
          padding: PaddingPreset.md,
          background: Background.code,
          fontFamily: FontFamily.mono,
          fontSize: FontSize.sm,
          lineHeight: LineHeight.relaxed,
          textColor: TextColor.primary,
          whiteSpace: WhiteSpace.preWrap,
          wordBreak: WordBreak.breakWord,
          borderRadius: Radius.md,
          border: BorderPreset.subtle,
          overflow: Overflow.auto,
        ),
      CodeBlockStyle.minimal => const ArcaneStyleData(
          margin: MarginPreset.none,
          padding: PaddingPreset.none,
          background: Background.transparent,
          fontFamily: FontFamily.mono,
          fontSize: FontSize.sm,
          lineHeight: LineHeight.relaxed,
          textColor: TextColor.primary,
          whiteSpace: WhiteSpace.preWrap,
          wordBreak: WordBreak.breakWord,
        ),
      CodeBlockStyle.inline => const ArcaneStyleData(
          margin: MarginPreset.none,
          padding: PaddingPreset.xs,
          background: Background.surfaceVariant,
          fontFamily: FontFamily.mono,
          fontSize: FontSize.sm,
          lineHeight: LineHeight.normal,
          textColor: TextColor.primary,
          whiteSpace: WhiteSpace.pre,
          borderRadius: Radius.sm,
        ),
      CodeBlockStyle.terminal => const ArcaneStyleData(
          margin: MarginPreset.none,
          padding: PaddingPreset.md,
          background: Background.black,
          fontFamily: FontFamily.mono,
          fontSize: FontSize.sm,
          lineHeight: LineHeight.relaxed,
          textColor: TextColor.neonGreen,
          whiteSpace: WhiteSpace.preWrap,
          wordBreak: WordBreak.breakWord,
          borderRadius: Radius.md,
        ),
    };
  }

  @override
  Component build(BuildContext context) {
    final baseStyles = _getPresetStyles();
    final mergedStyles = styles != null ? baseStyles.merge(styles!) : baseStyles;

    return pre(
      id: id,
      classes: classes,
      styles: mergedStyles.toStyles(),
      attributes: attributes,
      children,
    );
  }
}

class _ArcaneCodeBlockCode extends ArcaneCodeBlock {
  const _ArcaneCodeBlockCode({
    required super.children,
    super.styles,
    super.classes,
    super.id,
    super.key,
  }) : super(style: CodeBlockStyle.code);
}

class _ArcaneCodeBlockTerminal extends ArcaneCodeBlock {
  const _ArcaneCodeBlockTerminal({
    required super.children,
    super.styles,
    super.classes,
    super.id,
    super.key,
  }) : super(style: CodeBlockStyle.terminal);
}

// Legacy aliases for backwards compatibility
// ignore: unused_element
typedef ArcanePre = ArcaneCodeBlock;
// ignore: unused_element
typedef PreStyle = CodeBlockStyle;
