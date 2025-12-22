import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for typography components
class TypographyDemos {
  static List<Component> text() => [
        ArcaneText('Regular text'),
        ArcaneText('Bold text', weight: FontWeight.bold),
        ArcaneText('Accent text', color: TextColor.accent),
      ];

  static List<Component> heading() => [
        ArcaneHeading.h2(child: ArcaneText('Heading Text')),
      ];

  static List<Component> headline() => [
        ArcaneHeadline('Headline Text'),
      ];

  static List<Component> subheadline() => [
        ArcaneSubheadline('Subheadline Text'),
      ];

  static List<Component> paragraph() => [
        ArcaneParagraph(
          child: ArcaneText(
              'This is a paragraph of text that demonstrates the ArcaneParagraph component.'),
        ),
      ];

  static List<Component> span() => [
        ArcaneSpan(
          child: ArcaneText('Inline span text'),
          styles: const ArcaneStyleData(textColor: TextColor.accent),
        ),
      ];

  static List<Component> gradientText() => [
        ArcaneGradientText(
          content: 'Gradient Text',
          gradientStart: ArcaneColors.accent,
          gradientEnd: ArcaneColors.info,
        ),
      ];

  static List<Component> glowText() => [
        ArcaneGlowText(
          content: 'Glowing Text',
          glowColor: ArcaneColors.accent,
        ),
      ];

  static List<Component> richText() => [
        ArcaneRichText(
          children: [
            ArcaneSpan(child: ArcaneText('Rich ')),
            ArcaneSpan(
              child: ArcaneText('formatted'),
              styles: const ArcaneStyleData(fontWeight: FontWeight.bold),
            ),
            ArcaneSpan(child: ArcaneText(' text')),
          ],
        ),
      ];

  static List<Component> codeSnippet() => [
        ArcaneCodeSnippet(
          code: 'final greeting = "Hello, World!";',
          language: 'dart',
        ),
      ];

  static List<Component> inlineCode() => [
        ArcaneRow(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ArcaneText('Use'),
            ArcaneInlineCode('flutter run'),
            ArcaneText('to start'),
          ],
        ),
      ];

  static List<Component> pre() => [
        ArcanePre(
          children: [ArcaneText('Preformatted\n  text\n    block')],
        ),
      ];
}
