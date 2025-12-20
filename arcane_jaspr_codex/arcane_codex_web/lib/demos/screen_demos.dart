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
}
