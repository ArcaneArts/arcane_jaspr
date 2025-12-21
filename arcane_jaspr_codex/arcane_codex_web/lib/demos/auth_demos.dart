import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demos for authentication components
class AuthDemos {
  /// Login card demo
  static List<Component> loginCard() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          justifyContent: JustifyContent.center,
          padding: PaddingPreset.xl,
          background: Background.background,
        ),
        children: [
          ArcaneLoginCard(
            methods: const [AuthMethod.email, AuthMethod.github, AuthMethod.google],
            signupRoute: '/signup',
            forgotPasswordRoute: '/forgot-password',
          ),
        ],
      ),
    ];
  }

  /// Signup card demo
  static List<Component> signupCard() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          justifyContent: JustifyContent.center,
          padding: PaddingPreset.xl,
          background: Background.background,
        ),
        children: [
          ArcaneSignupCard(
            methods: const [AuthMethod.email, AuthMethod.github, AuthMethod.google],
            loginRoute: '/login',
            termsUrl: '/terms',
            privacyUrl: '/privacy',
            passwordPolicy: PasswordPolicy.medium,
          ),
        ],
      ),
    ];
  }

  /// Forgot password card demo
  static List<Component> forgotPasswordCard() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          justifyContent: JustifyContent.center,
          padding: PaddingPreset.xl,
          background: Background.background,
        ),
        children: [
          ArcaneForgotPasswordCard(
            loginRoute: '/login',
          ),
        ],
      ),
    ];
  }

  /// GitHub sign-in button demo
  static List<Component> githubButton() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.md,
          padding: PaddingPreset.lg,
        ),
        children: [
          const GithubSignInButton(
            onPressed: null,
          ),
          const GithubSignInButton(
            fullWidth: true,
            onPressed: null,
          ),
          const GithubSignInButton(
            label: 'Sign up with GitHub',
            onPressed: null,
          ),
        ],
      ),
    ];
  }

  /// Google sign-in button demo
  static List<Component> googleButton() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.md,
          padding: PaddingPreset.lg,
        ),
        children: [
          const GoogleSignInButton(
            onPressed: null,
          ),
          const GoogleSignInButton(
            fullWidth: true,
            onPressed: null,
          ),
          const GoogleSignInButton(
            label: 'Sign up with Google',
            onPressed: null,
          ),
        ],
      ),
    ];
  }

  /// Apple sign-in button demo
  static List<Component> appleButton() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.md,
          padding: PaddingPreset.lg,
        ),
        children: [
          const AppleSignInButton(
            onPressed: null,
          ),
          const AppleSignInButton(
            fullWidth: true,
            onPressed: null,
          ),
          const AppleSignInButton(
            label: 'Sign up with Apple',
            onPressed: null,
          ),
        ],
      ),
    ];
  }

  /// Auth split layout demo
  static List<Component> authSplitLayout() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          heightCustom: '500px',
          overflow: Overflow.hidden,
          borderRadius: Radius.lg,
          border: BorderPreset.standard,
        ),
        children: [
          AuthSplitLayout(
            brandingContent: const AuthBrandingPanel(
              tagline: 'Build amazing apps',
              description: 'The complete authentication solution for your Jaspr web applications.',
              features: [
                'Firebase Authentication',
                'OAuth providers (GitHub, Google, Apple)',
                'Email/password support',
                'Route protection with guards',
              ],
            ),
            formContent: ArcaneLoginCard(
              methods: const [AuthMethod.email, AuthMethod.github],
              signupRoute: '/signup',
            ),
          ),
        ],
      ),
    ];
  }

  /// Auth branding panel demo
  static List<Component> authBrandingPanel() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          heightCustom: '400px',
          background: Background.surface,
          borderRadius: Radius.lg,
          padding: PaddingPreset.xl,
        ),
        children: const [
          AuthBrandingPanel(
            tagline: 'Welcome to Arcane',
            description: 'A powerful UI framework for building beautiful web applications with Dart.',
            features: [
              'Modern, responsive design',
              'Dark mode support',
              'Firebase integration',
              'Easy to customize',
            ],
            testimonialQuote: 'Arcane has transformed how we build web apps.',
            testimonialAuthor: 'Jane Developer',
            testimonialTitle: 'CTO at TechCorp',
          ),
        ],
      ),
    ];
  }

  /// Password policy demo
  static List<Component> passwordPolicy() {
    return [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.lg,
          padding: PaddingPreset.lg,
        ),
        children: [
          // Weak policy
          ArcaneCard(
            child: ArcaneDiv(
              styles: const ArcaneStyleData(padding: PaddingPreset.md),
              children: [
                const ArcaneDiv(
                  styles: ArcaneStyleData(
                    fontWeight: FontWeight.w600,
                    margin: MarginPreset.bottomSm,
                  ),
                  children: [ArcaneText('Weak Policy')],
                ),
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.sm,
                    textColor: TextColor.muted,
                  ),
                  children: [ArcaneText(PasswordPolicy.weak.description)],
                ),
              ],
            ),
          ),
          // Medium policy
          ArcaneCard(
            child: ArcaneDiv(
              styles: const ArcaneStyleData(padding: PaddingPreset.md),
              children: [
                const ArcaneDiv(
                  styles: ArcaneStyleData(
                    fontWeight: FontWeight.w600,
                    margin: MarginPreset.bottomSm,
                  ),
                  children: [ArcaneText('Medium Policy')],
                ),
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.sm,
                    textColor: TextColor.muted,
                  ),
                  children: [ArcaneText(PasswordPolicy.medium.description)],
                ),
              ],
            ),
          ),
          // Strong policy
          ArcaneCard(
            child: ArcaneDiv(
              styles: const ArcaneStyleData(padding: PaddingPreset.md),
              children: [
                const ArcaneDiv(
                  styles: ArcaneStyleData(
                    fontWeight: FontWeight.w600,
                    margin: MarginPreset.bottomSm,
                  ),
                  children: [ArcaneText('Strong Policy')],
                ),
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.sm,
                    textColor: TextColor.muted,
                  ),
                  children: [ArcaneText(PasswordPolicy.strong.description)],
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }
}
