import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/component/typography/text.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class Tile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final String? titleText;
  final String? subtitleText;
  final void Function()? onPressed;
  final String? href;
  final bool selected;
  final bool disabled;

  const Tile({
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: 12,
      children: <Widget>[
        ?leading,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            gap: 4,
            children: <Widget>[
              title ?? (titleText != null ? Text.label(titleText!) : const SizedBox.shrink()),
              ?subtitle,
              if (subtitle == null && subtitleText != null) Text.bodySmall(subtitleText!),
            ],
          ),
        ),
        ?trailing,
      ],
    ),
  );
}
