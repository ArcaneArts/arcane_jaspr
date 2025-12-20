import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for view components
class ViewDemos {
  static List<Component> avatar() => [
        ArcaneAvatar(initials: 'JD'),
        ArcaneAvatar(initials: 'AB', size: AvatarSize.lg),
      ];

  static List<Component> badge() => [
        ArcaneBadge('Default'),
        ArcaneBadge('Success', style: BadgeStyle.success),
        ArcaneBadge('Warning', style: BadgeStyle.warning),
        ArcaneBadge('Destructive', style: BadgeStyle.destructive),
      ];

  static List<Component> chip() => [
        ArcaneChip(label: 'Chip 1'),
        ArcaneChip(label: 'Chip 2'),
      ];

  static List<Component> divider() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneDivider(),
          ],
        ),
      ];

  static List<Component> progressBar() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [ArcaneProgressBar(value: 0.3)],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [ArcaneProgressBar(value: 0.7)],
        ),
      ];

  static List<Component> loader() => [
        ArcaneLoader(),
        ArcaneLoader(size: '48px'),
      ];

  static List<Component> skeleton() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneSkeleton(height: '20px'),
            ArcaneDiv(
              styles: const ArcaneStyleData(margin: MarginPreset.topSm),
              children: [ArcaneSkeleton(height: '14px', width: '150px')],
            ),
          ],
        ),
      ];

  static List<Component> emptyState() => [
        ArcaneEmptyState(
          title: 'No items',
          message: 'Get started by adding your first item.',
        ),
      ];

  static List<Component> dataTable() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '300px',
            background: Background.surface,
            borderRadius: Radius.md,
            overflow: Overflow.hidden,
          ),
          children: [
            ArcaneStaticTable(
              headers: const ['Name', 'Value'],
              rows: [
                [ArcaneText('Item 1'), ArcaneText('100')],
                [ArcaneText('Item 2'), ArcaneText('200')],
              ],
            ),
          ],
        ),
      ];

  static List<Component> timeline() => [
        ArcaneTimeline(
          items: [
            ArcaneTimelineItem(title: 'Step 1', description: 'First step'),
            ArcaneTimelineItem(title: 'Step 2', description: 'Second step'),
          ],
        ),
      ];

  static List<Component> featureCard() => [
        ArcaneFeatureCard(
          title: 'Feature',
          description: 'Feature description text',
          icon: ArcaneText('★'),
        ),
      ];

  static List<Component> tooltip() => [
        ArcaneTooltip(
          content: 'Tooltip message',
          child: ArcaneButton.secondary(label: 'Hover me', onPressed: () {}),
        ),
      ];

  static List<Component> accordion() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneAccordion(
              items: [
                ArcaneAccordionItem(
                  title: 'Section 1',
                  content: 'Content for section 1',
                ),
                ArcaneAccordionItem(
                  title: 'Section 2',
                  content: 'Content for section 2',
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> toast() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
            raw: {'border-left': '4px solid var(--arcane-accent)'},
          ),
          children: [
            ArcaneRow(
              gapSize: Gap.sm,
              children: [
                ArcaneText('✓'),
                ArcaneText('Toast notification'),
              ],
            ),
          ],
        ),
      ];
}
