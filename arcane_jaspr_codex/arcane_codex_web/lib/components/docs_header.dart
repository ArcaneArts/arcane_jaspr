import 'package:arcane_jaspr/arcane_jaspr.dart';

import '../utils/constants.dart';

/// Documentation site header with navigation, search, and theme toggle
class DocsHeader extends StatelessComponent {
  final bool isDark;
  final VoidCallback? onThemeToggle;

  const DocsHeader({
    super.key,
    this.isDark = false,
    this.onThemeToggle,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneBar(
      leading: [
        a(
          href: '/',
          [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                display: Display.flex,
                alignItems: AlignItems.center,
                gap: Gap.sm,
              ),
              children: [
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.lg,
                    textColor: TextColor.primary,
                  ),
                  children: [ArcaneText(AppConstants.siteName)],
                ),
              ],
            ),
          ],
        ),
      ],
      trailing: [
        // Search bar
        _buildSearchBar(),

        // Navigation links
        a(
          href: '/docs',
          [
            ArcaneButton.ghost(
              label: 'Docs',
              onPressed: () {},
            ),
          ],
        ),
        a(
          href: '/guides',
          [
            ArcaneButton.ghost(
              label: 'Guides',
              onPressed: () {},
            ),
          ],
        ),
        if (AppConstants.githubUrl.isNotEmpty)
          a(
            href: AppConstants.githubUrl,
            attributes: {'target': '_blank', 'rel': 'noopener'},
            [
              ArcaneButton.ghost(
                label: 'GitHub',
                onPressed: () {},
              ),
            ],
          ),
        // Theme toggle button - uses JavaScript for static site
        _buildThemeToggle(),
      ],
    );
  }

  /// Search bar that filters documentation
  Component _buildSearchBar() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.relative,
        widthCustom: '240px',
        raw: {'margin-right': '16px'},
      ),
      children: [
        // Search input
        input(
          id: 'docs-search',
          type: InputType.text,
          attributes: {
            'placeholder': 'Search docs...',
            'autocomplete': 'off',
          },
          styles: const Styles(raw: {
            'width': '100%',
            'padding': '8px 12px 8px 36px',
            'font-size': '14px',
            'border': '1px solid var(--arcane-outline)',
            'border-radius': '8px',
            'background': 'var(--arcane-surface)',
            'color': 'var(--arcane-on-surface)',
            'outline': 'none',
            'transition': 'border-color 0.2s, box-shadow 0.2s',
          }),
        ),
        // Search icon (SVG)
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.absolute,
            raw: {
              'left': '12px',
              'top': '50%',
              'transform': 'translateY(-50%)',
              'pointer-events': 'none',
              'color': 'var(--arcane-on-surface-variant)',
            },
          ),
          children: [
            Component.element(
              tag: 'svg',
              attributes: {
                'width': '16',
                'height': '16',
                'viewBox': '0 0 24 24',
                'fill': 'none',
                'stroke': 'currentColor',
                'stroke-width': '2',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
              },
              children: [
                Component.element(tag: 'circle', attributes: {'cx': '11', 'cy': '11', 'r': '8'}),
                Component.element(tag: 'path', attributes: {'d': 'm21 21-4.35-4.35'}),
              ],
            ),
          ],
        ),
        // Search results dropdown
        div(
          id: 'search-results',
          styles: const Styles(raw: {
            'display': 'none',
            'position': 'absolute',
            'top': '100%',
            'left': '0',
            'right': '0',
            'margin-top': '4px',
            'background': 'var(--arcane-surface)',
            'border': '1px solid var(--arcane-outline)',
            'border-radius': '8px',
            'box-shadow': '0 4px 12px rgba(0,0,0,0.15)',
            'max-height': '300px',
            'overflow-y': 'auto',
            'z-index': '1000',
          }),
          [],
        ),
      ],
    );
  }

  /// Theme toggle button that works via JavaScript
  Component _buildThemeToggle() {
    return button(
      id: 'theme-toggle',
      attributes: {
        'aria-label': 'Toggle theme',
        'title': 'Toggle light/dark mode',
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '40px',
        'height': '40px',
        'border': '1px solid var(--arcane-outline)',
        'border-radius': '8px',
        'background': 'var(--arcane-surface)',
        'color': 'var(--arcane-on-surface)',
        'cursor': 'pointer',
        'transition': 'background 0.2s, border-color 0.2s',
      }),
      [
        // Sun icon (shown in dark mode - click to go light)
        span(
          id: 'sun-icon',
          styles: const Styles(raw: {'display': 'inline', 'line-height': '0'}),
          [
            Component.element(
              tag: 'svg',
              attributes: {
                'width': '18',
                'height': '18',
                'viewBox': '0 0 24 24',
                'fill': 'none',
                'stroke': 'currentColor',
                'stroke-width': '2',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
              },
              children: [
                Component.element(tag: 'circle', attributes: {'cx': '12', 'cy': '12', 'r': '5'}),
                Component.element(tag: 'line', attributes: {'x1': '12', 'y1': '1', 'x2': '12', 'y2': '3'}),
                Component.element(tag: 'line', attributes: {'x1': '12', 'y1': '21', 'x2': '12', 'y2': '23'}),
                Component.element(tag: 'line', attributes: {'x1': '4.22', 'y1': '4.22', 'x2': '5.64', 'y2': '5.64'}),
                Component.element(tag: 'line', attributes: {'x1': '18.36', 'y1': '18.36', 'x2': '19.78', 'y2': '19.78'}),
                Component.element(tag: 'line', attributes: {'x1': '1', 'y1': '12', 'x2': '3', 'y2': '12'}),
                Component.element(tag: 'line', attributes: {'x1': '21', 'y1': '12', 'x2': '23', 'y2': '12'}),
                Component.element(tag: 'line', attributes: {'x1': '4.22', 'y1': '19.78', 'x2': '5.64', 'y2': '18.36'}),
                Component.element(tag: 'line', attributes: {'x1': '18.36', 'y1': '5.64', 'x2': '19.78', 'y2': '4.22'}),
              ],
            ),
          ],
        ),
        // Moon icon (shown in light mode - click to go dark)
        span(
          id: 'moon-icon',
          styles: const Styles(raw: {'display': 'none', 'line-height': '0'}),
          [
            Component.element(
              tag: 'svg',
              attributes: {
                'width': '18',
                'height': '18',
                'viewBox': '0 0 24 24',
                'fill': 'none',
                'stroke': 'currentColor',
                'stroke-width': '2',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
              },
              children: [
                Component.element(tag: 'path', attributes: {'d': 'M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z'}),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
