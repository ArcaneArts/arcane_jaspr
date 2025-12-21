import 'package:arcane_jaspr/arcane_jaspr.dart';

import '../../provider/auth_provider.dart';
import 'social_button.dart';

/// Apple sign-in button
///
/// Branded button for Apple Sign-In authentication.
/// Note: Apple Sign-In requires additional setup in your Apple Developer account.
///
/// ```dart
/// AppleSignInButton(
///   onPressed: () => context.signInWithApple(),
/// )
/// ```
class AppleSignInButton extends StatelessComponent {
  /// Click handler (optional - defaults to context.signInWithApple())
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

  const AppleSignInButton({
    this.onPressed,
    this.label = 'Continue with Apple',
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
      icon: _buildAppleIcon(),
      onPressed: onPressed ?? () => context.signInWithApple(),
      size: size,
      fullWidth: fullWidth,
      disabled: disabled,
      loading: loading,
      backgroundColor: '#000000',
      foregroundColor: '#ffffff',
      borderColor: '#000000',
      hoverBackgroundColor: '#1a1a1a',
    );
  }

  Component _buildAppleIcon() {
    // Apple logo SVG
    return Component.element(
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
                'M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z',
          },
        ),
      ],
    );
  }
}
