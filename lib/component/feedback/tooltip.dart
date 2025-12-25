import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';
import '../view/icon.dart';

/// Tooltip position
enum TooltipPosition {
  top,
  bottom,
  left,
  right,
}

/// A tooltip component that shows on hover.
///
/// ```dart
/// ArcaneTooltip(
///   content: 'Helpful information',
///   child: ArcaneButton(label: 'Hover me'),
/// )
/// ```
class ArcaneTooltip extends StatelessComponent {
  /// Child widget to wrap
  final Component child;

  /// Tooltip content text
  final String content;

  /// Tooltip position relative to child
  final TooltipPosition position;

  /// Maximum width of tooltip
  final double maxWidth;

  const ArcaneTooltip({
    required this.child,
    required this.content,
    this.position = TooltipPosition.top,
    this.maxWidth = 250,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-tooltip-trigger',
      attributes: {
        'data-tooltip': content,
        'data-tooltip-position': position.name,
      },
      styles: const Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
      }),
      [
        child,
        // Tooltip element (hidden by default, shown via CSS :hover)
        div(
          classes: 'arcane-tooltip arcane-tooltip-${position.name}',
          attributes: {'role': 'tooltip'},
          styles: Styles(raw: {
            'position': 'absolute',
            'z-index': ArcaneZIndex.tooltip,
            'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
            'max-width': '${maxWidth}px',
            'font-size': ArcaneTypography.fontXs,
            'font-weight': ArcaneTypography.weightMedium,
            'line-height': '1.4',
            'color': ArcaneColors.tooltipForeground,
            'background': ArcaneColors.tooltip,
            'border-radius': ArcaneRadius.md,
            'box-shadow': ArcaneEffects.shadowMd,
            'white-space': 'nowrap',
            'pointer-events': 'none',
            'opacity': '0',
            'visibility': 'hidden',
            'transition': 'opacity 150ms ease, visibility 150ms ease, transform 150ms ease',
            ..._getPositionStyles(),
          }),
          [
            Component.text(content),
            // Arrow
            div(
              classes: 'arcane-tooltip-arrow',
              styles: Styles(raw: {
                'position': 'absolute',
                'width': '8px',
                'height': '8px',
                'background': ArcaneColors.tooltip,
                'transform': 'rotate(45deg)',
                ..._getArrowStyles(),
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }

  Map<String, String> _getPositionStyles() {
    return switch (position) {
      TooltipPosition.top => {
          'bottom': '100%',
          'left': '50%',
          'transform': 'translateX(-50%) translateY(-4px)',
          'margin-bottom': '8px',
        },
      TooltipPosition.bottom => {
          'top': '100%',
          'left': '50%',
          'transform': 'translateX(-50%) translateY(4px)',
          'margin-top': '8px',
        },
      TooltipPosition.left => {
          'right': '100%',
          'top': '50%',
          'transform': 'translateY(-50%) translateX(-4px)',
          'margin-right': '8px',
        },
      TooltipPosition.right => {
          'left': '100%',
          'top': '50%',
          'transform': 'translateY(-50%) translateX(4px)',
          'margin-left': '8px',
        },
    };
  }

  Map<String, String> _getArrowStyles() {
    return switch (position) {
      TooltipPosition.top => {
          'bottom': '-4px',
          'left': '50%',
          'margin-left': '-4px',
        },
      TooltipPosition.bottom => {
          'top': '-4px',
          'left': '50%',
          'margin-left': '-4px',
        },
      TooltipPosition.left => {
          'right': '-4px',
          'top': '50%',
          'margin-top': '-4px',
        },
      TooltipPosition.right => {
          'left': '-4px',
          'top': '50%',
          'margin-top': '-4px',
        },
    };
  }

  @css
  static final List<StyleRule> styles = [
    // Show tooltip on hover
    css('.arcane-tooltip-trigger:hover .arcane-tooltip').styles(raw: {
      'opacity': '1',
      'visibility': 'visible',
    }),
    // Animate in from correct direction
    css('.arcane-tooltip-trigger:hover .arcane-tooltip-top').styles(raw: {
      'transform': 'translateX(-50%) translateY(0)',
    }),
    css('.arcane-tooltip-trigger:hover .arcane-tooltip-bottom').styles(raw: {
      'transform': 'translateX(-50%) translateY(0)',
    }),
    css('.arcane-tooltip-trigger:hover .arcane-tooltip-left').styles(raw: {
      'transform': 'translateY(-50%) translateX(0)',
    }),
    css('.arcane-tooltip-trigger:hover .arcane-tooltip-right').styles(raw: {
      'transform': 'translateY(-50%) translateX(0)',
    }),
  ];
}

/// Short alias for ArcaneTooltip
typedef ATooltip = ArcaneTooltip;

/// A tooltip with custom content (not just text)
class ArcaneTooltipCustom extends StatelessComponent {
  /// Child widget to wrap
  final Component child;

  /// Custom tooltip content
  final Component tooltipContent;

  /// Tooltip position
  final TooltipPosition position;

  /// Maximum width
  final double? maxWidth;

  const ArcaneTooltipCustom({
    required this.child,
    required this.tooltipContent,
    this.position = TooltipPosition.top,
    this.maxWidth,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-tooltip-trigger',
      attributes: {
        'data-tooltip-position': position.name,
      },
      styles: const Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
      }),
      [
        child,
        div(
          classes: 'arcane-tooltip arcane-tooltip-custom arcane-tooltip-${position.name}',
          styles: Styles(raw: {
            'position': 'absolute',
            'z-index': ArcaneZIndex.tooltip,
            'padding': ArcaneSpacing.md,
            if (maxWidth != null) 'max-width': '${maxWidth}px',
            'background': ArcaneColors.surface,
            'border': '1px solid ${ArcaneColors.border}',
            'border-radius': ArcaneRadius.lg,
            'box-shadow': ArcaneEffects.shadowLg,
            'pointer-events': 'none',
            'opacity': '0',
            'visibility': 'hidden',
            'transition': 'opacity 150ms ease, visibility 150ms ease, transform 150ms ease',
            ..._getPositionStyles(),
          }),
          [tooltipContent],
        ),
      ],
    );
  }

  Map<String, String> _getPositionStyles() {
    return switch (position) {
      TooltipPosition.top => {
          'bottom': '100%',
          'left': '50%',
          'transform': 'translateX(-50%) translateY(-4px)',
          'margin-bottom': '8px',
        },
      TooltipPosition.bottom => {
          'top': '100%',
          'left': '50%',
          'transform': 'translateX(-50%) translateY(4px)',
          'margin-top': '8px',
        },
      TooltipPosition.left => {
          'right': '100%',
          'top': '50%',
          'transform': 'translateY(-50%) translateX(-4px)',
          'margin-right': '8px',
        },
      TooltipPosition.right => {
          'left': '100%',
          'top': '50%',
          'transform': 'translateY(-50%) translateX(4px)',
          'margin-left': '8px',
        },
    };
  }
}

/// An info icon with tooltip
class ArcaneInfoTooltip extends StatelessComponent {
  /// Tooltip content
  final String content;

  /// Icon size
  final double size;

  /// Tooltip position
  final TooltipPosition position;

  const ArcaneInfoTooltip({
    required this.content,
    this.size = 16,
    this.position = TooltipPosition.top,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneTooltip(
      content: content,
      position: position,
      child: span(
        classes: 'arcane-info-tooltip-icon',
        styles: Styles(raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '${size}px',
          'height': '${size}px',
          'color': ArcaneColors.muted,
          'cursor': 'help',
          'transition': ArcaneEffects.transitionFast,
        }),
        [ArcaneIcon.info(size: IconSize.sm)],
      ),
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-info-tooltip-icon:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
    }),
  ];
}
