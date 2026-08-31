import 'package:arcane_jaspr/component/form/field.dart';
import 'package:arcane_jaspr/component/form/field_wrapper.dart';
import 'package:arcane_jaspr/component/form/provider.dart';
import 'package:arcane_jaspr/component/input/date_picker.dart';
import 'package:arcane_jaspr/flutter.dart';

class ArcaneDateField extends StatelessWidget {
  final ArcaneFieldProvider<DateTime> provider;
  final String? name;
  final String? description;

  const ArcaneDateField({
    required this.provider,
    this.name,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ArcaneField<DateTime>(
    meta: ArcaneFieldMetadata(name: name, description: description),
    provider: provider,
    builder:
        (
          BuildContext context,
          DateTime value,
          void Function(DateTime) onChanged,
        ) => ArcaneFieldWrapper(
          labelText: name,
          description: description,
          field: ArcaneDatePicker(
            value: value,
            onChanged: (DateTime? next) =>
                onChanged(next ?? provider.defaultValue),
          ),
        ),
  );
}
