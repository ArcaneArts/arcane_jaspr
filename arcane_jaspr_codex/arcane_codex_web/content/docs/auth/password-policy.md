---
title: PasswordPolicy
description: Configurable password validation rules
layout: docs
component: password-policy
---

# PasswordPolicy

A configurable password validation policy for enforcing password requirements during registration.

## Basic Usage

```dart
const policy = PasswordPolicy(
  minLength: 8,
  requireUppercase: true,
  requireNumber: true,
);

// Validate a password
String? error = policy.validate(password);
if (error != null) {
  print('Invalid: $error');
}
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `minLength` | `int` | `6` | Minimum password length |
| `maxLength` | `int` | `128` | Maximum password length |
| `requireUppercase` | `bool` | `false` | Require uppercase letter |
| `requireLowercase` | `bool` | `false` | Require lowercase letter |
| `requireNumber` | `bool` | `false` | Require at least one digit |
| `requireSpecialChar` | `bool` | `false` | Require special character |

## Preset Policies

### Weak (Default)

```dart
PasswordPolicy.weak
// Minimum 6 characters, no other requirements
```

### Medium

```dart
PasswordPolicy.medium
// Minimum 8 characters
// One uppercase letter
// One number
```

### Strong

```dart
PasswordPolicy.strong
// Minimum 8 characters
// One uppercase letter
// One lowercase letter
// One number
// One special character
```

## Methods

### validate(String password)

Returns `null` if valid, or an error message string if invalid.

```dart
final policy = PasswordPolicy.medium;
final error = policy.validate('weak');
// Returns: 'Password must be at least 8 characters long.'
```

### isValid(String password)

Returns `true` if the password meets all requirements.

```dart
final policy = PasswordPolicy.medium;
bool valid = policy.isValid('StrongPass123');
// Returns: true
```

### description

Returns a human-readable description of the policy requirements.

```dart
final policy = PasswordPolicy.strong;
print(policy.description);
// Output: "At least 8 characters, one uppercase letter, one lowercase letter, one number, one special character"
```

## Custom Policies

```dart
// Very strict policy
const strictPolicy = PasswordPolicy(
  minLength: 12,
  maxLength: 64,
  requireUppercase: true,
  requireLowercase: true,
  requireNumber: true,
  requireSpecialChar: true,
);

// Length-only policy
const lengthPolicy = PasswordPolicy(
  minLength: 10,
);

// Numbers and uppercase only
const simplePolicy = PasswordPolicy(
  minLength: 8,
  requireUppercase: true,
  requireNumber: true,
);
```

## With Signup Card

```dart
ArcaneSignupCard(
  passwordPolicy: PasswordPolicy.strong,
  methods: [AuthMethod.email],
  loginRoute: '/login',
)
```

The signup card displays the policy description as a hint below the password field.

## Error Messages

The `validate` method returns specific error messages:

| Validation | Error Message |
|------------|---------------|
| Too short | "Password must be at least X characters long." |
| Too long | "Password must be no more than X characters long." |
| Missing uppercase | "Password must contain at least one uppercase letter." |
| Missing lowercase | "Password must contain at least one lowercase letter." |
| Missing number | "Password must contain at least one number." |
| Missing special | "Password must contain at least one special character." |

## Special Characters

The following characters count as special characters:
```
! @ # $ % ^ & * ( ) , . ? " : { } | < >
```

## Related Components

- [ArcaneSignupCard](/arcane_jaspr/docs/auth/arcane-signup-card) - Registration form
- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Login form
