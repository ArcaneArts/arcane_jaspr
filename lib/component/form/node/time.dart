import 'package:arcane_jaspr/component/form/field.dart';
import 'package:arcane_jaspr/component/form/field_wrapper.dart';
import 'package:arcane_jaspr/component/form/provider.dart';
import 'package:arcane_jaspr/component/input/time_picker.dart';
import 'package:arcane_jaspr/flutter.dart';

class ArcaneTimeField extends StatelessWidget {
  final ArcaneFieldProvider<TimeOfDay> provider;
  final String? name;
  final String? description;

  const ArcaneTimeField({
    required this.provider,
    this.name,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ArcaneField<TimeOfDay>(
    meta: ArcaneFieldMetadata(name: name, description: description),
    provider: provider,
    builder:
        (
          BuildContext context,
          TimeOfDay value,
          void Function(TimeOfDay) onChanged,
        ) => ArcaneFieldWrapper(
          labelText: name,
          description: description,
          field: ArcaneTimePicker(
            value: value,
            onChanged: (TimeOfDay? next) =>
                onChanged(next ?? provider.defaultValue),
          ),
        ),
  );
}
