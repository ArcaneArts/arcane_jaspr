---
title: ArcaneForm
description: Form wrapper with validation and submission handling
layout: docs
component: form
---

# ArcaneForm

A form wrapper component that handles validation, submission, and form state management.

## Basic Usage

```dart
ArcaneForm(
  onSubmit: handleSubmit,
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneTextInput(
        label: 'Email',
        name: 'email',
        type: TextInputType.email,
      ),
      ArcaneTextInput(
        label: 'Password',
        name: 'password',
        type: TextInputType.password,
      ),
      ArcaneButton.primary(
        label: 'Submit',
        type: ButtonType.submit,
      ),
    ],
  ),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Form content |
| `onSubmit` | `Function(Map<String, dynamic>)?` | `null` | Submit handler |
| `onReset` | `VoidCallback?` | `null` | Reset handler |
| `autoValidate` | `bool` | `false` | Validate on change |
| `id` | `String?` | `null` | Form ID |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Validation

```dart
ArcaneForm(
  autoValidate: true,
  onSubmit: (data) {
    print('Form data: $data');
  },
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneTextInput(
        label: 'Email',
        name: 'email',
        required: true,
        validator: (value) {
          if (!value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
      ArcaneTextInput(
        label: 'Password',
        name: 'password',
        required: true,
        minLength: 8,
        validator: (value) {
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
      ),
      ArcaneButton.primary(
        label: 'Sign Up',
        type: ButtonType.submit,
      ),
    ],
  ),
)
```

## With Form Sections

```dart
ArcaneForm(
  onSubmit: handleSubmit,
  child: ArcaneColumn(
    gap: Gap.xl,
    children: [
      ArcaneFormSection(
        title: 'Personal Information',
        description: 'Basic details about yourself',
        children: [
          ArcaneRow(
            gap: Gap.md,
            children: [
              ArcaneTextInput(label: 'First Name', name: 'firstName'),
              ArcaneTextInput(label: 'Last Name', name: 'lastName'),
            ],
          ),
          ArcaneTextInput(label: 'Email', name: 'email', type: TextInputType.email),
        ],
      ),
      ArcaneFormSection(
        title: 'Address',
        children: [
          ArcaneTextInput(label: 'Street Address', name: 'street'),
          ArcaneRow(
            gap: Gap.md,
            children: [
              ArcaneTextInput(label: 'City', name: 'city'),
              ArcaneTextInput(label: 'State', name: 'state'),
              ArcaneTextInput(label: 'ZIP', name: 'zip'),
            ],
          ),
        ],
      ),
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.end,
        gap: Gap.md,
        children: [
          ArcaneButton.secondary(label: 'Cancel', type: ButtonType.reset),
          ArcaneButton.primary(label: 'Save', type: ButtonType.submit),
        ],
      ),
    ],
  ),
)
```

## Examples

### Login Form

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.lg,
    children: [
      ArcaneHeadline(text: 'Sign In'),
      ArcaneForm(
        onSubmit: (data) async {
          await login(data['email'], data['password']);
        },
        child: ArcaneColumn(
          gap: Gap.md,
          children: [
            ArcaneTextInput(
              label: 'Email',
              name: 'email',
              type: TextInputType.email,
              required: true,
              placeholder: 'you@example.com',
            ),
            ArcaneTextInput(
              label: 'Password',
              name: 'password',
              type: TextInputType.password,
              required: true,
            ),
            ArcaneRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ArcaneCheckbox(
                  label: 'Remember me',
                  name: 'remember',
                ),
                ArcaneLink(
                  href: '/forgot-password',
                  child: ArcaneText('Forgot password?'),
                ),
              ],
            ),
            ArcaneButton.primary(
              label: 'Sign In',
              type: ButtonType.submit,
              isFullWidth: true,
            ),
          ],
        ),
      ),
      ArcaneDivider(),
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.center,
        gap: Gap.xs,
        children: [
          ArcaneText('Don\'t have an account?'),
          ArcaneLink(href: '/signup', child: ArcaneText('Sign up')),
        ],
      ),
    ],
  ),
)
```

### Registration Form

```dart
ArcaneForm(
  autoValidate: true,
  onSubmit: register,
  child: ArcaneColumn(
    gap: Gap.lg,
    children: [
      ArcaneRow(
        gap: Gap.md,
        children: [
          ArcaneTextInput(
            label: 'First Name',
            name: 'firstName',
            required: true,
          ),
          ArcaneTextInput(
            label: 'Last Name',
            name: 'lastName',
            required: true,
          ),
        ],
      ),
      ArcaneTextInput(
        label: 'Email',
        name: 'email',
        type: TextInputType.email,
        required: true,
      ),
      ArcaneTextInput(
        label: 'Password',
        name: 'password',
        type: TextInputType.password,
        required: true,
        helperText: 'At least 8 characters with a number',
      ),
      ArcaneTextInput(
        label: 'Confirm Password',
        name: 'confirmPassword',
        type: TextInputType.password,
        required: true,
      ),
      ArcaneCheckbox(
        label: 'I agree to the Terms of Service and Privacy Policy',
        name: 'terms',
        required: true,
      ),
      ArcaneButton.primary(
        label: 'Create Account',
        type: ButtonType.submit,
        isFullWidth: true,
      ),
    ],
  ),
)
```

### Contact Form

```dart
ArcaneForm(
  onSubmit: (data) async {
    await sendMessage(data);
    showSuccessToast('Message sent!');
  },
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneRow(
        gap: Gap.md,
        children: [
          ArcaneTextInput(
            label: 'Name',
            name: 'name',
            required: true,
          ),
          ArcaneTextInput(
            label: 'Email',
            name: 'email',
            type: TextInputType.email,
            required: true,
          ),
        ],
      ),
      ArcaneSelect(
        label: 'Subject',
        name: 'subject',
        options: [
          SelectOption(value: 'general', label: 'General Inquiry'),
          SelectOption(value: 'support', label: 'Technical Support'),
          SelectOption(value: 'billing', label: 'Billing Question'),
          SelectOption(value: 'other', label: 'Other'),
        ],
      ),
      ArcaneTextArea(
        label: 'Message',
        name: 'message',
        required: true,
        rows: 5,
        placeholder: 'How can we help?',
      ),
      ArcaneButton.primary(
        label: 'Send Message',
        type: ButtonType.submit,
      ),
    ],
  ),
)
```

### Settings Form

```dart
ArcaneForm(
  onSubmit: saveSettings,
  child: ArcaneColumn(
    gap: Gap.xl,
    children: [
      ArcaneFormSection(
        title: 'Profile',
        children: [
          ArcaneRow(
            gap: Gap.md,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArcaneAvatar(
                imageUrl: user.avatar,
                size: AvatarSize.xl,
              ),
              ArcaneColumn(
                gap: Gap.sm,
                children: [
                  ArcaneButton.secondary(
                    label: 'Change Photo',
                    onPressed: changePhoto,
                  ),
                  ArcaneText(
                    'JPG, GIF or PNG. Max 2MB.',
                    styles: const ArcaneStyleData(
                      fontSize: FontSize.sm,
                      textColor: TextColor.muted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ArcaneTextInput(
            label: 'Display Name',
            name: 'displayName',
            value: user.displayName,
          ),
          ArcaneTextArea(
            label: 'Bio',
            name: 'bio',
            value: user.bio,
            maxLength: 160,
          ),
        ],
      ),
      ArcaneFormSection(
        title: 'Notifications',
        children: [
          ArcaneToggleSwitch(
            label: 'Email notifications',
            name: 'emailNotifs',
            value: user.emailNotifs,
          ),
          ArcaneToggleSwitch(
            label: 'Push notifications',
            name: 'pushNotifs',
            value: user.pushNotifs,
          ),
          ArcaneToggleSwitch(
            label: 'Marketing emails',
            name: 'marketingEmails',
            value: user.marketingEmails,
          ),
        ],
      ),
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.end,
        gap: Gap.md,
        children: [
          ArcaneButton.secondary(label: 'Cancel', type: ButtonType.reset),
          ArcaneButton.primary(label: 'Save Changes', type: ButtonType.submit),
        ],
      ),
    ],
  ),
)
```

### Payment Form

```dart
ArcaneForm(
  onSubmit: processPayment,
  child: ArcaneColumn(
    gap: Gap.lg,
    children: [
      ArcaneTextInput(
        label: 'Card Number',
        name: 'cardNumber',
        placeholder: '1234 5678 9012 3456',
        required: true,
      ),
      ArcaneRow(
        gap: Gap.md,
        children: [
          ArcaneTextInput(
            label: 'Expiry Date',
            name: 'expiry',
            placeholder: 'MM/YY',
            required: true,
          ),
          ArcaneTextInput(
            label: 'CVC',
            name: 'cvc',
            placeholder: '123',
            required: true,
          ),
        ],
      ),
      ArcaneTextInput(
        label: 'Cardholder Name',
        name: 'name',
        placeholder: 'Name on card',
        required: true,
      ),
      ArcaneDivider(),
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArcaneText('Total'),
          ArcaneText(
            '\$99.00',
            styles: const ArcaneStyleData(
              fontWeight: FontWeight.bold,
              fontSize: FontSize.lg,
            ),
          ),
        ],
      ),
      ArcaneButton.primary(
        label: 'Pay \$99.00',
        type: ButtonType.submit,
        isFullWidth: true,
      ),
    ],
  ),
)
```

## Related Components

- [ArcaneField](/arcane_jaspr/docs/forms/arcane-field) - Form field component
- [ArcaneFieldWrapper](/arcane_jaspr/docs/forms/arcane-field-wrapper) - Field layout wrapper
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Text input field
