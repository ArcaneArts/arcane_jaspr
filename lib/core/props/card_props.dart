import 'package:arcane_jaspr/flutter.dart';

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

  const CardProps({
    this.child,
    this.children,
    this.variant = CardVariant.elevated,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.fillWidth = false,
    this.onTap,
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
