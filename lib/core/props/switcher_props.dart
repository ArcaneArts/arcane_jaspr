import 'package:arcane_jaspr/flutter.dart';

enum SwitcherDirection {
  up,
  down,
  left,
  right,
  fade,
}

/// Switcher component properties.
class SwitcherProps {
  final int index;
  final SwitcherDirection direction;
  final List<Widget> children;
  final int duration;

  const SwitcherProps({
    required this.index,
    required this.children,
    this.direction = SwitcherDirection.fade,
    this.duration = 300,
  });
}

/// Indexed stack component properties.
class IndexedStackProps {
  final int index;
  final List<Widget> children;

  const IndexedStackProps({
    required this.index,
    required this.children,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for switcher components.
mixin SwitcherRendererContract {
  Widget switcher(SwitcherProps props);
  Widget indexedStack(IndexedStackProps props);
}
