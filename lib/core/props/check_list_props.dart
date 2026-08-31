import 'package:jaspr/jaspr.dart';

enum CheckStyle { check, bullet, arrow, plus, star }

/// Check item component properties.
class CheckItemProps {
  final String text;
  final CheckStyle icon;
  final String? iconColor;
  final String? textColor;
  final String? fontSize;
  final String? gap;

  const CheckItemProps({
    required this.text,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.gap,
  });
}

/// Check list component properties.
class CheckListProps {
  final List<String> items;
  final CheckStyle icon;
  final String? iconColor;
  final String? textColor;
  final String? fontSize;
  final String? itemGap;
  final String? listGap;
  final String? alignItems;

  const CheckListProps({
    required this.items,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
  });
}

/// Feature row component properties.
///
/// Displays a feature with an included/excluded indicator.
/// Used in pricing cards and feature comparison lists.
class FeatureRowProps {
  final String feature;
  final bool included;
  final String? includedColor;
  final String? excludedColor;

  /// Whether to show strikethrough text for excluded features.
  final bool strikethrough;

  /// Whether to show the icon in a circular container.
  /// When true, renders a circular background with the icon.
  final bool circularIcon;

  /// Optional tooltip text (shown on hover via title attribute).
  final String? tooltip;

  /// Custom icon container size. Defaults to '18px'.
  final String? iconSize;

  const FeatureRowProps({
    required this.feature,
    this.included = true,
    this.includedColor,
    this.excludedColor,
    this.strikethrough = true,
    this.circularIcon = true,
    this.tooltip,
    this.iconSize,
  });

  FeatureRowProps copyWith({
    String? feature,
    bool? included,
    String? includedColor,
    String? excludedColor,
    bool? strikethrough,
    bool? circularIcon,
    String? tooltip,
    String? iconSize,
  }) {
    return FeatureRowProps(
      feature: feature ?? this.feature,
      included: included ?? this.included,
      includedColor: includedColor ?? this.includedColor,
      excludedColor: excludedColor ?? this.excludedColor,
      strikethrough: strikethrough ?? this.strikethrough,
      circularIcon: circularIcon ?? this.circularIcon,
      tooltip: tooltip ?? this.tooltip,
      iconSize: iconSize ?? this.iconSize,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for check list components.
mixin CheckListRendererContract {
  Component checkItem(CheckItemProps props);
  Component checkList(CheckListProps props);
  Component featureRow(FeatureRowProps props);
}
