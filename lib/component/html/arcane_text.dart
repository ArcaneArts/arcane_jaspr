import 'package:jaspr/jaspr.dart';

/// A simple text component that renders plain text content.
///
/// This is a thin wrapper around `Component.text()` that provides
/// a more Flutter-like API.
///
/// Example:
/// ```dart
/// ArcaneText('Hello World')
/// ```
class ArcaneText extends StatelessComponent {
  /// The text content to display
  final String text;

  const ArcaneText(this.text, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.text(text);
  }
}
