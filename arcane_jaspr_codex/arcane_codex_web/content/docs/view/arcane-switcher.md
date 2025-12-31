---
title: ArcaneSwitcher
description: Animated content switcher for transitions between children
layout: docs
component: switcher
---

# ArcaneSwitcher

An animated content switcher that transitions between multiple children with slide or fade animations.

## Basic Usage

```dart
ArcaneSwitcher(
  index: currentIndex,
  children: [
    StepOne(),
    StepTwo(),
    StepThree(),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `index` | `int` | required | Current visible child index |
| `children` | `List<Component>` | required | Children to switch between |
| `direction` | `SwitcherDirection` | `fade` | Animation direction |
| `duration` | `int` | `300` | Animation duration in ms |
| `onIndexChanged` | `ValueChanged<int>?` | `null` | Index change callback |

## SwitcherDirection Options

- `fade` - Fade in/out (no slide)
- `up` - Slide up
- `down` - Slide down
- `left` - Slide left
- `right` - Slide right

## Factory Constructors

### Horizontal Slide

```dart
ArcaneSwitcher.horizontal(
  index: currentIndex,
  children: pages,
)
```

### Vertical Slide

```dart
ArcaneSwitcher.vertical(
  index: currentIndex,
  children: pages,
)
```

### Fade Only

```dart
ArcaneSwitcher.fade(
  index: currentIndex,
  children: pages,
)
```

## Custom Duration

```dart
ArcaneSwitcher(
  index: currentIndex,
  duration: 500,  // 500ms transition
  direction: SwitcherDirection.left,
  children: pages,
)
```

# ArcaneKeyedSwitcher

A keyed version that uses keys instead of indices.

```dart
ArcaneKeyedSwitcher<String>(
  currentKey: selectedTab,
  children: {
    'home': HomeContent(),
    'profile': ProfileContent(),
    'settings': SettingsContent(),
  },
)
```

# ArcaneIndexedStack

A stack that preserves state of all children (renders all, shows one).

```dart
ArcaneIndexedStack(
  index: currentTab,
  children: [
    HeavyWidget1(),  // State preserved
    HeavyWidget2(),  // State preserved
    HeavyWidget3(),  // State preserved
  ],
)
```

## Examples

### Wizard Flow

```dart
ArcaneColumn(
  children: [
    ArcaneSwitcher.horizontal(
      index: wizardStep,
      children: [
        WizardStep1(),
        WizardStep2(),
        WizardStep3(),
      ],
    ),
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneButton.ghost(
          label: 'Back',
          onPressed: wizardStep > 0
              ? () => setState(() => wizardStep--)
              : null,
        ),
        ArcaneButton.primary(
          label: wizardStep < 2 ? 'Next' : 'Finish',
          onPressed: () {
            if (wizardStep < 2) {
              setState(() => wizardStep++);
            } else {
              finishWizard();
            }
          },
        ),
      ],
    ),
  ],
)
```

### Tab Content

```dart
ArcaneColumn(
  children: [
    ArcaneTabs(
      tabs: [
        ArcaneTabItem(label: 'Overview'),
        ArcaneTabItem(label: 'Details'),
        ArcaneTabItem(label: 'Reviews'),
      ],
      initialIndex: activeTab,
      onChanged: (i) => setState(() => activeTab = i),
    ),
    ArcaneSwitcher.fade(
      index: activeTab,
      children: [
        OverviewTab(),
        DetailsTab(),
        ReviewsTab(),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneTabs](/arcane_jaspr/docs/layout/arcane-tabs) - Tabbed navigation
- [ArcaneDotIndicator](/arcane_jaspr/docs/view/arcane-dot-indicator) - Page indicator dots
- [ArcaneStepIndicator](/arcane_jaspr/docs/view/arcane-step-indicator) - Step progress
