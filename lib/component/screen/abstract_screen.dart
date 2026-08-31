import 'package:arcane_jaspr/component/view/bar.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/component/screen/fill_screen.dart';

class Screen extends StatelessWidget {
  final Widget child;
  final Widget? sidebar;
  final Widget? header;
  final Widget? footer;
  final Widget? fab;
  final Widget? foreground;
  final Widget? background;
  final bool gutter;
  final String? title;
  final String? subtitle;
  final List<Widget> actions;
  final BarBackButtonMode backButtonMode;
  final void Function()? onBack;

  const Screen({
    this.child = const SizedBox.shrink(),
    this.sidebar,
    this.header,
    this.footer,
    this.fab,
    this.foreground,
    this.background,
    this.gutter = true,
    this.title,
    this.subtitle,
    this.actions = const <Widget>[],
    this.backButtonMode = BarBackButtonMode.never,
    this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FillScreen(
    sidebar: sidebar,
    header:
        header ??
        ((title != null || subtitle != null || actions.isNotEmpty)
            ? Bar(
                titleText: title,
                subtitleText: subtitle,
                trailing: actions,
                backButton: backButtonMode,
                onBack: onBack,
              )
            : null),
    footer: footer,
    fab: fab,
    foreground: foreground,
    background: background,
    gutter: gutter,
    child: child,
  );
}

abstract class AbstractStatelessScreen extends StatelessWidget {
  final Widget? header;
  final Widget? footer;
  final Widget? fab;
  final Widget? foreground;
  final Widget? background;
  final bool gutter;

  const AbstractStatelessScreen({
    this.header,
    this.footer,
    this.fab,
    this.foreground,
    this.background,
    this.gutter = true,
    super.key,
  });
}

abstract class AbstractStatefulScreen extends StatefulWidget {
  final Widget? header;
  final Widget? footer;
  final Widget? fab;
  final Widget? foreground;
  final Widget? background;
  final bool gutter;

  const AbstractStatefulScreen({
    this.header,
    this.footer,
    this.fab,
    this.foreground,
    this.background,
    this.gutter = true,
    super.key,
  });
}
