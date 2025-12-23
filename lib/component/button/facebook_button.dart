import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Facebook sign-in button
///
/// Branded button for Facebook OAuth authentication.
///
/// ```dart
/// FacebookSignInButton(
///   onPressed: () => signInWithFacebook(),
/// )
/// ```
class FacebookSignInButton extends StatelessComponent {
  /// Click handler
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

  const FacebookSignInButton({
    this.onPressed,
    this.label = 'Continue with Facebook',
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
      icon: _buildFacebookIcon(),
      onPressed: onPressed,
      size: size,
      fullWidth: fullWidth,
      disabled: disabled,
      loading: loading,
      backgroundColor: '#1877F2',
      foregroundColor: '#ffffff',
      borderColor: '#1877F2',
      hoverBackgroundColor: '#166fe5',
    );
  }

  Component _buildFacebookIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z',
          },
        ),
      ],
    );
  }
}
