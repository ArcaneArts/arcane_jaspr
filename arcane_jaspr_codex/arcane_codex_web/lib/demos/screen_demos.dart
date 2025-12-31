import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for screen components
class ScreenDemos {
  static List<Component> screen() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '200px',
            heightCustom: '120px',
            background: Background.background,
            borderRadius: Radius.md,
            overflow: Overflow.hidden,
            raw: {'border': '1px solid var(--arcane-outline)'},
          ),
          children: [
            ArcaneCenter(child: ArcaneText('Screen Preview')),
          ],
        ),
      ];

  static List<Component> chatScreen() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '300px',
            heightCustom: '200px',
            background: Background.surface,
            borderRadius: Radius.md,
            overflow: Overflow.hidden,
            raw: {'border': '1px solid var(--arcane-outline)'},
          ),
          children: [
            ArcaneColumn(
              children: [
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    padding: PaddingPreset.sm,
                    borderBottom: BorderPreset.subtle,
                  ),
                  children: [ArcaneText('Chat Preview', weight: FontWeight.bold)],
                ),
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    flexGrow: 1,
                    padding: PaddingPreset.sm,
                  ),
                  children: [
                    ArcaneColumn(
                      gapSize: Gap.sm,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            padding: PaddingPreset.sm,
                            background: Background.surfaceVariant,
                            borderRadius: Radius.md,
                          ),
                          children: [ArcaneText('Hello!', size: FontSize.sm)],
                        ),
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            padding: PaddingPreset.sm,
                            background: Background.accent,
                            borderRadius: Radius.md,
                          ),
                          children: [ArcaneText('Hi there!', size: FontSize.sm)],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}
