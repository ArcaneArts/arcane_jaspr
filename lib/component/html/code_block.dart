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

import '../../util/classes.dart';
import '../../util/style_types/index.dart';

enum CodeBlockStyle { raw, code, minimal, inline, terminal }

/// Styled preformatted text wrapper with style presets.
class ArcaneCodeBlock extends StatelessComponent {
  final List<Component> children;
  final CodeBlockStyle style;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;
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

  const factory ArcaneCodeBlock.code({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
    String? id,
    Key? key,
  }) = _ArcaneCodeBlockCode;

  const factory ArcaneCodeBlock.terminal({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
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
      CodeBlockStyle.terminal => ArcaneStyleData(
          margin: MarginPreset.none,
          padding: PaddingPreset.md,
          background: Background.black,
          fontFamily: FontFamily.mono,
          fontSize: FontSize.sm,
          lineHeight: LineHeight.relaxed,
          textColorCustom: ArcaneColor.neonGreen.css,
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
      classes: classes == null ? null : cx(classes!),
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
