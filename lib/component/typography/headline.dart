import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// Headline levels
enum HeadlineLevel {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
}

/// A styled headline component (Supabase-style typography)
class Headline extends StatelessComponent {
  /// The headline text
  final String content;

  /// The headline level (h1-h6)
  final HeadlineLevel level;

  /// Optional custom color
  final String? color;

  /// Text alignment
  final String align;

  /// Additional CSS classes
  final String? className;

  /// Whether to use gradient text (accent gradient)
  final bool gradient;

  const Headline(
    this.content, {
    this.level = HeadlineLevel.h1,
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  });

  /// H1 headline
  const Headline.h1(
    this.content, {
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  }) : level = HeadlineLevel.h1;

  /// H2 headline
  const Headline.h2(
    this.content, {
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  }) : level = HeadlineLevel.h2;

  /// H3 headline
  const Headline.h3(
    this.content, {
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  }) : level = HeadlineLevel.h3;

  /// H4 headline
  const Headline.h4(
    this.content, {
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  }) : level = HeadlineLevel.h4;

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    // Get size and weight based on level (Supabase-style typography)
    final (fontSize, fontWeight, lineHeight, letterSpacing) = switch (level) {
      HeadlineLevel.h1 => ('3.5rem', '700', '1.1', '-0.02em'),
      HeadlineLevel.h2 => ('2.5rem', '700', '1.2', '-0.02em'),
      HeadlineLevel.h3 => ('2rem', '600', '1.25', '-0.01em'),
      HeadlineLevel.h4 => ('1.5rem', '600', '1.3', '-0.01em'),
      HeadlineLevel.h5 => ('1.25rem', '600', '1.4', '0'),
      HeadlineLevel.h6 => ('1rem', '600', '1.5', '0'),
    };

    final baseStyles = <String, String>{
      'font-size': fontSize,
      'font-weight': fontWeight,
      'line-height': lineHeight,
      'letter-spacing': letterSpacing,
      'color': color ?? 'var(--arcane-on-background)',
      'text-align': align,
      'margin': '0',
      'padding': '0',
    };

    // Add gradient effect if enabled
    if (gradient) {
      baseStyles.addAll({
        'background': 'linear-gradient(to right, var(--arcane-accent), var(--arcane-accent-hover))',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        '-webkit-text-fill-color': 'transparent',
      });
    }

    final classes = 'arcane-headline arcane-${level.name} ${className ?? ''}';
    final styles = Styles(raw: baseStyles);
    final children = [text(content)];

    return switch (level) {
      HeadlineLevel.h1 => h1(classes: classes, styles: styles, children),
      HeadlineLevel.h2 => h2(classes: classes, styles: styles, children),
      HeadlineLevel.h3 => h3(classes: classes, styles: styles, children),
      HeadlineLevel.h4 => h4(classes: classes, styles: styles, children),
      HeadlineLevel.h5 => h5(classes: classes, styles: styles, children),
      HeadlineLevel.h6 => h6(classes: classes, styles: styles, children),
    };
  }
}

/// Subheadline / lead paragraph text
class Subheadline extends StatelessComponent {
  /// The text content
  final String content;

  /// Text size (sm, md, lg)
  final String size;

  /// Text alignment
  final String align;

  /// Whether to use muted color
  final bool muted;

  const Subheadline(
    this.content, {
    this.size = 'lg',
    this.align = 'left',
    this.muted = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final fontSize = switch (size) {
      'sm' => '1rem',
      'md' => '1.125rem',
      'lg' => '1.25rem',
      'xl' => '1.5rem',
      _ => '1.25rem',
    };

    return p(
      classes: 'arcane-subheadline',
      styles: Styles(raw: {
        'font-size': fontSize,
        'line-height': '1.7',
        'color': muted ? 'var(--arcane-muted)' : 'var(--arcane-on-background)',
        'text-align': align,
        'margin': '0',
        'max-width': '65ch', // Optimal reading width
      }),
      [text(content)],
    );
  }
}

/// Body text component
class BodyText extends StatelessComponent {
  /// The text content
  final String content;

  /// Text size (sm, base, lg)
  final String size;

  /// Whether to use muted color
  final bool muted;

  /// Text alignment
  final String align;

  const BodyText(
    this.content, {
    this.size = 'base',
    this.muted = false,
    this.align = 'left',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final fontSize = switch (size) {
      'sm' => '0.875rem',
      'base' => '1rem',
      'lg' => '1.125rem',
      _ => '1rem',
    };

    return p(
      classes: 'arcane-body-text',
      styles: Styles(raw: {
        'font-size': fontSize,
        'line-height': '1.6',
        'color': muted ? 'var(--arcane-muted)' : 'var(--arcane-on-surface)',
        'text-align': align,
        'margin': '0',
      }),
      [text(content)],
    );
  }
}
