import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Interactive pagination demo
class PaginationDemo extends StatefulComponent {
  const PaginationDemo({super.key});

  @override
  State<PaginationDemo> createState() => _PaginationDemoState();
}

class _PaginationDemoState extends State<PaginationDemo> {
  int _currentPage = 1;
  static const int _totalPages = 10;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcanePagination(
          currentPage: _currentPage,
          totalPages: _totalPages,
          onPageChange: (page) => setState(() => _currentPage = page),
        ),
        ArcaneText(
          'Page $_currentPage of $_totalPages',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive pagination with styles demo
class PaginationStylesDemo extends StatefulComponent {
  const PaginationStylesDemo({super.key});

  @override
  State<PaginationStylesDemo> createState() => _PaginationStylesDemoState();
}

class _PaginationStylesDemoState extends State<PaginationStylesDemo> {
  int _page1 = 3;
  int _page2 = 5;
  int _page3 = 2;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Outline style:', weight: FontWeight.w500),
            ArcanePagination(
              currentPage: _page1,
              totalPages: 10,
              style: PaginationStyle.outline,
              onPageChange: (page) => setState(() => _page1 = page),
            ),
          ],
        ),
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Filled style:', weight: FontWeight.w500),
            ArcanePagination(
              currentPage: _page2,
              totalPages: 10,
              style: PaginationStyle.filled,
              onPageChange: (page) => setState(() => _page2 = page),
            ),
          ],
        ),
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Ghost style:', weight: FontWeight.w500),
            ArcanePagination(
              currentPage: _page3,
              totalPages: 10,
              style: PaginationStyle.ghost,
              onPageChange: (page) => setState(() => _page3 = page),
            ),
          ],
        ),
      ],
    );
  }
}

/// Interactive simple pagination demo
class SimplePaginationDemo extends StatefulComponent {
  const SimplePaginationDemo({super.key});

  @override
  State<SimplePaginationDemo> createState() => _SimplePaginationDemoState();
}

class _SimplePaginationDemoState extends State<SimplePaginationDemo> {
  int _currentPage = 1;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcanePagination.simple(
          currentPage: _currentPage,
          totalPages: 5,
          onPageChange: (page) => setState(() => _currentPage = page),
        ),
      ],
    );
  }
}

/// Interactive sidebar demo
class SidebarDemo extends StatefulComponent {
  const SidebarDemo({super.key});

  @override
  State<SidebarDemo> createState() => _SidebarDemoState();
}

class _SidebarDemoState extends State<SidebarDemo> {
  String _selectedItem = 'dashboard';

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '220px',
        heightCustom: '300px',
        background: Background.surface,
        overflow: Overflow.hidden,
      ),
      children: [
        ArcaneSidebar(
          children: [
            ArcaneSidebarItem(
              icon: ArcaneIcon.home(),
              label: 'Dashboard',
              selected: _selectedItem == 'dashboard',
              onTap: () => setState(() => _selectedItem = 'dashboard'),
            ),
            ArcaneSidebarItem(
              icon: ArcaneIcon.user(),
              label: 'Users',
              selected: _selectedItem == 'users',
              onTap: () => setState(() => _selectedItem = 'users'),
            ),
            ArcaneSidebarItem(
              icon: ArcaneIcon.settings(),
              label: 'Settings',
              selected: _selectedItem == 'settings',
              onTap: () => setState(() => _selectedItem = 'settings'),
            ),
            ArcaneSidebarItem(
              icon: ArcaneIcon.folder(),
              label: 'Files',
              selected: _selectedItem == 'files',
              onTap: () => setState(() => _selectedItem = 'files'),
            ),
          ],
        ),
      ],
    );
  }
}

/// Interactive bottom nav demo
class BottomNavDemo extends StatefulComponent {
  const BottomNavDemo({super.key});

  @override
  State<BottomNavDemo> createState() => _BottomNavDemoState();
}

class _BottomNavDemoState extends State<BottomNavDemo> {
  int _selectedIndex = 0;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '320px'),
          children: [
            ArcaneBottomNavigationBar(
              items: [
                ArcaneBottomNavItem(
                  icon: ArcaneIcon.home(),
                  label: 'Home',
                ),
                ArcaneBottomNavItem(
                  icon: ArcaneIcon.search(),
                  label: 'Search',
                ),
                ArcaneBottomNavItem(
                  icon: ArcaneIcon.bell(),
                  label: 'Alerts',
                ),
                ArcaneBottomNavItem(
                  icon: ArcaneIcon.user(),
                  label: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onChanged: (index) => setState(() => _selectedIndex = index),
            ),
          ],
        ),
        ArcaneText(
          'Selected: ${['Home', 'Search', 'Alerts', 'Profile'][_selectedIndex]}',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive drawer demo
class DrawerDemo extends StatefulComponent {
  const DrawerDemo({super.key});

  @override
  State<DrawerDemo> createState() => _DrawerDemoState();
}

class _DrawerDemoState extends State<DrawerDemo> {
  bool _isOpen = false;
  DrawerPosition _position = DrawerPosition.left;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton.primary(
              label: 'Open Left',
              onPressed: () => setState(() {
                _position = DrawerPosition.left;
                _isOpen = true;
              }),
            ),
            ArcaneButton.primary(
              label: 'Open Right',
              onPressed: () => setState(() {
                _position = DrawerPosition.right;
                _isOpen = true;
              }),
            ),
          ],
        ),
        if (_isOpen)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              position: Position.fixed,
              raw: {'inset': '0', 'z-index': '1000'},
            ),
            children: [
              ArcaneDrawer(
                isOpen: _isOpen,
                position: _position,
                onClose: () => setState(() => _isOpen = false),
                header: ArcaneText('Drawer Title', weight: FontWeight.w600),
                child: ArcaneColumn(
                  gapSize: Gap.md,
                  children: [
                    ArcaneText('This is drawer content.'),
                    ArcaneText('You can put any widgets here.'),
                    ArcaneButton.outline(
                      label: 'Close',
                      onPressed: () => setState(() => _isOpen = false),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Interactive dropdown menu demo
class DropdownMenuDemo extends StatefulComponent {
  const DropdownMenuDemo({super.key});

  @override
  State<DropdownMenuDemo> createState() => _DropdownMenuDemoState();
}

class _DropdownMenuDemoState extends State<DropdownMenuDemo> {
  String _selectedItem = 'None';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDropdownMenu(
          trigger: ArcaneButton.secondary(label: 'Open Menu ▼', onPressed: () {}),
          items: [
            ArcaneDropdownItem(
              label: 'Edit',
              icon: ArcaneIcon.edit(),
              onTap: () => setState(() => _selectedItem = 'Edit'),
            ),
            ArcaneDropdownItem(
              label: 'Duplicate',
              icon: ArcaneIcon.copy(),
              onTap: () => setState(() => _selectedItem = 'Duplicate'),
            ),
            ArcaneDropdownItem(
              label: 'Delete',
              icon: ArcaneIcon.trash(),
              onTap: () => setState(() => _selectedItem = 'Delete'),
            ),
          ],
        ),
        ArcaneText(
          'Selected: $_selectedItem',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive mobile menu demo
class MobileMenuDemo extends StatefulComponent {
  const MobileMenuDemo({super.key});

  @override
  State<MobileMenuDemo> createState() => _MobileMenuDemoState();
}

class _MobileMenuDemoState extends State<MobileMenuDemo> {
  bool _isOpen = false;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '300px',
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ArcaneText('Logo', weight: FontWeight.bold),
                ArcaneIconButton(
                  icon: _isOpen ? ArcaneIcon.close() : ArcaneIcon.menu(),
                  onPressed: () => setState(() => _isOpen = !_isOpen),
                ),
              ],
            ),
            if (_isOpen)
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  margin: MarginPreset.topMd,
                  padding: PaddingPreset.md,
                  background: Background.surfaceVariant,
                  borderRadius: Radius.md,
                ),
                children: [
                  ArcaneColumn(
                    gapSize: Gap.sm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ArcaneText('Home'),
                      ArcaneText('About'),
                      ArcaneText('Services'),
                      ArcaneText('Contact'),
                    ],
                  ),
                ],
              ),
          ],
        ),
        ArcaneText(
          'Click the menu icon to toggle the mobile menu.',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive mega menu demo
class MegaMenuDemo extends StatefulComponent {
  const MegaMenuDemo({super.key});

  @override
  State<MegaMenuDemo> createState() => _MegaMenuDemoState();
}

class _MegaMenuDemoState extends State<MegaMenuDemo> {
  bool _isOpen = false;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '400px',
            background: Background.surface,
            borderRadius: Radius.md,
            overflow: Overflow.visible,
          ),
          children: [
            // Header bar
            ArcaneDiv(
              styles: const ArcaneStyleData(
                padding: PaddingPreset.md,
                display: Display.flex,
                gap: Gap.lg,
              ),
              children: [
                ArcaneText('Home'),
                div(
                  events: {
                    'mouseenter': (_) => setState(() => _isOpen = true),
                    'mouseleave': (_) => setState(() => _isOpen = false),
                  },
                  styles: const Styles(raw: {
                    'position': 'relative',
                  }),
                  [
                    ArcaneText('Products ▼', color: TextColor.accent),
                    if (_isOpen)
                      ArcaneDiv(
                        styles: const ArcaneStyleData(
                          position: Position.absolute,
                          raw: {'top': '100%', 'left': '0'},
                          padding: PaddingPreset.lg,
                          background: Background.surface,
                          borderRadius: Radius.md,
                          border: BorderPreset.subtle,
                          minWidth: '350px',
                          zIndex: ZIndex.dropdown,
                        ),
                        children: [
                          ArcaneRow(
                            gapSize: Gap.xl,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ArcaneColumn(
                                gapSize: Gap.sm,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ArcaneText('Category 1', weight: FontWeight.w600),
                                  ArcaneText('Product A', color: TextColor.muted),
                                  ArcaneText('Product B', color: TextColor.muted),
                                  ArcaneText('Product C', color: TextColor.muted),
                                ],
                              ),
                              ArcaneColumn(
                                gapSize: Gap.sm,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ArcaneText('Category 2', weight: FontWeight.w600),
                                  ArcaneText('Service X', color: TextColor.muted),
                                  ArcaneText('Service Y', color: TextColor.muted),
                                  ArcaneText('Service Z', color: TextColor.muted),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
                ArcaneText('About'),
                ArcaneText('Contact'),
              ],
            ),
          ],
        ),
        ArcaneText(
          'Hover over "Products" to see the mega menu.',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}
