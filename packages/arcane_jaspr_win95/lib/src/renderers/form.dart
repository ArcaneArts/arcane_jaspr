import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/field_wrapper_props.dart';

/// Win95 Form renderer.
class Win95Form extends StatelessComponent {
  final FormProps props;

  const Win95Form(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.form(
      classes: 'win95-form',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '${props.spacing}px',
        },
      ),
      events: props.onSubmit != null
          ? {
              'submit': (event) {
                event.preventDefault();
                props.onSubmit!();
              },
            }
          : null,
      [
        // Form fields
        ...props.children,

        // Action buttons
        if (props.showActions)
          dom.div(
            classes: 'win95-form-actions',
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'gap': '0.75rem',
                'margin-top': '0.5rem',
                'justify-content': 'flex-end',
              },
            ),
            [
              if (props.onCancel != null)
                dom.button(
                  classes: 'win95-form-cancel-btn win95-button',
                  attributes: {
                    'type': 'button',
                    'data-variant': 'outline',
                  },
                  styles: const dom.Styles(
                    raw: {
                      'padding': '0.7rem 1.4rem',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--foreground)',
                      'background': 'var(--background)',
                      'border': '1px solid var(--border)',
                      'cursor': 'pointer',
                      'transition':
                          'background 200ms ease, border-color 200ms ease, color 200ms ease',
                    },
                  ),
                  events: {'click': (_) => props.onCancel!()},
                  [Component.text(props.cancelText ?? 'Cancel')],
                ),
              dom.button(
                type: dom.ButtonType.submit,
                classes: 'win95-form-submit-btn win95-button',
                attributes: {'data-variant': 'primary'},
                styles: const dom.Styles(
                  raw: {
                    'padding': '0.7rem 1.4rem',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--primary-foreground)',
                    'background': 'var(--primary)',
                    'border': '1px solid var(--border)',
                    'cursor': 'pointer',
                    'transition': 'background 200ms ease',
                  },
                ),
                [Component.text(props.submitText ?? 'Submit')],
              ),
            ],
          ),
      ],
    );
  }
}
