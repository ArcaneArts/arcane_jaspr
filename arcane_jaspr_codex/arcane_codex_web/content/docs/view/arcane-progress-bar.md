---
title: ArcaneProgressBar
description: Linear progress indicator
layout: docs
---

# ArcaneProgressBar

A horizontal progress bar for showing completion percentage or indeterminate loading.

## Basic Usage

```dart
ArcaneProgressBar(value: 0.5)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `double?` | `null` | Progress 0.0-1.0 |
| `variant` | `ProgressVariant` | `default_` | Color variant |
| `size` | `ProgressSize` | `medium` | Bar height |
| `showLabel` | `bool` | `false` | Show percentage label |
| `indeterminate` | `bool` | `false` | Animated loading |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Variants

```dart
// Default
ArcaneProgressBar(value: 0.5, variant: ProgressVariant.default_)

// Success
ArcaneProgressBar(value: 0.5, variant: ProgressVariant.success)

// Warning
ArcaneProgressBar(value: 0.5, variant: ProgressVariant.warning)

// Destructive
ArcaneProgressBar(value: 0.5, variant: ProgressVariant.destructive)

// Accent
ArcaneProgressBar(value: 0.5, variant: ProgressVariant.accent)
```

## Sizes

```dart
// Small
ArcaneProgressBar(value: 0.5, size: ProgressSize.small)

// Medium (default)
ArcaneProgressBar(value: 0.5, size: ProgressSize.medium)

// Large
ArcaneProgressBar(value: 0.5, size: ProgressSize.large)
```

## With Label

```dart
ArcaneProgressBar(
  value: 0.75,
  showLabel: true,
)
// Displays "75%"
```

## Indeterminate

```dart
ArcaneProgressBar(
  indeterminate: true,
)
```

## Examples

### File Upload

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        children: [
          ArcaneText('Uploading file.zip'),
          ArcaneText('${(progress * 100).toInt()}%'),
        ],
      ),
      ArcaneProgressBar(
        value: progress,
        variant: ProgressVariant.accent,
      ),
      ArcaneText(
        '${uploadedMB} MB of ${totalMB} MB',
        styles: const ArcaneStyleData(
          fontSize: FontSize.sm,
          textColor: TextColor.muted,
        ),
      ),
    ],
  ),
)
```

### Step Progress

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneRow(
      mainAxisAlignment: JustifyContent.spaceBetween,
      children: [
        ArcaneText('Step $currentStep of $totalSteps'),
        ArcaneText('${(currentStep / totalSteps * 100).toInt()}%'),
      ],
    ),
    ArcaneProgressBar(
      value: currentStep / totalSteps,
      size: ProgressSize.large,
    ),
  ],
)
```

### Storage Usage

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        children: [
          ArcaneText('Storage'),
          ArcaneText('$usedGB GB / $totalGB GB'),
        ],
      ),
      ArcaneProgressBar(
        value: usedGB / totalGB,
        variant: usedGB / totalGB > 0.9
            ? ProgressVariant.destructive
            : usedGB / totalGB > 0.7
                ? ProgressVariant.warning
                : ProgressVariant.default_,
      ),
    ],
  ),
)
```

### Skill Level

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    for (var skill in skills)
      ArcaneColumn(
        gap: Gap.xs,
        children: [
          ArcaneRow(
            mainAxisAlignment: JustifyContent.spaceBetween,
            children: [
              ArcaneText(skill.name),
              ArcaneText('${skill.level}%'),
            ],
          ),
          ArcaneProgressBar(
            value: skill.level / 100,
            size: ProgressSize.small,
          ),
        ],
      ),
  ],
)
```

### Loading Operation

```dart
ArcaneColumn(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.md,
  children: [
    ArcaneText('Processing...'),
    ArcaneProgressBar(
      indeterminate: true,
      styles: const ArcaneStyleData(widthCustom: '300px'),
    ),
  ],
)
```

### Multi-segment Progress

```dart
ArcaneColumn(
  gap: Gap.sm,
  children: [
    ArcaneRow(
      mainAxisAlignment: JustifyContent.spaceBetween,
      children: [
        ArcaneText('Project Progress'),
      ],
    ),
    ArcaneRow(
      gap: Gap.xs,
      children: [
        ArcaneExpanded(
          flex: completedTasks,
          child: ArcaneProgressBar(
            value: 1,
            variant: ProgressVariant.success,
            size: ProgressSize.large,
          ),
        ),
        ArcaneExpanded(
          flex: inProgressTasks,
          child: ArcaneProgressBar(
            value: 1,
            variant: ProgressVariant.warning,
            size: ProgressSize.large,
          ),
        ),
        ArcaneExpanded(
          flex: pendingTasks,
          child: ArcaneProgressBar(
            value: 1,
            variant: ProgressVariant.default_,
            size: ProgressSize.large,
          ),
        ),
      ],
    ),
    ArcaneRow(
      gap: Gap.lg,
      children: [
        ArcaneRow(gap: Gap.xs, children: [
          ArcaneDiv(styles: const ArcaneStyleData(widthCustom: '12px', heightCustom: '12px', background: Background.success, borderRadius: Radius.sm), children: []),
          ArcaneText('Completed'),
        ]),
        ArcaneRow(gap: Gap.xs, children: [
          ArcaneDiv(styles: const ArcaneStyleData(widthCustom: '12px', heightCustom: '12px', background: Background.warning, borderRadius: Radius.sm), children: []),
          ArcaneText('In Progress'),
        ]),
        ArcaneRow(gap: Gap.xs, children: [
          ArcaneDiv(styles: const ArcaneStyleData(widthCustom: '12px', heightCustom: '12px', background: Background.muted, borderRadius: Radius.sm), children: []),
          ArcaneText('Pending'),
        ]),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneCircularProgress](/docs/view/arcane-circular-progress) - Circular progress
- [ArcaneLoader](/docs/view/arcane-loader) - Loading spinner
- [ArcaneStatusIndicator](/docs/view/arcane-status-indicator) - Status dot
