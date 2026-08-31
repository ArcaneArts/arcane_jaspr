import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/resizable_props.dart';

class NeonResizable extends StatelessComponent {
  final ResizableProps props;

  const NeonResizable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool horizontal = props.direction == ResizeDirection.horizontal;
    return dom.div(
      classes: 'neon-resizable ${horizontal ? 'horizontal' : 'vertical'}',
      attributes: {
        'data-resizable': 'true',
        'data-direction': horizontal ? 'horizontal' : 'vertical',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': horizontal ? 'row' : 'column',
          'width': '100%',
          'height': '100%',
          'overflow': 'hidden',
        },
      ),
      [
        for (int i = 0; i < props.panels.length; i++) ...[
          _panel(props.panels[i], horizontal, i),
          if (i < props.panels.length - 1)
            _handle(horizontal, i, props.showGrip, props.handleSize),
        ],
      ],
    );
  }
}

Component _panel(ResizablePanelData panel, bool horizontal, int index) {
  final String basis = panel.defaultSize != null
      ? '${panel.defaultSize}%'
      : 'auto';
  return dom.div(
    classes: 'neon-resizable-panel ${panel.collapsible ? 'collapsible' : ''}',
    attributes: {
      'data-panel-index': '$index',
      if (panel.minSize != null) 'data-min-size': '${panel.minSize}',
      if (panel.maxSize != null) 'data-max-size': '${panel.maxSize}',
      if (panel.collapsible) 'data-collapsible': 'true',
    },
    styles: dom.Styles(
      raw: {
        'flex': panel.defaultSize != null ? '0 0 $basis' : '1 1 auto',
        'min-width': horizontal
            ? (panel.minSize != null ? '${panel.minSize}%' : '0')
            : 'auto',
        'min-height': !horizontal
            ? (panel.minSize != null ? '${panel.minSize}%' : '0')
            : 'auto',
        'max-width': horizontal
            ? (panel.maxSize != null ? '${panel.maxSize}%' : 'none')
            : 'auto',
        'max-height': !horizontal
            ? (panel.maxSize != null ? '${panel.maxSize}%' : 'none')
            : 'auto',
        'overflow': 'auto',
      },
    ),
    [panel.child],
  );
}

Component _handle(
  bool horizontal,
  int index,
  bool showGrip,
  double handleSize,
) {
  final String size = '${handleSize}px';
  return dom.div(
    classes: 'neon-resizable-handle',
    attributes: {
      'data-handle-index': '$index',
      'role': 'separator',
      'aria-orientation': horizontal ? 'vertical' : 'horizontal',
      'aria-valuenow': '50',
      'tabindex': '0',
    },
    styles: dom.Styles(
      raw: {
        'position': 'relative',
        'flex': '0 0 $size',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'background-color': 'transparent',
        if (horizontal) 'border-left': '1px solid var(--border)',
        if (!horizontal) 'border-top': '1px solid var(--border)',
        'cursor': horizontal ? 'col-resize' : 'row-resize',
        'outline': 'none',
        'z-index': '10',
      },
    ),
    [
      if (showGrip)
        dom.div(
          classes: 'neon-resizable-grip',
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'border-radius': 'var(--radius-xs)',
              'border': '1px solid var(--border)',
              'background': 'var(--muted)',
              'width': horizontal ? '12px' : '18px',
              'height': horizontal ? '18px' : '12px',
            },
          ),
          [
            dom.div(
              styles: dom.Styles(
                raw: {
                  'display': 'flex',
                  'flex-direction': horizontal ? 'column' : 'row',
                  'gap': '2px',
                },
              ),
              [
                for (int i = 0; i < 3; i++)
                  const dom.div(
                    styles: dom.Styles(
                      raw: {
                        'width': '2px',
                        'height': '2px',
                        'border-radius': '50%',
                        'background-color': 'var(--muted-foreground)',
                      },
                    ),
                    [],
                  ),
              ],
            ),
          ],
        ),
    ],
  );
}
