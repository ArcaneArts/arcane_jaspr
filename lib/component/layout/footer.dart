import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A footer link group
class FooterLinkGroup {
  final String title;
  final List<FooterLink> links;

  const FooterLinkGroup({
    required this.title,
    required this.links,
  });
}

/// A footer link
class FooterLink {
  final String label;
  final String? href;
  final void Function()? onTap;
  final bool external;

  const FooterLink({
    required this.label,
    this.href,
    this.onTap,
    this.external = false,
  });
}

/// A website footer component (Supabase-style)
class Footer extends StatelessComponent {
  /// Logo component
  final Component? logo;

  /// Description/tagline
  final String? description;

  /// Link groups (columns)
  final List<FooterLinkGroup> linkGroups;

  /// Social media icons/links
  final List<Component>? socialLinks;

  /// Copyright text
  final String? copyright;

  /// Bottom links (privacy, terms, etc.)
  final List<FooterLink>? bottomLinks;

  /// Whether to show a newsletter form
  final bool showNewsletter;

  /// Newsletter placeholder
  final String newsletterPlaceholder;

  /// Newsletter submit text
  final String newsletterButtonText;

  /// Newsletter callback
  final void Function(String)? onNewsletterSubmit;

  const Footer({
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
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'footer',
      classes: 'arcane-footer',
      styles: Styles(raw: {
        'background-color': 'var(--arcane-surface)',
        'border-top': '1px solid var(--arcane-border)',
        'padding': '64px 24px 24px',
      }),
      children: [
        // Main footer content
        div(
          classes: 'arcane-footer-main',
          styles: Styles(raw: {
            'max-width': '1200px',
            'margin': '0 auto',
            'display': 'grid',
            'grid-template-columns': 'repeat(auto-fit, minmax(160px, 1fr))',
            'gap': '48px',
          }),
          [
            // Brand column
            if (logo != null || description != null)
              div(
                classes: 'arcane-footer-brand',
                styles: Styles(raw: {
                  'grid-column': 'span 2',
                }),
                [
                  if (logo != null) logo!,
                  if (description != null)
                    p(
                      styles: Styles(raw: {
                        'margin': '16px 0 0 0',
                        'font-size': '0.875rem',
                        'color': 'var(--arcane-muted)',
                        'max-width': '280px',
                        'line-height': '1.6',
                      }),
                      [text(description!)],
                    ),
                  if (socialLinks != null)
                    div(
                      classes: 'arcane-footer-social',
                      styles: Styles(raw: {
                        'display': 'flex',
                        'gap': '16px',
                        'margin-top': '24px',
                      }),
                      socialLinks!,
                    ),
                ],
              ),

            // Link groups
            for (final group in linkGroups)
              div(
                classes: 'arcane-footer-group',
                [
                  div(
                    classes: 'arcane-footer-group-title',
                    styles: Styles(raw: {
                      'font-size': '0.875rem',
                      'font-weight': '600',
                      'color': 'var(--arcane-on-surface)',
                      'margin-bottom': '16px',
                    }),
                    [text(group.title)],
                  ),
                  div(
                    classes: 'arcane-footer-group-links',
                    styles: Styles(raw: {
                      'display': 'flex',
                      'flex-direction': 'column',
                      'gap': '12px',
                    }),
                    [
                      for (final link in group.links)
                        _buildLink(link),
                    ],
                  ),
                ],
              ),

            // Newsletter
            if (showNewsletter)
              div(
                classes: 'arcane-footer-newsletter',
                [
                  div(
                    styles: Styles(raw: {
                      'font-size': '0.875rem',
                      'font-weight': '600',
                      'color': 'var(--arcane-on-surface)',
                      'margin-bottom': '16px',
                    }),
                    [text('Subscribe to our newsletter')],
                  ),
                  div(
                    styles: Styles(raw: {
                      'display': 'flex',
                      'gap': '8px',
                    }),
                    [
                      input(
                        type: InputType.email,
                        attributes: {
                          'placeholder': newsletterPlaceholder,
                        },
                        styles: Styles(raw: {
                          'flex': '1',
                          'padding': '10px 14px',
                          'font-size': '0.875rem',
                          'background-color': 'var(--arcane-surface-variant)',
                          'border': '1px solid var(--arcane-border)',
                          'border-radius': 'var(--arcane-radius)',
                          'color': 'var(--arcane-on-surface)',
                          'outline': 'none',
                        }),
                      ),
                      button(
                        attributes: {'type': 'submit'},
                        styles: Styles(raw: {
                          'padding': '10px 16px',
                          'font-size': '0.875rem',
                          'font-weight': '500',
                          'background-color': 'var(--arcane-accent)',
                          'color': 'var(--arcane-accent-foreground)',
                          'border': 'none',
                          'border-radius': 'var(--arcane-radius)',
                          'cursor': 'pointer',
                          'transition': 'var(--arcane-transition-fast)',
                        }),
                        [text(newsletterButtonText)],
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),

        // Bottom bar
        div(
          classes: 'arcane-footer-bottom',
          styles: Styles(raw: {
            'max-width': '1200px',
            'margin': '48px auto 0',
            'padding-top': '24px',
            'border-top': '1px solid var(--arcane-border)',
            'display': 'flex',
            'justify-content': 'space-between',
            'align-items': 'center',
            'flex-wrap': 'wrap',
            'gap': '16px',
          }),
          [
            // Copyright
            if (copyright != null)
              span(
                [text(copyright!)],
                styles: Styles(raw: {
                  'font-size': '0.8125rem',
                  'color': 'var(--arcane-muted)',
                }),
              ),

            // Bottom links
            if (bottomLinks != null)
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'gap': '24px',
                }),
                [
                  for (final link in bottomLinks!) _buildLink(link),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildLink(FooterLink link) {
    final linkStyles = Styles(raw: {
      'font-size': '0.875rem',
      'color': 'var(--arcane-muted)',
      'text-decoration': 'none',
      'transition': 'color var(--arcane-transition-fast)',
    });

    if (link.href != null) {
      return a(
        href: link.href!,
        classes: 'arcane-footer-link',
        styles: linkStyles,
        attributes: link.external
            ? {'target': '_blank', 'rel': 'noopener noreferrer'}
            : null,
        [text(link.label)],
      );
    }

    return button(
      classes: 'arcane-footer-link',
      attributes: {'type': 'button'},
      styles: Styles(raw: {
        'font-size': '0.875rem',
        'color': 'var(--arcane-muted)',
        'text-decoration': 'none',
        'transition': 'color var(--arcane-transition-fast)',
        'background': 'none',
        'border': 'none',
        'padding': '0',
        'cursor': 'pointer',
      }),
      events: {'click': (e) => link.onTap?.call()},
      [text(link.label)],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-footer-link:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
    }),
  ];
}

/// Social icon link component
class SocialIcon extends StatelessComponent {
  /// Icon component or text
  final Component icon;

  /// Link URL
  final String? href;

  /// Click handler
  final void Function()? onTap;

  /// Aria label for accessibility
  final String label;

  const SocialIcon({
    required this.icon,
    required this.label,
    this.href,
    this.onTap,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final iconStyles = Styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'width': '36px',
      'height': '36px',
      'border-radius': 'var(--arcane-radius)',
      'color': 'var(--arcane-muted)',
      'background': 'none',
      'border': 'none',
      'cursor': 'pointer',
      'transition': 'var(--arcane-transition-fast)',
    });

    if (href != null) {
      return a(
        href: href!,
        classes: 'arcane-social-icon',
        styles: iconStyles,
        attributes: {
          'aria-label': label,
          'target': '_blank',
          'rel': 'noopener noreferrer',
        },
        [icon],
      );
    }

    return button(
      classes: 'arcane-social-icon',
      attributes: {
        'type': 'button',
        'aria-label': label,
      },
      styles: iconStyles,
      events: {'click': (e) => onTap?.call()},
      [icon],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-social-icon:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}
