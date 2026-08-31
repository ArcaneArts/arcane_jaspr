import 'package:arcane_jaspr/core/props/status_badge_props.dart';
import 'package:arcane_jaspr/core/rendering/base/status_badge_render_base.dart';

/// Win95 Status Badge renderer (neutralized skeleton).
class Win95StatusBadge extends StatusBadgeRenderBase {
  const Win95StatusBadge(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

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
  String indicatorSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '6px',
    ComponentSize.md => '6px',
    ComponentSize.lg => '8px',
  };

  @override
  Map<String, String> labelStyles(
    StatusBadgeProps props,
    String effectiveLabelColor,
  ) => const <String, String>{};

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
