---
title: ArcaneStepIndicator
description: Labeled step indicator for multi-step flows
layout: docs
component: step-indicator
---

# ArcaneStepIndicator

A horizontal step indicator showing progress through a multi-step process.

## Basic Usage

```dart
ArcaneStepIndicator(
  currentStep: 1,
  steps: const ['Account', 'Profile', 'Review', 'Complete'],
  onStepTap: (index) => goToStep(index),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `currentStep` | `int` | required | Current active step (0-indexed) |
| `steps` | `List<String>` | required | Step labels |
| `onStepTap` | `ValueChanged<int>?` | `null` | Step tap handler |
| `allowStepNavigation` | `bool` | `true` | Allow clicking past steps |
| `showLabels` | `bool` | `true` | Show step labels |
| `connectorStyle` | `ConnectorStyle` | `line` | Style between steps |

## Without Labels

```dart
ArcaneStepIndicator(
  currentStep: 2,
  steps: const ['1', '2', '3', '4'],
  showLabels: false,
)
```

## Disable Navigation

```dart
ArcaneStepIndicator(
  currentStep: currentStep,
  steps: const ['Info', 'Payment', 'Confirm'],
  allowStepNavigation: false,  // Only forward progress
)
```

## Examples

### Checkout Flow

```dart
ArcaneColumn(
  children: [
    ArcaneStepIndicator(
      currentStep: checkoutStep,
      steps: const ['Cart', 'Shipping', 'Payment', 'Confirm'],
      onStepTap: (i) {
        if (i <= checkoutStep) goToStep(i);
      },
    ),
    ArcaneDiv(
      styles: const ArcaneStyleData(margin: MarginPreset.topXl),
      children: [
        // Step content based on checkoutStep
        ArcaneSwitcher(
          index: checkoutStep,
          children: [
            CartStep(),
            ShippingStep(),
            PaymentStep(),
            ConfirmStep(),
          ],
        ),
      ],
    ),
  ],
)
```

### Form Wizard

```dart
ArcaneCard(
  child: ArcaneColumn(
    children: [
      ArcaneStepIndicator(
        currentStep: formStep,
        steps: const ['Personal', 'Contact', 'Submit'],
      ),
      ArcaneDiv(
        styles: const ArcaneStyleData(padding: PaddingPreset.lg),
        children: [stepContent[formStep]],
      ),
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (formStep > 0)
            ArcaneButton.ghost(
              label: 'Back',
              onPressed: () => setState(() => formStep--),
            ),
          ArcaneButton.primary(
            label: formStep < 2 ? 'Next' : 'Submit',
            onPressed: () => formStep < 2
                ? setState(() => formStep++)
                : submitForm(),
          ),
        ],
      ),
    ],
  ),
)
```

## Related Components

- [ArcaneDotIndicator](/arcane_jaspr/docs/view/arcane-dot-indicator) - Simple dot indicator
- [ArcaneSteps](/arcane_jaspr/docs/view/arcane-steps) - Vertical step list
- [ArcaneTimeline](/arcane_jaspr/docs/view/arcane-timeline) - Timeline display
