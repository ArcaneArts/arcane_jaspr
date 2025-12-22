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
                ArcaneText('Logo', weight: FontWeight.bold),
                ArcaneRow(
                  gapSize: Gap.md,
                  children: [
                    ArcaneText('Home'),
                    ArcaneText('About'),
                    ArcaneText('Contact'),
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
            widthCustom: '150px',
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              children: [
                ArcaneText('Dashboard'),
                ArcaneText('Settings'),
                ArcaneText('Profile'),
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
                ArcaneText('🏠'),
                ArcaneText('🔍'),
                ArcaneText('👤'),
                ArcaneText('⚙'),
              ],
            ),
          ],
        ),
      ];

  static List<Component> dropdownMenu() => [
        ArcaneDropdownMenu(
          trigger: ArcaneButton.secondary(label: 'Menu ▼', onPressed: () {}),
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
                ArcaneIconButton(icon: ArcaneText('☰'), onPressed: () {}),
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
