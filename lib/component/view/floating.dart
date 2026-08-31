import 'dart:async';

import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/floating_props.dart'
    show FloatingTrigger, FloatingPosition, FloatingProps;

/// A unified floating content component.
///
/// Replaces the separate Tooltip, Popover, and Hovercard components with
/// a single flexible component that handles all floating content patterns:
///
/// - **Tooltip mode**: Simple text hint on hover
/// - **Popover mode**: Rich content panel on click
/// - **Hovercard mode**: Content shown after the configured hover delays
///
/// Use the named constructors for common patterns or the default constructor
/// for full control.
class ArcaneHoverCard extends StatefulWidget {
  final String? id;
  final Widget trigger;
  final Widget? content;
  final String? textContent;
  final FloatingTrigger triggerType;
  final FloatingPosition position;
  final bool? isOpen;
  final void Function(bool isOpen)? onOpenChange;
  final bool showArrow;
  final int offset;
  final int openDelay;
  final int closeDelay;
  final double? maxWidth;
  final bool closeOnOutsideClick;
  final bool closeOnEscape;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneHoverCard({
    this.id,
    required this.trigger,
    this.content,
    this.textContent,
    this.triggerType = FloatingTrigger.hover,
    this.position = FloatingPosition.top,
    this.isOpen,
    this.onOpenChange,
    this.showArrow = true,
    this.offset = 8,
    this.openDelay = 0,
    this.closeDelay = 0,
    this.maxWidth,
    this.closeOnOutsideClick = true,
    this.closeOnEscape = true,
    this.styles,
    this.decoration,
    super.key,
  });

  /// Creates a simple text tooltip that appears on hover.
  ///
  /// Best for providing hints or descriptions for UI elements.
  const ArcaneHoverCard.tooltip({
    this.id,
    required Widget child,
    required String this.textContent,
    this.position = FloatingPosition.top,
    this.maxWidth = 250,
    this.styles,
    this.decoration,
    super.key,
  }) : trigger = child,
       content = null,
       triggerType = FloatingTrigger.hover,
       isOpen = null,
       onOpenChange = null,
       showArrow = false,
       offset = 8,
       openDelay = 0,
       closeDelay = 0,
       closeOnOutsideClick = true,
       closeOnEscape = true;

  /// Creates a tooltip with custom component content.
  const ArcaneHoverCard.tooltipCustom({
    this.id,
    required Widget child,
    required Widget this.content,
    this.position = FloatingPosition.top,
    this.maxWidth,
    this.styles,
    this.decoration,
    super.key,
  }) : trigger = child,
       textContent = null,
       triggerType = FloatingTrigger.hover,
       isOpen = null,
       onOpenChange = null,
       showArrow = false,
       offset = 8,
       openDelay = 0,
       closeDelay = 0,
       closeOnOutsideClick = true,
       closeOnEscape = true;

  /// Creates a click-triggered popover with rich content.
  ///
  /// Best for menus, forms, or interactive content that should
  /// persist until dismissed.
  const ArcaneHoverCard.popover({
    this.id,
    required this.trigger,
    required Widget this.content,
    this.position = FloatingPosition.bottom,
    this.isOpen,
    this.onOpenChange,
    this.showArrow = true,
    this.offset = 8,
    this.closeOnOutsideClick = true,
    this.closeOnEscape = true,
    this.styles,
    this.decoration,
    super.key,
  }) : textContent = null,
       triggerType = FloatingTrigger.click,
       openDelay = 0,
       closeDelay = 0,
       maxWidth = null;

  /// Creates a hover-triggered card with configurable delays.
  ///
  /// Best for preview cards that show additional info on hover,
  /// like user profile previews or link previews.
  const ArcaneHoverCard.hovercard({
    this.id,
    required this.trigger,
    required Widget this.content,
    this.position = FloatingPosition.top,
    this.showArrow = true,
    this.offset = 8,
    this.openDelay = 200,
    this.closeDelay = 300,
    this.isOpen,
    this.onOpenChange,
    this.styles,
    this.decoration,
    super.key,
  }) : textContent = null,
       triggerType = FloatingTrigger.hover,
       maxWidth = null,
       closeOnOutsideClick = true,
       closeOnEscape = true;

  @override
  State<ArcaneHoverCard> createState() => _ArcaneHoverCardState();
}

class _ArcaneHoverCardState extends State<ArcaneHoverCard> {
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

  void _handleMouseEnter() {
    _cancelTimers();
    _startOpenTimer();
  }

  void _handleMouseLeave() {
    _cancelTimers();
    _startCloseTimer();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTextTooltip =
        component.textContent != null && component.content == null;

    return context.renderers.floating(
      FloatingProps(
        id: component.id,
        trigger: component.trigger,
        content: component.content,
        textContent: component.textContent,
        isOpen: _isOpen,
        triggerType: component.triggerType,
        position: component.position,
        onToggle: _toggle,
        onMouseEnter: _handleMouseEnter,
        onMouseLeave: _handleMouseLeave,
        showArrow: component.showArrow,
        offset: component.offset,
        maxWidth: component.maxWidth ?? (isTextTooltip ? 250 : null),
        closeOnOutsideClick: component.closeOnOutsideClick,
        closeOnEscape: component.closeOnEscape,
        styles: component.styles,
        decoration: component.decoration,
      ),
    );
  }
}
