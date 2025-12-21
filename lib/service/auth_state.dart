/// Authentication state models for arcane_jaspr

/// Authentication status enumeration
enum AuthStatus {
  /// Initial state, auth state is unknown
  unknown,

  /// User is authenticated
  authenticated,

  /// User is not authenticated
  unauthenticated,

  /// Authentication is in progress
  loading,

  /// An error occurred during authentication
  error,
}

/// Represents an authenticated user
class AuthUser {
  /// Firebase UID
  final String uid;

  /// User's email address
  final String? email;

  /// User's display name
  final String? displayName;

  /// User's photo URL
  final String? photoURL;

  /// Firebase ID token for server API calls
  final String? idToken;

  /// Whether the user is anonymous
  final bool isAnonymous;

  /// Whether the email is verified
  final bool emailVerified;

  const AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.idToken,
    this.isAnonymous = false,
    this.emailVerified = false,
  });

  /// Create a copy with updated fields
  AuthUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? idToken,
    bool? isAnonymous,
    bool? emailVerified,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      idToken: idToken ?? this.idToken,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  String toString() =>
      'AuthUser(uid: $uid, email: $email, displayName: $displayName)';
}

/// Authentication state container
class AuthState {
  /// Current authentication status
  final AuthStatus status;

  /// Current authenticated user (null if not authenticated)
  final AuthUser? user;

  /// Error message if status is error
  final String? error;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.error,
  });

  /// Whether the user is authenticated
  bool get isAuthenticated => status == AuthStatus.authenticated;

  /// Whether authentication is in progress
  bool get isLoading => status == AuthStatus.loading;

  /// Whether there is an error
  bool get hasError => status == AuthStatus.error;

  /// Whether the state is unknown (initial)
  bool get isUnknown => status == AuthStatus.unknown;

  /// Create a loading state
  const AuthState.loading()
      : status = AuthStatus.loading,
        user = null,
        error = null;

  /// Create an authenticated state
  AuthState.authenticated(AuthUser authenticatedUser)
      : status = AuthStatus.authenticated,
        user = authenticatedUser,
        error = null;

  /// Create an unauthenticated state
  const AuthState.unauthenticated()
      : status = AuthStatus.unauthenticated,
        user = null,
        error = null;

  /// Create an error state
  AuthState.withError(String errorMessage)
      : status = AuthStatus.error,
        user = null,
        error = errorMessage;

  /// Create a copy with updated fields
  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'AuthState(status: $status, user: $user, error: $error)';
}

/// Supported authentication methods
enum AuthMethod {
  /// Email and password authentication
  email,

  /// GitHub OAuth
  github,

  /// Google OAuth
  google,

  /// Apple Sign-In
  apple,

  /// Anonymous authentication
  anonymous,
}
