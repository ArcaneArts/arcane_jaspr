import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/html.dart';
import 'package:jaspr/dom.dart' as dom;

import '../utils/constants.dart';

/// Documentation site header
class DocsHeader extends StatelessWidget {
  const DocsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    String base = AppConstants.baseUrl;

    return dom.header(
      styles: const ArcaneStyleData(
        display: Display.flex,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        padding: PaddingPreset.horizontalLg,
        heightCustom: '64px',
        border: BorderPreset.subtle,
        background: Background.background,
        position: Position.sticky,
        top: '0',
        zIndex: ZIndex.sticky,
        width: Size.full,
      ).toStyles(),
      [
        _buildNavigation(base),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            crossAxisAlignment: CrossAxisAlignment.center,
            gap: Gap.lg,
          ),
          children: [
            _buildSearch(),
            if (AppConstants.githubUrl.isNotEmpty) _buildGitHubButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigation(String base) {
    return ArcaneNav(
      styles: const ArcaneStyleData(
        display: Display.flex,
        crossAxisAlignment: CrossAxisAlignment.center,
        gap: Gap.xs,
      ),
      children: [
        _navLink('Docs', '$base/docs'),
        _navLink('Components', '$base/docs/components-catalog'),
        _navLink('Guides', '$base/guides'),
      ],
    );
  }

  Widget _navLink(String label, String href) {
    return ArcaneLink(
      href: href,
      styles: const ArcaneStyleData(
        padding: PaddingPreset.smMd,
        fontSize: FontSize.sm,
        fontWeight: FontWeight.w500,
        textColor: TextColor.mutedForeground,
        textDecoration: TextDecoration.none,
        borderRadius: Radius.md,
        transition: Transition.colors,
      ),
      child: Text(label),
    );
  }

  Widget _buildSearch() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(widthCustom: '280px'),
      children: const [
        TextInput(
          id: 'docs-search',
          placeholder: 'Search documentation...',
          size: ComponentSize.sm,
        ),
      ],
    );
  }

  Widget _buildGitHubButton() {
    return ArcaneLink(
      href: AppConstants.githubUrl,
      target: '_blank',
      rel: 'noopener noreferrer',
      styles: const ArcaneStyleData(
        display: Display.inlineFlex,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        widthCustom: '36px',
        heightCustom: '36px',
        borderRadius: Radius.md,
        textColor: TextColor.mutedForeground,
        transition: Transition.allFast,
      ),
      child: ArcaneIcon.github(size: IconSize.sm),
    );
  }
}
