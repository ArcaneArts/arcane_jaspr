import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/button_panel_props.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class NeubrutalismButtonPanel extends StatelessComponent {
  final ButtonPanelProps props;

  const NeubrutalismButtonPanel(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String padding = props.padding?.padding ?? '8px 0';
    return dom.div(
      classes: 'neubrutalism-button-panel',
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

class NeubrutalismToolbar extends StatelessComponent {
  final ToolbarProps props;

  const NeubrutalismToolbar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String padding = props.padding?.padding ?? '6px 10px';
    return dom.div(
      classes: 'neubrutalism-toolbar',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'row',
          'justify-content': _mainAlign(props.mainAxisAlignment),
          'align-items': _crossAlign(props.crossAxisAlignment),
          'gap': '${props.gap}px',
          'padding': padding,
          'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'background': 'var(--nb-paper, var(--card))',
          'box-shadow':
              'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      props.children,
    );
  }
}

class NeubrutalismButtonGroup extends StatelessComponent {
  final ButtonGroupProps props;

  const NeubrutalismButtonGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-button-group',
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
