import 'package:arcane_jaspr/flutter.dart';

enum DirectionValue { ltr, rtl, auto }

class DirectionProps {
  final DirectionValue value;
  final List<Widget> children;
  final String? classes;

  const DirectionProps({
    required this.children,
    this.value = DirectionValue.ltr,
    this.classes,
  });

  DirectionProps copyWith({
    DirectionValue? value,
    List<Widget>? children,
    String? classes,
  }) {
    return DirectionProps(
      value: value ?? this.value,
      children: children ?? this.children,
      classes: classes ?? this.classes,
    );
  }
}

mixin DirectionRendererContract {
  Widget direction(DirectionProps props);
}
