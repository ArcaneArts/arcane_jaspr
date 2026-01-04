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
                ArcaneIcon.check(size: IconSize.sm),
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
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Size comparison
            ArcaneText('Icon Sizes', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.xs),
                    ArcaneText('xs', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.sm),
                    ArcaneText('sm', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.md),
                    ArcaneText('md', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.lg),
                    ArcaneText('lg', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.xl),
                    ArcaneText('xl', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.xl2),
                    ArcaneText('xl2', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
              ],
            ),

            // Navigation icons
            ArcaneText('Navigation', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.home(),
                ArcaneIcon.search(),
                ArcaneIcon.settings(),
                ArcaneIcon.menu(),
                ArcaneIcon.close(),
                ArcaneIcon.chevronDown(),
                ArcaneIcon.chevronRight(),
                ArcaneIcon.arrowLeft(),
                ArcaneIcon.externalLink(),
              ],
            ),

            // Actions
            ArcaneText('Actions', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.edit(),
                ArcaneIcon.copy(),
                ArcaneIcon.trash(),
                ArcaneIcon.save(),
                ArcaneIcon.download(),
                ArcaneIcon.upload(),
                ArcaneIcon.refresh(),
                ArcaneIcon.plus(),
                ArcaneIcon.check(),
              ],
            ),

            // Files & Folders
            ArcaneText('Files & Folders', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.file(),
                ArcaneIcon.fileText(),
                ArcaneIcon.folder(),
                ArcaneIcon.folderOpen(),
                ArcaneIcon.code(),
                ArcaneIcon.terminal(),
                ArcaneIcon.database(),
              ],
            ),

            // Communication
            ArcaneText('Communication', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.bell(),
                ArcaneIcon.mail(),
                ArcaneIcon.message(),
                ArcaneIcon.send(),
                ArcaneIcon.info(),
                ArcaneIcon.warning(),
                ArcaneIcon.help(),
              ],
            ),

            // Social & Feedback
            ArcaneText('Social & Feedback', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.heart(),
                ArcaneIcon.star(),
                ArcaneIcon.thumbsUp(),
                ArcaneIcon.thumbsDown(),
                ArcaneIcon.share(),
                ArcaneIcon.bookmark(),
              ],
            ),

            // Theme & Display
            ArcaneText('Theme & Display', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.sun(),
                ArcaneIcon.moon(),
                ArcaneIcon.eye(),
                ArcaneIcon.eyeOff(),
                ArcaneIcon.monitor(),
                ArcaneIcon.smartphone(),
              ],
            ),

            // Security
            ArcaneText('Security', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.lock(),
                ArcaneIcon.unlock(),
                ArcaneIcon.key(),
                ArcaneIcon.shield(),
                ArcaneIcon.shieldCheck(),
              ],
            ),

            // Semantic Aliases (intuitive names)
            ArcaneText('Semantic Aliases', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.home(), // -> house()
                ArcaneIcon.close(), // -> x()
                ArcaneIcon.edit(), // -> pencil()
                ArcaneIcon.delete(), // -> trash2()
                ArcaneIcon.success(), // -> circleCheck()
                ArcaneIcon.error(), // -> circleX()
                ArcaneIcon.loading(), // -> loaderCircle()
                ArcaneIcon.grid(), // -> grid3x3()
              ],
            ),

            // Status icons
            ArcaneText('Status', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.success(),
                ArcaneIcon.error(),
                ArcaneIcon.warning(),
                ArcaneIcon.info(),
                ArcaneIcon.help(),
                ArcaneIcon.loading(),
              ],
            ),

            // Misc
            ArcaneText('Misc', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.moreHorizontal(),
                ArcaneIcon.moreVertical(),
                ArcaneIcon.filter(),
                ArcaneIcon.sort(),
                ArcaneIcon.zap(),
                ArcaneIcon.sparkles(),
                ArcaneIcon.rocket(),
                ArcaneIcon.flame(),
              ],
            ),

            // Total count
            ArcaneText('1,666 icons available!',
              size: FontSize.sm,
              color: TextColor.muted,
            ),
          ],
        ),
      ];

  static List<Component> fadeEdge() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.relative,
            widthCustom: '300px',
            heightCustom: '100px',
            background: Background.surface,
            borderRadius: Radius.md,
            overflow: Overflow.hidden,
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                padding: PaddingPreset.md,
              ),
              children: [
                ArcaneText('Content with fade edges on left and right.'),
              ],
            ),
            ArcaneFadeEdge.left(),
            ArcaneFadeEdge.right(),
          ],
        ),
      ];

  static List<Component> marquee() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '100%',
            overflow: Overflow.hidden,
          ),
          children: [
            ArcaneMarquee(
              duration: '20s',
              showFadeEdges: true,
              pauseOnHover: true,
              children: [
                for (final tech in ['React', 'Vue', 'Angular', 'Svelte', 'Next.js', 'Nuxt', 'Astro', 'Remix'])
                  ArcaneDiv(
                    styles: const ArcaneStyleData(
                      padding: PaddingPreset.md,
                      background: Background.surface,
                      borderRadius: Radius.md,
                      border: BorderPreset.subtle,
                    ),
                    children: [ArcaneText(tech)],
                  ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> statDisplay() => [
        ArcaneStatRow(
          stats: [
            ArcaneStatDisplay(value: '99.9%', label: 'Uptime SLA'),
            ArcaneStatDisplay(value: '10K+', label: 'Active Servers'),
            ArcaneStatDisplay(value: '<60s', label: 'Deploy Time'),
          ],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(margin: MarginPreset.topLg),
          children: [
            ArcaneRow(
              gapSize: Gap.xl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ArcaneStatDisplay.accent(
                  value: '5M+',
                  label: 'Downloads',
                ),
                ArcaneStatDisplay.accent(
                  value: '150+',
                  label: 'Contributors',
                  layout: StatDisplayLayout.horizontal,
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> authorCard() => [
        ArcaneRow(
          gapSize: Gap.xl,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ArcaneAuthorCard.sm(
              name: 'Jane Doe',
              role: 'Developer',
              initials: 'JD',
            ),
            ArcaneAuthorCard(
              name: 'John Smith',
              role: 'Software Engineer',
              initials: 'JS',
            ),
            ArcaneAuthorCard.lg(
              name: 'Alice Johnson',
              role: 'CEO & Founder',
              initials: 'AJ',
            ),
          ],
        ),
      ];

  static List<Component> codeWindow() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '400px'),
          children: [
            ArcaneCodeWindow(
              title: 'main.dart',
              code: '''void main() {
  print('Hello, World!');
}''',
            ),
          ],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '400px',
            margin: MarginPreset.topMd,
          ),
          children: [
            ArcaneCodeWindow.terminal(
              title: 'Terminal',
              code: '\$ dart run\nHello, World!\n\$ ',
            ),
          ],
        ),
      ];

  static List<Component> checkList() => [
        ArcaneRow(
          gapSize: Gap.xxl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Brand Icons', weight: FontWeight.bold),
                ArcaneCheckList.brand(
                  items: [
                    'Shared models',
                    'Type-safe API calls',
                    'Hot reload',
                  ],
                ),
              ],
            ),
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Success Icons', weight: FontWeight.bold),
                ArcaneCheckList.success(
                  items: [
                    'All tests passing',
                    'Build successful',
                    'Deployed to prod',
                  ],
                ),
              ],
            ),
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Feature Rows', weight: FontWeight.bold),
                ArcaneFeatureRow(feature: 'Unlimited API calls', included: true),
                ArcaneFeatureRow(feature: 'Priority support', included: true),
                ArcaneFeatureRow(feature: 'Custom domain', included: false),
              ],
            ),
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

  static List<Component> dotIndicator() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Basic Dot Indicator', weight: FontWeight.w600),
            ArcaneDotIndicator(
              index: 2,
              length: 5,
              onChanged: (_) {},
            ),
            ArcaneText('Large Dots', weight: FontWeight.w600),
            ArcaneDotIndicator(
              index: 1,
              length: 4,
              size: DotIndicatorSize.lg,
              onChanged: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> stepIndicator() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '500px'),
          children: [
            ArcaneStepIndicator(
              currentStep: 1,
              steps: const ['Account', 'Profile', 'Review', 'Complete'],
              onStepTap: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> tracker() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Contribution Grid', weight: FontWeight.w600),
            ArcaneTracker(
              data: List.generate(90, (i) => TrackerData(
                level: i % 5 == 0 ? TrackerLevel.fine
                    : i % 7 == 0 ? TrackerLevel.warning
                    : i % 11 == 0 ? TrackerLevel.critical
                    : TrackerLevel.unknown,
                tooltip: 'Day ${i + 1}',
              )),
              showLegend: true,
            ),
            ArcaneText('Uptime Tracker', weight: FontWeight.w600),
            ArcaneDiv(
              styles: const ArcaneStyleData(widthCustom: '300px'),
              children: [
                ArcaneUptimeTracker(
                  days: List.generate(30, (i) => UptimeDay(
                    date: DateTime.now().subtract(Duration(days: i)),
                    uptime: 99.0 + (i % 10) / 10,
                  )),
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> surfaceCard() => [
        ArcaneRow(
          gapSize: Gap.lg,
          children: [
            ArcaneSurfaceCard(
              effect: SurfaceEffect.none,
              child: ArcaneText('Plain'),
            ),
            ArcaneSurfaceCard.blur(
              child: ArcaneText('Blur'),
            ),
            ArcaneSurfaceCard.frosted(
              child: ArcaneText('Frosted'),
            ),
            ArcaneSurfaceCard.glass(
              child: ArcaneText('Glass'),
            ),
            ArcaneSurfaceCard.gradient(
              child: ArcaneText('Gradient'),
            ),
          ],
        ),
      ];

  static List<Component> switcher() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '300px',
            heightCustom: '100px',
            background: Background.surfaceVariant,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneSwitcher(
              index: 0,
              direction: SwitcherDirection.fade,
              children: [
                ArcaneCenter(child: ArcaneText('Step 1 Content')),
                ArcaneCenter(child: ArcaneText('Step 2 Content')),
                ArcaneCenter(child: ArcaneText('Step 3 Content')),
              ],
            ),
          ],
        ),
      ];

  static List<Component> avatarGroup() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Avatar Group', weight: FontWeight.w600),
            ArcaneAvatarGroup.toRight(
              avatars: [
                ArcaneAvatar(initials: 'AB'),
                ArcaneAvatar(initials: 'CD'),
                ArcaneAvatar(initials: 'EF'),
                ArcaneAvatar(initials: 'GH'),
                ArcaneAvatar(initials: 'IJ'),
                ArcaneAvatar(initials: 'KL'),
              ],
              maxVisible: 4,
            ),
            ArcaneText('With Avatar Badge', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.lg,
              children: [
                ArcaneDiv(
                  styles: const ArcaneStyleData(position: Position.relative),
                  children: [
                    ArcaneAvatar(initials: 'JD'),
                    ArcaneAvatarBadge.online(),
                  ],
                ),
                ArcaneDiv(
                  styles: const ArcaneStyleData(position: Position.relative),
                  children: [
                    ArcaneAvatar(initials: 'AB'),
                    ArcaneAvatarBadge.busy(),
                  ],
                ),
                ArcaneDiv(
                  styles: const ArcaneStyleData(position: Position.relative),
                  children: [
                    ArcaneAvatar(initials: 'CD'),
                    ArcaneAvatarBadge.away(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}
