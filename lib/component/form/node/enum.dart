import 'package:arcane_jaspr/component/form/field.dart';
import 'package:arcane_jaspr/component/form/field_wrapper.dart';
import 'package:arcane_jaspr/component/form/provider.dart';
import 'package:arcane_jaspr/component/input/selector.dart';
import 'package:arcane_jaspr/flutter.dart';

class ArcaneEnumField<T> extends StatelessWidget {
  final ArcaneFieldProvider<T> provider;
  final List<T> options;
  final String? name;
  final String? description;
  final String Function(T)? labelBuilder;

  const ArcaneEnumField({
    required this.provider,
    required this.options,
    this.name,
    this.description,
    this.labelBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ArcaneField<T>(
    meta: ArcaneFieldMetadata(name: name, description: description),
    provider: provider,
    builder: (BuildContext context, T value, void Function(T) onChanged) =>
        ArcaneFieldWrapper(
          labelText: name,
          description: description,
          field: Selector<T>(
            value: value,
            values: options,
            onChanged: (T? next) {
              if (next != null) {
                onChanged(next);
              }
            },
            labelBuilder: labelBuilder ?? (T entry) => entry.toString(),
          ),
        ),
  );
}
