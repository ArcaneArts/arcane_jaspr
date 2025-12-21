import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:fast_log/fast_log.dart';
import 'package:http/http.dart' as http;

import 'auth_state.dart';

/// Firebase Auth JS interop
///
/// Uses the Firebase compat SDK loaded in index.html
extension type _FirebaseNamespace._(JSObject _) implements JSObject {
  external _FirebaseAuth auth();
}

/// Firebase auth namespace that contains provider classes
extension type _FirebaseAuth._(JSObject _) implements JSObject {
  external _FirebaseUser? get currentUser;
  external JSPromise<_UserCredential> signInWithPopup(_AuthProvider provider);
  external JSPromise<_UserCredential> signInWithEmailAndPassword(
      String email, String password);
  external JSPromise<_UserCredential> createUserWithEmailAndPassword(
      String email, String password);
  external JSPromise<JSAny?> signOut();
  external JSPromise<JSAny?> sendPasswordResetEmail(String email);
  external void onAuthStateChanged(JSFunction callback);
}

extension type _FirebaseUser._(JSObject _) implements JSObject {
  external String get uid;
  external String? get email;
  external String? get displayName;
  external String? get photoURL;
  external bool get isAnonymous;
  external bool get emailVerified;
  external JSPromise<JSString> getIdToken([bool? forceRefresh]);
  external JSPromise<JSAny?> updateProfile(_ProfileUpdate profile);
}

extension type _ProfileUpdate._(JSObject _) implements JSObject {
  external factory _ProfileUpdate({String? displayName, String? photoURL});
}

extension type _UserCredential._(JSObject _) implements JSObject {
  external _FirebaseUser? get user;
}

extension type _AuthProvider._(JSObject _) implements JSObject {}

/// Get the global firebase namespace
@JS('firebase')
external _FirebaseNamespace get _firebase;

/// Provider classes from firebase.auth namespace
@JS('firebase.auth.GithubAuthProvider')
extension type _GithubAuthProvider._(JSObject _) implements _AuthProvider {
  external factory _GithubAuthProvider();
}

@JS('firebase.auth.GoogleAuthProvider')
extension type _GoogleAuthProvider._(JSObject _) implements _AuthProvider {
  external factory _GoogleAuthProvider();
}

@JS('firebase.auth.OAuthProvider')
extension type _OAuthProvider._(JSObject _) implements _AuthProvider {
  external factory _OAuthProvider(String providerId);
}

/// Jaspr Authentication Service
///
/// Provides Firebase authentication for Jaspr web applications.
/// Uses the Firebase JS SDK loaded in the HTML page.
class JasprAuthService {
  static JasprAuthService? _instance;

  /// Get the singleton instance
  static JasprAuthService get instance => _instance ??= JasprAuthService._();

  /// Stream controller for auth state changes
  final StreamController<AuthState> _stateController =
      StreamController<AuthState>.broadcast();

  /// Current auth state
  AuthState _currentState = const AuthState();

  /// Server API base URL for user sync
  String? _serverApiUrl;

  JasprAuthService._();

  /// Get the auth state stream
  Stream<AuthState> get authStateStream => _stateController.stream;

  /// Get the current auth state
  AuthState get currentState => _currentState;

  /// Get the current user
  AuthUser? get currentUser => _currentState.user;

  /// Whether the user is authenticated
  bool get isAuthenticated => _currentState.isAuthenticated;

  /// Initialize the auth service
  ///
  /// Call this once at app startup. Optionally provide a server API URL
  /// for syncing user data to your backend.
  void initialize({String? serverApiUrl}) {
    _serverApiUrl = serverApiUrl;
    verbose('JasprAuthService initializing...');

    // Set up Firebase auth state listener
    void callback(JSAny? user) {
      _handleAuthStateChange(user as _FirebaseUser?);
    }

    _firebase.auth().onAuthStateChanged(callback.toJS);
    info('JasprAuthService initialized');
  }

  /// Handle Firebase auth state changes
  Future<void> _handleAuthStateChange(_FirebaseUser? firebaseUser) async {
    if (firebaseUser != null) {
      verbose('Auth state changed: user signed in (${firebaseUser.uid})');

      // Get the ID token
      final JSString jsToken = await firebaseUser.getIdToken().toDart;
      final String idToken = jsToken.toDart;

      // Create AuthUser
      final AuthUser authUser = AuthUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        photoURL: firebaseUser.photoURL,
        idToken: idToken,
        isAnonymous: firebaseUser.isAnonymous,
        emailVerified: firebaseUser.emailVerified,
      );

      // Sync user to server if URL is configured
      if (_serverApiUrl != null) {
        await _syncUserToServer(authUser, idToken);
      }

      _updateState(AuthState.authenticated(authUser));
    } else {
      verbose('Auth state changed: user signed out');
      _updateState(const AuthState.unauthenticated());
    }
  }

  /// Update the auth state
  void _updateState(AuthState newState) {
    _currentState = newState;
    _stateController.add(newState);
  }

  /// Sign in with GitHub
  Future<void> signInWithGitHub() async {
    print('[ArcaneAuth] signInWithGitHub called');
    _updateState(const AuthState.loading());
    try {
      verbose('Signing in with GitHub...');
      print('[ArcaneAuth] Creating GitHub provider...');
      final _GithubAuthProvider provider = _GithubAuthProvider();
      print('[ArcaneAuth] Calling signInWithPopup...');
      await _firebase.auth().signInWithPopup(provider).toDart;
      print('[ArcaneAuth] signInWithPopup completed');
      // Auth state listener will handle the rest
    } catch (e) {
      print('[ArcaneAuth] GitHub sign-in error: $e');
      error('GitHub sign-in failed: $e');
      _updateState(AuthState.withError(_parseFirebaseError(e)));
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    print('[ArcaneAuth] signInWithGoogle called');
    _updateState(const AuthState.loading());
    try {
      verbose('Signing in with Google...');
      print('[ArcaneAuth] Creating Google provider...');
      final _GoogleAuthProvider provider = _GoogleAuthProvider();
      print('[ArcaneAuth] Calling signInWithPopup...');
      await _firebase.auth().signInWithPopup(provider).toDart;
      print('[ArcaneAuth] signInWithPopup completed');
      // Auth state listener will handle the rest
    } catch (e) {
      print('[ArcaneAuth] Google sign-in error: $e');
      error('Google sign-in failed: $e');
      _updateState(AuthState.withError(_parseFirebaseError(e)));
    }
  }

  /// Sign in with Apple (placeholder - requires setup)
  Future<void> signInWithApple() async {
    _updateState(const AuthState.loading());
    try {
      verbose('Signing in with Apple...');
      final _OAuthProvider provider = _OAuthProvider('apple.com');
      await _firebase.auth().signInWithPopup(provider).toDart;
      // Auth state listener will handle the rest
    } catch (e) {
      error('Apple sign-in failed: $e');
      _updateState(AuthState.withError(_parseFirebaseError(e)));
    }
  }

  /// Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    _updateState(const AuthState.loading());
    try {
      verbose('Signing in with email...');
      await _firebase.auth().signInWithEmailAndPassword(email, password).toDart;
      // Auth state listener will handle the rest
    } catch (e) {
      error('Email sign-in failed: $e');
      _updateState(AuthState.withError(_parseFirebaseError(e)));
    }
  }

  /// Register a new user with email and password
  Future<void> registerWithEmail(
      String email, String password, String displayName) async {
    _updateState(const AuthState.loading());
    try {
      verbose('Registering with email...');
      final _UserCredential credential = await _firebase
          .auth()
          .createUserWithEmailAndPassword(email, password)
          .toDart;

      // Update display name
      if (credential.user != null) {
        await credential.user!
            .updateProfile(_ProfileUpdate(displayName: displayName))
            .toDart;
      }

      // Auth state listener will handle the rest
    } catch (e) {
      error('Email registration failed: $e');
      _updateState(AuthState.withError(_parseFirebaseError(e)));
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      verbose('Sending password reset email to $email...');
      await _firebase.auth().sendPasswordResetEmail(email).toDart;
      success('Password reset email sent');
    } catch (e) {
      error('Password reset failed: $e');
      throw _parseFirebaseError(e);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      verbose('Signing out...');
      await _firebase.auth().signOut().toDart;
      // Auth state listener will handle the rest
    } catch (e) {
      error('Sign out failed: $e');
      _updateState(AuthState.withError(_parseFirebaseError(e)));
    }
  }

  /// Refresh the ID token
  Future<String?> refreshToken() async {
    final _FirebaseUser? user = _firebase.auth().currentUser;
    if (user == null) return null;

    try {
      final JSString jsToken = await user.getIdToken(true).toDart;
      final String token = jsToken.toDart;
      _currentState = _currentState.copyWith(
        user: _currentState.user?.copyWith(idToken: token),
      );
      return token;
    } catch (e) {
      error('Token refresh failed: $e');
      return null;
    }
  }

  /// Sync user to server
  Future<void> _syncUserToServer(AuthUser user, String idToken) async {
    if (_serverApiUrl == null) return;

    try {
      verbose('Syncing user to server...');
      final http.Response response = await http.post(
        Uri.parse('$_serverApiUrl/api/auth/sync'),
        headers: <String, String>{
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'photoURL': user.photoURL,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        if (data['created'] == true) {
          info('New user created on server: ${user.uid}');
        } else {
          verbose('User synced to server: ${user.uid}');
        }
      } else {
        warn('Failed to sync user to server: ${response.statusCode}');
      }
    } catch (e) {
      warn('Failed to sync user to server: $e');
    }
  }

  /// Delete account from server and sign out
  ///
  /// This deletes all user data from the server and then signs out.
  /// The Firebase Auth account itself is NOT deleted (that requires re-authentication).
  Future<bool> deleteAccount() async {
    if (_serverApiUrl == null) {
      warn('Cannot delete account: server API URL not configured');
      return false;
    }

    final _FirebaseUser? user = _firebase.auth().currentUser;
    if (user == null) {
      warn('Cannot delete account: no user signed in');
      return false;
    }

    try {
      verbose('Deleting account from server...');

      // Get fresh ID token
      final JSString jsToken = await user.getIdToken(true).toDart;
      final String idToken = jsToken.toDart;

      final http.Response response = await http.delete(
        Uri.parse('$_serverApiUrl/api/auth/delete'),
        headers: <String, String>{
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        info('Account deleted from server');
        // Sign out after deletion
        await signOut();
        return true;
      } else {
        warn('Failed to delete account: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      error('Failed to delete account: $e');
      return false;
    }
  }

  /// Parse Firebase error messages into user-friendly strings
  String _parseFirebaseError(Object error) {
    final String errorString = error.toString();

    // Common Firebase Auth error codes
    if (errorString.contains('auth/user-not-found')) {
      return 'No account found with this email address.';
    }
    if (errorString.contains('auth/wrong-password')) {
      return 'Incorrect password. Please try again.';
    }
    if (errorString.contains('auth/email-already-in-use')) {
      return 'An account already exists with this email address.';
    }
    if (errorString.contains('auth/weak-password')) {
      return 'Password is too weak. Please use a stronger password.';
    }
    if (errorString.contains('auth/invalid-email')) {
      return 'Please enter a valid email address.';
    }
    if (errorString.contains('auth/popup-closed-by-user')) {
      return 'Sign-in was cancelled.';
    }
    if (errorString.contains('auth/cancelled-popup-request')) {
      return 'Sign-in was cancelled.';
    }
    if (errorString.contains('auth/popup-blocked')) {
      return 'Pop-up was blocked. Please allow pop-ups for this site.';
    }
    if (errorString.contains('auth/network-request-failed')) {
      return 'Network error. Please check your connection.';
    }
    if (errorString.contains('auth/too-many-requests')) {
      return 'Too many attempts. Please try again later.';
    }
    if (errorString.contains('auth/invalid-credential')) {
      return 'Invalid credentials. Please try again.';
    }

    // Default error message
    return 'An error occurred. Please try again.';
  }

  /// Dispose the service
  void dispose() {
    _stateController.close();
  }
}
