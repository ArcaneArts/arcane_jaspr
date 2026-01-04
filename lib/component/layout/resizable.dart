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

/// A resizable panel group with draggable dividers.
///
/// Allows users to resize panels by dragging the handles between them.
///
/// Example:
/// ```dart
/// ArcaneResizable(
///   direction: ResizeDirection.horizontal,
///   panels: [
///     ResizablePanel(
///       defaultSize: 30,
///       minSize: 20,
///       child: Sidebar(),
///     ),
///     ResizablePanel(
///       child: MainContent(),
///     ),
///   ],
/// )
/// ```
class ArcaneResizable extends StatelessComponent {
  /// The panels to display
  final List<ResizablePanel> panels;

  /// Direction of the resize
  final ResizeDirection direction;

  /// Handle size in pixels
  final double handleSize;

  /// Whether to show the handle grip dots
  final bool showGrip;

  const ArcaneResizable({
    required this.panels,
    this.direction = ResizeDirection.horizontal,
    this.handleSize = 8,
    this.showGrip = true,
    super.key,
  });

  /// Creates a horizontal resizable with two panels (sidebar + content)
  const ArcaneResizable.sidebarLayout({
    required Component sidebar,
    required Component content,
    double sidebarSize = 25,
    double sidebarMinSize = 15,
    double sidebarMaxSize = 40,
    super.key,
  })  : panels = const [],
        direction = ResizeDirection.horizontal,
        handleSize = 8,
        showGrip = true;

  /// Creates a vertical resizable with two panels (top + bottom)
  const ArcaneResizable.splitView({
    required Component top,
    required Component bottom,
    double topSize = 50,
    double topMinSize = 20,
    double topMaxSize = 80,
    super.key,
  })  : panels = const [],
        direction = ResizeDirection.vertical,
        handleSize = 8,
        showGrip = true;

  @override
  Component build(BuildContext context) {
    final isHorizontal = direction == ResizeDirection.horizontal;

    return div(
      classes: 'arcane-resizable ${isHorizontal ? 'horizontal' : 'vertical'}',
      attributes: {
        'data-resizable': 'true',
        'data-direction': isHorizontal ? 'horizontal' : 'vertical',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': isHorizontal ? 'row' : 'column',
        'width': '100%',
        'height': '100%',
        'overflow': 'hidden',
      }),
      [
        for (var i = 0; i < panels.length; i++) ...[
          // Panel
          _buildPanel(panels[i], isHorizontal, i),
          // Handle (between panels, not after last)
          if (i < panels.length - 1) _buildHandle(isHorizontal, i),
        ],
      ],
    );
  }

  Component _buildPanel(ResizablePanel panel, bool isHorizontal, int index) {
    final flexBasis = panel.defaultSize != null ? '${panel.defaultSize}%' : 'auto';

    return div(
      classes: 'arcane-resizable-panel ${panel.collapsible ? 'collapsible' : ''}',
      attributes: {
        'data-panel-index': '$index',
        if (panel.minSize != null) 'data-min-size': '${panel.minSize}',
        if (panel.maxSize != null) 'data-max-size': '${panel.maxSize}',
        if (panel.collapsible) 'data-collapsible': 'true',
      },
      styles: Styles(raw: {
        'flex': panel.defaultSize != null ? '0 0 $flexBasis' : '1 1 auto',
        'min-width': isHorizontal ? (panel.minSize != null ? '${panel.minSize}%' : '0') : 'auto',
        'min-height': !isHorizontal ? (panel.minSize != null ? '${panel.minSize}%' : '0') : 'auto',
        'max-width': isHorizontal ? (panel.maxSize != null ? '${panel.maxSize}%' : 'none') : 'auto',
        'max-height': !isHorizontal ? (panel.maxSize != null ? '${panel.maxSize}%' : 'none') : 'auto',
        'overflow': 'auto',
      }),
      [panel.child],
    );
  }

  Component _buildHandle(bool isHorizontal, int index) {
    return div(
      classes: 'arcane-resizable-handle',
      attributes: {
        'data-handle-index': '$index',
        'role': 'separator',
        'aria-orientation': isHorizontal ? 'vertical' : 'horizontal',
        'aria-valuenow': '50',
        'tabindex': '0',
      },
      styles: Styles(raw: {
        'flex': '0 0 ${handleSize}px',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'background-color': ArcaneColors.border,
        'cursor': isHorizontal ? 'col-resize' : 'row-resize',
        'transition': ArcaneEffects.transitionFast,
        'position': 'relative',
        'z-index': '10',
      }),
      [
        if (showGrip)
          div(
            classes: 'arcane-resizable-grip',
            styles: Styles(raw: {
              'display': 'flex',
              'flex-direction': isHorizontal ? 'column' : 'row',
              'gap': '2px',
            }),
            [
              for (var i = 0; i < 3; i++)
                const div(
                  styles: Styles(raw: {
                    'width': '4px',
                    'height': '4px',
                    'border-radius': '50%',
                    'background-color': ArcaneColors.muted,
                  }),
                  [],
                ),
            ],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-resizable-handle:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-resizable-handle:active').styles(raw: {
      'background-color': ArcaneColors.accent,
    }),
    css('.arcane-resizable-handle:focus').styles(raw: {
      'outline': 'none',
      'background-color': ArcaneColors.accentContainer,
    }),
    css('.arcane-resizable-handle:active .arcane-resizable-grip div')
        .styles(raw: {
      'background-color': ArcaneColors.accentForeground,
    }),
    css('.arcane-resizable.dragging').styles(raw: {
      'user-select': 'none',
    }),
    css('.arcane-resizable.dragging .arcane-resizable-panel').styles(raw: {
      'pointer-events': 'none',
    }),
  ];
}

/// A panel within a resizable group
class ResizablePanel {
  /// The panel content
  final Component child;

  /// Default size as percentage (e.g., 30 for 30%)
  final double? defaultSize;

  /// Minimum size as percentage
  final double? minSize;

  /// Maximum size as percentage
  final double? maxSize;

  /// Whether this panel can be collapsed
  final bool collapsible;

  /// Called when panel is collapsed
  final void Function()? onCollapse;

  /// Called when panel is expanded
  final void Function()? onExpand;

  const ResizablePanel({
    required this.child,
    this.defaultSize,
    this.minSize,
    this.maxSize,
    this.collapsible = false,
    this.onCollapse,
    this.onExpand,
  });
}

/// Direction for resizable panels
enum ResizeDirection {
  horizontal,
  vertical,
}