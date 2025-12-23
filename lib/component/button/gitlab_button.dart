import 'package:arcane_jaspr/arcane_jaspr.dart';

/// GitLab sign-in button
///
/// Branded button for GitLab OAuth authentication.
///
/// ```dart
/// GitLabSignInButton(
///   onPressed: () => signInWithGitLab(),
/// )
/// ```
class GitLabSignInButton extends StatelessComponent {
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

  const GitLabSignInButton({
    this.onPressed,
    this.label = 'Continue with GitLab',
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
      icon: _buildGitLabIcon(),
      onPressed: onPressed,
      size: size,
      fullWidth: fullWidth,
      disabled: disabled,
      loading: loading,
      backgroundColor: '#FC6D26',
      foregroundColor: '#ffffff',
      borderColor: '#FC6D26',
      hoverBackgroundColor: '#e24329',
    );
  }

  Component _buildGitLabIcon() {
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
                'M4.845.904c-.435 0-.82.28-.955.692C2.639 5.449 1.246 9.728.07 13.335a1.437 1.437 0 00.522 1.607l11.071 8.045c.2.145.472.144.67-.004l11.073-8.04a1.436 1.436 0 00.522-1.61c-1.285-3.942-2.683-8.256-3.817-11.746a1.004 1.004 0 00-.957-.684.987.987 0 00-.949.69l-2.405 7.408H8.203l-2.41-7.408a.987.987 0 00-.942-.69h-.006z',
          },
        ),
      ],
    );
  }
}
