import 'package:arcane_jaspr/arcane_jaspr.dart';

import '../button/github_button.dart';
import '../button/google_button.dart';
import '../button/apple_button.dart';
import '../../util/auth/password_policy.dart';

/// Signup card component
///
/// Provides a complete registration UI with email/password form and social sign-in buttons.
///
/// ```dart
/// ArcaneSignupCard(
///   methods: [AuthMethod.email, AuthMethod.github, AuthMethod.google],
///   loginRoute: '/login',
///   header: Logo(),
/// )
/// ```
class ArcaneSignupCard extends StatefulComponent {
  /// Authentication methods to display
  final List<AuthMethod> methods;

  /// Header component (logo, title, etc.)
  final Component? header;

  /// Route for login link
  final String? loginRoute;

  /// Password validation policy
  final PasswordPolicy passwordPolicy;

  /// Terms of service URL
  final String? termsUrl;

  /// Privacy policy URL
  final String? privacyUrl;

  /// Callback when registration succeeds
  final void Function()? onSuccess;

  /// Max width of the card
  final String maxWidth;

  const ArcaneSignupCard({
    this.methods = const <AuthMethod>[
      AuthMethod.email,
      AuthMethod.github,
      AuthMethod.google,
    ],
    this.header,
    this.loginRoute,
    this.passwordPolicy = const PasswordPolicy(),
    this.termsUrl,
    this.privacyUrl,
    this.onSuccess,
    this.maxWidth = '400px',
    super.key,
  });

  @override
  State<ArcaneSignupCard> createState() => _ArcaneSignupCardState();
}

class _ArcaneSignupCardState extends State<ArcaneSignupCard> {
  String _displayName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _acceptedTerms = false;
  bool _loading = false;
  String? _error;

  bool get _hasEmailMethod => component.methods.contains(AuthMethod.email);
  bool get _hasGithubMethod => component.methods.contains(AuthMethod.github);
  bool get _hasGoogleMethod => component.methods.contains(AuthMethod.google);
  bool get _hasAppleMethod => component.methods.contains(AuthMethod.apple);
  bool get _hasSocialMethods =>
      _hasGithubMethod || _hasGoogleMethod || _hasAppleMethod;
  bool get _hasTerms =>
      component.termsUrl != null || component.privacyUrl != null;

  Future<void> _handleSubmit() async {
    // Validation
    if (_displayName.isEmpty) {
      setState(() => _error = 'Please enter your name.');
      return;
    }
    if (_email.isEmpty) {
      setState(() => _error = 'Please enter your email.');
      return;
    }
    if (_password.isEmpty) {
      setState(() => _error = 'Please enter a password.');
      return;
    }

    // Password policy validation
    final String? passwordError = component.passwordPolicy.validate(_password);
    if (passwordError != null) {
      setState(() => _error = passwordError);
      return;
    }

    if (_password != _confirmPassword) {
      setState(() => _error = 'Passwords do not match.');
      return;
    }

    if (_hasTerms && !_acceptedTerms) {
      setState(() => _error = 'Please accept the terms and conditions.');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await context.registerWithEmail(_email, _password, _displayName);
      component.onSuccess?.call();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        width: Size.full,
        maxWidthCustom: component.maxWidth,
        padding: PaddingPreset.xl,
        background: Background.surface,
        border: BorderPreset.standard,
        borderRadius: Radius.lg,
        shadow: Shadow.lg,
      ),
      children: <Component>[
        // Header
        if (component.header != null) ...<Component>[
          component.header!,
          const ArcaneDiv(
            styles: ArcaneStyleData(heightCustom: ArcaneSpacing.lg),
            children: <Component>[],
          ),
        ],

        // Title
        const ArcaneDiv(
          styles: ArcaneStyleData(
            margin: MarginPreset.bottomXs,
            fontSize: FontSize.xl,
            fontWeight: FontWeight.w600,
            textColor: TextColor.primary,
            textAlign: TextAlign.center,
          ),
          children: [Component.text('Create an account')],
        ),

        const ArcaneDiv(
          styles: ArcaneStyleData(
            margin: MarginPreset.bottomLg,
            fontSize: FontSize.sm,
            textColor: TextColor.muted,
            textAlign: TextAlign.center,
          ),
          children: [Component.text('Get started with your free account')],
        ),

        // Error message
        if (_error != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              padding: PaddingPreset.md,
              margin: MarginPreset.bottomMd,
              backgroundCustom: ArcaneColors.errorAlpha10,
              borderCustom: '1px solid ${ArcaneColors.errorAlpha30}',
              borderRadius: Radius.md,
              textColor: TextColor.error,
              fontSize: FontSize.sm,
            ),
            children: <Component>[Component.text(_error!)],
          ),

        // Social sign-in buttons
        if (_hasSocialMethods) ...<Component>[
          ArcaneDiv(
            styles: const ArcaneStyleData(
              display: Display.flex,
              flexDirection: FlexDirection.column,
              gap: Gap.sm,
            ),
            children: <Component>[
              if (_hasGithubMethod)
                GithubSignInButton(
                  label: 'Sign up with GitHub',
                  fullWidth: true,
                  disabled: _loading,
                ),
              if (_hasGoogleMethod)
                GoogleSignInButton(
                  label: 'Sign up with Google',
                  fullWidth: true,
                  disabled: _loading,
                ),
              if (_hasAppleMethod)
                AppleSignInButton(
                  label: 'Sign up with Apple',
                  fullWidth: true,
                  disabled: _loading,
                ),
            ],
          ),
        ],

        // Divider
        if (_hasSocialMethods && _hasEmailMethod)
          const ArcaneDiv(
            styles: ArcaneStyleData(
              display: Display.flex,
              alignItems: AlignItems.center,
              gap: Gap.md,
              margin: MarginPreset.verticalLg,
            ),
            children: <Component>[
              ArcaneDiv(
                styles: ArcaneStyleData(
                  flexGrow: 1,
                  heightCustom: '1px',
                  backgroundCustom: ArcaneColors.border,
                ),
                children: <Component>[],
              ),
              ArcaneDiv(
                styles: ArcaneStyleData(
                  fontSize: FontSize.xs,
                  textColor: TextColor.muted,
                  textTransform: TextTransform.uppercase,
                  letterSpacing: LetterSpacing.wide,
                ),
                children: [Component.text('or continue with email')],
              ),
              ArcaneDiv(
                styles: ArcaneStyleData(
                  flexGrow: 1,
                  heightCustom: '1px',
                  backgroundCustom: ArcaneColors.border,
                ),
                children: <Component>[],
              ),
            ],
          ),

        // Email/password form
        if (_hasEmailMethod)
          form(
            events: {
              'submit': (event) {
                event.preventDefault();
                _handleSubmit();
              },
            },
            <Component>[
              // Display name field
              _buildField(
                labelText: 'Name',
                type: 'text',
                placeholder: 'Your name',
                autocomplete: 'name',
                onChanged: (String value) =>
                    setState(() => _displayName = value),
              ),

              // Email field
              _buildField(
                labelText: 'Email',
                type: 'email',
                placeholder: 'you@example.com',
                autocomplete: 'email',
                onChanged: (String value) => setState(() => _email = value),
              ),

              // Password field
              _buildField(
                labelText: 'Password',
                type: 'password',
                placeholder: 'Create a password',
                autocomplete: 'new-password',
                hint: component.passwordPolicy.description,
                onChanged: (String value) => setState(() => _password = value),
              ),

              // Confirm password field
              _buildField(
                labelText: 'Confirm Password',
                type: 'password',
                placeholder: 'Confirm your password',
                autocomplete: 'new-password',
                onChanged: (String value) =>
                    setState(() => _confirmPassword = value),
              ),

              // Terms checkbox
              if (_hasTerms)
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    display: Display.flex,
                    alignItems: AlignItems.flexStart,
                    gap: Gap.sm,
                    margin: MarginPreset.bottomLg,
                  ),
                  children: <Component>[
                    input(
                      attributes: <String, String>{
                        'type': 'checkbox',
                        'id': 'terms',
                        if (_acceptedTerms) 'checked': 'true',
                      },
                      styles: const Styles(raw: <String, String>{
                        'margin-top': '2px',
                        'accent-color': ArcaneColors.accent,
                      }),
                      events: {
                        'change': (event) {
                          final dynamic target = event.target;
                          if (target != null) {
                            setState(() =>
                                _acceptedTerms =
                                    (target as dynamic).checked ?? false);
                          }
                        },
                      },
                    ),
                    label(
                      attributes: <String, String>{'for': 'terms'},
                      styles: const Styles(raw: <String, String>{
                        'font-size': ArcaneTypography.fontSizeSm,
                        'color': ArcaneColors.muted,
                        'cursor': 'pointer',
                      }),
                      <Component>[
                        const Component.text('I agree to the '),
                        if (component.termsUrl != null)
                          a(
                            href: component.termsUrl!,
                            attributes: <String, String>{'target': '_blank'},
                            styles: const Styles(raw: <String, String>{
                              'color': ArcaneColors.accent,
                              'text-decoration': 'none',
                            }),
                            <Component>[const Component.text('Terms of Service')],
                          ),
                        if (component.termsUrl != null &&
                            component.privacyUrl != null)
                          const Component.text(' and '),
                        if (component.privacyUrl != null)
                          a(
                            href: component.privacyUrl!,
                            attributes: <String, String>{'target': '_blank'},
                            styles: const Styles(raw: <String, String>{
                              'color': ArcaneColors.accent,
                              'text-decoration': 'none',
                            }),
                            <Component>[const Component.text('Privacy Policy')],
                          ),
                      ],
                    ),
                  ],
                ),

              // Submit button
              ArcaneButton(
                label: _loading ? 'Creating account...' : 'Create account',
                fullWidth: true,
                disabled: _loading,
                loading: _loading,
                onPressed: _handleSubmit,
              ),
            ],
          ),

        // Login link
        if (component.loginRoute != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              margin: MarginPreset.topLg,
              textAlign: TextAlign.center,
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
            ),
            children: <Component>[
              const Component.text('Already have an account? '),
              a(
                href: component.loginRoute!,
                styles: const Styles(raw: <String, String>{
                  'color': ArcaneColors.accent,
                  'text-decoration': 'none',
                  'font-weight': '500',
                }),
                <Component>[const Component.text('Sign in')],
              ),
            ],
          ),
      ],
    );
  }

  Component _buildField({
    required String labelText,
    required String type,
    required String placeholder,
    required String autocomplete,
    required void Function(String) onChanged,
    String? hint,
  }) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(margin: MarginPreset.bottomMd),
      children: <Component>[
        label(
          styles: const Styles(raw: <String, String>{
            'display': 'block',
            'margin-bottom': ArcaneSpacing.xs,
            'font-size': ArcaneTypography.fontSizeSm,
            'font-weight': '500',
            'color': ArcaneColors.onBackground,
          }),
          <Component>[Component.text(labelText)],
        ),
        input(
          attributes: <String, String>{
            'type': type,
            'placeholder': placeholder,
            'autocomplete': autocomplete,
            'required': 'true',
          },
          styles: const Styles(raw: <String, String>{
            'width': '100%',
            'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
            'font-size': ArcaneTypography.fontSizeSm,
            'background': ArcaneColors.backgroundSecondary,
            'border': '1px solid ${ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'color': ArcaneColors.onBackground,
            'outline': 'none',
            'transition': ArcaneEffects.transitionFast,
            'box-sizing': 'border-box',
          }),
          events: {
            'input': (event) {
              final dynamic target = event.target;
              if (target != null) {
                final String value = (target as dynamic).value ?? '';
                onChanged(value);
              }
            },
          },
        ),
        if (hint != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              margin: MarginPreset.topXs,
              fontSize: FontSize.xs,
              textColor: TextColor.muted,
            ),
            children: [Component.text(hint)],
          ),
      ],
    );
  }
}
