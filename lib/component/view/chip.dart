import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Chip size variants
enum ChipSize {
  small,
  medium,
  large,
}

/// Chip/tag component for labels and filters
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneChip(
///   label: 'Active',
///   style: ChipStyle.success,
/// )
/// ```
class ArcaneChip extends StatelessComponent {
  final String label;
  final Component? icon;
  final ChipStyle? style;
  final ChipSize size;
  final bool removable;
  final void Function()? onRemove;
  final void Function()? onTap;

  const ArcaneChip({
    required this.label,
    this.icon,
    this.style,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  });

  /// Primary chip
  const ArcaneChip.primary({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : style = ChipStyle.primary;

  /// Success chip
  const ArcaneChip.success({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : style = ChipStyle.success;

  /// Warning chip
  const ArcaneChip.warning({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : style = ChipStyle.warning;

  /// Error chip
  const ArcaneChip.error({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : style = ChipStyle.error;

  /// Outline chip
  const ArcaneChip.outline({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : style = ChipStyle.outline;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? ChipStyle.standard;

    final (padding, fontSize) = switch (size) {
      ChipSize.small => ('${ArcaneSpacing.xs} ${ArcaneSpacing.sm}', ArcaneTypography.fontXs),
      ChipSize.medium => ('6px ${ArcaneSpacing.sm}', ArcaneTypography.fontSm),
      ChipSize.large => ('${ArcaneSpacing.sm} ${ArcaneSpacing.md}', ArcaneTypography.fontMd),
    };

    return span(
      classes: 'arcane-chip ${onTap != null ? 'clickable' : ''}',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
        'padding': padding,
        'border-radius': ArcaneRadius.full,
        ...effectiveStyle.styles,
        'font-size': fontSize,
        'font-weight': ArcaneTypography.weightMedium,
        'white-space': 'nowrap',
        if (onTap != null) 'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
      }),
      events: onTap != null
          ? {
              'click': (event) => onTap!(),
            }
          : null,
      [
        if (icon != null) icon!,
        text(label),
        if (removable)
          span(
            classes: 'arcane-chip-remove',
            styles: Styles(raw: {
              'margin-left': '2px',
              'cursor': 'pointer',
              'opacity': '0.7',
              'font-size': '1.1em',
              'line-height': '1',
            }),
            events: {
              'click': (event) {
                event.stopPropagation();
                onRemove?.call();
              },
            },
            [text('×')],
          ),
      ],
    );
  }
}

/// Chip group for multiple chips
class ArcaneChipGroup extends StatelessComponent {
  final List<ArcaneChip> chips;
  final String? gap;

  const ArcaneChipGroup({
    required this.chips,
    this.gap,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-chip-group',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': gap ?? ArcaneSpacing.sm,
      }),
      chips,
    );
  }
}
