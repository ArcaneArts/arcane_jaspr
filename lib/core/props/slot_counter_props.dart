import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

enum SlotCounterSize { xs, sm, md, lg, xl }

enum SlotCounterColor { primary, accent, muted, success, warning, destructive }

/// Slot counter component properties.
class SlotCounterProps {
  final int minValue;
  final int maxValue;
  final int? fixedValue;
  final String? prefix;
  final String? suffix;
  final String? label;
  final int spinDurationMs;
  final int spinIntervalMs;
  final int basePauseSeconds;
  final int randomPauseSeconds;
  final bool autoStart;
  final SlotCounterSize valueSize;
  final SlotCounterSize affixSize;
  final SlotCounterSize labelSize;
  final SlotCounterColor valueColor;
  final SlotCounterColor affixColor;
  final SlotCounterColor labelColor;
  final bool valueBold;
  final bool monospace;
  final int? minDigits;
  final void Function(int value)? onValueChange;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const SlotCounterProps({
    this.minValue = 0,
    this.maxValue = 9999,
    this.fixedValue,
    this.prefix,
    this.suffix,
    this.label,
    this.spinDurationMs = 1500,
    this.spinIntervalMs = 50,
    this.basePauseSeconds = 4,
    this.randomPauseSeconds = 5,
    this.autoStart = true,
    this.valueSize = SlotCounterSize.xl,
    this.affixSize = SlotCounterSize.sm,
    this.labelSize = SlotCounterSize.xs,
    this.valueColor = SlotCounterColor.accent,
    this.affixColor = SlotCounterColor.muted,
    this.labelColor = SlotCounterColor.muted,
    this.valueBold = true,
    this.monospace = true,
    this.minDigits,
    this.onValueChange,
    this.styles,
    this.decoration,
  });

  factory SlotCounterProps.latency({
    int minLatency = 5,
    int maxLatency = 150,
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.lg,
    SlotCounterColor valueColor = SlotCounterColor.accent,
    bool autoStart = true,
  }) {
    return SlotCounterProps(
      minValue: minLatency,
      maxValue: maxLatency,
      suffix: 'ms',
      label: label,
      valueSize: valueSize,
      valueColor: valueColor,
      basePauseSeconds: 4,
      randomPauseSeconds: 5,
      spinDurationMs: 1200,
      autoStart: autoStart,
    );
  }

  factory SlotCounterProps.percentage({
    int minValue = 0,
    int maxValue = 100,
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.xl,
    SlotCounterColor valueColor = SlotCounterColor.accent,
  }) {
    return SlotCounterProps(
      minValue: minValue,
      maxValue: maxValue,
      suffix: '%',
      label: label,
      valueSize: valueSize,
      valueColor: valueColor,
    );
  }

  factory SlotCounterProps.currency({
    int minValue = 0,
    int maxValue = 10000,
    String currencySymbol = '\$',
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.xl,
    SlotCounterColor valueColor = SlotCounterColor.accent,
  }) {
    return SlotCounterProps(
      minValue: minValue,
      maxValue: maxValue,
      prefix: currencySymbol,
      label: label,
      valueSize: valueSize,
      valueColor: valueColor,
    );
  }
}

/// Slot counter row component properties.
class SlotCounterRowProps {
  final List<SlotCounterProps> counters;
  final String gap;
  final bool wrap;
  final String justifyContent;

  const SlotCounterRowProps({
    required this.counters,
    this.gap = '2rem',
    this.wrap = true,
    this.justifyContent = 'center',
  });
}

/// Slot counter card component properties.
class SlotCounterCardProps {
  final SlotCounterProps counter;
  final String padding;
  final bool showBorder;
  final bool showBackground;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const SlotCounterCardProps({
    required this.counter,
    this.padding = '1rem',
    this.showBorder = false,
    this.showBackground = false,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for slot counter components.
mixin SlotCounterRendererContract {
  Component slotCounter(SlotCounterProps props);
  Component slotCounterRow(SlotCounterRowProps props);
  Component slotCounterCard(SlotCounterCardProps props);
}
