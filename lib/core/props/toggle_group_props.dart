import 'package:arcane_jaspr/flutter.dart';

import '../interaction/interaction.dart';

enum ToggleGroupVariantStyle {
  defaultVariant,
  outline,
}

enum ToggleGroupSizeVariant {
  sm,
  md,
  lg,
}

enum ToggleGroupSelectionType {
  single,
  multiple,
}

/// Toggle group item data.
class ToggleGroupItemProps {
  final String value;
  final Widget child;
  final bool disabled;

  const ToggleGroupItemProps({
    required this.value,
    required this.child,
    this.disabled = false,
  });
}

/// Toggle group component properties.
class ToggleGroupProps {
  final String? id;
  final List<ToggleGroupItemProps> items;
  final String? value;
  final Set<String>? values;
  final ToggleGroupSelectionType type;
  final ToggleGroupVariantStyle variant;
  final ToggleGroupSizeVariant size;
  final bool disabled;
  final void Function(String?)? onChanged;
  final void Function(Set<String>)? onMultiChanged;
  final ArcaneInteraction? onChangeAction;

  const ToggleGroupProps({
    this.id,
    required this.items,
    this.value,
    this.values,
    this.type = ToggleGroupSelectionType.single,
    this.variant = ToggleGroupVariantStyle.defaultVariant,
    this.size = ToggleGroupSizeVariant.md,
    this.disabled = false,
    this.onChanged,
    this.onMultiChanged,
    this.onChangeAction,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for toggle group components.
mixin ToggleGroupRendererContract {
  Widget toggleGroup(ToggleGroupProps props);
}
