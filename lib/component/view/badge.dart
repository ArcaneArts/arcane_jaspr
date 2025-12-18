import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// Badge variants
enum BadgeVariant {
  /// Default/neutral badge
  default_,
  /// Primary/accent colored badge
  primary,
  /// Secondary/muted badge
  secondary,
  /// Success badge (green)
  success,
  /// Warning badge (amber)
  warning,
  /// Destructive/error badge (red)
  destructive,
  /// Outline badge
  outline,
}

/// A pill-shaped badge/label component (Supabase-style)
class Badge extends StatelessComponent {
  /// The badge text
  final String label;

  /// Optional leading icon
  final Component? icon;

  /// Badge variant
  final BadgeVariant variant;

  /// Badge size (sm, md, lg)
  final String size;

  const Badge(
    this.label, {
    this.icon,
    this.variant = BadgeVariant.default_,
    this.size = 'md',
    super.key,
  });

  /// Primary badge
  const Badge.primary(
    this.label, {
    this.icon,
    this.size = 'md',
    super.key,
  }) : variant = BadgeVariant.primary;

  /// Success badge
  const Badge.success(
    this.label, {
    this.icon,
    this.size = 'md',
    super.key,
  }) : variant = BadgeVariant.success;

  /// Warning badge
  const Badge.warning(
    this.label, {
    this.icon,
    this.size = 'md',
    super.key,
  }) : variant = BadgeVariant.warning;

  /// Destructive badge
  const Badge.destructive(
    this.label, {
    this.icon,
    this.size = 'md',
    super.key,
  }) : variant = BadgeVariant.destructive;

  /// Outline badge
  const Badge.outline(
    this.label, {
    this.icon,
    this.size = 'md',
    super.key,
  }) : variant = BadgeVariant.outline;

  @override
  Component build(BuildContext context) {
    // Get size-specific styles
    final (paddingH, paddingV, fontSize) = switch (size) {
      'sm' => (6.0, 2.0, '0.6875rem'),
      'md' => (8.0, 3.0, '0.75rem'),
      'lg' => (12.0, 4.0, '0.8125rem'),
      _ => (8.0, 3.0, '0.75rem'),
    };

    // Get variant-specific colors
    final (bgColor, textColor, borderColor) = switch (variant) {
      BadgeVariant.default_ => (
          'var(--arcane-surface-variant)',
          'var(--arcane-on-surface)',
          'transparent',
        ),
      BadgeVariant.primary => (
          'var(--arcane-accent-container)',
          'var(--arcane-accent)',
          'transparent',
        ),
      BadgeVariant.secondary => (
          'var(--arcane-secondary-container)',
          'var(--arcane-on-secondary-container)',
          'transparent',
        ),
      BadgeVariant.success => (
          'var(--arcane-success)',
          'var(--arcane-success-foreground)',
          'transparent',
        ),
      BadgeVariant.warning => (
          'var(--arcane-warning)',
          'var(--arcane-warning-foreground)',
          'transparent',
        ),
      BadgeVariant.destructive => (
          'var(--arcane-destructive)',
          'var(--arcane-destructive-foreground)',
          'transparent',
        ),
      BadgeVariant.outline => (
          'transparent',
          'var(--arcane-on-surface)',
          'var(--arcane-border)',
        ),
    };

    return span(
      classes: 'arcane-badge arcane-badge-${variant.name}',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '4px',
        'padding': '${paddingV}px ${paddingH}px',
        'font-size': fontSize,
        'font-weight': '500',
        'line-height': '1',
        'border-radius': 'var(--arcane-radius-full)',
        'background-color': bgColor,
        'color': textColor,
        'border': borderColor == 'transparent'
            ? 'none'
            : '1px solid $borderColor',
        'white-space': 'nowrap',
      }),
      [
        if (icon != null) icon!,
        text(label),
      ],
    );
  }
}
