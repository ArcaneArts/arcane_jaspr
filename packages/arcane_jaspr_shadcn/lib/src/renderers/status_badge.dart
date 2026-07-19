import 'package:arcane_jaspr/core/props/status_badge_props.dart';
import 'package:arcane_jaspr/core/rendering/base/status_badge_render_base.dart';

/// ShadCN Status Badge renderer.
///
/// Unified renderer for both status indicators and card overlay badges.
/// Supports:
/// - Status badges: pill-shaped with dot/icon and optional pulse
/// - Card overlay badges: positioned absolutely with solid backgrounds
/// - All size variants (sm, md, lg)
class ShadcnStatusBadge extends StatusBadgeRenderBase {
  const ShadcnStatusBadge(super.props, {super.key});

  @override
  String get classPrefix => 'shadcn';

  @override
  Map<String, String>? variantBadgeAttributes(StatusBadgeProps props) => null;

  @override
  Map<String, String>? statusBadgeAttributes(StatusBadgeProps props) => null;

  @override
  String promoColor(StatusBadgeProps props) {
    if (props.accentColor != null) {
      return props.accentColor!;
    }
    return switch (props.variant) {
      BadgeVariant.popular => 'var(--primary)',
      BadgeVariant.recommended => 'var(--primary)',
      BadgeVariant.isNew => 'var(--success)',
      _ => 'var(--primary)',
    };
  }

  @override
  String indicatorSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '6px',
    ComponentSize.md => '6px',
    ComponentSize.lg => '8px',
  };

  String _statusPadding(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '0.25rem 0.5rem',
    ComponentSize.md => '0.25rem 0.75rem',
    ComponentSize.lg => '0.375rem 1rem',
  };

  @override
  Map<String, String> promoContainerStyles(StatusBadgeProps props) {
    final String color = promoColor(props);
    // Use color-mix for transparent background like status badges
    final String effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 15%, transparent)';
    final String effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 35%, transparent)';
    return <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': 'var(--space-2)',
      'padding': _statusPadding(props),
      'background': effectiveBackground,
      'border': '1px solid $effectiveBorder',
      'border-radius': '9999px', // Pill shape
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
      'box-shadow': '0 0 8px $color',
    };
  }

  @override
  Map<String, String> labelStyles(
    StatusBadgeProps props,
    String effectiveLabelColor,
  ) => <String, String>{
    'font-size': statusFontSize(props),
    'font-weight': '500',
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
    ComponentSize.sm => '0.125rem 0.5rem',
    ComponentSize.md => '0.125rem 0.625rem',
    ComponentSize.lg => '0.25rem 0.75rem',
  };

  String _cardFontSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '0.75rem',
    ComponentSize.md => '0.75rem',
    ComponentSize.lg => '0.875rem',
  };

  @override
  Map<String, String> cardBaseStyles(StatusBadgeProps props) =>
      <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
        'border-radius': '9999px',
        'font-size': _cardFontSize(props),
        'font-weight': '600',
        'line-height': '1',
        'white-space': 'nowrap',
        'transition': 'color 150ms, background-color 150ms, border-color 150ms',
        'padding': _cardPadding(props),
      };

  (String bgColor, String fgColor, String? glow, String? border) _cardColors(
    StatusBadgeProps props,
  ) {
    return switch (props.variant) {
      BadgeVariant.popular || BadgeVariant.primary => (
        'var(--primary)',
        'var(--primary-foreground)',
        '0 0 15px color-mix(in srgb, var(--primary) 20%, transparent)',
        null,
      ),
      BadgeVariant.recommended => (
        'var(--primary)', // Gradient overrides this
        'var(--primary-foreground)',
        '0 0 15px color-mix(in srgb, var(--primary) 20%, transparent)',
        null,
      ),
      BadgeVariant.isNew || BadgeVariant.successSolid => (
        'var(--success, #22c55e)',
        'var(--success-foreground, #ffffff)',
        null,
        null,
      ),
      BadgeVariant.warningSolid => (
        'var(--warning, #f59e0b)',
        'var(--warning-foreground, #000000)',
        null,
        null,
      ),
      BadgeVariant.errorSolid => (
        'var(--destructive)',
        'var(--destructive-foreground)',
        null,
        null,
      ),
      BadgeVariant.infoSolid => (
        'var(--info, #3b82f6)',
        'var(--info-foreground, #ffffff)',
        null,
        null,
      ),
      BadgeVariant.outline => (
        'transparent',
        'var(--foreground)',
        null,
        '1px solid var(--border)',
      ),
      BadgeVariant.secondary => (
        'var(--secondary)',
        'var(--secondary-foreground)',
        null,
        null,
      ),
      BadgeVariant.status => (
        'var(--secondary)',
        'var(--secondary-foreground)',
        null,
        null,
      ),
    };
  }

  @override
  void applyCardColors(StatusBadgeProps props, Map<String, String> styles) {
    // Get colors based on variant
    final (
      String bgColor,
      String fgColor,
      String? glowColor,
      String? borderStyle,
    ) = _cardColors(props);

    // Background and colors
    if (props.gradient != null) {
      styles['background'] = props.gradient!;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
      if (glowColor != null) styles['box-shadow'] = glowColor;
    } else if (props.background != null) {
      styles['background-color'] = props.background!;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
    } else {
      styles['background-color'] = bgColor;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
      if (glowColor != null) styles['box-shadow'] = glowColor;
    }
  }

  @override
  Map<String, String> statusContainerStyles(StatusBadgeProps props) {
    final String color = statusColor(props);
    // Use color-mix for consistent appearance
    final String effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 10%, transparent)';
    final String effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 25%, transparent)';
    return <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': 'var(--space-2)',
      'padding': _statusPadding(props),
      'background': effectiveBackground,
      'border': '1px solid $effectiveBorder',
      'border-radius': '9999px', // Pill shape
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
      if (props.showGlow) 'box-shadow': '0 0 8px $color',
      if (props.showPulse)
        'animation': 'arcane-pulse 2s ease-in-out infinite',
    };
  }
}
