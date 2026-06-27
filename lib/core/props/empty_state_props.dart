import 'package:arcane_jaspr/flutter.dart';

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
  final EmptyStateStyleVariant style;
  final EmptyStateSizeVariant size;

  const EmptyStateProps({
    required this.title,
    this.icon,
    this.description,
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyleVariant.centered,
    this.size = EmptyStateSizeVariant.md,
  });

  EmptyStateProps copyWith({
    Widget? icon,
    String? title,
    String? description,
    Widget? action,
    Widget? secondaryAction,
    EmptyStateStyleVariant? style,
    EmptyStateSizeVariant? size,
  }) {
    return EmptyStateProps(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      action: action ?? this.action,
      secondaryAction: secondaryAction ?? this.secondaryAction,
      style: style ?? this.style,
      size: size ?? this.size,
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
