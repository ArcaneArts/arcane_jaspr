import 'package:arcane_jaspr/flutter.dart';
import 'menu_item_props.dart';

export 'menu_item_props.dart';

enum DropdownAlignment {
  left,
  right,
  center,
}

/// Dropdown menu component properties.
class DropdownMenuProps {
  final String id;
  final Widget trigger;
  final List<ArcaneMenuItem> items;
  final DropdownAlignment alignment;
  final double? width;
  final bool keepOpenOnAction;
  final bool initiallyOpen;

  const DropdownMenuProps({
    required this.id,
    required this.trigger,
    required this.items,
    this.alignment = DropdownAlignment.left,
    this.width,
    this.keepOpenOnAction = false,
    this.initiallyOpen = false,
  });

  DropdownMenuProps copyWith({
    String? id,
    Widget? trigger,
    List<ArcaneMenuItem>? items,
    DropdownAlignment? alignment,
    double? width,
    bool? keepOpenOnAction,
    bool? initiallyOpen,
  }) {
    return DropdownMenuProps(
      id: id ?? this.id,
      trigger: trigger ?? this.trigger,
      items: items ?? this.items,
      alignment: alignment ?? this.alignment,
      width: width ?? this.width,
      keepOpenOnAction: keepOpenOnAction ?? this.keepOpenOnAction,
      initiallyOpen: initiallyOpen ?? this.initiallyOpen,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for dropdown menu components.
mixin DropdownMenuRendererContract {
  Widget dropdownMenu(DropdownMenuProps props);
}
