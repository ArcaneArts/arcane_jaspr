import 'package:jaspr/jaspr.dart';

import 'toast_types.dart';

/// Toast data for the queue
class ToastData {
  final String id;
  final String message;
  final String? title;
  final String? description;
  final ToastVariant variant;
  final int duration;
  final bool dismissible;
  final ToastAction? action;
  final Component? icon;
  final ToastPosition position;

  ToastData({
    required this.id,
    required this.message,
    this.title,
    this.description,
    this.variant = ToastVariant.info,
    this.duration = 4000,
    this.dismissible = true,
    this.action,
    this.icon,
    this.position = ToastPosition.bottomRight,
  });

  ToastData copyWith({
    String? message,
    String? title,
    String? description,
    ToastVariant? variant,
    int? duration,
    bool? dismissible,
    ToastAction? action,
    Component? icon,
  }) {
    return ToastData(
      id: id,
      message: message ?? this.message,
      title: title ?? this.title,
      description: description ?? this.description,
      variant: variant ?? this.variant,
      duration: duration ?? this.duration,
      dismissible: dismissible ?? this.dismissible,
      action: action ?? this.action,
      icon: icon ?? this.icon,
      position: position,
    );
  }
}

/// Global toast manager singleton
class ToastManager {
  static ToastManager? _instance;
  static ToastManager get instance => _instance ??= ToastManager._();

  ToastManager._();

  final List<ToastData> _toasts = [];
  final List<void Function()> _listeners = [];
  ToastPosition _defaultPosition = ToastPosition.bottomRight;

  List<ToastData> get toasts => List.unmodifiable(_toasts);

  void setDefaultPosition(ToastPosition position) {
    _defaultPosition = position;
  }

  void addListener(void Function() listener) => _listeners.add(listener);
  void removeListener(void Function() listener) => _listeners.remove(listener);
  void _notify() {
    for (final l in _listeners) {
      l();
    }
  }

  String _generateId() => 'toast_${DateTime.now().millisecondsSinceEpoch}';

  String _show(ToastData data) {
    _toasts.insert(0, data);
    _notify();
    return data.id;
  }

  void dismiss(String id) {
    _toasts.removeWhere((t) => t.id == id);
    _notify();
  }

  void dismissAll() {
    _toasts.clear();
    _notify();
  }

  void update(String id, ToastData Function(ToastData) updater) {
    final index = _toasts.indexWhere((t) => t.id == id);
    if (index != -1) {
      _toasts[index] = updater(_toasts[index]);
      _notify();
    }
  }

  // Convenience methods
  String info(
    String message, {
    String? title,
    String? description,
    int duration = 4000,
    ToastAction? action,
    Component? icon,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.info,
      duration: duration,
      action: action,
      icon: icon,
      position: position ?? _defaultPosition,
    ));
  }

  String success(
    String message, {
    String? title,
    String? description,
    int duration = 4000,
    ToastAction? action,
    Component? icon,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.success,
      duration: duration,
      action: action,
      icon: icon,
      position: position ?? _defaultPosition,
    ));
  }

  String warning(
    String message, {
    String? title,
    String? description,
    int duration = 5000,
    ToastAction? action,
    Component? icon,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.warning,
      duration: duration,
      action: action,
      icon: icon,
      position: position ?? _defaultPosition,
    ));
  }

  String error(
    String message, {
    String? title,
    String? description,
    int duration = 6000,
    ToastAction? action,
    Component? icon,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.error,
      duration: duration,
      action: action,
      icon: icon,
      position: position ?? _defaultPosition,
    ));
  }

  String loading(
    String message, {
    String? title,
    String? description,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.loading,
      duration: 0,
      dismissible: false,
      position: position ?? _defaultPosition,
    ));
  }

  String promise<T>(
    Future<T> future, {
    required String loading,
    required String Function(T) success,
    required String Function(Object) error,
    String? title,
    ToastPosition? position,
  }) {
    final id = this.loading(loading, title: title, position: position);

    future.then((result) {
      update(
          id,
          (t) => t.copyWith(
                message: success(result),
                variant: ToastVariant.success,
                duration: 4000,
                dismissible: true,
              ));
    }).catchError((e) {
      update(
          id,
          (t) => t.copyWith(
                message: error(e),
                variant: ToastVariant.error,
                duration: 6000,
                dismissible: true,
              ));
    });

    return id;
  }
}

/// Global toast accessor
ToastManager get toast => ToastManager.instance;
