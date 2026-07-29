import 'package:arcane_jaspr/component/view/progress_bar.dart';
import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/util/style_types/arcane_style_data.dart';

class ArcaneSpinner extends StatelessWidget {
  final String? size;
  final String? color;
  final ArcaneStyleData? styles;
  final ArcaneDecoration? decoration;

  const ArcaneSpinner({
    this.size,
    this.color,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ArcaneLoadingSpinner(
      size: size,
      color: color,
      styles: styles,
      decoration: decoration,
    );
  }
}
