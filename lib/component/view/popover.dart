import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

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

  /// Custom offset from trigger
  final int offset;

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
    super.key,
  });

  @override
  State<ArcanePopover> createState() => _ArcanePopoverState();
}

class _ArcanePopoverState extends State<ArcanePopover> {
  bool _internalIsOpen = false;

  bool get _isOpen => component.isOpen ?? _internalIsOpen;

  void _toggle() {
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

  (String, String, String?) get _positionStyles {
    const offset = '8px';

    return switch (component.position) {
      PopoverPosition.top => ('bottom', 'calc(100% + $offset)', 'left: 50%; transform: translateX(-50%);'),
      PopoverPosition.bottom => ('top', 'calc(100% + $offset)', 'left: 50%; transform: translateX(-50%);'),
      PopoverPosition.left => ('right', 'calc(100% + $offset)', 'top: 50%; transform: translateY(-50%);'),
      PopoverPosition.right => ('left', 'calc(100% + $offset)', 'top: 50%; transform: translateY(-50%);'),
      PopoverPosition.topStart => ('bottom', 'calc(100% + $offset)', 'left: 0;'),
      PopoverPosition.topEnd => ('bottom', 'calc(100% + $offset)', 'right: 0;'),
      PopoverPosition.bottomStart => ('top', 'calc(100% + $offset)', 'left: 0;'),
      PopoverPosition.bottomEnd => ('top', 'calc(100% + $offset)', 'right: 0;'),
    };
  }

  String get _arrowPosition => switch (component.position) {
        PopoverPosition.top || PopoverPosition.topStart || PopoverPosition.topEnd =>
          'bottom: -6px; left: 50%; transform: translateX(-50%) rotate(45deg);',
        PopoverPosition.bottom || PopoverPosition.bottomStart || PopoverPosition.bottomEnd =>
          'top: -6px; left: 50%; transform: translateX(-50%) rotate(45deg);',
        PopoverPosition.left =>
          'right: -6px; top: 50%; transform: translateY(-50%) rotate(45deg);',
        PopoverPosition.right =>
          'left: -6px; top: 50%; transform: translateY(-50%) rotate(45deg);',
      };

  @override
  Component build(BuildContext context) {
    final (positionProp, positionValue, alignment) = _positionStyles;

    return div(
      styles: const Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
      [
        // Trigger wrapper
        div(
          styles: const Styles(raw: {
            'display': 'inline-block',
          }),
          events: switch (component.triggerType) {
            PopoverTrigger.click => {'click': (_) => _toggle()},
            PopoverTrigger.hover => {
                'mouseenter': (_) => _open(),
                'mouseleave': (_) => _close(),
              },
            PopoverTrigger.manual => null,
          },
          [component.trigger],
        ),

        // Popover content
        if (_isOpen)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              positionProp: positionValue,
              if (alignment != null) ...{
                for (final part in alignment.split(';'))
                  if (part.trim().isNotEmpty && part.contains(':'))
                    part.split(':')[0].trim(): part.split(':')[1].trim().replaceAll(';', ''),
              },
              'z-index': '1060',
              'min-width': '180px',
              'background': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.lg,
              'box-shadow': ArcaneEffects.shadowLg,
              'padding': ArcaneSpacing.sm,
            }),
            events: component.triggerType == PopoverTrigger.hover
                ? {
                    'mouseenter': (_) => _open(),
                    'mouseleave': (_) => _close(),
                  }
                : null,
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
                    for (final part in _arrowPosition.split(';'))
                      if (part.trim().isNotEmpty && part.contains(':'))
                        part.split(':')[0].trim(): part.split(':')[1].trim().replaceAll(';', ''),
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
