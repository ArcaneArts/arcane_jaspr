---
title: ArcaneLoader
description: Loading spinner indicator
layout: docs
---

# ArcaneLoader

An animated loading spinner for indicating processing or loading states.

## Basic Usage

```dart
ArcaneLoader()
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `size` | `LoaderSize` | `medium` | Spinner size |
| `color` | `LoaderColor` | `accent` | Spinner color |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Sizes

```dart
// Small
ArcaneLoader(size: LoaderSize.small)

// Medium (default)
ArcaneLoader(size: LoaderSize.medium)

// Large
ArcaneLoader(size: LoaderSize.large)

// Extra large
ArcaneLoader(size: LoaderSize.xlarge)
```

## Colors

```dart
// Accent (default)
ArcaneLoader(color: LoaderColor.accent)

// Default
ArcaneLoader(color: LoaderColor.default_)

// Muted
ArcaneLoader(color: LoaderColor.muted)

// White
ArcaneLoader(color: LoaderColor.white)
```

## Examples

### Loading State

```dart
if (isLoading)
  ArcaneCenter(
    styles: const ArcaneStyleData(
      minHeightCustom: '200px',
    ),
    child: ArcaneLoader(),
  )
else
  ContentWidget(),
```

### Button Loading

```dart
ArcaneButton.primary(
  label: isLoading ? '' : 'Submit',
  leading: isLoading ? ArcaneLoader(size: LoaderSize.small, color: LoaderColor.white) : null,
  isDisabled: isLoading,
  onPressed: submit,
)
```

### Full Page Loading

```dart
ArcaneCenter(
  styles: const ArcaneStyleData(
    minHeightCustom: '100vh',
  ),
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.md,
    children: [
      ArcaneLoader(size: LoaderSize.large),
      ArcaneText('Loading...'),
    ],
  ),
)
```

### Card Loading

```dart
ArcaneCard(
  child: isLoading
      ? ArcaneCenter(
          styles: const ArcaneStyleData(heightCustom: '200px'),
          child: ArcaneLoader(),
        )
      : CardContent(),
)
```

### Loading Overlay

```dart
ArcaneStack(
  children: [
    ContentWidget(),
    if (isLoading)
      ArcaneDiv(
        styles: const ArcaneStyleData(
          position: Position.absolute,
          inset: Inset.zero,
          background: Background.overlay,
          display: Display.flex,
          justifyContent: JustifyContent.center,
          alignItems: AlignItems.center,
        ),
        children: [
          ArcaneLoader(size: LoaderSize.large),
        ],
      ),
  ],
)
```

### Table Loading

```dart
ArcaneDataTable(
  columns: [...],
  rows: isLoading
      ? [
          DataRow(cells: [
            ArcaneCenter(
              styles: const ArcaneStyleData(padding: PaddingPreset.xl),
              child: ArcaneLoader(),
            ),
          ]),
        ]
      : dataRows,
)
```

### Inline Loading

```dart
ArcaneRow(
  gap: Gap.sm,
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneLoader(size: LoaderSize.small),
    ArcaneText('Saving...'),
  ],
)
```

### Loading Message

```dart
ArcaneCenter(
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.lg,
    children: [
      ArcaneLoader(size: LoaderSize.xlarge),
      ArcaneColumn(
        crossAxisAlignment: AlignItems.center,
        gap: Gap.xs,
        children: [
          ArcaneHeading(text: 'Processing'),
          ArcaneText('Please wait while we process your request'),
        ],
      ),
    ],
  ),
)
```

## Related Components

- [ArcaneLoadingSpinner](/docs/view/arcane-loading-spinner) - Alternative spinner
- [ArcaneDotsLoader](/docs/view/arcane-dots-loader) - Dots animation
- [ArcaneLoadingState](/docs/view/arcane-loading-state) - Full loading state
- [ArcaneSkeleton](/docs/view/arcane-skeleton) - Skeleton loading
