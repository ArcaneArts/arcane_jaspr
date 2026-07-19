import 'package:arcane_jaspr/core/props/status_badge_props.dart';
import 'package:arcane_jaspr/core/rendering/base/status_badge_render_base.dart';

/// Neon Status Badge renderer (neutralized skeleton).
class NeonStatusBadge extends StatusBadgeRenderBase {
  const NeonStatusBadge(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  Map<String, String>? variantBadgeAttributes(StatusBadgeProps props) =>
      <String, String>{
        'data-variant': props.variant.name,
        'data-size': props.size.name,
      };

  @override
  Map<String, String>? statusBadgeAttributes(StatusBadgeProps props) =>
      <String, String>{
        'data-state': props.status.name,
        'data-size': props.size.name,
      };

  @override
  String promoColor(StatusBadgeProps props) =>
      props.accentColor ?? 'var(--foreground)';

  @override
  String indicatorSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '6px',
    ComponentSize.md => '6px',
    ComponentSize.lg => '8px',
  };

  @override
  Map<String, String> promoContainerStyles(StatusBadgeProps props) =>
      const <String, String>{};

  @override
  Map<String, String> promoIndicatorStyles(StatusBadgeProps props) =>
      const <String, String>{};

  @override
  Map<String, String> labelStyles(
    StatusBadgeProps props,
    String effectiveLabelColor,
  ) => const <String, String>{};

  @override
  String promoLabelColor(StatusBadgeProps props) =>
      props.labelColor ?? promoColor(props);

  @override
  String statusLabelColor(StatusBadgeProps props) =>
      props.labelColor ?? statusColor(props);

  @override
  Map<String, String> cardBaseStyles(StatusBadgeProps props) =>
      const <String, String>{};

  @override
  void applyCardColors(StatusBadgeProps props, Map<String, String> styles) {}

  @override
  Map<String, String> statusContainerStyles(StatusBadgeProps props) =>
      const <String, String>{};

  @override
  Map<String, String> statusDotStyles(StatusBadgeProps props) =>
      const <String, String>{};
}
