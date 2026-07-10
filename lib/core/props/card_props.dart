import 'package:arcane_jaspr/flutter.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

enum CardVariant {
  elevated,
  flat,
  outlined,
  ghost,
  glass,
  interactive,
}

/// Card component properties.
class CardProps {
  final Widget? child;
  final List<Widget>? children;
  final CardVariant variant;
  final String? padding;
  final String? borderRadius;
  final String? backgroundColor;
  final bool fillWidth;
  final void Function()? onTap;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const CardProps({
    this.child,
    this.children,
    this.variant = CardVariant.elevated,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.fillWidth = false,
    this.onTap,
    this.styles,
    this.decoration,
  }) : assert(child != null || children != null,
            'Either child or children must be provided');

  CardProps copyWith({
    Widget? child,
    List<Widget>? children,
    CardVariant? variant,
    String? padding,
    String? borderRadius,
    String? backgroundColor,
    bool? fillWidth,
    void Function()? onTap,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return CardProps(
      child: child ?? this.child,
      children: children ?? this.children,
      variant: variant ?? this.variant,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fillWidth: fillWidth ?? this.fillWidth,
      onTap: onTap ?? this.onTap,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for card components.
mixin CardRendererContract {
  /// Renders a card container component.
  Widget card(CardProps props);
}
