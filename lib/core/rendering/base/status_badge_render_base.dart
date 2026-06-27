import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/status_badge_props.dart';

/// Shared structural base for themed status-badge renderers.
///
/// Factors the identical build logic shared by every theme's status-badge
/// renderer — the promo/card/status dispatch, the absolute-positioning append,
/// the DOM skeleton for each badge kind (pill container, dot/icon indicator and
/// label), the icon-vs-dot branch, and the card icon resolution — into one
/// place. A concrete theme renderer only supplies the value-producing members
/// below: the class prefix, the optional data-attributes, the theme colour and
/// size lookups, and the variant/colour/size style maps. Where a theme diverges
/// structurally (card colour application differs between themes), the base
/// exposes the [applyCardColors] escape hatch.
///
/// This base lives in core and depends only on core props (and the core icon
/// view used by card badges); it must never depend on a theme package.
abstract class StatusBadgeRenderBase extends StatelessComponent {
  const StatusBadgeRenderBase(this.props, {super.key});

  final StatusBadgeProps props;

  // ===========================================================================
  // Theme-specific value members
  // ===========================================================================

  /// CSS class prefix for this theme (e.g. `'shadcn'`, `'neon'`).
  String get classPrefix;

  /// Root attributes for promo and card badges; return `null` for none.
  Map<String, String>? variantBadgeAttributes(StatusBadgeProps props);

  /// Root attributes for status badges; return `null` for none.
  Map<String, String>? statusBadgeAttributes(StatusBadgeProps props);

  /// Indicator/label colour for promo badges (popular/recommended/new).
  String promoColor(StatusBadgeProps props);

  /// Dot indicator dimension for the current size.
  String indicatorSize(StatusBadgeProps props);

  /// Base container styles for a promo badge (before positioning is applied).
  Map<String, String> promoContainerStyles(StatusBadgeProps props);

  /// Dot indicator styles for a promo badge.
  Map<String, String> promoIndicatorStyles(StatusBadgeProps props);

  /// Label text styles shared by promo and status badges.
  Map<String, String> labelStyles(
    StatusBadgeProps props,
    String effectiveLabelColor,
  );

  /// Fully resolved label colour for a promo badge (after the [props.labelColor]
  /// override). Themes differ in their default (theme colour vs foreground).
  String promoLabelColor(StatusBadgeProps props);

  /// Fully resolved label colour for a status badge (after the
  /// [props.labelColor] override).
  String statusLabelColor(StatusBadgeProps props);

  /// Base container styles for a card badge (before positioning and colours).
  Map<String, String> cardBaseStyles(StatusBadgeProps props);

  /// Applies theme-specific background/colour/border/shadow to a card badge's
  /// [styles] map. Implemented per theme because the colour model differs
  /// structurally (gradient support, border and shadow handling).
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

  /// Label font size for promo and status badges. Identical across all themes.
  String statusFontSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '0.75rem',
    ComponentSize.md => '0.875rem',
    ComponentSize.lg => '1rem',
  };

  // ===========================================================================
  // Shared structure
  // ===========================================================================

  @override
  Component build(BuildContext context) {
    final BadgePosition? position = props.position;
    final bool isPositioned = position != null;

    // Popular, recommended, isNew use status badge style (rounded pill with dot)
    final bool isPromoBadge =
        props.variant == BadgeVariant.popular ||
        props.variant == BadgeVariant.recommended ||
        props.variant == BadgeVariant.isNew;

    if (isPromoBadge) {
      return _buildPromoBadge(position);
    }

    // Solid color badges (no dot, solid background)
    final bool isSolidBadge =
        props.variant == BadgeVariant.primary ||
        props.variant == BadgeVariant.secondary ||
        props.variant == BadgeVariant.successSolid ||
        props.variant == BadgeVariant.warningSolid ||
        props.variant == BadgeVariant.errorSolid ||
        props.variant == BadgeVariant.infoSolid ||
        props.variant == BadgeVariant.outline;

    if (isSolidBadge || isPositioned) {
      return _buildCardBadge(position);
    }

    // Default: status badge (inline, with dot)
    return _buildStatusBadge();
  }

  /// Appends absolute-positioning declarations to [styles] when [position] is
  /// set. Identical across every theme.
  void _applyPosition(Map<String, String> styles, BadgePosition? position) {
    if (position == null) {
      return;
    }
    styles['position'] = 'absolute';
    if (position.top != null) styles['top'] = position.top!;
    if (position.right != null) styles['right'] = position.right!;
    if (position.bottom != null) styles['bottom'] = position.bottom!;
    if (position.left != null) styles['left'] = position.left!;
    styles['z-index'] = '1';
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

  Component _buildPromoBadge(BadgePosition? position) {
    final Map<String, String> containerStyles = <String, String>{
      ...promoContainerStyles(props),
    };
    _applyPosition(containerStyles, position);

    final String effectiveLabelColor = promoLabelColor(props);

    return dom.div(
      classes:
          '$classPrefix-status-badge $classPrefix-promo-badge $classPrefix-badge-${props.variant.name}',
      attributes: variantBadgeAttributes(props),
      styles: dom.Styles(raw: containerStyles),
      <Component>[
        // Dot indicator (always show for promo badges)
        dom.span(
          classes: '$classPrefix-status-indicator',
          styles: dom.Styles(raw: promoIndicatorStyles(props)),
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

  Component _buildCardBadge(BadgePosition? position) {
    final Map<String, String> styles = <String, String>{
      ...cardBaseStyles(props),
    };
    _applyPosition(styles, position);
    applyCardColors(props, styles);

    // Determine icon to show
    final Component? iconToShow =
        props.icon ??
        (props.showDefaultIcon ? ArcaneIcon.star(size: IconSize.xs) : null);

    return dom.span(
      classes: '$classPrefix-badge $classPrefix-badge-${props.variant.name}',
      attributes: variantBadgeAttributes(props),
      styles: dom.Styles(raw: styles),
      <Component>[
        ?iconToShow,
        Component.text(props.label),
      ],
    );
  }

  Component _buildStatusBadge() {
    final String effectiveLabelColor = statusLabelColor(props);

    return dom.div(
      classes: '$classPrefix-status-badge $classPrefix-status-${props.status.name}',
      attributes: statusBadgeAttributes(props),
      styles: dom.Styles(raw: statusContainerStyles(props)),
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
