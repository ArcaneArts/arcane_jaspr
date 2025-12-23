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

  static List<Component> callout() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneCallout(
              title: 'Note',
              content: 'This is an important callout message.',
              style: CalloutStyle.info,
            ),
          ],
        ),
      ];

  static List<Component> kbd() => [
        ArcaneRow(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ArcaneKbd('⌘'),
            ArcaneText('+'),
            ArcaneKbd('K'),
          ],
        ),
      ];

  static List<Component> meter() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneMeter(
              value: 0.65,
              label: 'Storage',
              showValue: true,
            ),
          ],
        ),
      ];

  static List<Component> alert() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneAlert(
              title: 'Success',
              message: 'Your changes have been saved.',
              severity: AlertSeverity.success,
            ),
          ],
        ),
      ];

  static List<Component> inlineTabs() => [
        ArcaneTabBar(
          tabs: const [
            ArcaneTabBarItem(label: 'Overview'),
            ArcaneTabBarItem(label: 'Features'),
            ArcaneTabBarItem(label: 'Pricing'),
          ],
          selectedIndex: 0,
          onChanged: (_) {},
        ),
      ];

  static List<Component> treeView() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '250px'),
          children: [
            ArcaneTreeView(
              nodes: [
                TreeNode(
                  id: 'src',
                  label: 'src',
                  icon: ArcaneIcon.folder(),
                  children: [
                    TreeNode(id: 'main', label: 'main.dart', icon: ArcaneIcon.file()),
                    TreeNode(id: 'app', label: 'app.dart', icon: ArcaneIcon.file()),
                  ],
                ),
                TreeNode(id: 'pubspec', label: 'pubspec.yaml', icon: ArcaneIcon.file()),
              ],
            ),
          ],
        ),
      ];

  static List<Component> popover() => [
        ArcanePopover(
          trigger: ArcaneButton.secondary(label: 'Open Popover', onPressed: () {}),
          content: ArcaneDiv(
            styles: const ArcaneStyleData(padding: PaddingPreset.sm),
            children: [
              ArcaneText('Popover content'),
            ],
          ),
          position: PopoverPosition.bottom,
        ),
      ];

  static List<Component> hovercard() => [
        ArcaneHovercard(
          trigger: ArcaneButton.secondary(label: 'Hover me', onPressed: () {}),
          content: ArcaneColumn(
            gapSize: Gap.sm,
            children: [
              ArcaneRow(
                gapSize: Gap.sm,
                children: [
                  ArcaneAvatar(initials: 'JD'),
                  ArcaneColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ArcaneText('John Doe', weight: FontWeight.bold),
                      ArcaneText('Software Engineer', color: TextColor.muted),
                    ],
                  ),
                ],
              ),
            ],
          ),
          position: HovercardPosition.bottom,
        ),
      ];

  static List<Component> icon() => [
        ArcaneRow(
          gapSize: Gap.md,
          children: [
            ArcaneIcon.home(),
            ArcaneIcon.search(),
            ArcaneIcon.settings(),
            ArcaneIcon.user(),
            ArcaneIcon.heart(),
            ArcaneIcon.star(),
          ],
        ),
      ];

  static List<Component> svg() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic SVG usage
            ArcaneRow(
              gapSize: Gap.lg,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneSvg(
                      viewBox: '0 0 24 24',
                      size: SvgSize.xl,
                      children: [
                        ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                      ],
                    ),
                    ArcaneText('Circle', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneSvg(
                      viewBox: '0 0 24 24',
                      size: SvgSize.xl,
                      children: [
                        ArcaneSvgRect(x: '2', y: '2', width: '20', height: '20', rx: '4'),
                      ],
                    ),
                    ArcaneText('Square', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneSvg(
                      viewBox: '0 0 24 24',
                      size: SvgSize.xl,
                      children: [
                        ArcaneSvgPolygon(points: '12,2 22,22 2,22'),
                      ],
                    ),
                    ArcaneText('Triangle', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
              ],
            ),
            // Colored SVGs
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneSvg(
                  viewBox: '0 0 24 24',
                  size: SvgSize.lg,
                  fill: 'var(--arcane-success)',
                  children: [
                    ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                  ],
                ),
                ArcaneSvg(
                  viewBox: '0 0 24 24',
                  size: SvgSize.lg,
                  fill: 'var(--arcane-warning)',
                  children: [
                    ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                  ],
                ),
                ArcaneSvg(
                  viewBox: '0 0 24 24',
                  size: SvgSize.lg,
                  fill: 'var(--arcane-error)',
                  children: [
                    ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                  ],
                ),
                ArcaneSvg(
                  viewBox: '0 0 24 24',
                  size: SvgSize.lg,
                  fill: 'var(--arcane-accent)',
                  children: [
                    ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}
