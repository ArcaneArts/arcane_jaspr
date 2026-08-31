import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;

class Carpet extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final double minItemWidth;

  const Carpet({
    required this.children,
    this.gap = 16,
    this.minItemWidth = 240,
    super.key,
  });

  @override
  Widget build(BuildContext context) => dom.div(
    styles: dom.Styles(
      raw: <String, String>{
        'display': 'grid',
        'gap': '${gap}px',
        'grid-template-columns':
            'repeat(auto-fit, minmax(${minItemWidth}px, 1fr))',
      },
    ),
    children,
  );
}
