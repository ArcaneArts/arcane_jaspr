import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A horizontal divider component
class Divider extends StatelessComponent {
  /// Vertical margin
  final double margin;

  /// Custom color
  final String? color;

  /// Optional label in the middle
  final String? label;

  /// Whether to use a dashed style
  final bool dashed;

  const Divider({
    this.margin = 16,
    this.color,
    this.label,
    this.dashed = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (label != null) {
      return div(
        classes: 'arcane-divider with-label',
        styles: Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': '16px',
          'margin': '${margin}px 0',
        }),
        [
          div(
            styles: Styles(raw: {
              'flex': '1',
              'height': '1px',
              'background-color': color ?? 'var(--arcane-border)',
              if (dashed) 'background':
                  'repeating-linear-gradient(to right, ${color ?? 'var(--arcane-border)'} 0, ${color ?? 'var(--arcane-border)'} 4px, transparent 4px, transparent 8px)',
            }),
            [],
          ),
          span(
            styles: Styles(raw: {
              'font-size': '0.8125rem',
              'color': 'var(--arcane-muted)',
              'white-space': 'nowrap',
            }),
            [text(label!)],
          ),
          div(
            styles: Styles(raw: {
              'flex': '1',
              'height': '1px',
              'background-color': color ?? 'var(--arcane-border)',
              if (dashed) 'background':
                  'repeating-linear-gradient(to right, ${color ?? 'var(--arcane-border)'} 0, ${color ?? 'var(--arcane-border)'} 4px, transparent 4px, transparent 8px)',
            }),
            [],
          ),
        ],
      );
    }

    return hr(
      classes: 'arcane-divider',
      styles: Styles(raw: {
        'margin': '${margin}px 0',
        'border': 'none',
        'height': '1px',
        'background-color': color ?? 'var(--arcane-border)',
        if (dashed) 'background':
            'repeating-linear-gradient(to right, ${color ?? 'var(--arcane-border)'} 0, ${color ?? 'var(--arcane-border)'} 4px, transparent 4px, transparent 8px)',
      }),
    );
  }
}

/// A vertical divider component
class VerticalDivider extends StatelessComponent {
  /// Horizontal margin
  final double margin;

  /// Custom color
  final String? color;

  /// Height (null for full height)
  final double? height;

  const VerticalDivider({
    this.margin = 16,
    this.color,
    this.height,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-divider-vertical',
      styles: Styles(raw: {
        'width': '1px',
        'margin': '0 ${margin}px',
        'background-color': color ?? 'var(--arcane-border)',
        if (height != null) 'height': '${height}px' else 'align-self': 'stretch',
      }),
      [],
    );
  }
}
