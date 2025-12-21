/// Stub implementation of JasprAuthService for non-web platforms (VM/server)
/// This allows the arcane_jaspr library to be imported during static site generation
/// without pulling in dart:js_interop which is web-only.

import 'dart:async';

import 'auth_state.dart';

/// Firebase Auth service stub - throws on any usage since auth is web-only
class JasprAuthService {
  /// Singleton instance
  static JasprAuthService? _instance;
  static JasprAuthService get instance {
    _instance ??= JasprAuthService._();
    return _instance!;
  }

  JasprAuthService._();

  /// Get current auth state stream - stub returns unauthenticated
  Stream<AuthState> get authStateStream => Stream.value(const AuthState.unauthenticated());

  /// Current auth state - stub returns unauthenticated
  AuthState get currentState => const AuthState.unauthenticated();

  /// Check if user is authenticated
  bool get isAuthenticated => false;

  /// Get current user
  AuthUser? get currentUser => null;

  /// Initialize the auth service - no-op on server
  void initialize({String? serverApiUrl}) {
    // No-op on server/VM
  }

  /// Sign in with GitHub - throws on server
  Future<void> signInWithGitHub() async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  /// Sign in with Google - throws on server
  Future<void> signInWithGoogle() async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  /// Sign in with Apple - throws on server
  Future<void> signInWithApple() async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  /// Sign in with email/password - throws on server
  Future<void> signInWithEmail(String email, String password) async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  /// Register with email/password - throws on server
  Future<void> registerWithEmail(String email, String password, String displayName) async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  /// Send password reset email - throws on server
  Future<void> sendPasswordResetEmail(String email) async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  /// Refresh the ID token - returns null on server
  Future<String?> refreshToken() async => null;

  /// Delete account - throws on server
  Future<bool> deleteAccount() async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  /// Sign out - no-op on server
  Future<void> signOut() async {}

  /// Dispose the service
  void dispose() {}
}
