import 'dart:async';

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

import '../../util/tokens/tokens.dart';

/// Hovercard position relative to the trigger element
enum HovercardPosition {
  /// Above the trigger, centered
  top,

  /// Below the trigger, centered
  bottom,

  /// To the left of the trigger
  left,

  /// To the right of the trigger
  right,

  /// Above and aligned to the start (left in LTR)
  topStart,

  /// Above and aligned to the end (right in LTR)
  topEnd,

  /// Below and aligned to the start
  bottomStart,

  /// Below and aligned to the end
  bottomEnd,
}

/// A floating card that appears on hover with rich, interactive content.
///
/// Unlike tooltips, hovercards can contain interactive elements like buttons
/// and links. The card stays open while the user hovers over either the
/// trigger or the card itself.
///
/// ```dart
/// ArcaneHovercard(
///   trigger: ArcaneAvatar(name: 'John Doe'),
///   content: UserProfileCard(user: user),
///   position: HovercardPosition.bottom,
///   openDelay: 200,
///   closeDelay: 300,
/// )
/// ```
class ArcaneHovercard extends StatefulComponent {
  /// The element that triggers the hovercard on hover
  final Component trigger;

  /// The content displayed inside the hovercard
  final Component content;

  /// Position of the hovercard relative to the trigger
  final HovercardPosition position;

  /// Whether to show an arrow pointing to the trigger
  final bool showArrow;

  /// Delay in milliseconds before showing the hovercard
  final int openDelay;

  /// Delay in milliseconds before hiding the hovercard
  final int closeDelay;

  /// Distance in pixels between the trigger and the hovercard
  final int offset;

  /// External control of the open state (optional)
  final bool? isOpen;

  /// Callback when the open state changes
  final void Function(bool isOpen)? onOpenChange;

  const ArcaneHovercard({
    required this.trigger,
    required this.content,
    this.position = HovercardPosition.top,
    this.showArrow = true,
    this.openDelay = 200,
    this.closeDelay = 300,
    this.offset = 8,
    this.isOpen,
    this.onOpenChange,
    super.key,
  });

  @override
  State<ArcaneHovercard> createState() => _ArcaneHovercardState();
}

class _ArcaneHovercardState extends State<ArcaneHovercard> {
  bool _internalIsOpen = false;
  Timer? _openTimer;
  Timer? _closeTimer;

  bool get _isOpen => component.isOpen ?? _internalIsOpen;

  void _cancelTimers() {
    _openTimer?.cancel();
    _openTimer = null;
    _closeTimer?.cancel();
    _closeTimer = null;
  }

  void _startOpenTimer() {
    _cancelTimers();
    if (component.openDelay <= 0) {
      _open();
    } else {
      _openTimer = Timer(Duration(milliseconds: component.openDelay), _open);
    }
  }

  void _startCloseTimer() {
    _cancelTimers();
    if (component.closeDelay <= 0) {
      _close();
    } else {
      _closeTimer = Timer(Duration(milliseconds: component.closeDelay), _close);
    }
  }

  void _open() {
    if (!_isOpen) {
      if (component.isOpen == null) {
        setState(() => _internalIsOpen = true);
      }
      component.onOpenChange?.call(true);
    }
  }

  void _close() {
    if (_isOpen) {
      if (component.isOpen == null) {
        setState(() => _internalIsOpen = false);
      }
      component.onOpenChange?.call(false);
    }
  }

  void _handleTriggerEnter() {
    _cancelTimers();
    _startOpenTimer();
  }

  void _handleTriggerLeave() {
    _cancelTimers();
    _startCloseTimer();
  }

  (String, String, String?) get _positionStyles {
    final offsetPx = '${component.offset}px';

    return switch (component.position) {
      HovercardPosition.top => (
          'bottom',
          'calc(100% + $offsetPx)',
          'left: 50%; transform: translateX(-50%);'
        ),
      HovercardPosition.bottom => (
          'top',
          'calc(100% + $offsetPx)',
          'left: 50%; transform: translateX(-50%);'
        ),
      HovercardPosition.left => (
          'right',
          'calc(100% + $offsetPx)',
          'top: 50%; transform: translateY(-50%);'
        ),
      HovercardPosition.right => (
          'left',
          'calc(100% + $offsetPx)',
          'top: 50%; transform: translateY(-50%);'
        ),
      HovercardPosition.topStart => (
          'bottom',
          'calc(100% + $offsetPx)',
          'left: 0;'
        ),
      HovercardPosition.topEnd => (
          'bottom',
          'calc(100% + $offsetPx)',
          'right: 0;'
        ),
      HovercardPosition.bottomStart => (
          'top',
          'calc(100% + $offsetPx)',
          'left: 0;'
        ),
      HovercardPosition.bottomEnd => (
          'top',
          'calc(100% + $offsetPx)',
          'right: 0;'
        ),
    };
  }

  String get _arrowPosition => switch (component.position) {
        HovercardPosition.top ||
        HovercardPosition.topStart ||
        HovercardPosition.topEnd =>
          'bottom: -6px; left: 50%; transform: translateX(-50%) rotate(45deg);',
        HovercardPosition.bottom ||
        HovercardPosition.bottomStart ||
        HovercardPosition.bottomEnd =>
          'top: -6px; left: 50%; transform: translateX(-50%) rotate(45deg);',
        HovercardPosition.left =>
          'right: -6px; top: 50%; transform: translateY(-50%) rotate(45deg);',
        HovercardPosition.right =>
          'left: -6px; top: 50%; transform: translateY(-50%) rotate(45deg);',
      };

  Map<String, String> _parseStyleString(String styleString) {
    final result = <String, String>{};
    for (final part in styleString.split(';')) {
      if (part.trim().isNotEmpty && part.contains(':')) {
        final key = part.split(':')[0].trim();
        final value = part.split(':')[1].trim().replaceAll(';', '');
        result[key] = value;
      }
    }
    return result;
  }

  @override
  Component build(BuildContext context) {
    final (positionProp, positionValue, alignment) = _positionStyles;

    // Put mouse events on the outer wrapper so there's no gap between
    // trigger and card that would cause premature closing
    return div(
      styles: const Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
      events: {
        'mouseenter': (_) => _handleTriggerEnter(),
        'mouseleave': (_) => _handleTriggerLeave(),
      },
      [
        // Trigger (no events needed - outer wrapper handles it)
        component.trigger,

        // Hovercard content
        if (_isOpen)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              positionProp: positionValue,
              if (alignment != null) ..._parseStyleString(alignment),
              'z-index': ArcaneZIndex.tooltip,
              'min-width': '200px',
              'background': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.lg,
              'box-shadow': ArcaneEffects.shadowLg,
              'padding': ArcaneSpacing.md,
            }),
            [
              // Arrow
              if (component.showArrow)
                div(
                  styles: Styles(raw: {
                    'position': 'absolute',
                    'width': '12px',
                    'height': '12px',
                    'background': ArcaneColors.surface,
                    'border-left': '1px solid ${ArcaneColors.border}',
                    'border-top': '1px solid ${ArcaneColors.border}',
                    ..._parseStyleString(_arrowPosition),
                  }),
                  [],
                ),

              // Content
              component.content,
            ],
          ),
      ],
    );
  }
}
