import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/checkbox_props.dart';
import 'package:arcane_jaspr/core/rendering/base/checkbox_render_base.dart';

/// Neon checkbox renderer with restrained dark styling.
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
  Map<String, String> wrapperStyles(CheckboxProps props) => <String, String>{
    'display': 'flex',
    'align-items': 'flex-start',
    'gap': '0.875rem',
    'cursor': props.disabled ? 'not-allowed' : 'pointer',
    'opacity': props.disabled ? '0.5' : '1',
    'pointer-events': props.disabled ? 'none' : 'auto',
  };

  @override
  Map<String, String> labelTextStyles(CheckboxProps props) => <String, String>{
    'display': 'block',
    'font-size': 'var(--font-size-sm)',
    'font-weight': 'var(--font-weight-medium)',
    'color': 'var(--foreground)',
    'line-height': '1.4',
  };

  @override
  Map<String, String> descriptionTextStyles(CheckboxProps props) =>
      <String, String>{
    'display': 'block',
    'font-size': 'var(--font-size-sm)',
    'color': 'var(--muted-foreground)',
    'line-height': '1.4',
    'margin-top': '0.25rem',
  };

  @override
  Component buildBox(CheckboxProps props, Map<String, String> itemAttrs) {
    final String boxSize = switch (props.size) {
      ComponentSize.sm => '18px',
      ComponentSize.md => '22px',
      ComponentSize.lg => '26px',
    };

    final (String tone, String checkColor) = switch (props.color) {
      ColorVariant.primary => ('var(--neon-accent)', 'var(--neon-on-accent)'),
      ColorVariant.secondary => (
        'var(--secondary)',
        'var(--secondary-foreground)',
      ),
      ColorVariant.destructive => ('var(--destructive)', '#ffffff'),
      ColorVariant.success => ('var(--success)', '#ffffff'),
      ColorVariant.warning => ('var(--warning)', '#111111'),
      ColorVariant.info => ('var(--info)', '#ffffff'),
    };

    return dom.div(
      classes: 'neon-checkbox-box',
      attributes: itemAttrs,
      styles: dom.Styles(
        raw: <String, String>{
          'width': boxSize,
          'height': boxSize,
          'border-radius': 'calc(var(--radius-sm) - 1px)',
          'background': props.checked
              ? 'linear-gradient(180deg, color-mix(in srgb, $tone 82%, #0d1110), $tone)'
              : 'var(--neon-surface-1)',
          'border': props.checked
              ? '1px solid color-mix(in srgb, $tone 42%, var(--border))'
              : '1px solid var(--border)',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'flex-shrink': '0',
          'transition':
              'background 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease',
          'box-shadow': props.checked
              ? '0 10px 20px rgba(0, 0, 0, 0.28)'
              : 'none',
        },
      ),
      <Component>[
        if (props.checked)
          dom.span(
            styles: dom.Styles(
              raw: <String, String>{
                'color': checkColor,
                'font-size': switch (props.size) {
                  ComponentSize.sm => '11px',
                  ComponentSize.md => '13px',
                  ComponentSize.lg => '15px',
                },
                'font-weight': '700',
                'line-height': '1',
              },
            ),
            <Component>[const Component.text('✓')],
          ),
      ],
    );
  }
}
