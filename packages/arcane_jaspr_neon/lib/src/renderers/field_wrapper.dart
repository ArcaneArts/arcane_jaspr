import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/field_wrapper_props.dart';
import 'package:arcane_jaspr/core/rendering/base/field_wrapper_render_base.dart';

/// Neon FieldWrapper renderer.
class NeonFieldWrapper extends FieldWrapperRenderBase {
  const NeonFieldWrapper(super.props, {super.key});

  @override
  String get cssClass => 'neon-field-wrapper';

  @override
  Map<String, String> get wrapperStyles => const <String, String>{
    'display': 'flex',
    'flex-direction': 'column',
    'gap': 'var(--space-2)',
  };

  @override
  Component? buildLabelRow(FieldWrapperProps props, bool hasError) {
    if (props.labelText == null) {
      return null;
    }
    return dom.div(
      classes: 'neon-field-label-row',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-2)',
        },
      ),
      [
        if (props.leading != null) props.leading!,
        dom.label(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
            },
          ),
          [
            Component.text(props.labelText!),
            if (props.required)
              const dom.span(
                styles: dom.Styles(
                  raw: {
                    'color': 'var(--destructive)',
                    'margin-left': '0.25rem',
                  },
                ),
                [Component.text('*')],
              ),
          ],
        ),
        if (props.trailing != null) props.trailing!,
      ],
    );
  }

  @override
  Component? buildDescription(FieldWrapperProps props) {
    if (props.description == null) {
      return null;
    }
    return dom.p(
      classes: 'neon-field-description',
      styles: const dom.Styles(
        raw: {
          'font-size': '0.8125rem',
          'color': 'var(--muted-foreground)',
          'margin': '0',
        },
      ),
      [Component.text(props.description!)],
    );
  }

  @override
  Component buildFieldContent(FieldWrapperProps props) {
    return props.field;
  }

  @override
  Component? buildError(FieldWrapperProps props, bool hasError) {
    if (!(hasError && props.showValidation)) {
      return null;
    }
    return dom.p(
      classes: 'neon-field-error',
      styles: const dom.Styles(
        raw: {
          'font-size': '0.8125rem',
          'color': 'var(--destructive)',
          'margin': '0',
        },
      ),
      [Component.text(props.error!)],
    );
  }
}

/// Neon FormSection renderer.
class NeonFormSection extends FormSectionRenderBase {
  const NeonFormSection(super.props, {super.key});

  @override
  String get headerClass => 'neon-form-section-header';

  @override
  Component buildRoot(List<Component> children) {
    return dom.fieldset(
      classes: 'neon-form-section',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '${props.spacing}px',
          'border': 'none',
          'padding': '0',
          'margin': '0',
        },
      ),
      children,
    );
  }

  @override
  Component buildTitle(FormSectionProps props) {
    return dom.legend(
      styles: const dom.Styles(
        raw: {
          'font-size': 'var(--font-size-base)',
          'font-weight': 'var(--font-weight-semibold)',
          'color': 'var(--foreground)',
          'padding': '0',
        },
      ),
      [Component.text(props.title!)],
    );
  }

  @override
  Component buildDescription(FormSectionProps props) {
    return dom.p(
      styles: const dom.Styles(
        raw: {
          'font-size': 'var(--font-size-sm)',
          'color': 'var(--muted-foreground)',
          'margin': '0.25rem 0 0 0',
        },
      ),
      [Component.text(props.description!)],
    );
  }
}

/// Neon InputGroup renderer.
class NeonInputGroup extends InputGroupRenderBase {
  const NeonInputGroup(super.props, {super.key});

  @override
  String get groupClass => 'neon-input-group';

  @override
  String get itemClass => 'neon-input-group-item';
}
