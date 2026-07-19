import 'package:arcane_jaspr/flutter.dart';

import '../service/auth_state.dart';

/// Stub route protection for non-web platforms.
class AuthGuard extends StatelessWidget {
  final Widget child;
  final Widget? loadingIndicator;
  final String redirectTo;
  final bool requireAdmin;
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
  Widget build(BuildContext context) {
    return child;
  }
}

/// Stub guest route protection for non-web platforms.
class GuestGuard extends StatelessWidget {
  final Widget child;
  final Widget? loadingIndicator;
  final String redirectTo;

  const GuestGuard({
    required this.child,
    this.loadingIndicator,
    this.redirectTo = '/dashboard',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
