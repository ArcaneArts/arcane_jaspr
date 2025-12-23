import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Microsoft sign-in button
///
/// Branded button for Microsoft OAuth authentication.
///
/// ```dart
/// MicrosoftSignInButton(
///   onPressed: () => signInWithMicrosoft(),
/// )
/// ```
class MicrosoftSignInButton extends StatelessComponent {
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

  const MicrosoftSignInButton({
    this.onPressed,
    this.label = 'Continue with Microsoft',
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
      icon: _buildMicrosoftIcon(),
      onPressed: onPressed,
      size: size,
      fullWidth: fullWidth,
      disabled: disabled,
      loading: loading,
      backgroundColor: '#2f2f2f',
      foregroundColor: '#ffffff',
      borderColor: '#2f2f2f',
      hoverBackgroundColor: '#3f3f3f',
    );
  }

  Component _buildMicrosoftIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 21 21',
        'fill': 'none',
      },
      children: <Component>[
        Component.element(
          tag: 'rect',
          attributes: <String, String>{
            'x': '1',
            'y': '1',
            'width': '9',
            'height': '9',
            'fill': '#F25022',
          },
        ),
        Component.element(
          tag: 'rect',
          attributes: <String, String>{
            'x': '11',
            'y': '1',
            'width': '9',
            'height': '9',
            'fill': '#7FBA00',
          },
        ),
        Component.element(
          tag: 'rect',
          attributes: <String, String>{
            'x': '1',
            'y': '11',
            'width': '9',
            'height': '9',
            'fill': '#00A4EF',
          },
        ),
        Component.element(
          tag: 'rect',
          attributes: <String, String>{
            'x': '11',
            'y': '11',
            'width': '9',
            'height': '9',
            'fill': '#FFB900',
          },
        ),
      ],
    );
  }
}
