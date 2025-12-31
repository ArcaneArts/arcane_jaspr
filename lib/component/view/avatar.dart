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

/// Direction for avatar group stacking
enum AvatarGroupDirection {
  /// Stack avatars to the left (each overlaps the previous from the right)
  toLeft,

  /// Stack avatars to the right (each overlaps the previous from the left)
  toRight,

  /// Stack avatars upward (each overlaps the previous from below)
  toTop,

  /// Stack avatars downward (each overlaps the previous from above)
  toBottom,
}

/// Avatar group for stacking multiple avatars with overlap.
///
/// ```dart
/// ArcaneAvatarGroup.toLeft(
///   avatars: [
///     ArcaneAvatar(initials: 'AB'),
///     ArcaneAvatar(initials: 'CD'),
///     ArcaneAvatar(initials: 'EF'),
///   ],
/// )
/// ```
class ArcaneAvatarGroup extends StatelessComponent {
  final List<ArcaneAvatar> avatars;
  final int maxVisible;
  final AvatarSize size;
  final AvatarGroupDirection direction;

  /// Amount of overlap in pixels
  final int overlap;

  const ArcaneAvatarGroup({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.direction = AvatarGroupDirection.toRight,
    this.overlap = 12,
    super.key,
  });

  /// Stack avatars to the left
  const ArcaneAvatarGroup.toLeft({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.overlap = 12,
    super.key,
  }) : direction = AvatarGroupDirection.toLeft;

  /// Stack avatars to the right
  const ArcaneAvatarGroup.toRight({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.overlap = 12,
    super.key,
  }) : direction = AvatarGroupDirection.toRight;

  /// Stack avatars upward
  const ArcaneAvatarGroup.toTop({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.overlap = 12,
    super.key,
  }) : direction = AvatarGroupDirection.toTop;

  /// Stack avatars downward
  const ArcaneAvatarGroup.toBottom({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.overlap = 12,
    super.key,
  }) : direction = AvatarGroupDirection.toBottom;

  bool get _isHorizontal =>
      direction == AvatarGroupDirection.toLeft ||
      direction == AvatarGroupDirection.toRight;

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

    // Determine margin property based on direction
    final (marginProp, zIndexFn) = switch (direction) {
      AvatarGroupDirection.toLeft => ('margin-right', (int i, int len) => i),
      AvatarGroupDirection.toRight => ('margin-left', (int i, int len) => len - i),
      AvatarGroupDirection.toTop => ('margin-bottom', (int i, int len) => i),
      AvatarGroupDirection.toBottom => ('margin-top', (int i, int len) => len - i),
    };

    return div(
      classes: 'arcane-avatar-group arcane-avatar-group-${direction.name}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        if (!_isHorizontal) 'flex-direction': 'column',
      }),
      [
        for (var i = 0; i < visible.length; i++)
          div(
            styles: Styles(raw: {
              marginProp: i > 0 ? '-${overlap}px' : '0',
              'position': 'relative',
              'z-index': '${zIndexFn(i, visible.length)}',
            }),
            [visible[i]],
          ),
        if (overflow > 0)
          div(
            classes: 'arcane-avatar-overflow',
            styles: Styles(raw: {
              marginProp: '-${overlap}px',
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

/// Badge displayed on an avatar (e.g., online status, notification count)
///
/// ```dart
/// ArcaneAvatar(
///   initials: 'JD',
///   badge: ArcaneAvatarBadge.online(),
/// )
/// ```
class ArcaneAvatarBadge extends StatelessComponent {
  /// Badge size in pixels
  final int size;

  /// Badge color
  final String color;

  /// Optional content (e.g., count)
  final String? content;

  /// Badge position
  final AvatarBadgePosition position;

  /// Whether to pulse/animate
  final bool pulse;

  const ArcaneAvatarBadge({
    this.size = 12,
    required this.color,
    this.content,
    this.position = AvatarBadgePosition.bottomRight,
    this.pulse = false,
    super.key,
  });

  /// Online status badge (green)
  const ArcaneAvatarBadge.online({
    this.size = 12,
    this.position = AvatarBadgePosition.bottomRight,
    this.pulse = false,
    super.key,
  })  : color = ArcaneColors.success,
        content = null;

  /// Offline status badge (gray)
  const ArcaneAvatarBadge.offline({
    this.size = 12,
    this.position = AvatarBadgePosition.bottomRight,
    super.key,
  })  : color = ArcaneColors.muted,
        content = null,
        pulse = false;

  /// Busy status badge (red)
  const ArcaneAvatarBadge.busy({
    this.size = 12,
    this.position = AvatarBadgePosition.bottomRight,
    super.key,
  })  : color = ArcaneColors.error,
        content = null,
        pulse = false;

  /// Away status badge (yellow)
  const ArcaneAvatarBadge.away({
    this.size = 12,
    this.position = AvatarBadgePosition.bottomRight,
    super.key,
  })  : color = ArcaneColors.warning,
        content = null,
        pulse = false;

  /// Notification count badge
  const ArcaneAvatarBadge.count(
    int count, {
    this.size = 18,
    this.position = AvatarBadgePosition.topRight,
    super.key,
  })  : color = ArcaneColors.error,
        content = '$count',
        pulse = false;

  Map<String, String> get _positionStyles => switch (position) {
        AvatarBadgePosition.topLeft => {'top': '-2px', 'left': '-2px'},
        AvatarBadgePosition.topRight => {'top': '-2px', 'right': '-2px'},
        AvatarBadgePosition.bottomLeft => {'bottom': '-2px', 'left': '-2px'},
        AvatarBadgePosition.bottomRight => {
            'bottom': '-2px',
            'right': '-2px'
          },
      };

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-avatar-badge ${pulse ? 'pulse' : ''}',
      styles: Styles(raw: {
        'position': 'absolute',
        ..._positionStyles,
        'min-width': '${size}px',
        'height': '${size}px',
        'border-radius': ArcaneRadius.full,
        'background': color,
        'border': '2px solid ${ArcaneColors.background}',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        if (content != null) ...{
          'padding': '0 4px',
          'font-size': '${size - 6}px',
          'font-weight': ArcaneTypography.weightBold,
          'color': ArcaneColors.errorForeground,
        },
      }),
      [
        if (content != null) text(content!),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-avatar-badge.pulse').styles(raw: {
      'animation': 'arcane-avatar-pulse 2s infinite',
    }),
    css('@keyframes arcane-avatar-pulse').styles(raw: {
      '0%, 100%': 'opacity: 1',
      '50%': 'opacity: 0.5',
    }),
  ];
}

/// Position for avatar badge
enum AvatarBadgePosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}