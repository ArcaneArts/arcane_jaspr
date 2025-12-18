import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

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
      'border-color': 'var(--arcane-accent)',
      'box-shadow': '0 0 0 2px var(--arcane-accent-container)',
    }),
    css('.arcane-newsletter-button:hover').styles(raw: {
      'background-color': 'var(--arcane-accent-hover)',
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
        styles: Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': '8px',
          'padding': '12px 16px',
          'background-color': 'var(--arcane-success)',
          'background-opacity': '0.1',
          'border': '1px solid var(--arcane-success)',
          'border-radius': 'var(--arcane-radius)',
          'color': 'var(--arcane-success)',
          'font-size': '0.875rem',
        }),
        [
          span([text('✓')]),
          span([text(component.successMessage)]),
        ],
      );
    }

    final inputHeight = component.compact ? '36px' : '44px';
    final inputPadding = component.compact ? '8px 12px' : '10px 14px';
    final buttonPadding = component.compact ? '8px 16px' : '10px 20px';

    if (component.inline) {
      return div(
        classes: 'arcane-newsletter-form',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '8px',
        }),
        [
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'gap': '8px',
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
                  'font-size': '0.875rem',
                  'background-color': 'var(--arcane-surface)',
                  'border': '1px solid ${_error != null ? 'var(--arcane-destructive)' : 'var(--arcane-border)'}',
                  'border-radius': 'var(--arcane-radius)',
                  'color': 'var(--arcane-on-surface)',
                  'outline': 'none',
                  'transition': 'border-color var(--arcane-transition-fast)',
                }),
                events: {
                  'input': (e) {
                    final target = e.target as dynamic;
                    setState(() {
                      _email = target.value as String;
                      _error = null;
                    });
                  },
                  'keypress': (e) {
                    final keyEvent = e as dynamic;
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
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'color': 'var(--arcane-accent-foreground)',
                  'background-color': 'var(--arcane-accent)',
                  'border': 'none',
                  'border-radius': 'var(--arcane-radius)',
                  'cursor': 'pointer',
                  'white-space': 'nowrap',
                  'transition': 'background-color var(--arcane-transition-fast)',
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
              styles: Styles(raw: {
                'font-size': '0.8125rem',
                'color': 'var(--arcane-destructive)',
              }),
            ),
        ],
      );
    }

    // Stacked layout
    return div(
      classes: 'arcane-newsletter-form stacked',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '12px',
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
            'font-size': '0.875rem',
            'background-color': 'var(--arcane-surface)',
            'border': '1px solid ${_error != null ? 'var(--arcane-destructive)' : 'var(--arcane-border)'}',
            'border-radius': 'var(--arcane-radius)',
            'color': 'var(--arcane-on-surface)',
            'outline': 'none',
          }),
          events: {
            'input': (e) {
              final target = e.target as dynamic;
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
            styles: Styles(raw: {
              'font-size': '0.8125rem',
              'color': 'var(--arcane-destructive)',
              'margin-top': '-4px',
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
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--arcane-accent-foreground)',
            'background-color': 'var(--arcane-accent)',
            'border': 'none',
            'border-radius': 'var(--arcane-radius)',
            'cursor': 'pointer',
            'transition': 'background-color var(--arcane-transition-fast)',
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
        styles: Styles(raw: {
          'padding': '24px',
          'text-align': 'center',
          'background-color': 'var(--arcane-surface)',
          'border': '1px solid var(--arcane-success)',
          'border-radius': 'var(--arcane-radius)',
        }),
        [
          div(
            [text('🎉')],
            styles: Styles(raw: {
              'font-size': '2rem',
              'margin-bottom': '12px',
            }),
          ),
          div(
            [text(component.successMessage)],
            styles: Styles(raw: {
              'font-size': '1rem',
              'color': 'var(--arcane-on-surface)',
            }),
          ),
        ],
      );
    }

    return div(
      classes: 'arcane-waitlist-form',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '16px',
        'padding': '24px',
        'background-color': 'var(--arcane-surface)',
        'border': '1px solid var(--arcane-border)',
        'border-radius': 'var(--arcane-radius)',
      }),
      [
        if (component.title != null)
          div(
            [text(component.title!)],
            styles: Styles(raw: {
              'font-size': '1.25rem',
              'font-weight': '600',
              'color': 'var(--arcane-on-surface)',
            }),
          ),
        if (component.description != null)
          div(
            [text(component.description!)],
            styles: Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--arcane-muted)',
              'line-height': '1.5',
            }),
          ),
        if (component.collectName)
          input(
            type: InputType.text,
            attributes: {'placeholder': 'Your name'},
            styles: Styles(raw: {
              'width': '100%',
              'height': '44px',
              'padding': '10px 14px',
              'font-size': '0.875rem',
              'background-color': 'var(--arcane-surface-variant)',
              'border': '1px solid var(--arcane-border)',
              'border-radius': 'var(--arcane-radius)',
              'color': 'var(--arcane-on-surface)',
              'outline': 'none',
            }),
            events: {
              'input': (e) {
                final target = e.target as dynamic;
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
            'font-size': '0.875rem',
            'background-color': 'var(--arcane-surface-variant)',
            'border': '1px solid ${_error != null ? 'var(--arcane-destructive)' : 'var(--arcane-border)'}',
            'border-radius': 'var(--arcane-radius)',
            'color': 'var(--arcane-on-surface)',
            'outline': 'none',
          }),
          events: {
            'input': (e) {
              final target = e.target as dynamic;
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
            styles: Styles(raw: {
              'font-size': '0.8125rem',
              'color': 'var(--arcane-destructive)',
            }),
          ),
        button(
          [text(component.buttonText)],
          attributes: {'type': 'button'},
          styles: Styles(raw: {
            'width': '100%',
            'height': '44px',
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--arcane-accent-foreground)',
            'background-color': 'var(--arcane-accent)',
            'border': 'none',
            'border-radius': 'var(--arcane-radius)',
            'cursor': 'pointer',
            'transition': 'background-color var(--arcane-transition-fast)',
          }),
          events: {
            'click': (e) => _handleSubmit(),
          },
        ),
      ],
    );
  }
}
