import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for navigation components
class NavigationDemos {
  static List<Component> header() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '100%',
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ArcaneRow(gapSize: Gap.sm, children: [
                  ArcaneIcon.zap(size: IconSize.md),
                  ArcaneText('Logo', weight: FontWeight.bold),
                ]),
                ArcaneRow(
                  gapSize: Gap.lg,
                  children: [
                    ArcaneRow(gapSize: Gap.xs, children: [
                      ArcaneIcon.home(size: IconSize.sm),
                      ArcaneText('Home'),
                    ]),
                    ArcaneRow(gapSize: Gap.xs, children: [
                      ArcaneIcon.info(size: IconSize.sm),
                      ArcaneText('About'),
                    ]),
                    ArcaneRow(gapSize: Gap.xs, children: [
                      ArcaneIcon.mail(size: IconSize.sm),
                      ArcaneText('Contact'),
                    ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> sidebar() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '180px',
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              children: [
                ArcaneRow(gapSize: Gap.sm, children: [
                  ArcaneIcon.home(size: IconSize.sm),
                  ArcaneText('Dashboard'),
                ]),
                ArcaneRow(gapSize: Gap.sm, children: [
                  ArcaneIcon.settings(size: IconSize.sm),
                  ArcaneText('Settings'),
                ]),
                ArcaneRow(gapSize: Gap.sm, children: [
                  ArcaneIcon.user(size: IconSize.sm),
                  ArcaneText('Profile'),
                ]),
              ],
            ),
          ],
        ),
      ];

  static List<Component> bottomNav() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '250px',
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneRow(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ArcaneIcon.home(size: IconSize.lg),
                ArcaneIcon.search(size: IconSize.lg),
                ArcaneIcon.user(size: IconSize.lg),
                ArcaneIcon.settings(size: IconSize.lg),
              ],
            ),
          ],
        ),
      ];

  static List<Component> dropdownMenu() => [
        ArcaneDropdownMenu(
          trigger: ArcaneButton.secondary(
            label: 'Menu',
            trailing: ArcaneIcon.chevronDown(size: IconSize.sm),
            onPressed: () {},
          ),
          items: [
            ArcaneDropdownItem(label: 'Option 1', onTap: () {}),
            ArcaneDropdownItem(label: 'Option 2', onTap: () {}),
          ],
        ),
      ];

  static List<Component> mobileMenu() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ArcaneText('Logo'),
                ArcaneIconButton(icon: ArcaneIcon.menu(), onPressed: () {}),
              ],
            ),
          ],
        ),
      ];

  static List<Component> megaMenu() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneText('Mega Menu (hover to expand)', color: TextColor.muted),
          ],
        ),
      ];

  static List<Component> breadcrumbs() => [
        ArcaneBreadcrumbs(
          items: const [
            BreadcrumbItem(label: 'Home', href: '/'),
            BreadcrumbItem(label: 'Products', href: '/products'),
            BreadcrumbItem(label: 'Category', href: '/products/category'),
            BreadcrumbItem(label: 'Item'),
          ],
        ),
      ];

  static List<Component> pagination() => [
        ArcanePagination(
          currentPage: 3,
          totalPages: 10,
          onPageChange: (_) {},
        ),
      ];
}
