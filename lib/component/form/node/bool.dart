import 'package:arcane_jaspr/component/form/field.dart';
import 'package:arcane_jaspr/component/form/field_wrapper.dart';
import 'package:arcane_jaspr/component/form/provider.dart';
import 'package:arcane_jaspr/component/input/checkbox.dart';
import 'package:arcane_jaspr/flutter.dart';

class ArcaneBoolField extends StatelessWidget {
  final String? name;
  final String? description;
  final ArcaneFieldProvider<bool> provider;

  const ArcaneBoolField({
    required this.provider,
    this.name,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ArcaneField<bool>(
    meta: ArcaneFieldMetadata(name: name, description: description),
    provider: provider,
    builder:
        (BuildContext context, bool value, void Function(bool) onChanged) =>
            ArcaneFieldWrapper(
              labelText: name,
              description: description,
              field: ArcaneCheckbox(checked: value, onChanged: onChanged),
            ),
  );
}
