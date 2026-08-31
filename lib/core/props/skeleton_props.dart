import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

enum SkeletonShape { rectangle, circle, text }

/// Skeleton component properties.
class SkeletonProps {
  final String? width;
  final String? height;
  final SkeletonShape shape;
  final bool animate;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const SkeletonProps({
    this.width,
    this.height,
    this.shape = SkeletonShape.rectangle,
    this.animate = true,
    this.styles,
    this.decoration,
  });

  SkeletonProps copyWith({
    String? width,
    String? height,
    SkeletonShape? shape,
    bool? animate,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return SkeletonProps(
      width: width ?? this.width,
      height: height ?? this.height,
      shape: shape ?? this.shape,
      animate: animate ?? this.animate,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for skeleton components.
mixin SkeletonRendererContract {
  /// Renders a skeleton loading placeholder component.
  Component skeleton(SkeletonProps props);
}
