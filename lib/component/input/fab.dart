import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class FabSocket extends StatelessWidget {
  final Widget child;

  const FabSocket({required this.child, super.key});

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.bottomRight,
    child: Padding(padding: const EdgeInsets.all(16), child: child),
  );
}

class Fab extends StatelessWidget {
  final String? label;
  final ArcaneGlyph icon;
  final void Function()? onPressed;
  final ArcaneInteraction? action;
  final String? href;

  const Fab({
    required this.icon,
    this.label,
    this.onPressed,
    this.action,
    this.href,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Button.primary(
    onPressed: onPressed,
    action: action,
    href: href,
    icon: icon,
    label: label,
  );
}
