import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/button_panel_props.dart';

/// Renders a button panel component.
Component renderButtonPanel(ButtonPanelProps props) {
  final String effectivePadding = props.padding?.padding ?? '8px 0';

  return dom.div(
    classes: 'arcane-button-panel',
    styles: dom.Styles(
      raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'justify-content': props.mainAxisAlignment.css,
        'align-items': 'center',
        'gap': '${props.gap}px',
        'padding': effectivePadding,
      },
    ),
    props.children,
  );
}

/// Renders a toolbar component.
Component renderToolbar(ToolbarProps props) {
  final String effectivePadding = props.padding?.padding ?? '4px 8px';

  return dom.div(
    classes: 'arcane-toolbar',
    styles: dom.Styles(
      raw: {
        'display': 'flex',
        'flex-direction': 'row',
        'justify-content': props.mainAxisAlignment.css,
        'align-items': props.crossAxisAlignment.css,
        'gap': '${props.gap}px',
        'padding': effectivePadding,
        ...?props.decoration?.universalStyles(),
        ...?props.styles?.toMap(),
      },
    ),
    props.children,
  );
}

/// Renders a button group component.
Component renderButtonGroup(ButtonGroupProps props) {
  return dom.div(
    classes: 'arcane-button-group',
    styles: dom.Styles(
      raw: {
        'display': 'flex',
        'flex-direction': props.vertical ? 'column' : 'row',
        if (props.spacing > 0) 'gap': '${props.spacing}px',
      },
    ),
    props.children,
  );
}
