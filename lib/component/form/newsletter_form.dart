import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// A newsletter signup form (Supabase-style)
class NewsletterForm extends StatefulComponent {
  /// Placeholder text
  final String placeholder;

  /// Submit button text
  final String buttonText;

  /// Success message
  final String successMessage;

  /// Submit callback
  final void Function(String email)? onSubmit;

  /// Whether to show inline (horizontal) layout
  final bool inline;

  /// Whether the form is compact
  final bool compact;

  const NewsletterForm({
    this.placeholder = 'Enter your email',
    this.buttonText = 'Subscribe',
    this.successMessage = 'Thanks for subscribing!',
    this.onSubmit,
    this.inline = true,
    this.compact = false,
    super.key,
  });

  @override
  State<NewsletterForm> createState() => _NewsletterFormState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-newsletter-input:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
    css('.arcane-newsletter-button:hover').styles(raw: {
      'filter': 'brightness(1.1)',
    }),
  ];
}

class _NewsletterFormState extends State<NewsletterForm> {
  String _email = '';
  bool _submitted = false;
  String? _error;

  void _handleSubmit() {
    if (_email.isEmpty) {
      setState(() => _error = 'Please enter your email');
      return;
    }

    if (!_email.contains('@')) {
      setState(() => _error = 'Please enter a valid email');
      return;
    }

    setState(() {
      _error = null;
      _submitted = true;
    });

    component.onSubmit?.call(_email);
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return div(
        classes: 'arcane-newsletter-success',
        styles: const Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': ArcaneSpacing.sm,
          'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
          'background-color': ArcaneColors.successContainer,
          'border': '1px solid ${ArcaneColors.success}',
          'border-radius': ArcaneRadius.md,
          'color': ArcaneColors.success,
          'font-size': ArcaneTypography.fontSm,
        }),
        [
          span([text('✓')]),
          span([text(component.successMessage)]),
        ],
      );
    }

    final String inputHeight = component.compact ? '36px' : '44px';
    final String inputPadding = component.compact ? '${ArcaneSpacing.sm} ${ArcaneSpacing.md}' : '10px 14px';
    final String buttonPadding = component.compact ? '${ArcaneSpacing.sm} ${ArcaneSpacing.lg}' : '10px 20px';

    if (component.inline) {
      return div(
        classes: 'arcane-newsletter-form',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': ArcaneSpacing.sm,
        }),
        [
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'gap': ArcaneSpacing.sm,
            }),
            [
              input(
                type: InputType.email,
                classes: 'arcane-newsletter-input',
                attributes: {
                  'placeholder': component.placeholder,
                },
                styles: Styles(raw: {
                  'flex': '1',
                  'height': inputHeight,
                  'padding': inputPadding,
                  'font-size': ArcaneTypography.fontSm,
                  'background-color': ArcaneColors.surface,
                  'border': '1px solid ${_error != null ? ArcaneColors.error : ArcaneColors.border}',
                  'border-radius': ArcaneRadius.md,
                  'color': ArcaneColors.onSurface,
                  'outline': 'none',
                  'transition': ArcaneEffects.transitionFast,
                }),
                events: {
                  'input': (e) {
                    final dynamic target = e.target;
                    setState(() {
                      _email = target.value as String;
                      _error = null;
                    });
                  },
                  'keypress': (e) {
                    final dynamic keyEvent = e;
                    if (keyEvent.key == 'Enter') {
                      _handleSubmit();
                    }
                  },
                },
              ),
              button(
                [text(component.buttonText)],
                classes: 'arcane-newsletter-button',
                attributes: {'type': 'button'},
                styles: Styles(raw: {
                  'height': inputHeight,
                  'padding': buttonPadding,
                  'font-size': ArcaneTypography.fontSm,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': ArcaneColors.accentForeground,
                  'background-color': ArcaneColors.accent,
                  'border': 'none',
                  'border-radius': ArcaneRadius.md,
                  'cursor': 'pointer',
                  'white-space': 'nowrap',
                  'transition': ArcaneEffects.transitionFast,
                }),
                events: {
                  'click': (e) => _handleSubmit(),
                },
              ),
            ],
          ),
          if (_error != null)
            span(
              [text(_error!)],
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontXs,
                'color': ArcaneColors.error,
              }),
            ),
        ],
      );
    }

    // Stacked layout
    return div(
      classes: 'arcane-newsletter-form stacked',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.md,
      }),
      [
        input(
          type: InputType.email,
          classes: 'arcane-newsletter-input',
          attributes: {
            'placeholder': component.placeholder,
          },
          styles: Styles(raw: {
            'width': '100%',
            'height': inputHeight,
            'padding': inputPadding,
            'font-size': ArcaneTypography.fontSm,
            'background-color': ArcaneColors.surface,
            'border': '1px solid ${_error != null ? ArcaneColors.error : ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'color': ArcaneColors.onSurface,
            'outline': 'none',
          }),
          events: {
            'input': (e) {
              final dynamic target = e.target;
              setState(() {
                _email = target.value as String;
                _error = null;
              });
            },
          },
        ),
        if (_error != null)
          span(
            [text(_error!)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.error,
              'margin-top': '-${ArcaneSpacing.xs}',
            }),
          ),
        button(
          [text(component.buttonText)],
          classes: 'arcane-newsletter-button',
          attributes: {'type': 'button'},
          styles: Styles(raw: {
            'width': '100%',
            'height': inputHeight,
            'padding': buttonPadding,
            'font-size': ArcaneTypography.fontSm,
            'font-weight': ArcaneTypography.weightMedium,
            'color': ArcaneColors.accentForeground,
            'background-color': ArcaneColors.accent,
            'border': 'none',
            'border-radius': ArcaneRadius.md,
            'cursor': 'pointer',
            'transition': ArcaneEffects.transitionFast,
          }),
          events: {
            'click': (e) => _handleSubmit(),
          },
        ),
      ],
    );
  }
}

/// A waitlist form with additional fields
class WaitlistForm extends StatefulComponent {
  /// Form title
  final String? title;

  /// Form description
  final String? description;

  /// Submit button text
  final String buttonText;

  /// Success message
  final String successMessage;

  /// Submit callback
  final void Function(String email, String? name)? onSubmit;

  /// Whether to collect name
  final bool collectName;

  const WaitlistForm({
    this.title,
    this.description,
    this.buttonText = 'Join Waitlist',
    this.successMessage = "You're on the list! We'll be in touch.",
    this.onSubmit,
    this.collectName = true,
    super.key,
  });

  @override
  State<WaitlistForm> createState() => _WaitlistFormState();
}

class _WaitlistFormState extends State<WaitlistForm> {
  String _email = '';
  String _name = '';
  bool _submitted = false;
  String? _error;

  void _handleSubmit() {
    if (_email.isEmpty || !_email.contains('@')) {
      setState(() => _error = 'Please enter a valid email');
      return;
    }

    setState(() {
      _error = null;
      _submitted = true;
    });

    component.onSubmit?.call(_email, component.collectName ? _name : null);
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return div(
        classes: 'arcane-waitlist-success',
        styles: const Styles(raw: {
          'padding': ArcaneSpacing.xl,
          'text-align': 'center',
          'background-color': ArcaneColors.surface,
          'border': '1px solid ${ArcaneColors.success}',
          'border-radius': ArcaneRadius.md,
        }),
        [
          div(
            [text('!')],
            styles: const Styles(raw: {
              'font-size': '2rem',
              'margin-bottom': ArcaneSpacing.md,
            }),
          ),
          div(
            [text(component.successMessage)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontBase,
              'color': ArcaneColors.onSurface,
            }),
          ),
        ],
      );
    }

    return div(
      classes: 'arcane-waitlist-form',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.lg,
        'padding': ArcaneSpacing.xl,
        'background-color': ArcaneColors.surface,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
      }),
      [
        if (component.title != null)
          div(
            [text(component.title!)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontLg,
              'font-weight': ArcaneTypography.weightSemibold,
              'color': ArcaneColors.onSurface,
            }),
          ),
        if (component.description != null)
          div(
            [text(component.description!)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'line-height': ArcaneTypography.lineHeightRelaxed,
            }),
          ),
        if (component.collectName)
          input(
            type: InputType.text,
            attributes: {'placeholder': 'Your name'},
            styles: const Styles(raw: {
              'width': '100%',
              'height': '44px',
              'padding': '10px 14px',
              'font-size': ArcaneTypography.fontSm,
              'background-color': ArcaneColors.surfaceVariant,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.md,
              'color': ArcaneColors.onSurface,
              'outline': 'none',
            }),
            events: {
              'input': (e) {
                final dynamic target = e.target;
                setState(() => _name = target.value as String);
              },
            },
          ),
        input(
          type: InputType.email,
          attributes: {'placeholder': 'your@email.com'},
          styles: Styles(raw: {
            'width': '100%',
            'height': '44px',
            'padding': '10px 14px',
            'font-size': ArcaneTypography.fontSm,
            'background-color': ArcaneColors.surfaceVariant,
            'border': '1px solid ${_error != null ? ArcaneColors.error : ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'color': ArcaneColors.onSurface,
            'outline': 'none',
          }),
          events: {
            'input': (e) {
              final dynamic target = e.target;
              setState(() {
                _email = target.value as String;
                _error = null;
              });
            },
          },
        ),
        if (_error != null)
          span(
            [text(_error!)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.error,
            }),
          ),
        button(
          [text(component.buttonText)],
          attributes: {'type': 'button'},
          styles: const Styles(raw: {
            'width': '100%',
            'height': '44px',
            'font-size': ArcaneTypography.fontSm,
            'font-weight': ArcaneTypography.weightMedium,
            'color': ArcaneColors.accentForeground,
            'background-color': ArcaneColors.accent,
            'border': 'none',
            'border-radius': ArcaneRadius.md,
            'cursor': 'pointer',
            'transition': ArcaneEffects.transitionFast,
          }),
          events: {
            'click': (e) => _handleSubmit(),
          },
        ),
      ],
    );
  }
}