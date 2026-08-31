import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/flutter.dart';

class Tile extends StatelessWidget {
  final ArcaneGlyph? leading;
  final String? titleText;
  final String? subtitleText;
  final void Function()? onPressed;
  final String? href;
  final bool selected;
  final bool disabled;

  const Tile({
    this.leading,
    this.titleText,
    this.subtitleText,
    this.onPressed,
    this.href,
    this.selected = false,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Button.ghost(
    onPressed: disabled ? null : onPressed,
    href: disabled ? null : href,
    fullWidth: true,
    icon: leading,
    label: titleText == null
        ? subtitleText
        : subtitleText == null
        ? titleText
        : '$titleText - $subtitleText',
  );
}
