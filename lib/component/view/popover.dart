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

/// Popover position
enum PopoverPosition {
  /// Above the trigger
  top,

  /// Below the trigger
  bottom,

  /// To the left of the trigger
  left,

  /// To the right of the trigger
  right,

  /// Above and to the start (left in LTR)
  topStart,

  /// Above and to the end (right in LTR)
  topEnd,

  /// Below and to the start
  bottomStart,

  /// Below and to the end
  bottomEnd,
}

/// Popover trigger type
enum PopoverTrigger {
  /// Trigger on click
  click,

  /// Trigger on hover
  hover,

  /// Manual control only
  manual,
}

/// Popover component
///
/// A floating content panel that appears relative to a trigger element.
///
/// ```dart
/// ArcanePopover(
///   trigger: ArcaneButton(label: 'Open Menu'),
///   content: MenuContent(),
///   position: PopoverPosition.bottomStart,
/// )
/// ```
class ArcanePopover extends StatefulComponent {
  /// Trigger element
  final Component trigger;

  /// Popover content
  final Component content;

  /// Position relative to trigger
  final PopoverPosition position;

  /// Trigger behavior
  final PopoverTrigger triggerType;

  /// Whether popover is open (for manual control)
  final bool? isOpen;

  /// Callback when popover opens/closes
  final void Function(bool isOpen)? onOpenChange;

  /// Whether to show arrow
  final bool showArrow;

  /// Close on outside click
  final bool closeOnOutsideClick;

  /// Close on escape key
  final bool closeOnEscape;

  /// Custom offset from trigger in pixels
  final int offset;

  /// Delay in milliseconds before opening (for hover trigger)
  final int openDelay;

  /// Delay in milliseconds before closing (for hover trigger)
  final int closeDelay;

  const ArcanePopover({
    required this.trigger,
    required this.content,
    this.position = PopoverPosition.bottom,
    this.triggerType = PopoverTrigger.click,
    this.isOpen,
    this.onOpenChange,
    this.showArrow = true,
    this.closeOnOutsideClick = true,
    this.closeOnEscape = true,
    this.offset = 8,
    this.openDelay = 0,
    this.closeDelay = 0,
    super.key,
  });

  @override
  State<ArcanePopover> createState() => _ArcanePopoverState();
}

class _ArcanePopoverState extends State<ArcanePopover> {
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

  void _toggle() {
    _cancelTimers();
    final newState = !_isOpen;
    if (component.isOpen == null) {
      setState(() => _internalIsOpen = newState);
    }
    component.onOpenChange?.call(newState);
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
      PopoverPosition.top => (
          'bottom',
          'calc(100% + $offsetPx)',
          'left: 50%; transform: translateX(-50%);'
        ),
      PopoverPosition.bottom => (
          'top',
          'calc(100% + $offsetPx)',
          'left: 50%; transform: translateX(-50%);'
        ),
      PopoverPosition.left => (
          'right',
          'calc(100% + $offsetPx)',
          'top: 50%; transform: translateY(-50%);'
        ),
      PopoverPosition.right => (
          'left',
          'calc(100% + $offsetPx)',
          'top: 50%; transform: translateY(-50%);'
        ),
      PopoverPosition.topStart => (
          'bottom',
          'calc(100% + $offsetPx)',
          'left: 0;'
        ),
      PopoverPosition.topEnd => (
          'bottom',
          'calc(100% + $offsetPx)',
          'right: 0;'
        ),
      PopoverPosition.bottomStart => (
          'top',
          'calc(100% + $offsetPx)',
          'left: 0;'
        ),
      PopoverPosition.bottomEnd => (
          'top',
          'calc(100% + $offsetPx)',
          'right: 0;'
        ),
    };
  }

  String get _arrowPosition => switch (component.position) {
        PopoverPosition.top ||
        PopoverPosition.topStart ||
        PopoverPosition.topEnd =>
          'bottom: -6px; left: 50%; transform: translateX(-50%) rotate(45deg);',
        PopoverPosition.bottom ||
        PopoverPosition.bottomStart ||
        PopoverPosition.bottomEnd =>
          'top: -6px; left: 50%; transform: translateX(-50%) rotate(45deg);',
        PopoverPosition.left =>
          'right: -6px; top: 50%; transform: translateY(-50%) rotate(45deg);',
        PopoverPosition.right =>
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

    // For hover trigger, put events on outer wrapper to avoid gap issues
    // For click/manual, use the inner wrapper approach
    final useOuterEvents = component.triggerType == PopoverTrigger.hover;

    return div(
      styles: const Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
      events: useOuterEvents
          ? {
              'mouseenter': (_) => _handleTriggerEnter(),
              'mouseleave': (_) => _handleTriggerLeave(),
            }
          : null,
      [
        // Trigger wrapper (click events need to be on inner wrapper)
        if (!useOuterEvents && component.triggerType == PopoverTrigger.click)
          div(
            styles: const Styles(raw: {
              'display': 'inline-block',
            }),
            events: {'click': (_) => _toggle()},
            [component.trigger],
          )
        else
          component.trigger,

        // Popover content
        if (_isOpen)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              positionProp: positionValue,
              if (alignment != null) ..._parseStyleString(alignment),
              'z-index': ArcaneZIndex.popover,
              'min-width': '180px',
              'background': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.lg,
              'box-shadow': ArcaneEffects.shadowLg,
              'padding': ArcaneSpacing.sm,
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
