import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for layout components
class LayoutDemos {
  static List<Component> div() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [ArcaneText('ArcaneDiv with styling')],
        ),
      ];

  static List<Component> row() => [
        ArcaneRow(
          gapSize: Gap.md,
          children: [
            for (var i = 1; i <= 3; i++)
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.sm,
                  background: Background.accent,
                  borderRadius: Radius.sm,
                ),
                children: [ArcaneText('Item $i')],
              ),
          ],
        ),
      ];

  static List<Component> column() => [
        ArcaneColumn(
          gapSize: Gap.sm,
          children: [
            for (var i = 1; i <= 2; i++)
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.sm,
                  background: Background.surface,
                  borderRadius: Radius.sm,
                ),
                children: [ArcaneText('Row $i')],
              ),
          ],
        ),
      ];

  static List<Component> container() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            maxWidth: MaxWidth.content,
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [ArcaneText('Contained content')],
        ),
      ];

  static List<Component> section() => [
        ArcaneSection(
          header: 'Section Header',
          children: [ArcaneText('Section content')],
        ),
      ];

  static List<Component> box() => [
        ArcaneBox(
          padding: PaddingPreset.md,
          background: Background.surface,
          borderRadius: Radius.lg,
          children: [ArcaneText('Box content')],
        ),
      ];

  static List<Component> center() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '200px',
            heightCustom: '80px',
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneCenter(child: ArcaneText('Centered')),
          ],
        ),
      ];

  static List<Component> flow() => [
        ArcaneFlow(
          gap: 8,
          children: [
            ArcaneBadge('Tag 1'),
            ArcaneBadge('Tag 2'),
            ArcaneBadge('Tag 3'),
            ArcaneBadge('Tag 4'),
          ],
        ),
      ];

  static List<Component> spacer() => [
        ArcaneRow(
          children: [
            ArcaneText('Left'),
            ArcaneSpacer(),
            ArcaneText('Right'),
          ],
        ),
      ];

  static List<Component> expanded() => [
        ArcaneRow(
          children: [
            ArcaneText('Fixed'),
            ArcaneExpanded(
              child: ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.sm,
                  background: Background.accent,
                  textAlign: TextAlign.center,
                ),
                children: [ArcaneText('Expanded')],
              ),
            ),
          ],
        ),
      ];

  static List<Component> stack() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '150px',
            heightCustom: '80px',
          ),
          children: [
            ArcaneStack(
              children: [
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    widthCustom: '100%',
                    heightCustom: '100%',
                    background: Background.surface,
                    borderRadius: Radius.md,
                  ),
                  children: [],
                ),
                ArcanePositioned(
                  top: '8px',
                  right: '8px',
                  child: ArcaneBadge('New'),
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> positioned() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.relative,
            widthCustom: '150px',
            heightCustom: '80px',
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcanePositioned(
              bottom: '8px',
              left: '8px',
              child: ArcaneText('Positioned'),
            ),
          ],
        ),
      ];

  static List<Component> padding() => [
        ArcanePadding(
          padding: EdgeInsets.all(16),
          child: ArcaneDiv(
            styles: const ArcaneStyleData(
              background: Background.accent,
              borderRadius: Radius.sm,
            ),
            children: [ArcaneText('Padded content')],
          ),
        ),
      ];

  static List<Component> gutter() => [
        ArcaneRow(
          children: [
            ArcaneText('Before'),
            ArcaneGutter.large(),
            ArcaneText('After'),
          ],
        ),
      ];

  static List<Component> card() => [
        ArcaneCard(
          child: ArcaneDiv(
            styles: const ArcaneStyleData(padding: PaddingPreset.md),
            children: [ArcaneText('Card content')],
          ),
        ),
      ];

  static List<Component> tabs() => [
        ArcaneTabs(
          tabs: [
            ArcaneTabItem(label: 'Tab 1', content: ArcaneText('Content 1')),
            ArcaneTabItem(label: 'Tab 2', content: ArcaneText('Content 2')),
            ArcaneTabItem(label: 'Tab 3', content: ArcaneText('Content 3')),
          ],
          initialIndex: 0,
          onChanged: (_) {},
        ),
      ];

  static List<Component> tile() => [
        ArcaneTile(
          title: 'Tile Title',
          subtitle: 'Subtitle text',
          onTap: () {},
        ),
      ];

  static List<Component> buttonGroup() => [
        ArcaneButtonGroup(
          children: [
            ArcaneButton.secondary(label: 'Left', onPressed: () {}),
            ArcaneButton.secondary(label: 'Center', onPressed: () {}),
            ArcaneButton.secondary(label: 'Right', onPressed: () {}),
          ],
        ),
      ];

  static List<Component> heroSection() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '100%',
            padding: PaddingPreset.lg,
            background: Background.surface,
            borderRadius: Radius.lg,
            textAlign: TextAlign.center,
          ),
          children: [
            ArcaneHeadline('Hero Title'),
            ArcaneDiv(
              styles: const ArcaneStyleData(margin: MarginPreset.topSm),
              children: [ArcaneText('Hero subtitle text')],
            ),
          ],
        ),
      ];

  static List<Component> footer() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
            textAlign: TextAlign.center,
          ),
          children: [ArcaneText('Footer Example')],
        ),
      ];

  static List<Component> authLayout() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '200px',
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.lg,
            textAlign: TextAlign.center,
          ),
          children: [
            ArcaneText('Auth Layout Preview'),
            ArcaneDiv(
              styles: const ArcaneStyleData(margin: MarginPreset.topMd),
              children: [
                ArcaneButton.primary(label: 'Sign In', onPressed: () {}),
              ],
            ),
          ],
        ),
      ];

  static List<Component> dashboardLayout() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            widthCustom: '300px',
            heightCustom: '100px',
            background: Background.surface,
            borderRadius: Radius.md,
            overflow: Overflow.hidden,
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                widthCustom: '60px',
                background: Background.surfaceVariant,
                padding: PaddingPreset.sm,
              ),
              children: [ArcaneText('Nav')],
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                flexGrow: 1,
                padding: PaddingPreset.sm,
              ),
              children: [ArcaneText('Content')],
            ),
          ],
        ),
      ];

  static List<Component> pageBody() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [ArcaneText('Page body content area')],
        ),
      ];
}
