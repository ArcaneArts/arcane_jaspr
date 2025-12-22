import 'package:arcane_jaspr/arcane_jaspr.dart';

import 'social_button.dart';

/// Google sign-in button
///
/// Branded button for Google OAuth authentication.
///
/// ```dart
/// GoogleSignInButton(
///   onPressed: () => context.signInWithGoogle(),
/// )
/// ```
class GoogleSignInButton extends StatelessComponent {
  /// Click handler (optional - defaults to context.signInWithGoogle())
  final void Function()? onPressed;

  /// Button label
  final String label;

  /// Button size
  final ButtonSize size;

  /// Whether to expand to full width
  final bool fullWidth;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is loading
  final bool loading;

  const GoogleSignInButton({
    this.onPressed,
    this.label = 'Continue with Google',
    this.size = ButtonSize.medium,
    this.fullWidth = false,
    this.disabled = false,
    this.loading = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return SocialSignInButton(
      label: label,
      icon: _buildGoogleIcon(),
      onPressed: onPressed ?? () => context.signInWithGoogle(),
      size: size,
      fullWidth: fullWidth,
      disabled: disabled,
      loading: loading,
      backgroundColor: '#ffffff',
      foregroundColor: '#1f1f1f',
      borderColor: '#dadce0',
      hoverBackgroundColor: '#f8f9fa',
    );
  }

  Component _buildGoogleIcon() {
    // Google "G" logo SVG
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'fill': '#4285F4',
            'd':
                'M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'fill': '#34A853',
            'd':
                'M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'fill': '#FBBC05',
            'd':
                'M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'fill': '#EA4335',
            'd':
                'M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z',
          },
        ),
      ],
    );
  }
}