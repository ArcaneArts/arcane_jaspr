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

  static List<Component> aspectRatio() => [
        ArcaneRow(
          gapSize: Gap.lg,
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              children: [
                ArcaneDiv(
                  styles: const ArcaneStyleData(widthCustom: '120px'),
                  children: [
                    ArcaneAspectRatio.square(
                      child: ArcaneDiv(
                        styles: const ArcaneStyleData(
                          background: Background.accent,
                          borderRadius: Radius.md,
                          display: Display.flex,
                          alignItems: AlignItems.center,
                          justifyContent: JustifyContent.center,
                        ),
                        children: [ArcaneText('1:1')],
                      ),
                    ),
                  ],
                ),
                ArcaneText('Square', size: FontSize.sm, color: TextColor.muted),
              ],
            ),
            ArcaneColumn(
              gapSize: Gap.sm,
              children: [
                ArcaneDiv(
                  styles: const ArcaneStyleData(widthCustom: '160px'),
                  children: [
                    ArcaneAspectRatio.video(
                      child: ArcaneDiv(
                        styles: const ArcaneStyleData(
                          background: Background.surfaceVariant,
                          borderRadius: Radius.md,
                          display: Display.flex,
                          alignItems: AlignItems.center,
                          justifyContent: JustifyContent.center,
                        ),
                        children: [ArcaneText('16:9')],
                      ),
                    ),
                  ],
                ),
                ArcaneText('Video', size: FontSize.sm, color: TextColor.muted),
              ],
            ),
            ArcaneColumn(
              gapSize: Gap.sm,
              children: [
                ArcaneDiv(
                  styles: const ArcaneStyleData(widthCustom: '80px'),
                  children: [
                    ArcaneAspectRatio.portrait(
                      child: ArcaneDiv(
                        styles: const ArcaneStyleData(
                          background: Background.surface,
                          border: BorderPreset.subtle,
                          borderRadius: Radius.md,
                          display: Display.flex,
                          alignItems: AlignItems.center,
                          justifyContent: JustifyContent.center,
                        ),
                        children: [ArcaneText('3:4')],
                      ),
                    ),
                  ],
                ),
                ArcaneText('Portrait', size: FontSize.sm, color: TextColor.muted),
              ],
            ),
          ],
        ),
      ];

  static List<Component> resizable() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '100%',
            heightCustom: '200px',
            borderRadius: Radius.md,
            overflow: Overflow.hidden,
            border: BorderPreset.subtle,
          ),
          children: [
            ArcaneResizable(
              direction: ResizeDirection.horizontal,
              panels: [
                ResizablePanel(
                  defaultSize: 30,
                  minSize: 20,
                  child: ArcaneDiv(
                    styles: const ArcaneStyleData(
                      heightCustom: '100%',
                      background: Background.surfaceVariant,
                      padding: PaddingPreset.md,
                    ),
                    children: [ArcaneText('Sidebar (30%)')],
                  ),
                ),
                ResizablePanel(
                  child: ArcaneDiv(
                    styles: const ArcaneStyleData(
                      heightCustom: '100%',
                      background: Background.surface,
                      padding: PaddingPreset.md,
                    ),
                    children: [ArcaneText('Main Content')],
                  ),
                ),
                ResizablePanel(
                  defaultSize: 25,
                  minSize: 15,
                  child: ArcaneDiv(
                    styles: const ArcaneStyleData(
                      heightCustom: '100%',
                      background: Background.surfaceVariant,
                      padding: PaddingPreset.md,
                    ),
                    children: [ArcaneText('Panel (25%)')],
                  ),
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> sectionHeader() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '100%'),
          children: [
            ArcaneSectionHeader(
              label: 'Features',
              heading: 'Why Choose Us',
              description: 'Discover what makes our platform different from the rest.',
              align: SectionHeaderAlign.center,
            ),
          ],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            margin: MarginPreset.topXxl,
            widthCustom: '100%',
          ),
          children: [
            ArcaneSectionHeader.left(
              label: 'Pricing',
              heading: 'Simple, Transparent Pricing',
              description: 'No hidden fees or surprise charges.',
            ),
          ],
        ),
      ];

  static List<Component> footerColumn() => [
        ArcaneRow(
          gapSize: Gap.xxl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneFooterBrandColumn(
              logo: ArcaneText('Acme Inc', weight: FontWeight.bold, size: FontSize.lg),
              description: 'Building the future of web development with modern tools and best practices.',
              bottomContent: ArcaneStatusBadge.success('All Systems Operational'),
            ),
            ArcaneFooterColumn(
              title: 'Product',
              links: [
                FooterLink(label: 'Features', href: '#'),
                FooterLink(label: 'Pricing', href: '#'),
                FooterLink(label: 'Documentation', href: '#'),
              ],
            ),
            ArcaneFooterColumn(
              title: 'Company',
              links: [
                FooterLink(label: 'About', href: '#'),
                FooterLink(label: 'Blog', href: '#'),
                FooterLink(label: 'Careers', href: '#'),
              ],
            ),
            ArcaneFooterColumn(
              title: 'Legal',
              links: [
                FooterLink(label: 'Privacy', href: '#'),
                FooterLink(label: 'Terms', href: '#'),
              ],
            ),
          ],
        ),
      ];

  static List<Component> drawer() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Drawer Component', weight: FontWeight.bold),
                ArcaneText('Slide-in panel from screen edge', color: TextColor.muted),
                ArcaneDiv(
                  styles: const ArcaneStyleData(margin: MarginPreset.topSm),
                  children: [
                    ArcaneButton.secondary(
                      label: 'Open Drawer',
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}
