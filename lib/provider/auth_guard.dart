import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:web/web.dart' as web;

import '../service/auth_state.dart';
import 'auth_provider.dart';

/// Route protection component
///
/// Wraps protected routes to ensure only authenticated users can access them.
/// Redirects unauthenticated users to a specified route.
///
/// ```dart
/// AuthGuard(
///   redirectTo: '/login',
///   child: DashboardScreen(),
/// )
/// ```
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
  /// If not provided, always returns false for requireAdmin
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
    final AuthState state = context.authState;

    // Show loading indicator while auth state is unknown or loading
    if (state.isUnknown || state.isLoading) {
      return loadingIndicator ?? _buildDefaultLoader();
    }

    // Redirect if not authenticated
    if (!state.isAuthenticated) {
      // Schedule redirect for after build
      _scheduleRedirect();
      return loadingIndicator ?? _buildDefaultLoader();
    }

    // Check admin privileges if required
    if (requireAdmin) {
      final AuthUser user = state.user!;
      final bool hasAdminAccess = isAdmin?.call(user) ?? false;

      if (!hasAdminAccess) {
        // Not an admin, redirect
        _scheduleRedirect();
        return loadingIndicator ?? _buildDefaultLoader();
      }
    }

    // User is authenticated (and admin if required), show content
    return child;
  }

  void _scheduleRedirect() {
    Future<void>.microtask(() {
      web.window.location.href = redirectTo;
    });
  }

  Component _buildDefaultLoader() {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
        height: Size.screen,
        width: Size.full,
        background: Background.background,
      ),
      children: <Component>[
        div(
          styles: Styles(raw: <String, String>{
            'width': '40px',
            'height': '40px',
            'border': '3px solid ${ArcaneColors.border}',
            'border-top-color': ArcaneColors.accent,
            'border-radius': ArcaneRadius.full,
            'animation': 'arcane-spin 0.75s linear infinite',
          }),
          <Component>[],
        ),
      ],
    );
  }
}

/// Inverse of AuthGuard - only shows content when NOT authenticated
///
/// Useful for login/signup pages that should redirect authenticated users away.
///
/// ```dart
/// GuestGuard(
///   redirectTo: '/dashboard',
///   child: LoginScreen(),
/// )
/// ```
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
    final AuthState state = context.authState;

    // Show loading while unknown
    if (state.isUnknown || state.isLoading) {
      return loadingIndicator ?? _buildDefaultLoader();
    }

    // Redirect if authenticated
    if (state.isAuthenticated) {
      Future<void>.microtask(() {
        web.window.location.href = redirectTo;
      });
      return loadingIndicator ?? _buildDefaultLoader();
    }

    // Not authenticated, show guest content
    return child;
  }

  Component _buildDefaultLoader() {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
        height: Size.screen,
        width: Size.full,
        background: Background.background,
      ),
      children: <Component>[
        div(
          styles: Styles(raw: <String, String>{
            'width': '40px',
            'height': '40px',
            'border': '3px solid ${ArcaneColors.border}',
            'border-top-color': ArcaneColors.accent,
            'border-radius': ArcaneRadius.full,
            'animation': 'arcane-spin 0.75s linear infinite',
          }),
          <Component>[],
        ),
      ],
    );
  }
}
