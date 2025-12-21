---
title: ArcaneBox
description: Styled container with padding and border
layout: docs
component: box
---

# ArcaneBox

A simple container component with built-in padding and optional border styling, useful for creating visual groupings.

## Basic Usage

```dart
ArcaneBox(
  children: [
    ArcaneText('Content inside a box'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Box content |
| `padding` | `PaddingPreset?` | `md` | Internal padding |
| `border` | `bool` | `true` | Show border |
| `background` | `Background?` | `null` | Background style |
| `borderRadius` | `Radius?` | `md` | Corner radius |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Without Border

```dart
ArcaneBox(
  border: false,
  background: Background.surface,
  children: [
    ArcaneText('No border box'),
  ],
)
```

## Padding Sizes

```dart
// No padding
ArcaneBox(
  padding: PaddingPreset.none,
  children: [...],
)

// Small padding
ArcaneBox(
  padding: PaddingPreset.sm,
  children: [...],
)

// Medium padding (default)
ArcaneBox(
  padding: PaddingPreset.md,
  children: [...],
)

// Large padding
ArcaneBox(
  padding: PaddingPreset.lg,
  children: [...],
)

// Extra large padding
ArcaneBox(
  padding: PaddingPreset.xl,
  children: [...],
)
```

## Examples

### Information Box

```dart
ArcaneBox(
  background: Background.info,
  children: [
    ArcaneRow(
      gap: Gap.sm,
      crossAxisAlignment: AlignItems.start,
      children: [
        span([text('ℹ️')]),
        ArcaneColumn(
          crossAxisAlignment: AlignItems.start,
          gap: Gap.xs,
          children: [
            ArcaneText('Did you know?'),
            ArcaneText('This is helpful information for users.'),
          ],
        ),
      ],
    ),
  ],
)
```

### Form Section

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    ArcaneBox(
      padding: PaddingPreset.lg,
      children: [
        ArcaneColumn(
          gap: Gap.md,
          children: [
            ArcaneHeading(text: 'Personal Information'),
            ArcaneTextInput(label: 'Full Name'),
            ArcaneTextInput(label: 'Email'),
            ArcaneTextInput(label: 'Phone'),
          ],
        ),
      ],
    ),
    ArcaneBox(
      padding: PaddingPreset.lg,
      children: [
        ArcaneColumn(
          gap: Gap.md,
          children: [
            ArcaneHeading(text: 'Address'),
            ArcaneTextInput(label: 'Street'),
            ArcaneRow(
              gap: Gap.md,
              children: [
                ArcaneExpanded(child: ArcaneTextInput(label: 'City')),
                ArcaneExpanded(child: ArcaneTextInput(label: 'ZIP')),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Code Block Container

```dart
ArcaneBox(
  padding: PaddingPreset.none,
  background: Background.code,
  borderRadius: Radius.lg,
  children: [
    ArcaneRow(
      mainAxisAlignment: JustifyContent.spaceBetween,
      styles: const ArcaneStyleData(
        padding: PaddingPreset.smMd,
        borderBottom: Border.subtle,
      ),
      children: [
        ArcaneText('example.dart'),
        ArcaneIconButton(
          icon: span([text('📋')]),
          size: IconButtonSize.small,
          onPressed: copyCode,
        ),
      ],
    ),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        padding: PaddingPreset.md,
        fontFamily: FontFamily.mono,
      ),
      children: [
        pre([text(codeContent)]),
      ],
    ),
  ],
)
```

### Settings Group

```dart
ArcaneBox(
  children: [
    ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneRow(
          mainAxisAlignment: JustifyContent.spaceBetween,
          children: [
            ArcaneColumn(
              crossAxisAlignment: AlignItems.start,
              children: [
                ArcaneText('Notifications'),
                ArcaneText('Receive email notifications'),
              ],
            ),
            ArcaneToggleSwitch(
              value: notifications,
              onChanged: (v) => setState(() => notifications = v),
            ),
          ],
        ),
        ArcaneDivider(),
        ArcaneRow(
          mainAxisAlignment: JustifyContent.spaceBetween,
          children: [
            ArcaneColumn(
              crossAxisAlignment: AlignItems.start,
              children: [
                ArcaneText('Dark Mode'),
                ArcaneText('Use dark theme'),
              ],
            ),
            ArcaneThemeToggle(
              isDark: isDark,
              onToggle: (v) => setState(() => isDark = v),
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Nested Boxes

```dart
ArcaneBox(
  padding: PaddingPreset.lg,
  background: Background.surface,
  children: [
    ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneHeading(text: 'Section Title'),
        ArcaneBox(
          background: Background.default_,
          children: [
            ArcaneText('Nested content'),
          ],
        ),
        ArcaneBox(
          background: Background.default_,
          children: [
            ArcaneText('More nested content'),
          ],
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneCard](/arcane_jaspr/docs/view/arcane-card) - Card with shadow
- [ArcaneDiv](/arcane_jaspr/docs/layout/arcane-div) - Generic layout div
- [ArcaneSection](/arcane_jaspr/docs/layout/arcane-section) - Semantic section wrapper
