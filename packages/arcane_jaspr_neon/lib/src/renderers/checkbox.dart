import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/checkbox_props.dart';
import 'package:arcane_jaspr/core/rendering/base/checkbox_render_base.dart';

/// Neon checkbox renderer (neutralized skeleton).
class NeonCheckbox extends CheckboxRenderBase {
  const NeonCheckbox(super.props, {super.key});

  @override
  String wrapperClasses(CheckboxProps props) =>
      'neon-checkbox-wrapper ${props.disabled ? 'disabled' : ''}';

  @override
  Map<String, String> extraWrapperAttrs(CheckboxProps props) => <String, String>{
    'data-variant': props.color.name,
    'data-size': props.size.name,
  };

  @override
  Map<String, String> wrapperStyles(CheckboxProps props) =>
      const <String, String>{};

  @override
  Map<String, String> labelTextStyles(CheckboxProps props) =>
      const <String, String>{};

  @override
  Map<String, String> descriptionTextStyles(CheckboxProps props) =>
      const <String, String>{};

  @override
  Component buildBox(CheckboxProps props, Map<String, String> itemAttrs) =>
      dom.div(
        classes: 'neon-checkbox-box',
        attributes: itemAttrs,
        styles: dom.Styles(
          raw: <String, String>{
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            ...?props.decoration?.universalStyles(),
            ...decorationStyles(props.decoration),
            ...?props.styles?.toMap(),
          },
        ),
        <Component>[if (props.checked) const Component.text('x')],
      );
}
