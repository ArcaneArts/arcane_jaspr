/// Conditional export for auth provider
/// Uses real implementation on web, stub on VM/server
export 'auth_provider_stub.dart'
    if (dart.library.js_interop) 'auth_provider.dart';
