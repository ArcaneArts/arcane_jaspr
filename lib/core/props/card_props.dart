import 'package:arcane_jaspr/flutter.dart';

import '../../util/arcane.dart';
import '../../util/style_types/arcane_style_data.dart';
import '../../util/style_types/borders.dart';
import '../decoration/arcane_decoration.dart';

enum CardVariant { elevated, flat, outlined, ghost, interactive }

/// Card component properties.
class CardProps {
  final Widget? child;
  final List<Widget>? children;
  final CardVariant variant;
  final EdgeInsets? padding;
  final Radius? borderRadius;
  final String? backgroundColor;
  final bool fillWidth;

  /// Callback semantics for a native button card. Mutually exclusive with
  /// [href].
  final void Function()? onTap;

  /// Navigation semantics for a native anchor card. Mutually exclusive with
  /// [onTap].
  final String? href;

  /// Anchor browsing context, such as `_blank`.
  final String? target;

  /// Anchor relationship tokens. `_blank` links gain any missing `noopener`
  /// and `noreferrer` tokens during rendering.
  final String? rel;

  /// Additional classes appended after the theme and interaction classes.
  final String? classes;

  /// Additional non-structural attributes for the root element.
  final Map<String, String>? attributes;

  /// Optional accessible name for the root element.
  final String? ariaLabel;

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
    this.href,
    this.target,
    this.rel,
    this.classes,
    this.attributes,
    this.ariaLabel,
    this.styles,
    this.decoration,
  }) : assert(
         child != null || children != null,
         'Either child or children must be provided',
       ),
       assert(
         href == null || onTap == null,
         'CardProps href and onTap are mutually exclusive',
       );

  CardProps copyWith({
    Widget? child,
    List<Widget>? children,
    CardVariant? variant,
    EdgeInsets? padding,
    Radius? borderRadius,
    String? backgroundColor,
    bool? fillWidth,
    void Function()? onTap,
    String? href,
    bool clearInteraction = false,
    String? target,
    String? rel,
    String? classes,
    Map<String, String>? attributes,
    String? ariaLabel,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    assert(
      href == null || onTap == null,
      'CardProps.copyWith href and onTap are mutually exclusive',
    );
    assert(
      !clearInteraction || (href == null && onTap == null),
      'clearInteraction cannot be combined with href or onTap',
    );

    // Supplying either interaction mode intentionally replaces the other.
    // `clearInteraction` is the explicit nullable sentinel for returning a
    // card to its static div form.
    final String? nextHref = clearInteraction
        ? null
        : href ?? (onTap == null ? this.href : null);
    final void Function()? nextOnTap = clearInteraction || href != null
        ? null
        : onTap ?? this.onTap;

    return CardProps(
      child: child ?? this.child,
      children: children ?? this.children,
      variant: variant ?? this.variant,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fillWidth: fillWidth ?? this.fillWidth,
      onTap: nextOnTap,
      href: nextHref,
      target: target ?? this.target,
      rel: rel ?? this.rel,
      classes: classes ?? this.classes,
      attributes: attributes ?? this.attributes,
      ariaLabel: ariaLabel ?? this.ariaLabel,
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
