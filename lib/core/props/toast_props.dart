import 'package:arcane_jaspr/flutter.dart';

enum ToastVariant {
  info,
  success,
  warning,
  error,
  loading,
}

enum ToastPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// Toast action button data.
class ToastAction {
  final String label;
  final void Function() onPressed;
  final bool destructive;

  const ToastAction({
    required this.label,
    required this.onPressed,
    this.destructive = false,
  });
}

/// Toast component properties.
class ToastProps {
  final String message;
  final String? title;
  final String? description;
  final ToastVariant variant;
  final ToastPosition position;
  final int duration;
  final bool dismissible;
  final ToastAction? action;
  final Widget? icon;
  final String? id;
  final bool isExiting;
  final bool isHovered;
  final void Function()? onMouseEnter;
  final void Function()? onMouseLeave;
  final void Function()? onDismiss;

  const ToastProps({
    required this.message,
    this.title,
    this.description,
    this.variant = ToastVariant.info,
    this.position = ToastPosition.bottomRight,
    this.duration = 4000,
    this.dismissible = true,
    this.action,
    this.icon,
    this.id,
    this.isExiting = false,
    this.isHovered = false,
    this.onMouseEnter,
    this.onMouseLeave,
    this.onDismiss,
  });

  ToastProps copyWith({
    String? message,
    String? title,
    String? description,
    ToastVariant? variant,
    ToastPosition? position,
    int? duration,
    bool? dismissible,
    ToastAction? action,
    Widget? icon,
    String? id,
    bool? isExiting,
    bool? isHovered,
    void Function()? onMouseEnter,
    void Function()? onMouseLeave,
    void Function()? onDismiss,
  }) {
    return ToastProps(
      message: message ?? this.message,
      title: title ?? this.title,
      description: description ?? this.description,
      variant: variant ?? this.variant,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      dismissible: dismissible ?? this.dismissible,
      action: action ?? this.action,
      icon: icon ?? this.icon,
      id: id ?? this.id,
      isExiting: isExiting ?? this.isExiting,
      isHovered: isHovered ?? this.isHovered,
      onMouseEnter: onMouseEnter ?? this.onMouseEnter,
      onMouseLeave: onMouseLeave ?? this.onMouseLeave,
      onDismiss: onDismiss ?? this.onDismiss,
    );
  }
}

/// Toast container component properties.
class ToastContainerProps {
  final ToastPosition position;
  final int maxVisible;
  final double gap;
  final double offset;
  final List<ToastProps> toasts;

  const ToastContainerProps({
    this.position = ToastPosition.bottomRight,
    this.maxVisible = 3,
    this.gap = 12,
    this.offset = 20,
    this.toasts = const [],
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for toast components.
mixin ToastRendererContract {
  Widget toast(ToastProps props);
  Widget toastContainer(ToastContainerProps props);
}
