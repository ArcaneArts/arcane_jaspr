---
title: ArcaneAlertBanner
description: Inline alert banner for important messages
layout: docs
component: alert-banner
---

# ArcaneAlertBanner

An inline alert banner component for displaying important messages, warnings, or status information.

## Basic Usage

```dart
ArcaneAlertBanner(
  message: 'This is an important message',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `message` | `String` | required | Alert message |
| `variant` | `AlertVariant` | `info` | Alert type |
| `title` | `String?` | `null` | Alert title |
| `icon` | `Component?` | `null` | Custom icon |
| `action` | `Component?` | `null` | Action button |
| `dismissible` | `bool` | `false` | Show dismiss button |
| `onDismiss` | `VoidCallback?` | `null` | Dismiss callback |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Variants

```dart
// Info (default)
ArcaneAlertBanner(
  variant: AlertVariant.info,
  message: 'New features are now available.',
)

// Success
ArcaneAlertBanner(
  variant: AlertVariant.success,
  message: 'Your changes have been saved.',
)

// Warning
ArcaneAlertBanner(
  variant: AlertVariant.warning,
  message: 'Your subscription expires in 3 days.',
)

// Error
ArcaneAlertBanner(
  variant: AlertVariant.error,
  message: 'Failed to save changes. Please try again.',
)
```

## With Title

```dart
ArcaneAlertBanner(
  variant: AlertVariant.info,
  title: 'New Feature Available',
  message: 'We\'ve added dark mode support. Try it out in settings!',
)
```

## With Action

```dart
ArcaneAlertBanner(
  variant: AlertVariant.warning,
  message: 'Your trial expires in 3 days.',
  action: ArcaneButton.link(
    label: 'Upgrade Now',
    onPressed: upgrade,
  ),
)
```

## Dismissible

```dart
ArcaneAlertBanner(
  variant: AlertVariant.info,
  message: 'Welcome to the new dashboard!',
  dismissible: true,
  onDismiss: () => setState(() => showBanner = false),
)
```

## Custom Icon

```dart
ArcaneAlertBanner(
  variant: AlertVariant.info,
  icon: span([text('🎉')]),
  message: 'Congratulations! You\'ve earned a new badge.',
)
```

## Examples

### Form Validation Error

```dart
if (errors.isNotEmpty)
  ArcaneAlertBanner(
    variant: AlertVariant.error,
    title: 'Please fix the following errors:',
    message: errors.join(', '),
  ),
ArcaneForm(
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneTextInput(label: 'Email', error: emailError),
      ArcaneTextInput(label: 'Password', error: passwordError),
      ArcaneButton.primary(label: 'Submit', onPressed: submit),
    ],
  ),
)
```

### Maintenance Notice

```dart
ArcaneAlertBanner(
  variant: AlertVariant.warning,
  icon: span([text('🔧')]),
  title: 'Scheduled Maintenance',
  message: 'The system will be unavailable on Sunday, Jan 21st from 2:00 AM to 4:00 AM EST for scheduled maintenance.',
  dismissible: true,
)
```

### Success Confirmation

```dart
ArcaneAlertBanner(
  variant: AlertVariant.success,
  icon: span([text('✓')]),
  message: 'Your profile has been updated successfully.',
  action: ArcaneButton.link(
    label: 'View Profile',
    onPressed: viewProfile,
  ),
)
```

### Subscription Warning

```dart
ArcaneAlertBanner(
  variant: AlertVariant.warning,
  title: 'Action Required',
  message: 'Your payment method has expired. Please update it to continue using premium features.',
  action: ArcaneButton.primary(
    label: 'Update Payment',
    onPressed: updatePayment,
    size: ButtonSize.sm,
  ),
)
```

### Feature Announcement

```dart
ArcaneAlertBanner(
  variant: AlertVariant.info,
  icon: span([text('🚀')]),
  title: 'New: Dark Mode',
  message: 'We\'ve added dark mode support! Toggle it in your settings.',
  action: ArcaneButton.link(
    label: 'Try it now',
    onPressed: openSettings,
  ),
  dismissible: true,
  onDismiss: dismissAnnouncement,
)
```

### Error with Retry

```dart
ArcaneAlertBanner(
  variant: AlertVariant.error,
  icon: span([text('⚠️')]),
  title: 'Connection Error',
  message: 'Unable to connect to the server. Please check your internet connection.',
  action: ArcaneButton.secondary(
    label: 'Retry',
    onPressed: retryConnection,
    size: ButtonSize.sm,
  ),
)
```

### Security Alert

```dart
ArcaneAlertBanner(
  variant: AlertVariant.error,
  icon: span([text('🔒')]),
  title: 'Security Alert',
  message: 'Unusual login activity detected. If this wasn\'t you, please change your password immediately.',
  action: ArcaneRow(
    gap: Gap.sm,
    children: [
      ArcaneButton.primary(
        label: 'Change Password',
        onPressed: changePassword,
        size: ButtonSize.sm,
      ),
      ArcaneButton.ghost(
        label: 'It was me',
        onPressed: dismissAlert,
        size: ButtonSize.sm,
      ),
    ],
  ),
)
```

### Info Banner with Link

```dart
ArcaneAlertBanner(
  variant: AlertVariant.info,
  message: 'Learn more about our new pricing plans.',
  action: ArcaneLink(
    href: '/pricing',
    child: ArcaneRow(
      gap: Gap.xs,
      children: [
        ArcaneText('View Pricing'),
        span([text('→')]),
      ],
    ),
  ),
)
```

### Cookie Consent

```dart
ArcaneAlertBanner(
  variant: AlertVariant.info,
  title: 'Cookie Consent',
  message: 'We use cookies to enhance your experience. By continuing to visit this site you agree to our use of cookies.',
  action: ArcaneRow(
    gap: Gap.sm,
    children: [
      ArcaneButton.primary(
        label: 'Accept',
        onPressed: acceptCookies,
        size: ButtonSize.sm,
      ),
      ArcaneButton.ghost(
        label: 'Learn More',
        onPressed: learnMore,
        size: ButtonSize.sm,
      ),
    ],
  ),
)
```

### Multi-line Content

```dart
ArcaneAlertBanner(
  variant: AlertVariant.info,
  title: 'Terms of Service Update',
  message: ArcaneColumn(
    gap: Gap.sm,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ArcaneParagraph(
        text: 'We\'ve updated our Terms of Service effective January 1, 2024. Key changes include:',
      ),
      ArcaneColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArcaneText('• Updated privacy policy'),
          ArcaneText('• New data retention guidelines'),
          ArcaneText('• Revised refund policy'),
        ],
      ),
    ],
  ),
  action: ArcaneButton.link(
    label: 'Read Full Terms',
    onPressed: readTerms,
  ),
)
```

## Placement Examples

### Page Top Banner

```dart
ArcaneColumn(
  children: [
    ArcaneAlertBanner(
      variant: AlertVariant.warning,
      message: 'System maintenance in progress. Some features may be unavailable.',
      dismissible: true,
    ),
    // Rest of page content
    ArcaneContainer(
      children: [...],
    ),
  ],
)
```

### Card Alert

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneHeading(text: 'Account Settings'),
      ArcaneAlertBanner(
        variant: AlertVariant.success,
        message: 'Two-factor authentication is enabled.',
        icon: span([text('🛡️')]),
      ),
      // Settings content...
    ],
  ),
)
```

## Related Components

- [ArcaneToast](/arcane_jaspr/docs/feedback/arcane-toast) - Temporary notifications
- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Modal dialogs
- [ArcaneBadge](/arcane_jaspr/docs/view/arcane-badge) - Status badges
