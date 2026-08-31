import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;

enum GestureType { press, secondaryPress, doublePress, longPress }

class OnHover extends StatelessWidget {
  final void Function(bool hovering) action;
  final Widget child;

  const OnHover({required this.action, required this.child, super.key});

  @override
  Widget build(BuildContext context) => dom.div(
    events: <String, dynamic Function(dynamic)>{
      'mouseenter': (dynamic event) {
        action(true);
        return null;
      },
      'mouseleave': (dynamic event) {
        action(false);
        return null;
      },
    },
    <Widget>[child],
  );
}

class OnGesture extends StatelessWidget {
  final GestureType type;
  final Widget child;
  final void Function() action;

  const OnGesture({
    required this.type,
    required this.child,
    required this.action,
    super.key,
  });

  const OnGesture.press({required this.child, required this.action, super.key})
    : type = GestureType.press;

  const OnGesture.secondaryPress({
    required this.child,
    required this.action,
    super.key,
  }) : type = GestureType.secondaryPress;

  const OnGesture.doublePress({
    required this.child,
    required this.action,
    super.key,
  }) : type = GestureType.doublePress;

  const OnGesture.longPress({
    required this.child,
    required this.action,
    super.key,
  }) : type = GestureType.longPress;

  @override
  Widget build(BuildContext context) => dom.div(
    events: <String, dynamic Function(dynamic)>{
      switch (type) {
        GestureType.secondaryPress => 'contextmenu',
        GestureType.doublePress => 'dblclick',
        GestureType.longPress => 'pointerdown',
        _ => 'click',
      }: (dynamic event) {
        action();
        return null;
      },
    },
    <Widget>[child],
  );
}
