import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Utilities for building consistent demo layouts
class DemoUtils {
  /// Creates a standard demo column layout with consistent styling
  static Component column({
    required List<Component> children,
    Gap gapSize = Gap.md,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return ArcaneColumn(
      gapSize: gapSize,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }

  /// Creates a standard demo row layout with consistent styling
  static Component row({
    required List<Component> children,
    Gap gapSize = Gap.md,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return ArcaneRow(
      gapSize: gapSize,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }

  /// Creates a status text component for showing demo state
  static Component statusText(String text) {
    return ArcaneText(
      text,
      size: FontSize.sm,
      color: TextColor.muted,
    );
  }

  /// Creates a labeled value display (e.g., "Selected: Option 1")
  static Component labeledValue(String label, String value) {
    return statusText('$label: $value');
  }

  /// Creates a demo section with a title
  static Component section({
    required String title,
    required List<Component> children,
    Gap gapSize = Gap.md,
  }) {
    return ArcaneColumn(
      gapSize: gapSize,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneText(
          title,
          size: FontSize.sm,
          weight: FontWeight.w600,
          color: TextColor.primary,
        ),
        ...children,
      ],
    );
  }

  /// Creates a constrained width container for demos
  static Component constrained({
    required Component child,
    String width = '400px',
  }) {
    return ArcaneDiv(
      styles: ArcaneStyleData(widthCustom: width),
      children: [child],
    );
  }

  /// Creates a demo container with surface background
  static Component surface({
    required List<Component> children,
    PaddingPreset padding = PaddingPreset.md,
    Radius borderRadius = Radius.md,
    Background background = Background.surfaceVariant,
  }) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        padding: padding,
        background: background,
        borderRadius: borderRadius,
      ),
      children: children,
    );
  }

  /// Creates a small colored box for layout demos
  static Component colorBox(String label) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        padding: PaddingPreset.md,
        background: Background.accentContainer,
        textColor: TextColor.accent,
        borderRadius: Radius.sm,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
      ),
      children: [ArcaneText(label)],
    );
  }

  /// Creates a small box for spacing demos
  static Component smallBox() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '24px',
        heightCustom: '24px',
        background: Background.accent,
        borderRadius: Radius.sm,
      ),
      children: const [],
    );
  }

  /// Creates a style demo wrapper with title
  static Component styleDemo(String title, List<Component> children) {
    return ArcaneColumn(
      gapSize: Gap.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneText(
          title,
          size: FontSize.sm,
          weight: FontWeight.w500,
          color: TextColor.onSurfaceVariant,
        ),
        ...children,
      ],
    );
  }

  /// Creates a showcase for style enum values
  static Component enumShowcase<T>({
    required String title,
    required List<(String name, T value)> items,
    required Component Function(String name, T value) builder,
    Gap gapSize = Gap.md,
  }) {
    return ArcaneColumn(
      gapSize: gapSize,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (name, value) in items) builder(name, value),
      ],
    );
  }

  /// Creates a row of styled boxes for comparison demos
  static Component comparisonRow({
    required List<(String label, ArcaneStyleData styles)> items,
    Gap gapSize = Gap.md,
  }) {
    return ArcaneRow(
      gapSize: gapSize,
      children: [
        for (final (label, styles) in items)
          ArcaneColumn(
            gapSize: Gap.xs,
            children: [
              ArcaneText(label, size: FontSize.xs, color: TextColor.muted),
              ArcaneDiv(styles: styles, children: [smallBox()]),
            ],
          ),
      ],
    );
  }
}

/// Mixin for stateful demo components with common patterns
mixin DemoStateMixin<T extends StatefulComponent> on State<T> {
  /// Helper to build a demo with status display
  Component buildDemoWithStatus({
    required String statusLabel,
    required String statusValue,
    required List<Component> children,
  }) {
    return DemoUtils.column(
      children: [
        ...children,
        DemoUtils.labeledValue(statusLabel, statusValue),
      ],
    );
  }
}
