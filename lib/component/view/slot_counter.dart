import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/slot_counter_props.dart';

/// A slot-machine style animated counter that spins through random values.
class ArcaneSlotCounter extends StatelessWidget {
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

  const ArcaneSlotCounter({
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
    super.key,
  });

  factory ArcaneSlotCounter.latency({
    int minLatency = 5,
    int maxLatency = 150,
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.lg,
    SlotCounterColor valueColor = SlotCounterColor.accent,
    bool autoStart = true,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
    Key? key,
  }) {
    return ArcaneSlotCounter(
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
      styles: styles,
      decoration: decoration,
      key: key,
    );
  }

  factory ArcaneSlotCounter.percentage({
    int minValue = 0,
    int maxValue = 100,
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.xl,
    SlotCounterColor valueColor = SlotCounterColor.accent,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
    Key? key,
  }) {
    return ArcaneSlotCounter(
      minValue: minValue,
      maxValue: maxValue,
      suffix: '%',
      label: label,
      valueSize: valueSize,
      valueColor: valueColor,
      styles: styles,
      decoration: decoration,
      key: key,
    );
  }

  factory ArcaneSlotCounter.currency({
    int minValue = 0,
    int maxValue = 10000,
    String currencySymbol = '\$',
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.xl,
    SlotCounterColor valueColor = SlotCounterColor.accent,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
    Key? key,
  }) {
    return ArcaneSlotCounter(
      minValue: minValue,
      maxValue: maxValue,
      prefix: currencySymbol,
      label: label,
      valueSize: valueSize,
      valueColor: valueColor,
      styles: styles,
      decoration: decoration,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.renderers.slotCounter(
      SlotCounterProps(
        minValue: minValue,
        maxValue: maxValue,
        fixedValue: fixedValue,
        prefix: prefix,
        suffix: suffix,
        label: label,
        spinDurationMs: spinDurationMs,
        spinIntervalMs: spinIntervalMs,
        basePauseSeconds: basePauseSeconds,
        randomPauseSeconds: randomPauseSeconds,
        autoStart: autoStart,
        valueSize: valueSize,
        affixSize: affixSize,
        labelSize: labelSize,
        valueColor: valueColor,
        affixColor: affixColor,
        labelColor: labelColor,
        valueBold: valueBold,
        monospace: monospace,
        minDigits: minDigits,
        onValueChange: onValueChange,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}

/// A row of slot counters for displaying multiple live values.
class ArcaneSlotCounterRow extends StatelessWidget {
  final List<SlotCounterProps> counters;
  final String gap;
  final bool wrap;
  final String justifyContent;

  const ArcaneSlotCounterRow({
    required this.counters,
    this.gap = '2rem',
    this.wrap = true,
    this.justifyContent = 'center',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.slotCounterRow(
      SlotCounterRowProps(
        counters: counters,
        gap: gap,
        wrap: wrap,
        justifyContent: justifyContent,
      ),
    );
  }
}

/// A card containing a slot counter with optional styling.
class ArcaneSlotCounterCard extends StatelessWidget {
  final SlotCounterProps counter;
  final String padding;
  final bool showBorder;
  final bool showBackground;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneSlotCounterCard({
    required this.counter,
    this.padding = '1rem',
    this.showBorder = false,
    this.showBackground = false,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.slotCounterCard(
      SlotCounterCardProps(
        counter: counter,
        padding: padding,
        showBorder: showBorder,
        showBackground: showBackground,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}
