import 'package:arcane_jaspr/flutter.dart';

import '../interaction/interaction.dart';

/// Sealed class hierarchy for menu items.
/// Use pattern matching to handle different item types in renderers.
sealed class ArcaneMenuItem {
  const ArcaneMenuItem();
}

/// Standard clickable menu item.
class MenuItemAction extends ArcaneMenuItem {
  final String label;
  final Widget? icon;
  final String? description;
  final String? shortcut;
  final bool disabled;
  final bool destructive;
  final void Function()? onSelect;
  final ArcaneInteraction? action;
  final String? href;

  const MenuItemAction({
    required this.label,
    this.icon,
    this.description,
    this.shortcut,
    this.disabled = false,
    this.destructive = false,
    this.onSelect,
    this.action,
    this.href,
  });
}

/// Visual separator between menu items.
class MenuItemSeparator extends ArcaneMenuItem {
  const MenuItemSeparator();
}

/// Checkbox menu item.
class MenuItemCheckbox extends ArcaneMenuItem {
  final String label;
  final Widget? icon;
  final bool checked;
  final bool disabled;
  final String? shortcut;
  final void Function(bool)? onChanged;
  final ArcaneInteraction? action;

  const MenuItemCheckbox({
    required this.label,
    this.icon,
    required this.checked,
    this.disabled = false,
    this.shortcut,
    this.onChanged,
    this.action,
  });
}

/// Radio menu item (part of a group).
class MenuItemRadio extends ArcaneMenuItem {
  final String label;
  final Widget? icon;
  final String group;
  final String value;
  final bool selected;
  final bool disabled;
  final void Function(String)? onChanged;
  final ArcaneInteraction? action;

  const MenuItemRadio({
    required this.label,
    this.icon,
    required this.group,
    required this.value,
    required this.selected,
    this.disabled = false,
    this.onChanged,
    this.action,
  });
}

/// Submenu with nested items.
class MenuItemSubmenu extends ArcaneMenuItem {
  final String label;
  final Widget? icon;
  final List<ArcaneMenuItem> children;
  final bool disabled;
  final String? id;

  const MenuItemSubmenu({
    required this.label,
    this.icon,
    required this.children,
    this.disabled = false,
    this.id,
  });
}

/// Label/header for grouping items (non-interactive).
class MenuItemLabel extends ArcaneMenuItem {
  final String label;

  const MenuItemLabel({required this.label});
}
