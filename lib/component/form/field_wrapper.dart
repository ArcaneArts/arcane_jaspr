import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A wrapper widget for form fields providing consistent styling and layout.
///
/// This component displays form field values with metadata such as labels,
/// descriptions, icons, and validation feedback. It integrates with the
/// Arcane form system for a polished user experience.
class ArcaneFieldWrapper extends StatelessComponent {
  /// The form field to wrap.
  final Component field;

  /// Label text for the field.
  final String? labelText;

  /// Description text for the field.
  final String? description;

  /// Icon identifier.
  final String? icon;

  /// Error message to display.
  final String? error;

  /// Whether the field is required.
  final bool required;

  /// Whether to show validation feedback.
  final bool showValidation;

  /// Custom leading widget.
  final Component? leading;

  /// Custom trailing widget.
  final Component? trailing;

  const ArcaneFieldWrapper({
    required this.field,
    this.labelText,
    this.description,
    this.icon,
    this.error,
    this.required = false,
    this.showValidation = true,
    this.leading,
    this.trailing,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;

    return div(
      classes: 'arcane-field-wrapper',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '6px',
        'width': '100%',
      }),
      [
        // Label row
        if (labelText != null || icon != null || required)
          div(
            classes: 'arcane-field-label-row',
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '8px',
            }),
            [
              if (leading != null) leading!,
              if (icon != null)
                span(
                  styles: Styles(raw: {
                    'color': hasError
                        ? 'var(--arcane-error)'
                        : 'var(--arcane-on-surface-variant)',
                    'font-size': '1rem',
                  }),
                  [Component.text(icon!)],
                ),
              if (labelText != null)
                label(
                  classes: 'arcane-field-label',
                  styles: Styles(raw: {
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': hasError
                        ? 'var(--arcane-error)'
                        : 'var(--arcane-on-surface)',
                  }),
                  [
                    Component.text(labelText!),
                    if (required)
                      span(
                        styles: Styles(raw: {
                          'color': 'var(--arcane-error)',
                          'margin-left': '4px',
                        }),
                        [Component.text('*')],
                      ),
                  ],
                ),
              if (trailing != null) trailing!,
            ],
          ),

        // Description
        if (description != null)
          div(
            classes: 'arcane-field-description',
            styles: Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--arcane-on-surface-variant)',
              'line-height': '1.4',
            }),
            [Component.text(description!)],
          ),

        // Field content
        div(
          classes: 'arcane-field-content',
          styles: Styles(raw: {
            'width': '100%',
          }),
          [field],
        ),

        // Error message
        if (hasError && showValidation)
          div(
            classes: 'arcane-field-error',
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '4px',
              'font-size': '0.75rem',
              'color': 'var(--arcane-error)',
            }),
            [
              span([Component.text('!')]),
              Component.text(error!),
            ],
          ),
      ],
    );
  }
}

/// A form section that groups multiple fields together.
class FormSection extends StatelessComponent {
  /// Section title.
  final String? title;

  /// Section description.
  final String? description;

  /// Fields in this section.
  final List<Component> children;

  /// Spacing between fields.
  final double spacing;

  const FormSection({
    this.title,
    this.description,
    required this.children,
    this.spacing = 16,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-form-section',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${spacing}px',
      }),
      [
        if (title != null || description != null)
          div(
            classes: 'arcane-form-section-header',
            styles: Styles(raw: {
              'margin-bottom': '8px',
            }),
            [
              if (title != null)
                div(
                  styles: Styles(raw: {
                    'font-size': '1rem',
                    'font-weight': '600',
                    'color': 'var(--arcane-on-surface)',
                    'margin-bottom': description != null ? '4px' : '0',
                  }),
                  [Component.text(title!)],
                ),
              if (description != null)
                div(
                  styles: Styles(raw: {
                    'font-size': '0.875rem',
                    'color': 'var(--arcane-on-surface-variant)',
                    'line-height': '1.5',
                  }),
                  [Component.text(description!)],
                ),
            ],
          ),
        ...children,
      ],
    );
  }
}

/// A complete form component with built-in state management.
class ArcaneForm extends StatefulComponent {
  /// Form fields.
  final List<Component> children;

  /// Submit button text.
  final String? submitText;

  /// Cancel button text.
  final String? cancelText;

  /// Submit handler.
  final void Function()? onSubmit;

  /// Cancel handler.
  final void Function()? onCancel;

  /// Whether to show action buttons.
  final bool showActions;

  /// Spacing between fields.
  final double spacing;

  const ArcaneForm({
    required this.children,
    this.submitText = 'Submit',
    this.cancelText = 'Cancel',
    this.onSubmit,
    this.onCancel,
    this.showActions = true,
    this.spacing = 16,
    super.key,
  });

  @override
  State<ArcaneForm> createState() => _ArcaneFormState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-form button[type="button"]:hover').styles(
      raw: {
        'background-color': 'var(--arcane-surface-variant)',
      },
    ),
    css('.arcane-form button[type="submit"]:hover').styles(
      raw: {
        'filter': 'brightness(1.1)',
      },
    ),
  ];
}

class _ArcaneFormState extends State<ArcaneForm> {
  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return form(
      classes: 'arcane-form',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${component.spacing}px',
      }),
      events: {
        'submit': (event) {
          event.preventDefault();
          component.onSubmit?.call();
        },
      },
      [
        ...component.children,
        if (component.showActions)
          div(
            classes: 'arcane-form-actions',
            styles: Styles(raw: {
              'display': 'flex',
              'justify-content': 'flex-end',
              'gap': '8px',
              'margin-top': '16px',
              'padding-top': '16px',
              'border-top': '1px solid var(--arcane-outline-variant)',
            }),
            [
              if (component.onCancel != null)
                button(
                  attributes: {'type': 'button'},
                  styles: Styles(raw: {
                    'padding': '10px 20px',
                    'border': '1px solid var(--arcane-outline-variant)',
                    'border-radius': theme.borderRadiusCss,
                    'background-color': 'transparent',
                    'color': 'var(--arcane-on-surface)',
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'cursor': 'pointer',
                    'transition': 'all 150ms ease',
                  }),
                  events: {
                    'click': (_) => component.onCancel?.call(),
                  },
                  [Component.text(component.cancelText!)],
                ),
              button(
                attributes: {'type': 'submit'},
                styles: Styles(raw: {
                  'padding': '10px 20px',
                  'border': 'none',
                  'border-radius': theme.borderRadiusCss,
                  'background-color': 'var(--arcane-primary)',
                  'color': 'var(--arcane-on-primary)',
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                }),
                [Component.text(component.submitText!)],
              ),
            ],
          ),
      ],
    );
  }
}

/// An input group that combines multiple inputs in a row.
class InputGroup extends StatelessComponent {
  /// Children inputs.
  final List<Component> children;

  /// Gap between inputs.
  final double gap;

  const InputGroup({
    required this.children,
    this.gap = 8,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-input-group',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '${gap}px',
      }),
      children,
    );
  }
}
