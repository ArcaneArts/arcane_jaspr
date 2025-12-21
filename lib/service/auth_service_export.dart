/// Conditional export for auth service
/// Uses real implementation on web, stub on VM/server
export 'auth_service_stub.dart'
    if (dart.library.js_interop) 'auth_service.dart';
