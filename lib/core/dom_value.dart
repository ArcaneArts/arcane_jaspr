/// Safely read form-control values from DOM event targets without importing
/// `package:web` (and thus `dart:js_interop`) into styled component files —
/// which breaks Jaspr's off-web style extraction. The web implementation does
/// the typed interop read; the stub keeps the styles build compiling.
export 'dom_value_stub.dart' if (dart.library.js_interop) 'dom_value_web.dart';
