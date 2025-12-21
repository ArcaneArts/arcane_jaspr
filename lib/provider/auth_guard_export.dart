/// Conditional export for auth guard
/// Uses real implementation on web, stub on VM/server
export 'auth_guard_stub.dart'
    if (dart.library.js_interop) 'auth_guard.dart';
