import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Forgot password card component
///
/// Provides a password reset UI with email input.
///
/// ```dart
/// ArcaneForgotPasswordCard(
///   loginRoute: '/login',
///   header: Logo(),
/// )
/// ```
class ArcaneForgotPasswordCard extends StatefulComponent {
  /// Header component (logo, title, etc.)
  final Component? header;

  /// Route for login link
  final String? loginRoute;

  /// Callback when email is sent successfully
  final void Function()? onSuccess;

  /// Max width of the card
  final String maxWidth;

  const ArcaneForgotPasswordCard({
    this.header,
    this.loginRoute,
    this.onSuccess,
    this.maxWidth = '400px',
    super.key,
  });

  @override
  State<ArcaneForgotPasswordCard> createState() =>
      _ArcaneForgotPasswordCardState();
}

class _ArcaneForgotPasswordCardState extends State<ArcaneForgotPasswordCard> {
  String _email = '';
  bool _loading = false;
  bool _sent = false;
  String? _error;

  Future<void> _handleSubmit() async {
    if (_email.isEmpty) {
      setState(() => _error = 'Please enter your email.');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await context.sendPasswordResetEmail(_email);
      setState(() {
        _sent = true;
        _loading = false;
      });
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
        ArcaneDiv(
          styles: const ArcaneStyleData(
            margin: MarginPreset.bottomXs,
            fontSize: FontSize.xl,
            fontWeight: FontWeight.w600,
            textColor: TextColor.primary,
            textAlign: TextAlign.center,
          ),
          children: [Component.text(_sent ? 'Check your email' : 'Reset password')],
        ),

        ArcaneDiv(
          styles: const ArcaneStyleData(
            margin: MarginPreset.bottomLg,
            fontSize: FontSize.sm,
            textColor: TextColor.muted,
            textAlign: TextAlign.center,
          ),
          children: [
            Component.text(
              _sent
                  ? "We've sent a password reset link to $_email"
                  : 'Enter your email and we\'ll send you a reset link',
            ),
          ],
        ),

        // Success message
        if (_sent)
          const ArcaneDiv(
            styles: ArcaneStyleData(
              padding: PaddingPreset.md,
              margin: MarginPreset.bottomMd,
              backgroundCustom: 'rgba(16, 185, 129, 0.1)',
              borderCustom: '1px solid rgba(16, 185, 129, 0.3)',
              borderRadius: Radius.md,
              textColor: TextColor.success,
              fontSize: FontSize.sm,
              textAlign: TextAlign.center,
            ),
            children: <Component>[
              Component.text('Check your inbox for the password reset link.'),
            ],
          ),

        // Error message
        if (_error != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              padding: PaddingPreset.md,
              margin: MarginPreset.bottomMd,
              backgroundCustom: 'rgba(239, 68, 68, 0.1)',
              borderCustom: '1px solid rgba(239, 68, 68, 0.3)',
              borderRadius: Radius.md,
              textColor: TextColor.error,
              fontSize: FontSize.sm,
            ),
            children: <Component>[Component.text(_error!)],
          ),

        // Form (hidden if sent)
        if (!_sent)
          form(
            events: {
              'submit': (event) {
                event.preventDefault();
                _handleSubmit();
              },
            },
            <Component>[
              // Email field
              ArcaneDiv(
                styles: const ArcaneStyleData(margin: MarginPreset.bottomLg),
                children: <Component>[
                  const label(
                    styles: Styles(raw: <String, String>{
                      'display': 'block',
                      'margin-bottom': ArcaneSpacing.xs,
                      'font-size': ArcaneTypography.fontSizeSm,
                      'font-weight': '500',
                      'color': ArcaneColors.onBackground,
                    }),
                    <Component>[Component.text('Email')],
                  ),
                  input(
                    attributes: <String, String>{
                      'type': 'email',
                      'placeholder': 'you@example.com',
                      'autocomplete': 'email',
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
                          setState(
                              () => _email = (target as dynamic).value ?? '');
                        }
                      },
                    },
                  ),
                ],
              ),

              // Submit button
              ArcaneButton(
                label: _loading ? 'Sending...' : 'Send reset link',
                fullWidth: true,
                disabled: _loading,
                loading: _loading,
                onPressed: _handleSubmit,
              ),
            ],
          ),

        // Try again button (shown after sent)
        if (_sent)
          ArcaneButton.secondary(
            label: 'Try another email',
            fullWidth: true,
            onPressed: () => setState(() => _sent = false),
          ),

        // Back to login link
        if (component.loginRoute != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              margin: MarginPreset.topLg,
              textAlign: TextAlign.center,
            ),
            children: <Component>[
              a(
                href: component.loginRoute!,
                styles: const Styles(raw: <String, String>{
                  'font-size': ArcaneTypography.fontSizeSm,
                  'color': ArcaneColors.accent,
                  'text-decoration': 'none',
                }),
                <Component>[const Component.text('Back to sign in')],
              ),
            ],
          ),
      ],
    );
  }
}