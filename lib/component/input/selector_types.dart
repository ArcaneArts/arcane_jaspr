import 'package:jaspr/jaspr.dart';

/// Size variants for the selector
enum SelectorSize {
  /// Small selector - compact height
  sm,

  /// Medium selector - default size
  md,

  /// Large selector - more padding
  lg,
}

/// Direction for dropdown to open
enum DropdownDirection {
  /// Opens downward (default)
  down,

  /// Opens upward
  up,

  /// Auto-detect based on viewport position
  auto,
}

/// An option for ArcaneSelector
class ArcaneSelectorOption<T> {
  /// The value of this option
  final T value;

  /// The display label
  final String label;

  /// Optional subtitle displayed below the label
  final String? subtitle;

  /// Optional description displayed on the right
  final String? description;

  /// Optional icon displayed before the label
  final Component? icon;

  /// Whether this option is disabled
  final bool disabled;

  /// Optional group this option belongs to
  final String? group;

  /// Additional keywords for search filtering
  final List<String>? searchKeywords;

  const ArcaneSelectorOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.description,
    this.icon,
    this.disabled = false,
    this.group,
    this.searchKeywords,
  });
}

/// A group header for organizing options
class ArcaneSelectorGroup<T> {
  /// The group label
  final String label;

  /// Options in this group
  final List<ArcaneSelectorOption<T>> options;

  /// Optional icon for the group
  final Component? icon;

  const ArcaneSelectorGroup({
    required this.label,
    required this.options,
    this.icon,
  });
}
