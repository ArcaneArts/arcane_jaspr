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
    final base = AppConstants.baseUrl;
    return ArcaneBar(
      leading: [
        // Logo/title link using ArcaneLink
        ArcaneLink(
          href: '$base/',
          styles: const ArcaneStyleData(
            textDecoration: TextDecoration.none,
          ),
          child: ArcaneDiv(
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
        ),
      ],
      trailing: [
        // Search bar using ArcaneSearchBar
        ArcaneSearchBar(
          id: 'docs-search',
          resultsId: 'search-results',
          placeholder: 'Search docs...',
          width: '240px',
          iconSize: 20,
          styles: const ArcaneStyleData(
            margin: MarginPreset.rightMd,
          ),
        ),

        // Navigation links using ArcaneLink
        ArcaneLink(
          href: '$base/docs',
          styles: const ArcaneStyleData(
            textDecoration: TextDecoration.none,
          ),
          child: ArcaneButton.ghost(
            label: 'Docs',
            onPressed: () {},
          ),
        ),
        ArcaneLink(
          href: '$base/guides',
          styles: const ArcaneStyleData(
            textDecoration: TextDecoration.none,
          ),
          child: ArcaneButton.ghost(
            label: 'Guides',
            onPressed: () {},
          ),
        ),
        if (AppConstants.githubUrl.isNotEmpty)
          ArcaneLink.external(
            href: AppConstants.githubUrl,
            styles: const ArcaneStyleData(
              textDecoration: TextDecoration.none,
            ),
            child: ArcaneButton.ghost(
              label: 'GitHub',
              onPressed: () {},
            ),
          ),

        // Theme toggle button using ArcaneIconButton
        _buildThemeToggle(),
      ],
    );
  }

  /// Theme toggle button that uses the layout state for switching themes
  /// Uses ArcaneIconButton with ArcaneIcon for proper component structure
  Component _buildThemeToggle() {
    return ArcaneDiv(
      id: 'theme-toggle',
      styles: const ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
        widthCustom: '40px',
        heightCustom: '40px',
        border: BorderPreset.subtle,
        borderRadius: Radius.md,
        background: Background.surface,
        textColor: TextColor.primary,
        cursor: Cursor.pointer,
        transition: Transition.allFast,
      ),
      events: {
        'click': (_) {
          onThemeToggle?.call();
        },
      },
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            lineHeight: LineHeight.none,
          ),
          children: [
            if (isDark) Sun(width: Unit.pixels(20), height: Unit.pixels(20)),
            if (!isDark) Moon(width: Unit.pixels(20), height: Unit.pixels(20)),
          ],
        ),
      ],
    );
  }
}
