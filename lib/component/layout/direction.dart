import 'package:arcane_jaspr/flutter.dart';

import '../../util/classes.dart';
import '../../core/theme_provider.dart';

enum ArcaneDirectionValue { ltr, rtl, auto }

class ArcaneDirection extends StatelessWidget {
  final ArcaneDirectionValue value;
  final List<Widget> children;
  final List<String>? classes;

  const ArcaneDirection({
    required this.children,
    this.value = ArcaneDirectionValue.ltr,
    this.classes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DirectionValue mappedValue = switch (value) {
      ArcaneDirectionValue.ltr => DirectionValue.ltr,
      ArcaneDirectionValue.rtl => DirectionValue.rtl,
      ArcaneDirectionValue.auto => DirectionValue.auto,
    };

    return context.renderers.direction(
      DirectionProps(
        value: mappedValue,
        children: children,
        classes: classes == null ? null : cx(classes!),
      ),
    );
  }
}
