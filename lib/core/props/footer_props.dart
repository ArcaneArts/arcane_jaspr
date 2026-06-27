import 'package:arcane_jaspr/flutter.dart';

/// Footer link group data.
class FooterLinkGroup {
  final String title;
  final List<FooterLink> links;

  const FooterLinkGroup({
    required this.title,
    required this.links,
  });
}

/// Footer link data.
class FooterLink {
  final String label;
  final String? href;
  final void Function()? onTap;
  final bool external;
  final String? icon;

  const FooterLink({
    required this.label,
    this.href,
    this.onTap,
    this.external = false,
    this.icon,
  });
}

/// Footer component properties.
class FooterProps {
  final Widget? logo;
  final String? description;
  final List<FooterLinkGroup> linkGroups;
  final List<Widget>? socialLinks;
  final String? copyright;
  final List<FooterLink>? bottomLinks;
  final bool showNewsletter;
  final String newsletterPlaceholder;
  final String newsletterButtonText;
  final void Function(String)? onNewsletterSubmit;

  const FooterProps({
    this.logo,
    this.description,
    required this.linkGroups,
    this.socialLinks,
    this.copyright,
    this.bottomLinks,
    this.showNewsletter = false,
    this.newsletterPlaceholder = 'Enter your email',
    this.newsletterButtonText = 'Subscribe',
    this.onNewsletterSubmit,
  });
}

/// Footer social icon component properties.
class FooterSocialIconProps {
  final Widget icon;
  final String? href;
  final void Function()? onTap;
  final String label;

  const FooterSocialIconProps({
    required this.icon,
    required this.label,
    this.href,
    this.onTap,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for footer components.
mixin FooterRendererContract {
  Widget footer(FooterProps props);
  Widget footerSocialIcon(FooterSocialIconProps props);
}
