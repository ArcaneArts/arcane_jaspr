import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

/// Direction for switcher animation
enum SwitcherDirection {
  /// Slide up
  up,

  /// Slide down
  down,

  /// Slide left
  left,

  /// Slide right
  right,

  /// Fade in/out (no slide)
  fade,
}

/// Animated content switcher that transitions between children.
///
/// Use for wizards, step transitions, and content swaps.
///
/// ```dart
/// ArcaneSwitcher(
///   index: currentIndex,
///   direction: SwitcherDirection.left,
///   children: [
///     StepOne(),
///     StepTwo(),
///     StepThree(),
///   ],
/// )
/// ```
class ArcaneSwitcher extends StatelessComponent {
  /// Currently visible child index
  final int index;

  /// Animation direction when transitioning
  final SwitcherDirection direction;

  /// Children to switch between
  final List<Component> children;

  /// Animation duration in milliseconds
  final int duration;

  /// Callback when index changes (for controlled mode)
  final void Function(int)? onIndexChanged;

  const ArcaneSwitcher({
    required this.index,
    required this.children,
    this.direction = SwitcherDirection.fade,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  });

  /// Horizontal slide (left)
  const ArcaneSwitcher.horizontal({
    required this.index,
    required this.children,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  }) : direction = SwitcherDirection.left;

  /// Vertical slide (up)
  const ArcaneSwitcher.vertical({
    required this.index,
    required this.children,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  }) : direction = SwitcherDirection.up;

  /// Fade transition
  const ArcaneSwitcher.fade({
    required this.index,
    required this.children,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  }) : direction = SwitcherDirection.fade;

  String get _transformAxis => switch (direction) {
        SwitcherDirection.up || SwitcherDirection.down => 'Y',
        SwitcherDirection.left || SwitcherDirection.right => 'X',
        SwitcherDirection.fade => '',
      };

  @override
  Component build(BuildContext context) {
    if (children.isEmpty) return const div([], styles: Styles(raw: {}));

    final safeIndex = index.clamp(0, children.length - 1);

    return div(
      classes: 'arcane-switcher',
      attributes: {
        'data-switcher': 'true',
        'data-index': '$safeIndex',
        'data-direction': direction.name,
      },
      styles: Styles(raw: {
        'position': 'relative',
        'overflow': 'hidden',
        'width': '100%',
      }),
      [
        // Render all children but only show current
        for (var i = 0; i < children.length; i++)
          div(
            classes: 'arcane-switcher-item ${i == safeIndex ? 'active' : ''}',
            styles: Styles(raw: {
              'width': '100%',
              if (i != safeIndex) ...{
                'position': 'absolute',
                'top': '0',
                'left': '0',
                'opacity': '0',
                'pointer-events': 'none',
                if (direction != SwitcherDirection.fade)
                  'transform': i < safeIndex
                      ? 'translate$_transformAxis(-100%)'
                      : 'translate$_transformAxis(100%)',
              } else ...{
                'opacity': '1',
                'transform': 'none',
              },
              'transition':
                  'opacity ${duration}ms ease, transform ${duration}ms ease',
            }),
            [children[i]],
          ),
      ],
    );
  }
}

/// A keyed switcher that uses keys to determine which child to show.
///
/// Useful when children are dynamically generated and may change.
///
/// ```dart
/// ArcaneKeyedSwitcher<String>(
///   currentKey: selectedTab,
///   children: {
///     'home': HomeContent(),
///     'profile': ProfileContent(),
///     'settings': SettingsContent(),
///   },
/// )
/// ```
class ArcaneKeyedSwitcher<T> extends StatelessComponent {
  /// Currently active key
  final T currentKey;

  /// Map of keys to children
  final Map<T, Component> children;

  /// Animation direction
  final SwitcherDirection direction;

  /// Animation duration in milliseconds
  final int duration;

  /// Fallback component if key not found
  final Component? fallback;

  const ArcaneKeyedSwitcher({
    required this.currentKey,
    required this.children,
    this.direction = SwitcherDirection.fade,
    this.duration = 300,
    this.fallback,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final keys = children.keys.toList();
    final currentIndex = keys.indexOf(currentKey);

    if (currentIndex == -1) {
      return fallback ?? const div([], styles: Styles(raw: {}));
    }

    return ArcaneSwitcher(
      index: currentIndex,
      direction: direction,
      duration: duration,
      children: children.values.toList(),
    );
  }
}

/// An indexed stack that preserves state of all children.
///
/// Unlike Switcher which transitions, this simply hides/shows.
///
/// ```dart
/// ArcaneIndexedStack(
///   index: currentTab,
///   children: [
///     HeavyWidget1(),
///     HeavyWidget2(),
///     HeavyWidget3(),
///   ],
/// )
/// ```
class ArcaneIndexedStack extends StatelessComponent {
  /// Currently visible child index
  final int index;

  /// All children (all kept in DOM, only one visible)
  final List<Component> children;

  /// Whether to use lazy loading (only render visited children)
  final bool lazy;

  const ArcaneIndexedStack({
    required this.index,
    required this.children,
    this.lazy = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (children.isEmpty) return const div([], styles: Styles(raw: {}));

    final safeIndex = index.clamp(0, children.length - 1);

    return div(
      classes: 'arcane-indexed-stack',
      styles: const Styles(raw: {
        'position': 'relative',
        'width': '100%',
      }),
      [
        for (var i = 0; i < children.length; i++)
          div(
            classes: 'arcane-indexed-stack-item',
            styles: Styles(raw: {
              'width': '100%',
              if (i != safeIndex) ...{
                'display': 'none',
              },
            }),
            [children[i]],
          ),
      ],
    );
  }
}
