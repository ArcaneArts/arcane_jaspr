import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Social media platforms
enum SocialPlatform {
  twitter,
  github,
  discord,
  youtube,
  linkedin,
  instagram,
  facebook,
  twitch,
  reddit,
  tiktok,
}

/// Social media icon link
class ArcaneSocialIcon extends StatelessComponent {
  /// Platform to display
  final SocialPlatform platform;

  /// Link URL (optional)
  final String? url;

  /// Icon size
  final String size;

  /// Custom color
  final String? color;

  /// Whether to show background
  final bool showBackground;

  const ArcaneSocialIcon({
    required this.platform,
    this.url,
    this.size = '24px',
    this.color,
    this.showBackground = true,
    super.key,
  });

  /// Named constructor for Twitter/X
  const ArcaneSocialIcon.twitter({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.twitter;

  /// Named constructor for GitHub
  const ArcaneSocialIcon.github({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.github;

  /// Named constructor for Discord
  const ArcaneSocialIcon.discord({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.discord;

  /// Named constructor for YouTube
  const ArcaneSocialIcon.youtube({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.youtube;

  /// Named constructor for LinkedIn
  const ArcaneSocialIcon.linkedin({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.linkedin;

  String get _icon {
    return switch (platform) {
      SocialPlatform.twitter => '𝕏',
      SocialPlatform.github => '⌘',
      SocialPlatform.discord => '💬',
      SocialPlatform.youtube => '▶',
      SocialPlatform.linkedin => 'in',
      SocialPlatform.instagram => '📷',
      SocialPlatform.facebook => 'f',
      SocialPlatform.twitch => '📺',
      SocialPlatform.reddit => 'r/',
      SocialPlatform.tiktok => '♪',
    };
  }

  @override
  Component build(BuildContext context) {
    final String iconColor = color ?? ArcaneColors.muted;

    final Component content = div(
      classes: 'arcane-social-icon',
      styles: Styles(raw: {
        'width': size,
        'height': size,
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'border-radius': ArcaneRadius.md,
        if (showBackground) 'background': ArcaneColors.surfaceVariant,
        'color': iconColor,
        'font-size': 'calc($size * 0.5)',
        'font-weight': ArcaneTypography.weightSemibold,
        'transition': ArcaneEffects.transitionFast,
        'cursor': 'pointer',
      }),
      [text(_icon)],
    );

    if (url != null) {
      return a(
        href: url!,
        attributes: {'target': '_blank', 'rel': 'noopener noreferrer'},
        styles: const Styles(raw: {'text-decoration': 'none'}),
        [content],
      );
    } else {
      return content;
    }
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-social-icon:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
      'background': ArcaneColors.accent,
    }),
  ];
}

/// Group of social icons
class ArcaneSocialIconGroup extends StatelessComponent {
  /// Icons to display
  final List<ArcaneSocialIcon> icons;

  /// Gap between icons
  final String gap;

  const ArcaneSocialIconGroup({
    required this.icons,
    this.gap = '12px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-social-icon-group',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': gap,
      }),
      icons,
    );
  }
}

/// Social links component with labels
class ArcaneSocialLinks extends StatelessComponent {
  /// Social link items
  final List<ArcaneSocialLinkItem> links;

  /// Orientation (horizontal or vertical)
  final bool vertical;

  /// Gap between items
  final String gap;

  const ArcaneSocialLinks({
    required this.links,
    this.vertical = false,
    this.gap = '16px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-social-links',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': vertical ? 'column' : 'row',
        'align-items': vertical ? 'flex-start' : 'center',
        'gap': gap,
        'flex-wrap': 'wrap',
      }),
      [
        for (final link in links)
          a(
            href: link.url,
            attributes: {'target': '_blank', 'rel': 'noopener noreferrer'},
            classes: 'arcane-social-link',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.sm,
              'text-decoration': 'none',
              'color': ArcaneColors.muted,
              'font-size': ArcaneTypography.fontSm,
              'transition': ArcaneEffects.transitionFast,
            }),
            [
              ArcaneSocialIcon(
                platform: link.platform,
                size: '20px',
                showBackground: false,
              ),
              if (link.label != null)
                span([text(link.label!)]),
            ],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-social-link:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
    }),
  ];
}

/// A social link item
class ArcaneSocialLinkItem {
  /// Platform
  final SocialPlatform platform;

  /// URL
  final String url;

  /// Optional label
  final String? label;

  const ArcaneSocialLinkItem({
    required this.platform,
    required this.url,
    this.label,
  });
}