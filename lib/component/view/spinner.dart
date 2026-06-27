import 'package:arcane_jaspr/flutter.dart';

import 'progress_bar.dart';

class ArcaneSpinner extends StatelessWidget {
  final String? size;
  final String? color;

  const ArcaneSpinner({
    this.size,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ArcaneLoadingSpinner(
      size: size,
      color: color,
    );
  }
}
