import 'package:arcane_jaspr/component/interactive/disclosure.dart';
import 'package:arcane_jaspr/flutter.dart';

class Expander extends StatelessWidget {
  final Widget header;
  final Widget child;
  final bool open;

  const Expander({
    required this.header,
    required this.child,
    this.open = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      ArcaneDisclosure(summary: header, child: child, open: open);
}
