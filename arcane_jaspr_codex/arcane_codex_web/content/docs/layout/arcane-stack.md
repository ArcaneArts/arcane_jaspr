---
title: ArcaneStack
description: Layered positioning container for overlapping elements
layout: docs
---

# ArcaneStack

A container that allows children to be positioned on top of each other using absolute positioning.

## Basic Usage

```dart
ArcaneStack(
  children: [
    ArcaneImage(src: '/background.jpg'),
    ArcanePositioned(
      bottom: Spacing.lg,
      left: Spacing.lg,
      child: ArcaneText('Overlay text'),
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Stack children |
| `styles` | `ArcaneStyleData?` | `null` | Container styling |

## Examples

### Image with Badge

```dart
ArcaneStack(
  styles: const ArcaneStyleData(
    widthCustom: '200px',
    heightCustom: '200px',
  ),
  children: [
    ArcaneAvatar(
      imageUrl: '/user.jpg',
      size: AvatarSize.xlarge,
    ),
    ArcanePositioned(
      bottom: Spacing.xs,
      right: Spacing.xs,
      child: ArcaneStatusIndicator(status: 'online'),
    ),
  ],
)
```

### Card with Floating Action

```dart
ArcaneStack(
  children: [
    ArcaneCard(
      child: ArcaneColumn(
        children: [
          ArcaneHeading(text: 'Project Name'),
          ArcaneParagraph(text: 'Project description...'),
          ArcaneDiv(
            styles: const ArcaneStyleData(heightCustom: '40px'),
            children: [],
          ),
        ],
      ),
    ),
    ArcanePositioned(
      bottom: Spacing.md,
      right: Spacing.md,
      child: ArcaneFab(
        icon: span([text('+')]),
        onPressed: () {},
      ),
    ),
  ],
)
```

### Notification Badge

```dart
ArcaneStack(
  children: [
    ArcaneIconButton(
      icon: span([text('🔔')]),
      onPressed: () {},
    ),
    ArcanePositioned(
      top: Spacing.none,
      right: Spacing.none,
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          widthCustom: '18px',
          heightCustom: '18px',
          borderRadius: Radius.circle,
          background: Background.destructive,
          display: Display.flex,
          justifyContent: JustifyContent.center,
          alignItems: AlignItems.center,
          fontSize: FontSize.xs,
          textColor: TextColor.onDestructive,
        ),
        children: [ArcaneText('3')],
      ),
    ),
  ],
)
```

### Hero Image Overlay

```dart
ArcaneStack(
  styles: const ArcaneStyleData(
    heightCustom: '400px',
    borderRadius: Radius.xl,
    overflow: Overflow.hidden,
  ),
  children: [
    ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '100%',
        heightCustom: '100%',
        raw: {'background': 'url(/hero.jpg) center/cover'},
      ),
      children: [],
    ),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.absolute,
        inset: Inset.zero,
        background: Background.overlay,
      ),
      children: [],
    ),
    ArcanePositioned(
      bottom: Spacing.xl,
      left: Spacing.xl,
      right: Spacing.xl,
      child: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneHeadline(
            text: 'Welcome to Our Platform',
            styles: const ArcaneStyleData(textColor: TextColor.onPrimary),
          ),
          ArcaneButton.primary(label: 'Get Started', onPressed: () {}),
        ],
      ),
    ),
  ],
)
```

### Loading Overlay

```dart
ArcaneStack(
  children: [
    ArcaneCard(
      child: ArcaneColumn(
        children: [
          ArcaneTextInput(label: 'Email'),
          ArcaneTextInput(label: 'Password'),
          ArcaneButton.primary(label: 'Submit', onPressed: () {}),
        ],
      ),
    ),
    if (isLoading)
      ArcaneDiv(
        styles: const ArcaneStyleData(
          position: Position.absolute,
          inset: Inset.zero,
          background: Background.overlay,
          display: Display.flex,
          justifyContent: JustifyContent.center,
          alignItems: AlignItems.center,
          borderRadius: Radius.lg,
        ),
        children: [ArcaneLoader()],
      ),
  ],
)
```

### Image Gallery Item

```dart
ArcaneStack(
  styles: const ArcaneStyleData(
    borderRadius: Radius.lg,
    overflow: Overflow.hidden,
    cursor: Cursor.pointer,
  ),
  children: [
    ArcaneImage(src: '/gallery/image1.jpg'),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.absolute,
        inset: Inset.zero,
        background: Background.overlay,
        opacity: Opacity.zero,
        transition: Transition.opacity,
        display: Display.flex,
        justifyContent: JustifyContent.center,
        alignItems: AlignItems.center,
        hover: HoverStyles(opacity: Opacity.full),
      ),
      children: [
        ArcaneIconButton(
          icon: span([text('🔍')]),
          onPressed: () {},
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcanePositioned](/docs/layout/arcane-positioned) - Position children in stack
- [ArcaneDiv](/docs/layout/arcane-div) - Generic layout div
