/// Stub implementation of ArcaneAuthProvider for non-web platforms (VM/server)
/// This allows the arcane_jaspr library to be imported during static site generation.

import 'dart:async';

import 'package:jaspr/jaspr.dart';

import '../service/auth_service_stub.dart';
import '../service/auth_state.dart';

/// InheritedComponent for auth state propagation - stub version
class _AuthInheritedProvider extends InheritedComponent {
  final AuthState state;

  const _AuthInheritedProvider({
    required this.state,
    required super.child,
  });

  static _AuthInheritedProvider? of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_AuthInheritedProvider>();
  }

  @override
  bool updateShouldNotify(_AuthInheritedProvider oldComponent) {
    return state.status != oldComponent.state.status ||
        state.user?.uid != oldComponent.state.user?.uid ||
        state.error != oldComponent.state.error;
  }
}

/// Authentication provider component - stub version
///
/// On server builds, this simply passes through the child without auth functionality.
class ArcaneAuthProvider extends StatefulComponent {
  /// The child component to wrap
  final Component child;

  /// Callback when auth state changes
  final void Function(AuthState)? onAuthStateChanged;

  /// Route to redirect to after successful login
  final String? redirectOnLogin;

  /// Route to redirect to after logout
  final String? redirectOnLogout;

  /// Server API URL for user sync
  final String? serverApiUrl;

  const ArcaneAuthProvider({
    required this.child,
    this.onAuthStateChanged,
    this.redirectOnLogin,
    this.redirectOnLogout,
    this.serverApiUrl,
    super.key,
  });

  @override
  State<ArcaneAuthProvider> createState() => _ArcaneAuthProviderState();
}

class _ArcaneAuthProviderState extends State<ArcaneAuthProvider> {
  final AuthState _state = const AuthState.unauthenticated();

  @override
  Component build(BuildContext context) {
    return _AuthInheritedProvider(
      state: _state,
      child: component.child,
    );
  }
}

/// Extension for accessing auth state from any component
extension AuthContextExtension on BuildContext {
  /// Get the current auth state
  AuthState get authState {
    final _AuthInheritedProvider? provider = _AuthInheritedProvider.of(this);
    return provider?.state ?? const AuthState();
  }

  /// Get the current authenticated user
  AuthUser? get currentUser => authState.user;

  /// Whether the user is authenticated
  bool get isAuthenticated => authState.isAuthenticated;

  /// Whether auth is loading
  bool get isAuthLoading => authState.isLoading;

  /// Get the current user's UID
  String? get uid => currentUser?.uid;

  /// Get the current user's ID token for API calls
  String? get idToken => currentUser?.idToken;

  /// Sign in with GitHub
  Future<void> signInWithGitHub() => JasprAuthService.instance.signInWithGitHub();

  /// Sign in with Google
  Future<void> signInWithGoogle() => JasprAuthService.instance.signInWithGoogle();

  /// Sign in with Apple
  Future<void> signInWithApple() => JasprAuthService.instance.signInWithApple();

  /// Sign in with email and password
  Future<void> signInWithEmail(String email, String password) =>
      JasprAuthService.instance.signInWithEmail(email, password);

  /// Register with email and password
  Future<void> registerWithEmail(
          String email, String password, String displayName) =>
      JasprAuthService.instance.registerWithEmail(email, password, displayName);

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) =>
      JasprAuthService.instance.sendPasswordResetEmail(email);

  /// Sign out
  Future<void> signOut() => JasprAuthService.instance.signOut();

  /// Refresh the ID token
  Future<String?> refreshAuthToken() => JasprAuthService.instance.refreshToken();

  /// Delete account and all associated data
  Future<bool> deleteAccount() => JasprAuthService.instance.deleteAccount();
}
