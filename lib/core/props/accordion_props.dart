import 'package:arcane_jaspr/flutter.dart';

/// Accordion item data.
class AccordionItemProps {
  final String title;
  final String content;
  final Widget? customContent;

  /// Optional category label (displayed as badge).
  final String? category;

  /// Optional accent color for category badge and chevron (CSS color value).
  final String? accentColor;

  const AccordionItemProps({
    required this.title,
    this.content = '',
    this.customContent,
    this.category,
    this.accentColor,
  });
}

/// Accordion variant styles.
enum AccordionVariant {
  /// Standard accordion with toggle icons.
  standard,

  /// FAQ-style with category badges and accent colors.
  faq,
}

/// Accordion component properties.
class AccordionProps {
  final List<AccordionItemProps> items;
  final Set<int> openItems;
  final void Function(int index)? onToggle;
  final bool allowMultiple;
  final bool bordered;

  /// Visual variant of the accordion.
  final AccordionVariant variant;

  /// Default accent color for items without a specific accentColor.
  final String? defaultAccentColor;

  const AccordionProps({
    required this.items,
    required this.openItems,
    this.onToggle,
    this.allowMultiple = false,
    this.bordered = false,
    this.variant = AccordionVariant.standard,
    this.defaultAccentColor,
  });

  AccordionProps copyWith({
    List<AccordionItemProps>? items,
    Set<int>? openItems,
    void Function(int index)? onToggle,
    bool? allowMultiple,
    bool? bordered,
    AccordionVariant? variant,
    String? defaultAccentColor,
  }) {
    return AccordionProps(
      items: items ?? this.items,
      openItems: openItems ?? this.openItems,
      onToggle: onToggle ?? this.onToggle,
      allowMultiple: allowMultiple ?? this.allowMultiple,
      bordered: bordered ?? this.bordered,
      variant: variant ?? this.variant,
      defaultAccentColor: defaultAccentColor ?? this.defaultAccentColor,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for accordion components.
mixin AccordionRendererContract {
  /// Renders an accordion with collapsible sections.
  Widget accordion(AccordionProps props);
}
