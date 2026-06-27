import 'package:arcane_jaspr/flutter.dart';

/// Radio card item data.
class RadioCardItemData<T> {
  final T value;
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final Widget? child;
  final bool disabled;

  const RadioCardItemData({
    required this.value,
    this.title,
    this.subtitle,
    this.icon,
    this.child,
    this.disabled = false,
  });
}

/// Radio cards component properties.
class RadioCardsProps<T> {
  final List<RadioCardItemData<T>> items;
  final T? value;
  final void Function(T value)? onChanged;
  final double gap;
  final bool wrap;
  final double? cardWidth;

  const RadioCardsProps({
    required this.items,
    this.value,
    this.onChanged,
    this.gap = 12,
    this.wrap = true,
    this.cardWidth,
  });
}

/// Selectable chip group component properties.
class SelectableChipGroupProps {
  final List<Widget> children;
  final double gap;
  final bool wrap;

  const SelectableChipGroupProps({
    required this.children,
    this.gap = 8,
    this.wrap = true,
  });
}

/// Selectable chip component properties.
class ArcaneChipProps {
  final String label;
  final Widget? avatar;
  final Widget? deleteIcon;
  final void Function()? onDeleted;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;

  const ArcaneChipProps({
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onTap,
    this.selected = false,
    this.disabled = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for radio cards components.
mixin RadioCardsRendererContract {
  Widget radioCards<T>(RadioCardsProps<T> props);
  Widget selectableChipGroup(SelectableChipGroupProps props);
  Widget arcaneChip(ArcaneChipProps props);
}
