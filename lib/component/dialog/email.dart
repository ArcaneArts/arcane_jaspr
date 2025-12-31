import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';
import '../input/button.dart';
import 'dialog.dart';

/// An email input dialog with validation.
///
/// ```dart
/// ArcaneEmailDialog(
///   title: 'Enter Email',
///   message: 'Please enter your email address.',
///   onConfirm: (email) => handleEmail(email),
///   onCancel: () => closeDialog(),
/// )
/// ```
class ArcaneEmailDialog extends StatefulComponent {
  /// Dialog title
  final String title;

  /// Optional message/description
  final String? message;

  /// Input placeholder
  final String placeholder;

  /// Initial email value
  final String? initialValue;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Confirm callback with the entered email
  final void Function(String email)? onConfirm;

  /// Cancel callback
  final void Function()? onCancel;

  /// Custom email validation (in addition to format validation)
  final String? Function(String email)? validator;

  /// Whether to require work/business email domains
  final bool requireWorkEmail;

  /// Blocked domains (e.g., disposable email providers)
  final List<String>? blockedDomains;

  const ArcaneEmailDialog({
    required this.title,
    this.message,
    this.placeholder = 'Enter email address...',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.requireWorkEmail = false,
    this.blockedDomains,
    super.key,
  });

  @override
  State<ArcaneEmailDialog> createState() => _EmailDialogState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-email-dialog-input input:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
  ];
}

class _EmailDialogState extends State<ArcaneEmailDialog> {
  late String _value;
  String? _error;

  // Common consumer email domains
  static const _consumerDomains = [
    'gmail.com',
    'yahoo.com',
    'hotmail.com',
    'outlook.com',
    'aol.com',
    'icloud.com',
    'mail.com',
    'protonmail.com',
  ];

  @override
  void initState() {
    super.initState();
    _value = component.initialValue ?? '';
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }

    // Basic email format validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    // Extract domain
    final domain = email.split('@').last.toLowerCase();

    // Check blocked domains
    if (component.blockedDomains != null &&
        component.blockedDomains!.contains(domain)) {
      return 'This email domain is not allowed';
    }

    // Check work email requirement
    if (component.requireWorkEmail && _consumerDomains.contains(domain)) {
      return 'Please use a work email address';
    }

    // Custom validation
    if (component.validator != null) {
      return component.validator!(email);
    }

    return null;
  }

  void _handleConfirm() {
    final error = _validateEmail(_value);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    component.onConfirm?.call(_value.trim());
  }

  @override
  Component build(BuildContext context) {
    return ArcaneDialog(
      title: component.title,
      onClose: component.onCancel,
      maxWidth: 450,
      child: div(
        classes: 'arcane-email-dialog-content',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': ArcaneSpacing.md,
        }),
        [
          if (component.message != null)
            div(
              styles: const Styles(raw: {
                'color': ArcaneColors.muted,
                'font-size': ArcaneTypography.fontSm,
                'line-height': ArcaneTypography.lineHeightRelaxed,
              }),
              [text(component.message!)],
            ),

          // Email input field
          div(
            classes: 'arcane-email-dialog-input',
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': ArcaneSpacing.xs,
            }),
            [
              // Input with email icon
              div(
                styles: const Styles(raw: {
                  'position': 'relative',
                  'display': 'flex',
                  'align-items': 'center',
                }),
                [
                  span(
                    styles: const Styles(raw: {
                      'position': 'absolute',
                      'left': ArcaneSpacing.sm,
                      'color': ArcaneColors.muted,
                      'pointer-events': 'none',
                    }),
                    [text('✉')],
                  ),
                  input(
                    type: InputType.email,
                    attributes: {
                      'value': _value,
                      'placeholder': component.placeholder,
                      'autofocus': 'true',
                      'autocomplete': 'email',
                    },
                    styles: Styles(raw: {
                      'width': '100%',
                      'padding': '10px ${ArcaneSpacing.sm}',
                      'padding-left': '36px',
                      'border': _error != null
                          ? '1px solid ${ArcaneColors.error}'
                          : '1px solid ${ArcaneColors.border}',
                      'border-radius': ArcaneRadius.md,
                      'background-color': ArcaneColors.surface,
                      'color': ArcaneColors.onSurface,
                      'font-size': ArcaneTypography.fontSm,
                      'outline': 'none',
                    }),
                    events: {
                      'input': (event) {
                        final dynamic target = event.target;
                        if (target != null) {
                          setState(() {
                            _value = target.value ?? '';
                            _error = null;
                          });
                        }
                      },
                      'keydown': (event) {
                        if ((event as dynamic).key == 'Enter') {
                          _handleConfirm();
                        }
                      },
                    },
                  ),
                ],
              ),

              if (_error != null)
                span(
                  styles: const Styles(raw: {
                    'color': ArcaneColors.error,
                    'font-size': ArcaneTypography.fontXs,
                    'display': 'flex',
                    'align-items': 'center',
                    'gap': ArcaneSpacing.xs,
                  }),
                  [
                    text('⚠'),
                    text(_error!),
                  ],
                ),

              if (component.requireWorkEmail)
                span(
                  styles: const Styles(raw: {
                    'color': ArcaneColors.muted,
                    'font-size': ArcaneTypography.fontXs,
                  }),
                  [text('Please use your work email address')],
                ),
            ],
          ),
        ],
      ),
      actions: [
        ArcaneButton.outline(
          label: component.cancelText,
          onPressed: component.onCancel,
        ),
        ArcaneButton.primary(
          label: component.confirmText,
          onPressed: _handleConfirm,
        ),
      ],
    );
  }
}
