import 'package:arcane_jaspr/core/props/status_badge_props.dart';
import 'package:arcane_jaspr/core/rendering/base/status_badge_render_base.dart';

/// Neon Status Badge renderer.
///
/// Unified renderer for both status indicators and card overlay badges.
/// Supports:
/// - Status badges: pill-shaped with dot/icon and optional emphasis
/// - Card overlay badges: positioned absolutely with solid backgrounds
/// - All size variants (sm, md, lg)
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
  String promoColor(StatusBadgeProps props) {
    if (props.accentColor != null) {
      return props.accentColor!;
    }
    return switch (props.variant) {
      BadgeVariant.popular => 'var(--neon-accent)',
      BadgeVariant.recommended => 'var(--neon-accent)',
      BadgeVariant.isNew => 'var(--success)',
      _ => 'var(--neon-accent)',
    };
  }

  @override
  String indicatorSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '6px',
    ComponentSize.md => '6px',
    ComponentSize.lg => '8px',
  };

  String _statusPadding(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '0.25rem 0.625rem',
    ComponentSize.md => '0.375rem 0.75rem',
    ComponentSize.lg => '0.5rem 1rem',
  };

  @override
  Map<String, String> promoContainerStyles(StatusBadgeProps props) {
    final String color = promoColor(props);
    final String effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 8%, transparent)';
    final String effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 22%, transparent)';
    return <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4375rem',
      'padding': _statusPadding(props),
      'background': effectiveBackground,
      'border': '1px solid $effectiveBorder',
    };
  }

  @override
  Map<String, String> promoIndicatorStyles(StatusBadgeProps props) {
    final String color = promoColor(props);
    final String size = indicatorSize(props);
    return <String, String>{
      'width': size,
      'height': size,
      'border-radius': '50%',
      'background': color,
      'flex-shrink': '0',
      'box-shadow': '0 0 8px color-mix(in srgb, $color 45%, transparent)',
    };
  }

  @override
  Map<String, String> labelStyles(
    StatusBadgeProps props,
    String effectiveLabelColor,
  ) => <String, String>{
    'font-size': statusFontSize(props),
    'font-weight': '600',
    'color': effectiveLabelColor,
    'white-space': 'nowrap',
  };

  @override
  String promoLabelColor(StatusBadgeProps props) =>
      props.labelColor ?? promoColor(props);

  @override
  String statusLabelColor(StatusBadgeProps props) =>
      props.labelColor ?? statusColor(props);

  String _cardPadding(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '0.25rem 0.625rem',
    ComponentSize.md => '0.25rem 0.75rem',
    ComponentSize.lg => '0.375rem 1rem',
  };

  String _cardFontSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => 'var(--font-size-xs)',
    ComponentSize.md => 'var(--font-size-xs)',
    ComponentSize.lg => 'var(--font-size-sm)',
  };

  @override
  Map<String, String> cardBaseStyles(StatusBadgeProps props) =>
      <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
        'font-size': _cardFontSize(props),
        'font-weight': 'var(--font-weight-semibold)',
        'line-height': '1',
        'white-space': 'nowrap',
        'transition': 'all var(--transition)',
        'padding': _cardPadding(props),
        'letter-spacing': '0.04em',
      };

  (String bgColor, String fgColor, String? shadow, String? border) _cardColors(
    StatusBadgeProps props,
  ) {
    return switch (props.variant) {
      BadgeVariant.popular || BadgeVariant.primary => (
        'var(--neon-accent)',
        'var(--neon-on-accent)',
        '0 4px 14px color-mix(in srgb, var(--neon-accent) 26%, transparent)',
        '1px solid color-mix(in srgb, var(--neon-accent) 60%, #12151C)',
      ),
      BadgeVariant.recommended => (
        'var(--neon-accent)',
        'var(--neon-on-accent)',
        '0 4px 14px color-mix(in srgb, var(--neon-accent) 26%, transparent)',
        '1px solid color-mix(in srgb, var(--neon-accent) 60%, #12151C)',
      ),
      BadgeVariant.isNew || BadgeVariant.successSolid => (
        'var(--success, #22c55e)',
        'var(--success-foreground, #ffffff)',
        '0 4px 14px color-mix(in srgb, var(--success) 24%, transparent)',
        '1px solid color-mix(in srgb, var(--success) 55%, #12151C)',
      ),
      BadgeVariant.warningSolid => (
        'var(--warning, #f59e0b)',
        'var(--warning-foreground, #0b0b0b)',
        '0 4px 14px color-mix(in srgb, var(--warning) 24%, transparent)',
        '1px solid color-mix(in srgb, var(--warning) 58%, #12151C)',
      ),
      BadgeVariant.errorSolid => (
        'var(--destructive)',
        'var(--destructive-foreground)',
        '0 4px 14px color-mix(in srgb, var(--destructive) 24%, transparent)',
        '1px solid color-mix(in srgb, var(--destructive) 55%, #12151C)',
      ),
      BadgeVariant.infoSolid => (
        'var(--info, #3b82f6)',
        'var(--info-foreground, #ffffff)',
        '0 4px 14px color-mix(in srgb, var(--info) 24%, transparent)',
        '1px solid color-mix(in srgb, var(--info) 58%, #12151C)',
      ),
      BadgeVariant.outline => (
        'transparent',
        'var(--foreground)',
        null,
        '1px solid var(--neon-control-border)',
      ),
      BadgeVariant.secondary => (
        'color-mix(in srgb, var(--neon-accent-cool) 6%, var(--neon-surface-2))',
        'var(--secondary-foreground)',
        null,
        '1px solid color-mix(in srgb, var(--neon-accent-cool) 18%, var(--neon-control-border))',
      ),
      BadgeVariant.status => (
        'color-mix(in srgb, var(--neon-accent-cool) 6%, var(--neon-surface-2))',
        'var(--secondary-foreground)',
        null,
        '1px solid color-mix(in srgb, var(--neon-accent-cool) 18%, var(--neon-control-border))',
      ),
    };
  }

  @override
  void applyCardColors(StatusBadgeProps props, Map<String, String> styles) {
    final (
      String bgColor,
      String fgColor,
      String? shadowColor,
      String? borderStyle,
    ) = _cardColors(props);

    if (props.gradient != null) {
      styles['background'] = props.gradient!;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
      if (shadowColor != null) styles['box-shadow'] = shadowColor;
    } else if (props.background != null) {
      styles['background-color'] = props.background!;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
    } else {
      styles['background-color'] = bgColor;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
      if (shadowColor != null) styles['box-shadow'] = shadowColor;
    }
  }

  @override
  Map<String, String> statusContainerStyles(StatusBadgeProps props) {
    final String color = statusColor(props);
    final String effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 6%, transparent)';
    final String effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 20%, transparent)';
    return <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4375rem',
      'padding': _statusPadding(props),
      'background': effectiveBackground,
      'border': '1px solid $effectiveBorder',
    };
  }

  @override
  Map<String, String> statusDotStyles(StatusBadgeProps props) {
    final String color = statusColor(props);
    final String size = indicatorSize(props);
    return <String, String>{
      'width': size,
      'height': size,
      'border-radius': '50%',
      'background': color,
      'flex-shrink': '0',
      if (props.showGlow)
        'box-shadow': '0 0 8px color-mix(in srgb, $color 45%, transparent)',
    };
  }
}
