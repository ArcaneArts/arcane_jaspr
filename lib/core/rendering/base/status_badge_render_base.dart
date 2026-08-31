import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/style_layering.dart';
import 'package:arcane_jaspr/core/props/status_badge_props.dart';

/// Shared structural base for themed status-badge renderers.
///
/// Factors the identical build logic shared by every theme's status-badge
/// renderer — the solid/status dispatch, the DOM skeleton for each label kind,
/// the dot/icon indicator, and the label in one place. A concrete theme renderer
/// only supplies the value-producing members
/// below: the class prefix, the optional data-attributes, the theme colour and
/// size lookups, and the variant/colour/size style maps. Where a theme diverges
/// structurally (card colour application differs between themes), the base
/// exposes the [applyCardColors] escape hatch.
///
/// This base lives in core and depends only on core props (and the core icon
/// view used by labels); it must never depend on a theme package.
abstract class StatusBadgeRenderBase extends StatelessComponent {
  const StatusBadgeRenderBase(this.props, {super.key});

  final StatusBadgeProps props;

  // ===========================================================================
  // Theme-specific value members
  // ===========================================================================

  /// CSS class prefix for this theme (e.g. `'shadcn'`, `'neon'`).
  String get classPrefix;

  /// Root attributes for solid labels; return `null` for none.
  Map<String, String>? variantBadgeAttributes(StatusBadgeProps props);

  /// Root attributes for status badges; return `null` for none.
  Map<String, String>? statusBadgeAttributes(StatusBadgeProps props);

  /// Dot indicator dimension for the current size.
  String indicatorSize(StatusBadgeProps props);

  /// Label text styles shared by solid and status badges.
  Map<String, String> labelStyles(
    StatusBadgeProps props,
    String effectiveLabelColor,
  );

  /// Fully resolved label colour for a status badge (after the
  /// [props.labelColor] override).
  String statusLabelColor(StatusBadgeProps props);

  /// Base container styles for a solid label.
  Map<String, String> cardBaseStyles(StatusBadgeProps props);

  /// Applies theme-specific background, colour, and border to a solid label's
  /// [styles] map.
  void applyCardColors(StatusBadgeProps props, Map<String, String> styles);

  /// Container styles for a status badge.
  Map<String, String> statusContainerStyles(StatusBadgeProps props);

  /// Dot indicator styles for a status badge.
  Map<String, String> statusDotStyles(StatusBadgeProps props);

  // ===========================================================================
  // Shared value members
  // ===========================================================================

  /// Indicator/label colour for status badges. Identical across all themes.
  String statusColor(StatusBadgeProps props) {
    if (props.accentColor != null) {
      return props.accentColor!;
    }
    return switch (props.status) {
      StatusType.success || StatusType.online => 'var(--success)',
      StatusType.warning || StatusType.away => 'var(--warning)',
      StatusType.error || StatusType.busy => 'var(--destructive)',
      StatusType.info => 'var(--info)',
      StatusType.offline => 'var(--muted-foreground)',
    };
  }

  /// Label font size for solid and status badges. Identical across all themes.
  String statusFontSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '0.75rem',
    ComponentSize.md => '0.875rem',
    ComponentSize.lg => '1rem',
  };

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  // ===========================================================================
  // Shared structure
  // ===========================================================================

  @override
  Component build(BuildContext context) {
    if (props.variant != BadgeVariant.status) {
      return _buildSolidBadge();
    }

    // Default: status badge (inline, with dot)
    return _buildStatusBadge();
  }

  /// Icon-indicator span styles for a status badge. Identical across themes.
  Map<String, String> _statusIconStyles(StatusBadgeProps props) =>
      <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'color': statusColor(props),
        'font-size': indicatorSize(props),
      };

  Component _buildSolidBadge() {
    final Map<String, String> styles = <String, String>{
      ...cardBaseStyles(props),
    };
    applyCardColors(props, styles);
    // Layer the permeability overrides last so decoration/styles win over the
    // theme's solid-label colors.
    layerStyles(styles, <Map<String, String>?>[
      props.decoration?.universalStyles(),
      decorationStyles(props.decoration),
      props.styles?.toMap(),
    ]);

    return dom.span(
      classes: '$classPrefix-badge $classPrefix-badge-${props.variant.name}',
      attributes: variantBadgeAttributes(props),
      styles: dom.Styles(raw: styles),
      <Component>[?props.icon, Component.text(props.label)],
    );
  }

  Component _buildStatusBadge() {
    final String effectiveLabelColor = statusLabelColor(props);

    return dom.div(
      classes:
          '$classPrefix-status-badge $classPrefix-status-${props.status.name}',
      attributes: statusBadgeAttributes(props),
      styles: dom.Styles(
        raw: <String, String>{
          ...statusContainerStyles(props),
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      <Component>[
        // Indicator (dot or custom icon)
        if (props.icon != null)
          dom.span(
            classes: '$classPrefix-status-indicator $classPrefix-status-icon',
            styles: dom.Styles(raw: _statusIconStyles(props)),
            <Component>[props.icon!],
          )
        else if (props.effectiveShowDot)
          dom.span(
            classes: '$classPrefix-status-indicator',
            styles: dom.Styles(raw: statusDotStyles(props)),
            const <Component>[],
          ),
        // Label
        dom.span(
          classes: '$classPrefix-status-label',
          styles: dom.Styles(raw: labelStyles(props, effectiveLabelColor)),
          <Component>[Component.text(props.label)],
        ),
      ],
    );
  }
}
