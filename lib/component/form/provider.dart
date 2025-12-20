import 'dart:async';

import 'package:jaspr/jaspr.dart';

/// The abstract base class for form field providers in the Arcane form system.
///
/// This class defines the interface for getting and setting form values,
/// enabling dynamic validation and custom storage backends. Subclasses like
/// [ArcaneFieldMapProvider] and [ArcaneFieldDirectProvider] implement the
/// abstract [onGetValue] and [onSetValue] for specific persistence needs.
abstract class ArcaneFieldProvider<T> {
  ArcaneFieldProvider({required this.defaultValue});

  /// The default value used as a fallback when value retrieval fails.
  final T defaultValue;

  /// Stream controller for value changes.
  final StreamController<T> _controller = StreamController<T>.broadcast();

  /// Current cached value.
  T? _currentValue;

  /// Stream of value changes.
  Stream<T> get stream => _controller.stream;

  /// Current value or default.
  T get currentValue => _currentValue ?? defaultValue;

  /// Abstract method to retrieve the value associated with a key.
  Future<T> onGetValue(String k);

  /// Abstract method to set the value for a key.
  Future<void> onSetValue(String k, T value);

  /// Retrieves the value for the given key, falling back to [defaultValue] on error.
  Future<T> getValue(String k) async {
    try {
      final value = await onGetValue(k);
      _currentValue = value;
      if (!_controller.isClosed) {
        _controller.add(value);
      }
      return value;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Sets the value for the given key and emits the new value.
  Future<void> setValue(String k, T value) async {
    await onSetValue(k, value);
    _currentValue = value;
    if (!_controller.isClosed) {
      _controller.add(value);
    }
  }

  /// Dispose resources.
  void dispose() {
    _controller.close();
  }
}

/// A concrete implementation of [ArcaneFieldProvider] using a nested Map for storage.
///
/// Supports hierarchical data access via dot notation (e.g., 'user.name.first').
class ArcaneFieldMapProvider<T> extends ArcaneFieldProvider<T> {
  /// The nested storage map holding form field values.
  final Map<String, dynamic> storage;

  ArcaneFieldMapProvider({required super.defaultValue, required this.storage});

  @override
  Future<T> onGetValue(String k) async {
    List<String> parts = k.split('.');
    Map<String, dynamic> current = storage;
    for (int i = 0; i < parts.length; i++) {
      String part = parts[i];

      if (i == parts.length - 1) {
        if (current.containsKey(part)) {
          return current[part] as T;
        } else {
          throw Exception("Key not found: $k");
        }
      } else {
        if (current[part] is Map<String, dynamic>) {
          current = current[part] as Map<String, dynamic>;
        } else {
          throw Exception("Key not found: $k");
        }
      }
    }

    throw Exception("Key not found: $k");
  }

  @override
  Future<void> onSetValue(String k, T value) async {
    List<String> parts = k.split('.');
    Map<String, dynamic> current = storage;
    for (int i = 0; i < parts.length; i++) {
      String part = parts[i];
      if (i == parts.length - 1) {
        current[part] = value;
      } else {
        current[part] ??= <String, dynamic>{};
        current = current[part] as Map<String, dynamic>;
      }
    }
  }
}

/// A flexible provider that delegates to custom getter/setter functions.
///
/// Allows integration with external data sources, databases, or APIs.
class ArcaneFieldDirectProvider<T> extends ArcaneFieldProvider<T> {
  /// The function to retrieve a value by key.
  final Future<T> Function(String) getter;

  /// The function to set a value by key.
  final Future<void> Function(String, T) setter;

  ArcaneFieldDirectProvider({
    required super.defaultValue,
    required this.getter,
    required this.setter,
  });

  @override
  Future<T> onGetValue(String k) => getter(k);

  @override
  Future<void> onSetValue(String k, T value) => setter(k, value);
}

/// Form context data for accessing form state.
class ArcaneFormContext {
  final Map<String, dynamic> values;
  final Map<String, String?> errors;
  final void Function(String key, dynamic value) setValue;
  final void Function(String key, String? error) setError;
  final void Function() submit;
  final bool isValid;

  const ArcaneFormContext({
    required this.values,
    required this.errors,
    required this.setValue,
    required this.setError,
    required this.submit,
    required this.isValid,
  });
}

/// A form provider component that manages form state.
class ArcaneFormProvider extends StatefulComponent {
  /// Initial form values.
  final Map<String, dynamic> initialValues;

  /// Form submission handler.
  final void Function(Map<String, dynamic> values)? onSubmit;

  /// Form validation handler.
  final Map<String, String?> Function(Map<String, dynamic> values)? validator;

  /// Child builder with form context.
  final Component Function(ArcaneFormContext context) builder;

  const ArcaneFormProvider({
    this.initialValues = const {},
    this.onSubmit,
    this.validator,
    required this.builder,
    super.key,
  });

  @override
  State<ArcaneFormProvider> createState() => _ArcaneFormProviderState();
}

class _ArcaneFormProviderState extends State<ArcaneFormProvider> {
  late Map<String, dynamic> _values;
  Map<String, String?> _errors = {};

  @override
  void initState() {
    super.initState();
    _values = Map<String, dynamic>.from(component.initialValues);
  }

  void _setValue(String key, dynamic value) {
    setState(() {
      _values[key] = value;
      // Clear error when value changes
      _errors[key] = null;
    });
  }

  void _setError(String key, String? error) {
    setState(() {
      _errors[key] = error;
    });
  }

  bool get _isValid => !_errors.values.any((e) => e != null);

  void _submit() {
    // Run validation if provided
    if (component.validator != null) {
      final validationErrors = component.validator!(_values);
      setState(() {
        _errors = validationErrors;
      });

      if (validationErrors.values.any((e) => e != null)) {
        return;
      }
    }

    component.onSubmit?.call(_values);
  }

  @override
  Component build(BuildContext context) {
    final formContext = ArcaneFormContext(
      values: _values,
      errors: _errors,
      setValue: _setValue,
      setError: _setError,
      submit: _submit,
      isValid: _isValid,
    );

    return component.builder(formContext);
  }
}

/// An inherited component to provide form context to descendants.
class ArcaneFormScope extends InheritedComponent {
  final ArcaneFormContext formContext;

  const ArcaneFormScope({
    required this.formContext,
    required super.child,
    super.key,
  });

  static ArcaneFormContext? of(BuildContext context) {
    final scope =
        context.dependOnInheritedComponentOfExactType<ArcaneFormScope>();
    return scope?.formContext;
  }

  @override
  bool updateShouldNotify(covariant ArcaneFormScope oldComponent) {
    return formContext != oldComponent.formContext;
  }
}
