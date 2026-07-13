import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/button_panel_props.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class Win95ButtonPanel extends StatelessComponent {
  final ButtonPanelProps props;

  const Win95ButtonPanel(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String padding = props.padding?.padding ?? '8px 0';
    return dom.div(
      classes: 'win95-button-panel',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-wrap': props.responsive ? 'wrap' : 'nowrap',
          'justify-content': _mainAlign(props.mainAxisAlignment),
          'align-items': 'center',
          'gap': '${props.gap}px',
          'padding': padding,
        },
      ),
      props.children,
    );
  }
}

class Win95Toolbar extends StatelessComponent {
  final ToolbarProps props;

  const Win95Toolbar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String padding = props.padding?.padding ?? '6px 10px';
    return dom.div(
      classes: 'win95-toolbar',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'row',
          'justify-content': _mainAlign(props.mainAxisAlignment),
          'align-items': _crossAlign(props.crossAxisAlignment),
          'gap': '${props.gap}px',
          'padding': padding,
          'border': '1px solid var(--border)',
          'background': 'var(--background)',
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      props.children,
    );
  }
}

class Win95ButtonGroup extends StatelessComponent {
  final ButtonGroupProps props;

  const Win95ButtonGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'win95-button-group',
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
}

String _mainAlign(MainAxisAlignment alignment) {
  return switch (alignment) {
    MainAxisAlignment.start => 'flex-start',
    MainAxisAlignment.end => 'flex-end',
    MainAxisAlignment.center => 'center',
    MainAxisAlignment.spaceBetween => 'space-between',
    MainAxisAlignment.spaceAround => 'space-around',
    MainAxisAlignment.spaceEvenly => 'space-evenly',
  };
}

String _crossAlign(CrossAxisAlignment alignment) {
  return switch (alignment) {
    CrossAxisAlignment.start => 'flex-start',
    CrossAxisAlignment.end => 'flex-end',
    CrossAxisAlignment.center => 'center',
    CrossAxisAlignment.stretch => 'stretch',
    CrossAxisAlignment.baseline => 'baseline',
  };
}
