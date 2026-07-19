import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// Read the `value` of a form control from a DOM event target (web) via an
/// explicit JS property read — avoids dynamic dispatch on package:web extension
/// types, which throws on dart2js (Dart 3.11).
String domInputValue(Object? target) {
  final JSObject? obj = target as JSObject?;
  final JSAny? v = obj?.getProperty<JSAny?>('value'.toJS);
  return (v as JSString?)?.toDart ?? '';
}

/// Read the `checked` state of a checkbox/radio from a DOM event target (web).
bool domCheckedValue(Object? target) {
  final JSObject? obj = target as JSObject?;
  final JSAny? v = obj?.getProperty<JSAny?>('checked'.toJS);
  return (v as JSBoolean?)?.toDart ?? false;
}

/// Read the `selectedIndex` of a <select> from a DOM event target (web).
int domSelectedIndex(Object? target) {
  final JSObject? obj = target as JSObject?;
  final JSAny? v = obj?.getProperty<JSAny?>('selectedIndex'.toJS);
  return (v as JSNumber?)?.toDartInt ?? 0;
}

/// Read the `key` of a keyboard event (web).
String domEventKey(Object? event) {
  final JSObject? obj = event as JSObject?;
  final JSAny? v = obj?.getProperty<JSAny?>('key'.toJS);
  return (v as JSString?)?.toDart ?? '';
}

/// Read `event.target.value` from a DOM event (web) — for handlers that only
/// have the (dynamic) event, not the target.
String domEventValue(Object? event) {
  final JSObject? ev = event as JSObject?;
  final JSAny? target = ev?.getProperty<JSAny?>('target'.toJS);
  return domInputValue(target);
}

/// Call `event.stopPropagation()` on a DOM event (web).
void domStopPropagation(Object? event) {
  (event as JSObject?)?.callMethod<JSAny?>('stopPropagation'.toJS);
}

/// Call `event.preventDefault()` on a DOM event (web).
void domPreventDefault(Object? event) {
  (event as JSObject?)?.callMethod<JSAny?>('preventDefault'.toJS);
}
