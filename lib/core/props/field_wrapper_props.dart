import 'package:arcane_jaspr/flutter.dart';

/// Field wrapper component properties.
class FieldWrapperProps {
  final Widget field;
  final String? labelText;
  final String? description;
  final String? icon;
  final String? error;
  final bool required;
  final bool showValidation;
  final Widget? leading;
  final Widget? trailing;

  const FieldWrapperProps({
    required this.field,
    this.labelText,
    this.description,
    this.icon,
    this.error,
    this.required = false,
    this.showValidation = true,
    this.leading,
    this.trailing,
  });
}

/// Form section component properties.
class FormSectionProps {
  final String? title;
  final String? description;
  final List<Widget> children;
  final double spacing;

  const FormSectionProps({
    this.title,
    this.description,
    required this.children,
    this.spacing = 16,
  });
}

/// Form component properties.
class FormProps {
  final List<Widget> children;
  final String? submitText;
  final String? cancelText;
  final void Function()? onSubmit;
  final void Function()? onCancel;
  final bool showActions;
  final double spacing;

  const FormProps({
    required this.children,
    this.submitText = 'Submit',
    this.cancelText = 'Cancel',
    this.onSubmit,
    this.onCancel,
    this.showActions = true,
    this.spacing = 16,
  });
}

/// Input group component properties.
class InputGroupProps {
  final List<Widget> children;
  final double gap;

  const InputGroupProps({
    required this.children,
    this.gap = 8,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for field wrapper components.
mixin FieldWrapperRendererContract {
  Widget fieldWrapper(FieldWrapperProps props);
  Widget formSection(FormSectionProps props);
  Widget form(FormProps props);
  Widget inputGroup(InputGroupProps props);
}
