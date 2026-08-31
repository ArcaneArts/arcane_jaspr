import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart'
    hide
        BuildContext,
        InheritedComponent,
        Key,
        State,
        StatefulComponent,
        StatelessComponent,
        UniqueKey,
        ValueKey,
        runApp;
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../core/theme_provider.dart';
import '../../core/decoration/arcane_decoration.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/avatar_props.dart' show AvatarSize, AvatarShape;

/// Avatar component for displaying user images or initials.
class ArcaneAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final AvatarSize size;
  final AvatarShape shape;
  final String? borderColor;
  final bool showStatus;
  final String? statusColor;
  final void Function()? onTap;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneAvatar({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.shape = AvatarShape.circle,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
    this.styles,
    this.decoration,
    super.key,
  });

  const ArcaneAvatar.circle({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
    this.styles,
    this.decoration,
    super.key,
  }) : shape = AvatarShape.circle;

  const ArcaneAvatar.rounded({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
    this.styles,
    this.decoration,
    super.key,
  }) : shape = AvatarShape.rounded;

  const ArcaneAvatar.square({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
    this.styles,
    this.decoration,
    super.key,
  }) : shape = AvatarShape.square;

  @override
  Widget build(BuildContext context) {
    return context.renderers.avatar(
      AvatarProps(
        imageUrl: imageUrl,
        initials: initials,
        size: size,
        shape: shape,
        borderColor: borderColor,
        showStatus: showStatus,
        statusColor: statusColor,
        onTap: onTap,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}

/// Direction for avatar group stacking.
enum AvatarGroupDirection { toLeft, toRight, toTop, toBottom }

/// Avatar group for stacking multiple avatars with overlap.
class ArcaneAvatarGroup extends StatelessWidget {
  final List<ArcaneAvatar> avatars;
  final int maxVisible;
  final AvatarSize size;
  final AvatarGroupDirection direction;
  final int overlap;

  const ArcaneAvatarGroup({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.direction = AvatarGroupDirection.toRight,
    this.overlap = 12,
    super.key,
  });

  const ArcaneAvatarGroup.toLeft({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.overlap = 12,
    super.key,
  }) : direction = AvatarGroupDirection.toLeft;

  const ArcaneAvatarGroup.toRight({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.overlap = 12,
    super.key,
  }) : direction = AvatarGroupDirection.toRight;

  const ArcaneAvatarGroup.toTop({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    this.overlap = 12,
    super.key,
  }) : direction = AvatarGroupDirection.toTop;

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
  Widget build(BuildContext context) {
    final visible = avatars.take(maxVisible).toList();
    final overflow = avatars.length - maxVisible;

    final dimension = switch (size) {
      AvatarSize.xs => '24px',
      AvatarSize.sm => '32px',
      AvatarSize.md => '48px',
      AvatarSize.lg => '64px',
      AvatarSize.xl => '96px',
    };

    final (marginProp, zIndexFn) = switch (direction) {
      AvatarGroupDirection.toLeft => ('margin-right', (int i, int len) => i),
      AvatarGroupDirection.toRight => (
        'margin-left',
        (int i, int len) => len - i,
      ),
      AvatarGroupDirection.toTop => ('margin-bottom', (int i, int len) => i),
      AvatarGroupDirection.toBottom => (
        'margin-top',
        (int i, int len) => len - i,
      ),
    };

    return div(
      classes: 'arcane-avatar-group arcane-avatar-group-${direction.name}',
      styles: Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          if (!_isHorizontal) 'flex-direction': 'column',
        },
      ),
      [
        for (var i = 0; i < visible.length; i++)
          div(
            styles: Styles(
              raw: {
                marginProp: i > 0 ? '-${overlap}px' : '0',
                'position': 'relative',
                'z-index': '${zIndexFn(i, visible.length)}',
              },
            ),
            [visible[i]],
          ),
        if (overflow > 0)
          div(
            classes: 'arcane-avatar-overflow',
            attributes: const <String, String>{
              'data-arcane-intrinsic-shape': 'avatar',
            },
            styles: Styles(
              raw: {
                marginProp: '-${overlap}px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': dimension,
                'height': dimension,
                'border-radius': '50%',
                'background': 'var(--muted)',
                'border': '2px solid var(--background)',
                'color': 'var(--muted-foreground)',
                'font-size': '0.875rem',
                'font-weight': '500',
              },
            ),
            [Component.text('+$overflow')],
          ),
      ],
    );
  }
}

/// Position for avatar badge.
enum AvatarBadgePosition { topLeft, topRight, bottomLeft, bottomRight }

/// Badge displayed on an avatar.
class ArcaneAvatarBadge extends StatelessWidget {
  final int size;
  final String color;
  final String? content;
  final AvatarBadgePosition position;
  final bool pulse;

  const ArcaneAvatarBadge({
    this.size = 12,
    required this.color,
    this.content,
    this.position = AvatarBadgePosition.bottomRight,
    this.pulse = false,
    super.key,
  });

  const ArcaneAvatarBadge.online({
    this.size = 12,
    this.position = AvatarBadgePosition.bottomRight,
    this.pulse = false,
    super.key,
  }) : color = 'var(--success, #22c55e)',
       content = null;

  const ArcaneAvatarBadge.offline({
    this.size = 12,
    this.position = AvatarBadgePosition.bottomRight,
    super.key,
  }) : color = 'var(--muted-foreground)',
       content = null,
       pulse = false;

  const ArcaneAvatarBadge.busy({
    this.size = 12,
    this.position = AvatarBadgePosition.bottomRight,
    super.key,
  }) : color = 'var(--destructive)',
       content = null,
       pulse = false;

  const ArcaneAvatarBadge.away({
    this.size = 12,
    this.position = AvatarBadgePosition.bottomRight,
    super.key,
  }) : color = 'var(--warning, #f59e0b)',
       content = null,
       pulse = false;

  const ArcaneAvatarBadge.count(
    int count, {
    this.size = 18,
    this.position = AvatarBadgePosition.topRight,
    super.key,
  }) : color = 'var(--destructive)',
       content = '$count',
       pulse = false;

  Map<String, String> get _positionStyles => switch (position) {
    AvatarBadgePosition.topLeft => {'top': '-2px', 'left': '-2px'},
    AvatarBadgePosition.topRight => {'top': '-2px', 'right': '-2px'},
    AvatarBadgePosition.bottomLeft => {'bottom': '-2px', 'left': '-2px'},
    AvatarBadgePosition.bottomRight => {'bottom': '-2px', 'right': '-2px'},
  };

  @override
  Widget build(BuildContext context) {
    return div(
      classes: 'arcane-avatar-badge ${pulse ? 'pulse' : ''}',
      styles: Styles(
        raw: {
          'position': 'absolute',
          ..._positionStyles,
          'min-width': '${size}px',
          'height': '${size}px',
          'border-radius': 'var(--radius-xs)',
          'background': color,
          'border': '2px solid var(--background)',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          if (content != null) ...{
            'padding': '0 4px',
            'font-size': '${size - 6}px',
            'font-weight': '700',
            'color': 'var(--destructive-foreground, #fff)',
          },
        },
      ),
      [if (content != null) Component.text(content!)],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css(
      '.arcane-avatar-badge.pulse',
    ).styles(raw: {'animation': 'arcane-avatar-pulse 2s infinite'}),
    css(
      '@keyframes arcane-avatar-pulse',
    ).styles(raw: {'0%, 100%': 'opacity: 1', '50%': 'opacity: 0.5'}),
  ];
}
