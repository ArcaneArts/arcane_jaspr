---
title: ArcaneResizable
description: Resizable panel groups with draggable dividers
layout: docs
component: resizable
---

# ArcaneResizable

Resizable panel groups with draggable dividers for adjustable layouts.

## Basic Usage

```dart
ArcaneResizable(
  direction: ResizeDirection.horizontal,
  panels: [
    ResizablePanel(
      defaultSize: 25,
      minSize: 15,
      child: Sidebar(),
    ),
    ResizablePanel(
      child: MainContent(),
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `panels` | `List<ResizablePanel>` | required | Panels to display |
| `direction` | `ResizeDirection` | `horizontal` | Resize direction |
| `handleSize` | `double` | `8` | Handle size in pixels |
| `showGrip` | `bool` | `true` | Show grip indicator |

## ResizablePanel

```dart
ResizablePanel(
  child: content,
  defaultSize: 30,     // Percentage
  minSize: 20,         // Minimum percentage
  maxSize: 50,         // Maximum percentage
  collapsible: false,
  onCollapse: () {},
  onExpand: () {},
)
```

## Horizontal Layout

```dart
ArcaneResizable(
  direction: ResizeDirection.horizontal,
  panels: [
    ResizablePanel(
      defaultSize: 20,
      minSize: 15,
      maxSize: 40,
      child: NavigationSidebar(),
    ),
    ResizablePanel(
      child: ContentArea(),
    ),
    ResizablePanel(
      defaultSize: 25,
      minSize: 20,
      maxSize: 35,
      child: PropertiesPanel(),
    ),
  ],
)
```

## Vertical Layout

```dart
ArcaneResizable(
  direction: ResizeDirection.vertical,
  panels: [
    ResizablePanel(
      defaultSize: 60,
      child: CodeEditor(),
    ),
    ResizablePanel(
      defaultSize: 40,
      minSize: 20,
      child: Terminal(),
    ),
  ],
)
```

## IDE-Style Layout

```dart
ArcaneResizable(
  direction: ResizeDirection.horizontal,
  panels: [
    ResizablePanel(
      defaultSize: 20,
      minSize: 15,
      collapsible: true,
      child: FileExplorer(),
    ),
    ResizablePanel(
      child: ArcaneResizable(
        direction: ResizeDirection.vertical,
        panels: [
          ResizablePanel(
            defaultSize: 70,
            child: Editor(),
          ),
          ResizablePanel(
            defaultSize: 30,
            minSize: 15,
            child: Output(),
          ),
        ],
      ),
    ),
  ],
)
```

## Features

- Horizontal and vertical directions
- Min/max size constraints
- Collapsible panels
- Keyboard support (arrow keys)
- Visual grip indicator
- Nested resizable groups
