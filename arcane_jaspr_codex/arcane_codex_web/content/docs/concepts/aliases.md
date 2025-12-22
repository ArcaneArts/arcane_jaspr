---
title: Component Aliases
description: Use shorter A* names for all Arcane components
layout: docs
component: aliases
---

# Component Aliases

Tired of typing `ArcaneButton`, `ArcaneCard`, `ArcaneText` everywhere? We get it. That's why we created short-hand aliases for every component.

## Using Aliases

Instead of importing the main library:

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

// Long names
ArcaneButton(label: 'Click me', onPressed: () {})
ArcaneCard(child: ArcaneText('Hello'))
```

Import the aliases file:

```dart
import 'package:arcane_jaspr/aliases.dart';

// Short names - same components, less typing
AButton(label: 'Click me', onPressed: () {})
ACard(child: AText('Hello'))
```

The `aliases.dart` file re-exports everything from the main library, so you don't lose access to anything. You just gain shorter names.

## The Pattern

Every `Arcane*` component has an `A*` alias:

| Full Name | Alias |
|-----------|-------|
| `ArcaneButton` | `AButton` |
| `ArcaneCard` | `ACard` |
| `ArcaneText` | `AText` |
| `ArcaneDiv` | `ADiv` |
| `ArcaneRow` | `ARow` |
| `ArcaneColumn` | `AColumn` |
| `ArcaneContainer` | `AContainer` |
| `ArcaneDialog` | `ADialog` |
| `ArcaneForm` | `AForm` |
| `ArcaneApp` | `AApp` |

...and so on for all 100+ components.

## Complete Alias List

### Layout Components

```dart
ADiv          // ArcaneDiv
ARow          // ArcaneRow
AColumn       // ArcaneColumn
AContainer    // ArcaneContainer
ACenter       // ArcaneCenter
AStack        // ArcaneStack
ABox          // ArcaneBox
APadding      // ArcanePadding
AGutter       // ArcaneGutter
ASpacer       // ArcaneSpacer
AExpanded     // ArcaneExpanded
ACard         // ArcaneCard
ATabs         // ArcaneTabs
AFlow         // ArcaneFlow
```

### Input Components

```dart
AButton       // ArcaneButton
AIconButton   // ArcaneIconButton
ATextInput    // ArcaneTextInput
ATextArea     // ArcaneTextArea
ACheckbox     // ArcaneCheckbox
ARadio        // ArcaneRadio
ASelect       // ArcaneSelect
ASlider       // ArcaneSlider
AToggleSwitch // ArcaneToggleSwitch
ASearch       // ArcaneSearch
AFAB          // ArcaneFAB
```

### Typography Components

```dart
AText         // ArcaneText
AHeading      // ArcaneHeading
AHeadline     // ArcaneHeadline
ASubheadline  // ArcaneSubheadline
AParagraph    // ArcaneParagraph
ASpan         // ArcaneSpan
ARichText     // ArcaneRichText
ACodeSnippet  // ArcaneCodeSnippet
```

### View Components

```dart
AAvatar       // ArcaneAvatar
ABadge        // ArcaneBadge
AChip         // ArcaneChip
ADivider      // ArcaneDivider
AProgressBar  // ArcaneProgressBar
ALoader       // ArcaneLoader
ASkeleton     // ArcaneSkeleton
ADataTable    // ArcaneDataTable
ATimeline     // ArcaneTimeline
ATooltip      // ArcaneTooltip
```

### Navigation Components

```dart
AHeader       // ArcaneHeader
ASidebar      // ArcaneSidebar
ABottomBar    // ArcaneBottomBar
ADropdownMenu // ArcaneDropdownMenu
AMobileMenu   // ArcaneMobileMenu
AMegaMenu     // ArcaneMegaMenu
```

### Feedback & Dialog

```dart
ADialog       // ArcaneDialog
ALoader       // ArcaneLoader
AEmptyState   // ArcaneEmptyState
AErrorState   // ArcaneErrorState
```

### Form Components

```dart
AForm         // ArcaneForm
AField        // ArcaneField
AFieldWrapper // ArcaneFieldWrapper
```

## Why Use Aliases?

1. **Less typing** - `AButton` is 6 characters shorter than `ArcaneButton`
2. **Cleaner code** - Your widget trees become more scannable
3. **Familiar pattern** - Similar to how Flutter uses `Text` instead of `FlutterText`
4. **No downsides** - Same components, same API, just shorter names

## Mixing Both

You can use both naming styles in the same file if you prefer:

```dart
import 'package:arcane_jaspr/aliases.dart';

// Both work
AButton(label: 'Short')
ArcaneButton(label: 'Long')
```

The aliases are just Dart `typedef`s pointing to the original classes.
