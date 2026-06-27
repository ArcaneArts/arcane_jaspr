import 'package:arcane_jaspr/flutter.dart';

/// Size variants for the selector.
enum SelectorSize {
  sm,
  md,
  lg,
}

/// Direction for dropdown to open.
enum DropdownDirection {
  down,
  up,
  auto,
}

/// An option for ArcaneSelector.
class ArcaneSelectorOption<T> {
  final T value;
  final String label;
  final String? subtitle;
  final String? description;
  final Widget? icon;
  final bool disabled;
  final String? group;
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

/// A group header for organizing options.
class ArcaneSelectorGroup<T> {
  final String label;
  final List<ArcaneSelectorOption<T>> options;
  final Widget? icon;

  const ArcaneSelectorGroup({
    required this.label,
    required this.options,
    this.icon,
  });
}
