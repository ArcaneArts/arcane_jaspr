---
title: ArcaneSteps
description: Numbered step indicators for multi-step processes
layout: docs
component: steps
---

# ArcaneSteps

A numbered steps component for showing progress through a multi-step process. Supports horizontal and vertical layouts with clickable navigation.

**Aliases:** `ArcaneSteps`, `ASteps`

## Basic Usage

```dart
ArcaneSteps(
  items: [
    ArcaneStepItem(
      title: 'Account',
      description: 'Create your account',
      status: StepStatus.complete,
    ),
    ArcaneStepItem(
      title: 'Profile',
      description: 'Set up your profile',
      status: StepStatus.current,
    ),
    ArcaneStepItem(
      title: 'Complete',
      description: 'Start using the app',
      status: StepStatus.pending,
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<ArcaneStepItem>` | required | Step items |
| `layout` | `StepsLayout` | `horizontal` | Layout type |
| `size` | `StepsSize` | `md` | Component size |
| `showConnectors` | `bool` | `true` | Show connector lines |
| `currentStep` | `int?` | `null` | Auto-set status by index |
| `onStepTap` | `Function(int)?` | `null` | Callback for step clicks |

## ArcaneStepItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Step title |
| `description` | `String?` | `null` | Step description |
| `status` | `StepStatus` | `pending` | Step status |
| `content` | `Component?` | `null` | Custom content |

## Layouts

### Horizontal (Default)

```dart
ArcaneSteps.horizontal(
  items: [
    ArcaneStepItem(title: 'Cart', status: StepStatus.complete),
    ArcaneStepItem(title: 'Shipping', status: StepStatus.current),
    ArcaneStepItem(title: 'Payment', status: StepStatus.pending),
    ArcaneStepItem(title: 'Confirm', status: StepStatus.pending),
  ],
)
```

### Vertical

```dart
ArcaneSteps.vertical(
  items: [
    ArcaneStepItem(
      title: 'Account',
      description: 'Create your account',
      status: StepStatus.complete,
    ),
    ArcaneStepItem(
      title: 'Profile',
      description: 'Set up your profile',
      status: StepStatus.current,
    ),
    ArcaneStepItem(
      title: 'Preferences',
      description: 'Configure settings',
      status: StepStatus.pending,
    ),
    ArcaneStepItem(
      title: 'Complete',
      description: 'Start using the app',
      status: StepStatus.pending,
    ),
  ],
)
```

## Using currentStep

Instead of setting status on each item, use `currentStep` for automatic status:

```dart
ArcaneSteps(
  currentStep: 1, // 0-indexed: first step complete, second current
  items: [
    ArcaneStepItem(title: 'Account'),
    ArcaneStepItem(title: 'Profile'),
    ArcaneStepItem(title: 'Settings'),
    ArcaneStepItem(title: 'Complete'),
  ],
)
```

## Clickable Steps

Enable navigation by tapping completed steps:

```dart
ArcaneSteps(
  currentStep: currentStep,
  onStepTap: (index) {
    // Navigate back to a previous step
    setState(() => currentStep = index);
  },
  items: [
    ArcaneStepItem(title: 'Account'),
    ArcaneStepItem(title: 'Profile'),
    ArcaneStepItem(title: 'Settings'),
    ArcaneStepItem(title: 'Complete'),
  ],
)
```

## Status Types

```dart
// Complete (green checkmark)
ArcaneStepItem(title: 'Done', status: StepStatus.complete)

// Current (accent color with number)
ArcaneStepItem(title: 'In Progress', status: StepStatus.current)

// Pending (muted, shows number)
ArcaneStepItem(title: 'Upcoming', status: StepStatus.pending)
```

## Sizes

```dart
// Small
ArcaneSteps(size: StepsSize.sm, items: [...])

// Medium (default)
ArcaneSteps(size: StepsSize.md, items: [...])

// Large
ArcaneSteps(size: StepsSize.lg, items: [...])
```

## Examples

### Checkout Flow

```dart
class CheckoutSteps extends StatefulComponent {
  @override
  State createState() => _CheckoutStepsState();
}

class _CheckoutStepsState extends State<CheckoutSteps> {
  int _currentStep = 0;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      children: [
        ArcaneSteps(
          currentStep: _currentStep,
          onStepTap: (index) => setState(() => _currentStep = index),
          items: const [
            ArcaneStepItem(title: 'Cart'),
            ArcaneStepItem(title: 'Shipping'),
            ArcaneStepItem(title: 'Payment'),
            ArcaneStepItem(title: 'Confirm'),
          ],
        ),
        // Step content
        if (_currentStep == 0) CartContent(),
        if (_currentStep == 1) ShippingContent(),
        if (_currentStep == 2) PaymentContent(),
        if (_currentStep == 3) ConfirmContent(),
        // Navigation
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            if (_currentStep > 0)
              ArcaneButton.outline(
                label: 'Previous',
                onPressed: () => setState(() => _currentStep--),
              ),
            ArcaneButton.primary(
              label: _currentStep == 3 ? 'Complete Order' : 'Next',
              onPressed: () {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  // Complete order
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
```

### Registration Wizard

```dart
ArcaneSteps.vertical(
  items: [
    ArcaneStepItem(
      title: 'Create Account',
      description: 'Enter your email and password',
      status: StepStatus.complete,
      content: ArcaneDiv(
        styles: const ArcaneStyleData(padding: PaddingPreset.md),
        children: [
          ArcaneText('Email verified!', color: TextColor.success),
        ],
      ),
    ),
    ArcaneStepItem(
      title: 'Personal Info',
      description: 'Tell us about yourself',
      status: StepStatus.current,
    ),
    ArcaneStepItem(
      title: 'Preferences',
      description: 'Customize your experience',
      status: StepStatus.pending,
    ),
  ],
)
```

### Form Wizard with Validation

```dart
ArcaneSteps(
  currentStep: _step,
  items: [
    ArcaneStepItem(
      title: 'Basic Info',
      description: _step > 0 ? 'Completed' : 'Fill in your details',
    ),
    ArcaneStepItem(
      title: 'Contact',
      description: _step > 1 ? 'Completed' : 'How can we reach you?',
    ),
    ArcaneStepItem(
      title: 'Review',
      description: 'Confirm your information',
    ),
  ],
)
```

## Accessibility

The component includes:
- Button elements for clickable steps
- Disabled state for non-clickable steps
- Visual indicators for current and completed states
- Keyboard navigation support

## Related Components

- [ArcaneTimeline](/arcane_jaspr/docs/view/arcane-timeline) - Chronological event display
- [ArcaneProgressBar](/arcane_jaspr/docs/view/arcane-progress-bar) - Progress indicator
- [ArcaneTabs](/arcane_jaspr/docs/layout/arcane-tabs) - Tabbed content
