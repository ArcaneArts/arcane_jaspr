import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// Tooltip position
enum TooltipPosition {
  top,
  bottom,
  left,
  right,
}

/// A tooltip component (Supabase-style)
class Tooltip extends StatefulComponent {
  /// Child widget to wrap
  final Component child;

  /// Tooltip content text
  final String content;

  /// Tooltip position
  final TooltipPosition position;

  /// Delay before showing (ms)
  final int delay;

  /// Maximum width
  final double maxWidth;

  const Tooltip({
    required this.child,
    required this.content,
    this.position = TooltipPosition.top,
    this.delay = 200,
    this.maxWidth = 250,
    super.key,
  });

  @override
  State<Tooltip> createState() => _TooltipState();

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-tooltip-fade').styles(raw: {
      '0%': 'opacity: 0; transform: translateX(-50%) translateY(-4px) scale(0.95)',
      '100%': 'opacity: 1; transform: translateX(-50%) translateY(-8px) scale(1)',
    }),
  ];
}

class _TooltipState extends State<Tooltip> {
  bool _isVisible = false;

  void _showTooltip() {
    setState(() => _isVisible = true);
  }

  void _hideTooltip() {
    setState(() => _isVisible = false);
  }

  @override
  Component build(BuildContext context) {
    final (top, bottom, left, right, transform) = switch (component.position) {
      TooltipPosition.top => (
          'auto',
          '100%',
          '50%',
          'auto',
          'translateX(-50%) translateY(-8px)',
        ),
      TooltipPosition.bottom => (
          '100%',
          'auto',
          '50%',
          'auto',
          'translateX(-50%) translateY(8px)',
        ),
      TooltipPosition.left => (
          '50%',
          'auto',
          'auto',
          '100%',
          'translateY(-50%) translateX(-8px)',
        ),
      TooltipPosition.right => (
          '50%',
          'auto',
          '100%',
          'auto',
          'translateY(-50%) translateX(8px)',
        ),
    };

    return div(
      classes: 'arcane-tooltip-wrapper',
      styles: Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
      }),
      events: {
        'mouseenter': (e) => _showTooltip(),
        'mouseleave': (e) => _hideTooltip(),
        'focus': (e) => _showTooltip(),
        'blur': (e) => _hideTooltip(),
      },
      [
        component.child,
        if (_isVisible)
          div(
            classes: 'arcane-tooltip',
            attributes: {'role': 'tooltip'},
            styles: Styles(raw: {
              'position': 'absolute',
              'top': top,
              'bottom': bottom,
              'left': left,
              'right': right,
              'transform': transform,
              'z-index': '1000',
              'padding': '8px 12px',
              'max-width': '${component.maxWidth}px',
              'font-size': '0.8125rem',
              'line-height': '1.4',
              'color': 'var(--arcane-tooltip-foreground)',
              'background-color': 'var(--arcane-tooltip)',
              'border-radius': 'var(--arcane-radius)',
              'box-shadow': 'var(--arcane-shadow-lg)',
              'white-space': 'normal',
              'word-wrap': 'break-word',
              'pointer-events': 'none',
              'animation': 'arcane-tooltip-fade 0.15s ease-out',
            }),
            [text(component.content)],
          ),
      ],
    );
  }
}

/// A tooltip with custom content
class TooltipCustom extends StatefulComponent {
  /// Child widget to wrap
  final Component child;

  /// Custom tooltip content
  final Component tooltipContent;

  /// Tooltip position
  final TooltipPosition position;

  /// Maximum width
  final double? maxWidth;

  const TooltipCustom({
    required this.child,
    required this.tooltipContent,
    this.position = TooltipPosition.top,
    this.maxWidth,
    super.key,
  });

  @override
  State<TooltipCustom> createState() => _TooltipCustomState();
}

class _TooltipCustomState extends State<TooltipCustom> {
  bool _isVisible = false;

  void _showTooltip() {
    setState(() => _isVisible = true);
  }

  void _hideTooltip() {
    setState(() => _isVisible = false);
  }

  @override
  Component build(BuildContext context) {
    final (top, bottom, left, right, transform) = switch (component.position) {
      TooltipPosition.top => (
          'auto',
          '100%',
          '50%',
          'auto',
          'translateX(-50%) translateY(-8px)',
        ),
      TooltipPosition.bottom => (
          '100%',
          'auto',
          '50%',
          'auto',
          'translateX(-50%) translateY(8px)',
        ),
      TooltipPosition.left => (
          '50%',
          'auto',
          'auto',
          '100%',
          'translateY(-50%) translateX(-8px)',
        ),
      TooltipPosition.right => (
          '50%',
          'auto',
          '100%',
          'auto',
          'translateY(-50%) translateX(8px)',
        ),
    };

    return div(
      classes: 'arcane-tooltip-wrapper',
      styles: Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
      }),
      events: {
        'mouseenter': (e) => _showTooltip(),
        'mouseleave': (e) => _hideTooltip(),
      },
      [
        component.child,
        if (_isVisible)
          div(
            classes: 'arcane-tooltip-custom',
            styles: Styles(raw: {
              'position': 'absolute',
              'top': top,
              'bottom': bottom,
              'left': left,
              'right': right,
              'transform': transform,
              'z-index': '1000',
              'padding': '12px 16px',
              if (component.maxWidth != null) 'max-width': '${component.maxWidth}px',
              'background-color': 'var(--arcane-surface)',
              'border': '1px solid var(--arcane-border)',
              'border-radius': 'var(--arcane-radius)',
              'box-shadow': 'var(--arcane-shadow-lg)',
              'animation': 'arcane-tooltip-fade 0.15s ease-out',
            }),
            [component.tooltipContent],
          ),
      ],
    );
  }
}

/// An info icon with tooltip
class InfoTooltip extends StatelessComponent {
  /// Tooltip content
  final String content;

  /// Icon size
  final double size;

  /// Tooltip position
  final TooltipPosition position;

  const InfoTooltip({
    required this.content,
    this.size = 16,
    this.position = TooltipPosition.top,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Tooltip(
      content: content,
      position: position,
      child: span(
        classes: 'arcane-info-icon',
        styles: Styles(raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '${size}px',
          'height': '${size}px',
          'font-size': '${size * 0.7}px',
          'font-weight': '600',
          'color': 'var(--arcane-muted)',
          'border': '1px solid var(--arcane-border)',
          'border-radius': '50%',
          'cursor': 'help',
          'transition': 'color var(--arcane-transition-fast), border-color var(--arcane-transition-fast)',
        }),
        [text('?')],
      ),
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-info-icon:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
      'border-color': 'var(--arcane-on-surface)',
    }),
  ];
}
