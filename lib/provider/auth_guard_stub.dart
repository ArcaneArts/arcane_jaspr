/// Stub implementation of AuthGuard for non-web platforms (VM/server)
/// This allows the arcane_jaspr library to be imported during static site generation.

import 'package:jaspr/jaspr.dart';

import '../service/auth_state.dart';

/// Route protection component - stub version
///
/// On server builds, this simply renders the child since there's no actual auth.
class AuthGuard extends StatelessComponent {
  /// The protected content
  final Component child;

  /// Custom loading indicator (shown while auth state is loading)
  final Component? loadingIndicator;

  /// Route to redirect to if not authenticated
  final String redirectTo;

  /// Whether this route requires admin privileges
  final bool requireAdmin;

  /// Callback to check if user has admin privileges
  final bool Function(AuthUser user)? isAdmin;

  const AuthGuard({
    required this.child,
    this.loadingIndicator,
    this.redirectTo = '/login',
    this.requireAdmin = false,
    this.isAdmin,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // On server, just render the child for static generation
    // The real auth guard logic only runs in the browser
    return child;
  }
}

/// Inverse of AuthGuard - only shows content when NOT authenticated
///
/// Stub version for server builds.
class GuestGuard extends StatelessComponent {
  /// The content to show for guests
  final Component child;

  /// Custom loading indicator
  final Component? loadingIndicator;

  /// Route to redirect authenticated users to
  final String redirectTo;

  const GuestGuard({
    required this.child,
    this.loadingIndicator,
    this.redirectTo = '/dashboard',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // On server, just render the child for static generation
    return child;
  }
}
