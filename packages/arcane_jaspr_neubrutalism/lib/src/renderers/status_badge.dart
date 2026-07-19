import 'package:arcane_jaspr/core/props/status_badge_props.dart';
import 'package:arcane_jaspr/core/rendering/base/status_badge_render_base.dart';

class NeubrutalismStatusBadge extends StatusBadgeRenderBase {
  const NeubrutalismStatusBadge(super.props, {super.key});

  @override
  String get classPrefix => 'neubrutalism';

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
      BadgeVariant.popular => 'var(--nb-accent, var(--primary))',
      BadgeVariant.recommended => 'var(--nb-accent-hot, var(--primary))',
      BadgeVariant.isNew => 'var(--success)',
      _ => 'var(--nb-accent, var(--primary))',
    };
  }

  @override
  String indicatorSize(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '8px',
    ComponentSize.md => '8px',
    ComponentSize.lg => '10px',
  };

  String _statusPadding(StatusBadgeProps props) => switch (props.size) {
    ComponentSize.sm => '0.25rem 0.625rem',
    ComponentSize.md => '0.375rem 0.75rem',
    ComponentSize.lg => '0.5rem 1rem',
  };

  /// Promo and status badges share the same pill container in this theme.
  Map<String, String> _pillContainerStyles(StatusBadgeProps props) {
    final String effectiveBackground =
        props.background ?? 'var(--nb-paper, var(--card))';
    final String effectiveBorder = props.borderColor ?? 'var(--nb-line, #000)';
    return <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4375rem',
      'padding': _statusPadding(props),
      'background': effectiveBackground,
      'border': 'var(--nb-border-thin, 2px) solid $effectiveBorder',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'box-shadow':
          'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
    };
  }

  /// Promo and status badges share the same dot indicator in this theme; only
  /// the indicator [color] differs between the two.
  Map<String, String> _dotStyles(StatusBadgeProps props, String color) {
    final String size = indicatorSize(props);
    return <String, String>{
      'width': size,
      'height': size,
      'border-radius': '9999px',
      'background': color,
      'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
      'flex-shrink': '0',
    };
  }

  @override
  Map<String, String> promoContainerStyles(StatusBadgeProps props) =>
      _pillContainerStyles(props);

  @override
  Map<String, String> promoIndicatorStyles(StatusBadgeProps props) =>
      _dotStyles(props, promoColor(props));

  @override
  Map<String, String> labelStyles(
    StatusBadgeProps props,
    String effectiveLabelColor,
  ) => <String, String>{
    'font-family': 'var(--font-heading)',
    'font-size': statusFontSize(props),
    'font-weight': '800',
    'color': effectiveLabelColor,
    'white-space': 'nowrap',
    'letter-spacing': '0.02em',
  };

  @override
  String promoLabelColor(StatusBadgeProps props) =>
      props.labelColor ?? 'var(--foreground)';

  @override
  String statusLabelColor(StatusBadgeProps props) =>
      props.labelColor ?? 'var(--foreground)';

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
        'font-family': 'var(--font-heading)',
        'font-size': _cardFontSize(props),
        'font-weight': '800',
        'line-height': '1',
        'white-space': 'nowrap',
        'padding': _cardPadding(props),
        'letter-spacing': '0.04em',
        'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow':
            'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
        'transition':
            'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
      };

  (String bgColor, String fgColor) _cardColors(StatusBadgeProps props) {
    return switch (props.variant) {
      BadgeVariant.popular || BadgeVariant.primary => (
        'var(--nb-accent, var(--primary))',
        'var(--nb-on-accent, #000)',
      ),
      BadgeVariant.recommended => (
        'var(--nb-accent-hot, var(--primary))',
        'var(--nb-on-accent, #000)',
      ),
      BadgeVariant.isNew || BadgeVariant.successSolid => (
        'var(--success, #22c55e)',
        'var(--success-foreground, #000)',
      ),
      BadgeVariant.warningSolid => (
        'var(--warning, #f59e0b)',
        'var(--warning-foreground, #000)',
      ),
      BadgeVariant.errorSolid => (
        'var(--destructive)',
        'var(--destructive-foreground, #fff)',
      ),
      BadgeVariant.infoSolid => (
        'var(--info, #3b82f6)',
        'var(--info-foreground, #fff)',
      ),
      BadgeVariant.outline => (
        'transparent',
        'var(--foreground)',
      ),
      BadgeVariant.secondary => (
        'var(--nb-paper-soft, var(--card))',
        'var(--foreground)',
      ),
      BadgeVariant.status => (
        'var(--nb-paper-soft, var(--card))',
        'var(--foreground)',
      ),
    };
  }

  @override
  void applyCardColors(StatusBadgeProps props, Map<String, String> styles) {
    final (String bgColor, String fgColor) = _cardColors(props);

    if (props.background != null) {
      styles['background-color'] = props.background!;
    } else {
      styles['background-color'] = bgColor;
    }
    styles['color'] = fgColor;
  }

  @override
  Map<String, String> statusContainerStyles(StatusBadgeProps props) =>
      _pillContainerStyles(props);

  @override
  Map<String, String> statusDotStyles(StatusBadgeProps props) =>
      _dotStyles(props, statusColor(props));
}
