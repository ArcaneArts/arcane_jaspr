import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Style for the check icon
enum CheckStyle {
  /// Checkmark (✓)
  check,

  /// Bullet point (•)
  bullet,

  /// Arrow (→)
  arrow,

  /// Plus (+)
  plus,

  /// Star (★)
  star,
}

/// A single check item with icon and text.
///
/// ```dart
/// ArcaneCheckItem(
///   text: 'Shared models across web and server',
/// )
///
/// ArcaneCheckItem.success(
///   text: 'All tests passing',
/// )
/// ```
class ArcaneCheckItem extends StatelessComponent {
  /// The text content
  final String text;

  /// Icon style
  final CheckStyle icon;

  /// Icon color
  final String? iconColor;

  /// Text color
  final String? textColor;

  /// Font size
  final String? fontSize;

  /// Gap between icon and text
  final String? gap;

  const ArcaneCheckItem({
    required this.text,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.gap,
    super.key,
  });

  /// Create with brand/accent colored icon
  const ArcaneCheckItem.brand({
    required this.text,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.gap,
    super.key,
  }) : iconColor = ArcaneColors.accent;

  /// Create with success/green colored icon
  const ArcaneCheckItem.success({
    required this.text,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.gap,
    super.key,
  }) : iconColor = ArcaneColors.success;

  @override
  Component build(BuildContext context) {
    final effectiveIconColor = iconColor ?? ArcaneColors.accent;
    final effectiveTextColor = textColor ?? ArcaneColors.onSurface;
    final effectiveFontSize = fontSize ?? ArcaneTypography.fontSizeBase;
    final effectiveGap = gap ?? ArcaneSpacing.sm;

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': effectiveGap,
      }),
      [
        span(
          styles: Styles(raw: {
            'color': effectiveIconColor,
            'font-weight': '600',
            'flex-shrink': '0',
          }),
          [Component.text(_getIconChar())],
        ),
        span(
          styles: Styles(raw: {
            'color': effectiveTextColor,
            'font-size': effectiveFontSize,
          }),
          [Component.text(text)],
        ),
      ],
    );
  }

  String _getIconChar() {
    switch (icon) {
      case CheckStyle.check:
        return '\u2713';
      case CheckStyle.bullet:
        return '\u2022';
      case CheckStyle.arrow:
        return '\u2192';
      case CheckStyle.plus:
        return '+';
      case CheckStyle.star:
        return '\u2605';
    }
  }
}

/// A list of check items.
///
/// Common for feature lists, benefits, and requirements.
///
/// ```dart
/// ArcaneCheckList(
///   items: [
///     'Shared models across web and server',
///     'Type-safe API calls',
///     'Hot reload in development',
///     'Server-side rendering',
///   ],
/// )
///
/// ArcaneCheckList.brand(
///   items: ['Feature 1', 'Feature 2', 'Feature 3'],
/// )
/// ```
class ArcaneCheckList extends StatelessComponent {
  /// List of text items
  final List<String> items;

  /// Icon style for all items
  final CheckStyle icon;

  /// Icon color for all items
  final String? iconColor;

  /// Text color for all items
  final String? textColor;

  /// Font size for all items
  final String? fontSize;

  /// Gap between icon and text in each item
  final String? itemGap;

  /// Gap between items in the list
  final String? listGap;

  /// Cross axis alignment
  final String? alignItems;

  const ArcaneCheckList({
    required this.items,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
    super.key,
  });

  /// Create with brand/accent colored icons
  const ArcaneCheckList.brand({
    required this.items,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
    super.key,
  }) : iconColor = ArcaneColors.accent;

  /// Create with success/green colored icons
  const ArcaneCheckList.success({
    required this.items,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
    super.key,
  }) : iconColor = ArcaneColors.success;

  @override
  Component build(BuildContext context) {
    final effectiveListGap = listGap ?? ArcaneSpacing.md;
    final effectiveAlignItems = alignItems ?? 'flex-start';

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': effectiveListGap,
        'align-items': effectiveAlignItems,
      }),
      [
        for (final item in items)
          ArcaneCheckItem(
            text: item,
            icon: icon,
            iconColor: iconColor,
            textColor: textColor,
            fontSize: fontSize,
            gap: itemGap,
          ),
      ],
    );
  }
}

/// A feature/benefit row commonly used in pricing or comparison sections.
///
/// ```dart
/// ArcaneFeatureRow(
///   feature: 'Unlimited API calls',
///   included: true,
/// )
/// ```
class ArcaneFeatureRow extends StatelessComponent {
  /// Feature text
  final String feature;

  /// Whether the feature is included
  final bool included;

  /// Custom included icon color
  final String? includedColor;

  /// Custom excluded icon color
  final String? excludedColor;

  const ArcaneFeatureRow({
    required this.feature,
    this.included = true,
    this.includedColor,
    this.excludedColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveIncludedColor = includedColor ?? ArcaneColors.success;
    final effectiveExcludedColor = excludedColor ?? ArcaneColors.muted;

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
      }),
      [
        span(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontSizeSm,
            'color': included ? effectiveIncludedColor : effectiveExcludedColor,
          }),
          [text(included ? '\u2713' : '\u2717')],
        ),
        span(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontSizeSm,
            'color': included ? ArcaneColors.onSurface : ArcaneColors.muted,
          }),
          [text(feature)],
        ),
      ],
    );
  }
}