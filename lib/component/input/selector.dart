import 'package:arcane_jaspr/component/input/combobox.dart';
import 'package:arcane_jaspr/flutter.dart';

import '../../core/interaction/interaction.dart';

class Selector<T> extends StatelessWidget {
  final T? value;
  final void Function(T?)? onChanged;
  final List<T> values;
  final String Function(T) labelBuilder;
  final bool canUnselect;
  final String? placeholder;
  final String? id;
  final String? group;
  final ArcaneInteraction? onChangedAction;

  const Selector({
    required this.values,
    required this.labelBuilder,
    this.value,
    this.onChanged,
    this.canUnselect = false,
    this.placeholder,
    this.id,
    this.group,
    this.onChangedAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ArcaneCombobox<T>(
    value: value,
    onChanged: onChanged,
    placeholder: placeholder,
    id: id,
    group: group,
    onChangedAction: onChangedAction,
    options: values
        .map(
          (T entry) =>
              ComboboxOption<T>(value: entry, label: labelBuilder(entry)),
        )
        .toList(),
  );
}
