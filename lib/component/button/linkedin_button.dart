import 'package:arcane_jaspr/arcane_jaspr.dart';

/// LinkedIn sign-in button
///
/// Branded button for LinkedIn OAuth authentication.
///
/// ```dart
/// LinkedInSignInButton(
///   onPressed: () => signInWithLinkedIn(),
/// )
/// ```
class LinkedInSignInButton extends StatelessComponent {
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

  const LinkedInSignInButton({
    this.onPressed,
    this.label = 'Continue with LinkedIn',
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
      icon: _buildLinkedInIcon(),
      onPressed: onPressed,
      size: size,
      fullWidth: fullWidth,
      disabled: disabled,
      loading: loading,
      backgroundColor: '#0A66C2',
      foregroundColor: '#ffffff',
      borderColor: '#0A66C2',
      hoverBackgroundColor: '#004182',
    );
  }

  Component _buildLinkedInIcon() {
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
                'M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z',
          },
        ),
      ],
    );
  }
}
