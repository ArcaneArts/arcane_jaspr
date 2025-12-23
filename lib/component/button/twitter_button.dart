import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Twitter/X sign-in button
///
/// Branded button for Twitter OAuth authentication.
///
/// ```dart
/// TwitterSignInButton(
///   onPressed: () => signInWithTwitter(),
/// )
/// ```
class TwitterSignInButton extends StatelessComponent {
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

  const TwitterSignInButton({
    this.onPressed,
    this.label = 'Continue with X',
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
      icon: _buildTwitterIcon(),
      onPressed: onPressed,
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

  Component _buildTwitterIcon() {
    // X (Twitter) logo
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '16',
        'height': '16',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z',
          },
        ),
      ],
    );
  }
}
