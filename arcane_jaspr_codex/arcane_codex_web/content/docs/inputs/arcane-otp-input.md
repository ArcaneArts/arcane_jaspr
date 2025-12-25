---
title: ArcaneOtpInput
description: One-time password input with separate digit fields
layout: docs
component: otp-input
---

# ArcaneOtpInput

One-time password input with separate digit fields for verification codes.

## Basic Usage

```dart
ArcaneOtpInput(
  length: 6,
  onComplete: (code) => verifyCode(code),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `length` | `int` | `6` | Number of digits |
| `onComplete` | `Function(String)?` | - | Called when all digits filled |
| `onChange` | `Function(String)?` | - | Called on any change |
| `value` | `String?` | - | Initial value |
| `obscure` | `bool` | `false` | Hide digits like password |
| `size` | `OtpInputSize` | `md` | Size variant |
| `disabled` | `bool` | `false` | Disable input |
| `error` | `String?` | - | Error message |
| `label` | `String?` | - | Label above input |
| `separator` | `String?` | - | Separator character |
| `separatorPosition` | `int?` | - | Where to show separator |

## Variants

### Four Digit

```dart
ArcaneOtpInput.fourDigit(
  onComplete: (code) => verifyPin(code),
)
```

### Six Digit

```dart
ArcaneOtpInput.sixDigit(
  onComplete: (code) => verify2FA(code),
)
```

### With Separator

```dart
ArcaneOtpInput(
  length: 6,
  separator: '-',
  separatorPosition: 3,
  onComplete: (code) => verify(code),
)
```

## Sizes

```dart
ArcaneOtpInput(length: 4, size: OtpInputSize.sm)
ArcaneOtpInput(length: 4, size: OtpInputSize.md)
ArcaneOtpInput(length: 4, size: OtpInputSize.lg)
```

## Features

- Auto-advance focus on digit entry
- Backspace navigates to previous field
- Paste support fills all fields
- Arrow key navigation
- ARIA labels for accessibility
