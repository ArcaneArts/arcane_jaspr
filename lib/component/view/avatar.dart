import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Avatar size presets
enum AvatarSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

/// Avatar component for displaying user images or initials
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneAvatar(
///   initials: 'JD',
///   style: AvatarStyle.circle,
///   size: AvatarSize.lg,
/// )
/// ```
class ArcaneAvatar extends StatelessComponent {
  final String? imageUrl;
  final String? initials;
  final AvatarSize size;
  final AvatarStyle? style;
  final String? borderColor;
  final bool showStatus;
  final String? statusColor;
  final void Function()? onTap;

  const ArcaneAvatar({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.style,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
    super.key,
  });

  /// Circle avatar (default)
  const ArcaneAvatar.circle({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
    super.key,
  }) : style = AvatarStyle.circle;

  /// Rounded square avatar
  const ArcaneAvatar.rounded({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
    super.key,
  }) : style = AvatarStyle.rounded;

  /// Square avatar
  const ArcaneAvatar.square({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
    super.key,
  }) : style = AvatarStyle.square;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? AvatarStyle.circle;

    final (dimension, fontSize, statusSize) = switch (size) {
      AvatarSize.xs => ('24px', ArcaneTypography.fontXs, '8px'),
      AvatarSize.sm => ('32px', ArcaneTypography.fontSm, '10px'),
      AvatarSize.md => ('48px', ArcaneTypography.fontReg, '12px'),
      AvatarSize.lg => ('64px', ArcaneTypography.fontXl, '14px'),
      AvatarSize.xl => ('96px', ArcaneTypography.font2xl, '18px'),
    };

    return div(
      classes: 'arcane-avatar',
      styles: Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': dimension,
        'height': dimension,
        ...effectiveStyle.styles,
        'background': imageUrl != null
            ? 'url($imageUrl) center/cover no-repeat'
            : 'linear-gradient(135deg, ${ArcaneColors.accent} 0%, ${ArcaneColors.accentHover} 100%)',
        if (borderColor != null) 'border': '2px solid $borderColor',
        'color': ArcaneColors.accentForeground,
        'font-weight': ArcaneTypography.weightSemibold,
        'font-size': fontSize,
        'flex-shrink': '0',
        if (onTap != null) 'cursor': 'pointer',
      }),
      events: onTap != null
          ? {
              'click': (event) => onTap!(),
            }
          : null,
      [
        if (imageUrl == null && initials != null) text(initials!),
        if (showStatus)
          div(
            classes: 'arcane-avatar-status',
            styles: Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'right': '0',
              'width': statusSize,
              'height': statusSize,
              'border-radius': ArcaneRadius.full,
              'background': statusColor ?? ArcaneColors.success,
              'border': '2px solid ${ArcaneColors.background}',
            }),
            [],
          ),
      ],
    );
  }
}

/// Avatar group for stacking multiple avatars
class AvatarGroup extends StatelessComponent {
  final List<ArcaneAvatar> avatars;
  final int maxVisible;
  final AvatarSize size;

  const AvatarGroup({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final visible = avatars.take(maxVisible).toList();
    final overflow = avatars.length - maxVisible;

    final dimension = switch (size) {
      AvatarSize.xs => '24px',
      AvatarSize.sm => '32px',
      AvatarSize.md => '48px',
      AvatarSize.lg => '64px',
      AvatarSize.xl => '96px',
    };

    return div(
      classes: 'arcane-avatar-group',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
      }),
      [
        for (var i = 0; i < visible.length; i++)
          div(
            styles: Styles(raw: {
              'margin-left': i > 0 ? '-12px' : '0',
              'position': 'relative',
              'z-index': '${visible.length - i}',
            }),
            [visible[i]],
          ),
        if (overflow > 0)
          div(
            classes: 'arcane-avatar-overflow',
            styles: Styles(raw: {
              'margin-left': '-12px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': dimension,
              'height': dimension,
              'border-radius': ArcaneRadius.full,
              'background': ArcaneColors.surfaceVariant,
              'border': '2px solid ${ArcaneColors.background}',
              'color': ArcaneColors.muted,
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
            }),
            [text('+$overflow')],
          ),
      ],
    );
  }
}
