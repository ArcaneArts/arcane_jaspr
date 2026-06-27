import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/checkbox_props.dart';
import 'package:arcane_jaspr/core/rendering/base/checkbox_render_base.dart';

class NeubrutalismCheckbox extends CheckboxRenderBase {
  const NeubrutalismCheckbox(super.props, {super.key});

  @override
  String wrapperClasses(CheckboxProps props) =>
      'neubrutalism-checkbox-wrapper ${props.disabled ? 'disabled' : ''}';

  @override
  Map<String, String> extraWrapperAttrs(CheckboxProps props) => <String, String>{
    'data-variant': props.color.name,
    'data-size': props.size.name,
  };

  @override
  Map<String, String> wrapperStyles(CheckboxProps props) => <String, String>{
    'display': 'flex',
    'align-items': 'flex-start',
    'gap': '0.625rem',
    'cursor': props.disabled ? 'not-allowed' : 'pointer',
    'opacity': props.disabled ? '0.5' : '1',
    'pointer-events': props.disabled ? 'none' : 'auto',
  };

  @override
  Map<String, String> labelTextStyles(CheckboxProps props) => <String, String>{
    'display': 'block',
    'font-size': 'var(--font-size-sm)',
    'font-weight': '600',
    'color': 'var(--foreground)',
    'line-height': '1.4',
  };

  @override
  Map<String, String> descriptionTextStyles(CheckboxProps props) =>
      <String, String>{
    'display': 'block',
    'font-size': 'var(--font-size-sm)',
    'color': 'var(--foreground)',
    'line-height': '1.4',
    'margin-top': '0.25rem',
  };

  @override
  Component buildBox(CheckboxProps props, Map<String, String> itemAttrs) {
    final String boxSize = switch (props.size) {
      ComponentSize.sm => '20px',
      ComponentSize.md => '24px',
      ComponentSize.lg => '28px',
    };

    final (String tone, String checkColor) = switch (props.color) {
      ColorVariant.primary => (
        'var(--nb-accent, var(--primary))',
        'var(--nb-ink, #000)',
      ),
      ColorVariant.secondary => (
        'var(--nb-accent-cool, var(--secondary))',
        'var(--nb-ink, #000)',
      ),
      ColorVariant.destructive => ('var(--destructive)', '#ffffff'),
      ColorVariant.success => ('var(--success)', 'var(--nb-ink, #000)'),
      ColorVariant.warning => ('var(--warning)', 'var(--nb-ink, #000)'),
      ColorVariant.info => ('var(--info)', '#ffffff'),
    };

    return dom.div(
      classes: 'neubrutalism-checkbox',
      attributes: itemAttrs,
      styles: dom.Styles(
        raw: <String, String>{
          'width': boxSize,
          'height': boxSize,
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'background-color': props.checked ? tone : 'var(--nb-paper, #fff)',
          'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
          'box-shadow': 'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'flex-shrink': '0',
          'transition':
              'transform 120ms cubic-bezier(0.2, 0.8, 0.2, 1), box-shadow 120ms cubic-bezier(0.2, 0.8, 0.2, 1)',
        },
      ),
      <Component>[
        if (props.checked)
          dom.span(
            styles: dom.Styles(
              raw: <String, String>{
                'color': checkColor,
                'font-size': switch (props.size) {
                  ComponentSize.sm => '13px',
                  ComponentSize.md => '15px',
                  ComponentSize.lg => '17px',
                },
                'font-weight': '900',
                'line-height': '1',
              },
            ),
            <Component>[const Component.text('✓')],
          ),
      ],
    );
  }
}
