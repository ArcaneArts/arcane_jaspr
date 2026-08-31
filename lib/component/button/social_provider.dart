import 'package:arcane_jaspr/component/view/icon.dart';

import 'social_icons.dart';

/// OAuth provider types for social sign-in buttons.
enum SocialProvider {
  google,
  github,
  apple,
  microsoft,
  discord,
  twitter,
  facebook,
  linkedin,
  slack,
  gitlab,
}

/// Configuration for a social provider's appearance.
class SocialProviderConfig {
  final String defaultLabel;
  final String backgroundColor;
  final String foregroundColor;
  final String borderColor;
  final String hoverBackgroundColor;
  final ArcaneGlyph Function() buildIcon;

  const SocialProviderConfig({
    required this.defaultLabel,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.hoverBackgroundColor,
    required this.buildIcon,
  });

  /// Get the configuration for a given provider.
  static SocialProviderConfig forProvider(SocialProvider provider) {
    return switch (provider) {
      SocialProvider.google => const SocialProviderConfig(
        defaultLabel: 'Continue with Google',
        backgroundColor: '#ffffff',
        foregroundColor: '#1f1f1f',
        borderColor: '#dadce0',
        hoverBackgroundColor: '#f8f9fa',
        buildIcon: SocialIcons.google,
      ),
      SocialProvider.github => const SocialProviderConfig(
        defaultLabel: 'Continue with GitHub',
        backgroundColor: '#24292e',
        foregroundColor: '#ffffff',
        borderColor: '#24292e',
        hoverBackgroundColor: '#2f363d',
        buildIcon: SocialIcons.github,
      ),
      SocialProvider.apple => const SocialProviderConfig(
        defaultLabel: 'Continue with Apple',
        backgroundColor: '#000000',
        foregroundColor: '#ffffff',
        borderColor: '#000000',
        hoverBackgroundColor: '#1a1a1a',
        buildIcon: SocialIcons.apple,
      ),
      SocialProvider.microsoft => const SocialProviderConfig(
        defaultLabel: 'Continue with Microsoft',
        backgroundColor: '#2f2f2f',
        foregroundColor: '#ffffff',
        borderColor: '#2f2f2f',
        hoverBackgroundColor: '#3f3f3f',
        buildIcon: SocialIcons.microsoft,
      ),
      SocialProvider.discord => const SocialProviderConfig(
        defaultLabel: 'Continue with Discord',
        backgroundColor: '#5865F2',
        foregroundColor: '#ffffff',
        borderColor: '#5865F2',
        hoverBackgroundColor: '#4752c4',
        buildIcon: SocialIcons.discord,
      ),
      SocialProvider.twitter => const SocialProviderConfig(
        defaultLabel: 'Continue with X',
        backgroundColor: '#000000',
        foregroundColor: '#ffffff',
        borderColor: '#000000',
        hoverBackgroundColor: '#1a1a1a',
        buildIcon: SocialIcons.twitter,
      ),
      SocialProvider.facebook => const SocialProviderConfig(
        defaultLabel: 'Continue with Facebook',
        backgroundColor: '#1877F2',
        foregroundColor: '#ffffff',
        borderColor: '#1877F2',
        hoverBackgroundColor: '#166fe5',
        buildIcon: SocialIcons.facebook,
      ),
      SocialProvider.linkedin => const SocialProviderConfig(
        defaultLabel: 'Continue with LinkedIn',
        backgroundColor: '#0A66C2',
        foregroundColor: '#ffffff',
        borderColor: '#0A66C2',
        hoverBackgroundColor: '#004182',
        buildIcon: SocialIcons.linkedin,
      ),
      SocialProvider.slack => const SocialProviderConfig(
        defaultLabel: 'Continue with Slack',
        backgroundColor: '#4A154B',
        foregroundColor: '#ffffff',
        borderColor: '#4A154B',
        hoverBackgroundColor: '#611f64',
        buildIcon: SocialIcons.slack,
      ),
      SocialProvider.gitlab => const SocialProviderConfig(
        defaultLabel: 'Continue with GitLab',
        backgroundColor: '#FC6D26',
        foregroundColor: '#ffffff',
        borderColor: '#FC6D26',
        hoverBackgroundColor: '#e24329',
        buildIcon: SocialIcons.gitlab,
      ),
    };
  }
}
