/// Toast notification variant
enum ToastVariant {
  /// Default informational toast
  info,

  /// Success toast with green accent
  success,

  /// Warning toast with yellow/orange accent
  warning,

  /// Error toast with red accent
  error,

  /// Loading toast with spinner
  loading,
}

/// Toast position on screen
enum ToastPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// Toast action button configuration
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
