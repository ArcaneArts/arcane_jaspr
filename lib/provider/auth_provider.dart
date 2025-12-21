import 'dart:async';

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:fast_log/fast_log.dart';
import 'package:web/web.dart' as web;

import '../service/auth_service.dart';
import '../service/auth_state.dart';

/// InheritedComponent for auth state propagation
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

/// Authentication provider component
///
/// Wraps your app to provide authentication state throughout the component tree.
///
/// ```dart
/// ArcaneAuthProvider(
///   serverApiUrl: 'https://api.example.com',
///   redirectOnLogin: '/dashboard',
///   redirectOnLogout: '/login',
///   child: const AppRouter(),
/// )
/// ```
class ArcaneAuthProvider extends StatefulComponent {
  /// The child component to wrap
  final Component child;

  /// Callback when auth state changes
  final void Function(AuthState)? onAuthStateChanged;

  /// Route to redirect to after successful login
  final String? redirectOnLogin;

  /// Route to redirect to after logout
  final String? redirectOnLogout;

  /// Server API URL for user sync (e.g., 'https://api.example.com')
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
  late final StreamSubscription<AuthState> _subscription;
  AuthState _state = const AuthState();
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    verbose('ArcaneAuthProvider initializing...');

    // Initialize the auth service
    JasprAuthService.instance.initialize(serverApiUrl: component.serverApiUrl);

    // Listen to auth state changes
    _subscription = JasprAuthService.instance.authStateStream.listen(_onAuthStateChanged);

    // Get initial state
    _state = JasprAuthService.instance.currentState;
  }

  void _onAuthStateChanged(AuthState newState) {
    final AuthState previousState = _state;

    setState(() => _state = newState);

    // Call user callback
    component.onAuthStateChanged?.call(newState);

    // Skip redirects on initial auth state (page load/refresh)
    // Only redirect on actual user-initiated login/logout
    if (!_hasInitialized) {
      _hasInitialized = true;
      verbose('Initial auth state received, skipping redirect');
      return;
    }

    // Only redirect on actual state transitions (not page refreshes)
    // previousState.isLoading means this came from a user action
    if (newState.isAuthenticated && previousState.isLoading) {
      // User just logged in (was loading, now authenticated)
      if (component.redirectOnLogin != null) {
        info('User authenticated, redirecting to ${component.redirectOnLogin}');
        _navigateTo(component.redirectOnLogin!);
      }
    } else if (!newState.isAuthenticated &&
               !newState.isLoading &&
               previousState.isAuthenticated) {
      // User just logged out
      if (component.redirectOnLogout != null) {
        info('User logged out, redirecting to ${component.redirectOnLogout}');
        _navigateTo(component.redirectOnLogout!);
      }
    }
  }

  void _navigateTo(String path) {
    // Schedule navigation for after the current build
    Future<void>.microtask(() {
      web.window.location.href = path;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

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
