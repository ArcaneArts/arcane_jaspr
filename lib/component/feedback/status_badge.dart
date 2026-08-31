import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';
import '../view/icon.dart';

export '../../core/props/status_badge_props.dart';

/// Compact status or label component with at most one leading mark.
///
/// Renderers use a restrained rectangular container. Glow, pulse, gradients,
/// automatic decorative icons, and overlapping marks are intentionally absent
/// from this API.
class ArcaneStatusBadge extends StatelessWidget {
  final String label;
  final ComponentSize size;
  final BadgeVariant variant;
  final StatusType status;
  final bool showDot;
  final String? accentColor;
  final ArcaneGlyph? icon;
  final String? background;
  final String? borderColor;
  final String? labelColor;
  final ArcaneStyleData? styles;
  final ArcaneDecoration? decoration;

  const ArcaneStatusBadge({
    required this.label,
    this.size = ComponentSize.md,
    this.variant = BadgeVariant.status,
    this.status = StatusType.info,
    this.showDot = true,
    this.accentColor,
    this.icon,
    this.background,
    this.borderColor,
    this.labelColor,
    this.styles,
    this.decoration,
    super.key,
  });

  const ArcaneStatusBadge.success(
    this.label, {
    this.size = ComponentSize.md,
    this.showDot = true,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.status,
       status = StatusType.success,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.warning(
    this.label, {
    this.size = ComponentSize.md,
    this.showDot = true,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.status,
       status = StatusType.warning,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.error(
    this.label, {
    this.size = ComponentSize.md,
    this.showDot = true,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.status,
       status = StatusType.error,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.info(
    this.label, {
    this.size = ComponentSize.md,
    this.showDot = true,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.status,
       status = StatusType.info,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.offline(
    this.label, {
    this.size = ComponentSize.md,
    this.showDot = true,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.status,
       status = StatusType.offline,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.custom({
    required this.label,
    required this.accentColor,
    this.size = ComponentSize.md,
    this.showDot = true,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.status,
       status = StatusType.info,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.successSolid(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.successSolid,
       status = StatusType.success,
       showDot = false,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.warningSolid(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.warningSolid,
       status = StatusType.warning,
       showDot = false,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.errorSolid(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.errorSolid,
       status = StatusType.error,
       showDot = false,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.infoSolid(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.infoSolid,
       status = StatusType.info,
       showDot = false,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.outline(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.outline,
       status = StatusType.info,
       showDot = false,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.primary(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.primary,
       status = StatusType.info,
       showDot = false,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  const ArcaneStatusBadge.secondary(
    this.label, {
    this.size = ComponentSize.md,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = BadgeVariant.secondary,
       status = StatusType.info,
       showDot = false,
       accentColor = null,
       background = null,
       borderColor = null,
       labelColor = null;

  @override
  Widget build(BuildContext context) {
    return context.renderers.statusBadge(
      StatusBadgeProps(
        label: label,
        size: size,
        variant: variant,
        status: status,
        showDot: showDot,
        accentColor: accentColor,
        icon: icon,
        background: background,
        borderColor: borderColor,
        labelColor: labelColor,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}
