import 'package:arcane_jaspr/flutter.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

enum EmptyStateStyleVariant {
  centered,
  compact,
  card,
}

enum EmptyStateSizeVariant {
  sm,
  md,
  lg,
}

/// Empty state component properties.
class EmptyStateProps {
  final Widget? icon;
  final String title;
  final String? description;
  final Widget? action;
  final Widget? secondaryAction;
  final EmptyStateStyleVariant variant;
  final EmptyStateSizeVariant size;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const EmptyStateProps({
    required this.title,
    this.icon,
    this.description,
    this.action,
    this.secondaryAction,
    this.variant = EmptyStateStyleVariant.centered,
    this.size = EmptyStateSizeVariant.md,
    this.styles,
    this.decoration,
  });

  EmptyStateProps copyWith({
    Widget? icon,
    String? title,
    String? description,
    Widget? action,
    Widget? secondaryAction,
    EmptyStateStyleVariant? variant,
    EmptyStateSizeVariant? size,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return EmptyStateProps(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      action: action ?? this.action,
      secondaryAction: secondaryAction ?? this.secondaryAction,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for empty state components.
mixin EmptyStateRendererContract {
  /// Renders an empty state placeholder component.
  Widget emptyState(EmptyStateProps props);
}
