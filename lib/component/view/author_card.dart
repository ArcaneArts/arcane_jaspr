import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Size variants for author card
enum AuthorCardSize {
  /// Small: 32px avatar
  sm,

  /// Medium: 40px avatar (default)
  md,

  /// Large: 48px avatar
  lg,
}

/// An author attribution card with avatar, name, and role.
///
/// Common for testimonials, blog posts, comments, and user profiles.
///
/// ```dart
/// ArcaneAuthorCard(
///   avatarUrl: 'https://example.com/avatar.jpg',
///   name: 'John Doe',
///   role: 'Software Engineer',
/// )
/// ```
class ArcaneAuthorCard extends StatelessComponent {
  /// Avatar image URL
  final String? avatarUrl;

  /// Author name
  final String name;

  /// Role/title/subtitle
  final String? role;

  /// Size variant
  final AuthorCardSize size;

  /// Fallback initials when no avatar (uses first letter of name if not provided)
  final String? initials;

  /// Avatar background color for initials fallback
  final String? avatarBackground;

  /// Name text color
  final String? nameColor;

  /// Role text color
  final String? roleColor;

  const ArcaneAuthorCard({
    this.avatarUrl,
    required this.name,
    this.role,
    this.size = AuthorCardSize.md,
    this.initials,
    this.avatarBackground,
    this.nameColor,
    this.roleColor,
    super.key,
  });

  /// Create a small author card
  const ArcaneAuthorCard.sm({
    this.avatarUrl,
    required this.name,
    this.role,
    this.initials,
    this.avatarBackground,
    this.nameColor,
    this.roleColor,
    super.key,
  }) : size = AuthorCardSize.sm;

  /// Create a large author card
  const ArcaneAuthorCard.lg({
    this.avatarUrl,
    required this.name,
    this.role,
    this.initials,
    this.avatarBackground,
    this.nameColor,
    this.roleColor,
    super.key,
  }) : size = AuthorCardSize.lg;

  @override
  Component build(BuildContext context) {
    final avatarSize = _getAvatarSize();
    final nameFontSize = _getNameFontSize();
    final roleFontSize = _getRoleFontSize();
    final effectiveNameColor = nameColor ?? ArcaneColors.onBackground;
    final effectiveRoleColor = roleColor ?? ArcaneColors.muted;
    final effectiveInitials = initials ?? (name.isNotEmpty ? name[0].toUpperCase() : '?');
    final effectiveAvatarBg = avatarBackground ?? ArcaneColors.accent;

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.md,
      }),
      [
        // Avatar
        div(
          styles: Styles(raw: {
            'width': avatarSize,
            'height': avatarSize,
            'border-radius': '50%',
            'overflow': 'hidden',
            'flex-shrink': '0',
            if (avatarUrl == null) 'background': effectiveAvatarBg,
            if (avatarUrl == null) 'display': 'flex',
            if (avatarUrl == null) 'align-items': 'center',
            if (avatarUrl == null) 'justify-content': 'center',
          }),
          [
            if (avatarUrl != null)
              img(
                src: avatarUrl!,
                alt: name,
                styles: const Styles(raw: {
                  'width': '100%',
                  'height': '100%',
                  'object-fit': 'cover',
                }),
              )
            else
              span(
                styles: Styles(raw: {
                  'font-size': _getInitialsFontSize(),
                  'font-weight': '600',
                  'color': ArcaneColors.accentForeground,
                }),
                [text(effectiveInitials)],
              ),
          ],
        ),
        // Name and role
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
          }),
          [
            div(
              styles: Styles(raw: {
                'font-size': nameFontSize,
                'font-weight': '600',
                'color': effectiveNameColor,
              }),
              [text(name)],
            ),
            if (role != null)
              div(
                styles: Styles(raw: {
                  'font-size': roleFontSize,
                  'color': effectiveRoleColor,
                }),
                [text(role!)],
              ),
          ],
        ),
      ],
    );
  }

  String _getAvatarSize() {
    switch (size) {
      case AuthorCardSize.sm:
        return '32px';
      case AuthorCardSize.md:
        return '40px';
      case AuthorCardSize.lg:
        return '48px';
    }
  }

  String _getNameFontSize() {
    switch (size) {
      case AuthorCardSize.sm:
        return ArcaneTypography.fontSizeXs;
      case AuthorCardSize.md:
        return ArcaneTypography.fontSizeSm;
      case AuthorCardSize.lg:
        return ArcaneTypography.fontSizeBase;
    }
  }

  String _getRoleFontSize() {
    switch (size) {
      case AuthorCardSize.sm:
        return ArcaneTypography.fontSizeXs;
      case AuthorCardSize.md:
        return ArcaneTypography.fontSizeXs;
      case AuthorCardSize.lg:
        return ArcaneTypography.fontSizeSm;
    }
  }

  String _getInitialsFontSize() {
    switch (size) {
      case AuthorCardSize.sm:
        return ArcaneTypography.fontSizeXs;
      case AuthorCardSize.md:
        return ArcaneTypography.fontSizeSm;
      case AuthorCardSize.lg:
        return ArcaneTypography.fontSizeBase;
    }
  }
}