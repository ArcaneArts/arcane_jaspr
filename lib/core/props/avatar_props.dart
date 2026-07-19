import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

/// Avatar size with extended range for flexibility.
enum AvatarSize {
  xs,
  sm,
  md,
  lg,
  xl;

  static const AvatarSize extraSmall = xs;
  static const AvatarSize small = sm;
  static const AvatarSize medium = md;
  static const AvatarSize large = lg;
  static const AvatarSize extraLarge = xl;
}

enum AvatarShape {
  circle,
  rounded,
  square,
}

/// Avatar component properties.
class AvatarProps {
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

  const AvatarProps({
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
  });

  AvatarProps copyWith({
    String? imageUrl,
    String? initials,
    AvatarSize? size,
    AvatarShape? shape,
    String? borderColor,
    bool? showStatus,
    String? statusColor,
    void Function()? onTap,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return AvatarProps(
      imageUrl: imageUrl ?? this.imageUrl,
      initials: initials ?? this.initials,
      size: size ?? this.size,
      shape: shape ?? this.shape,
      borderColor: borderColor ?? this.borderColor,
      showStatus: showStatus ?? this.showStatus,
      statusColor: statusColor ?? this.statusColor,
      onTap: onTap ?? this.onTap,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for avatar components.
mixin AvatarRendererContract {
  /// Renders an avatar component.
  Component avatar(AvatarProps props);
}
