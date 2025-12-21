---
title: ArcaneSelector
description: Custom styled selector with rich option rendering
layout: docs
---

# ArcaneSelector

A customizable selector component that allows rich option rendering beyond simple text labels.

## Basic Usage

```dart
ArcaneSelector<String>(
  value: selected,
  options: [
    ArcaneSelectorOption(value: 'opt1', child: ArcaneText('Option 1')),
    ArcaneSelectorOption(value: 'opt2', child: ArcaneText('Option 2')),
    ArcaneSelectorOption(value: 'opt3', child: ArcaneText('Option 3')),
  ],
  onChanged: (value) {
    setState(() => selected = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T?` | `null` | Currently selected value |
| `options` | `List<ArcaneSelectorOption<T>>` | required | Available options |
| `onChanged` | `ValueChanged<T>?` | `null` | Selection handler |
| `placeholder` | `Component?` | `null` | Placeholder when empty |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `isOpen` | `bool` | `false` | Control open state |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## ArcaneSelectorOption

```dart
ArcaneSelectorOption<String>(
  value: 'option1',
  child: YourCustomComponent(),  // Any component for display
  isDisabled: false,
)
```

## Rich Options

Display complex options with icons and descriptions:

```dart
ArcaneSelector<String>(
  value: selectedPlan,
  options: [
    ArcaneSelectorOption(
      value: 'free',
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.md,
        ),
        children: [
          span([text('🆓')]),
          ArcaneDiv(
            children: [
              ArcaneText('Free'),
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  fontSize: FontSize.sm,
                  textColor: TextColor.muted,
                ),
                children: [ArcaneText('Basic features')],
              ),
            ],
          ),
        ],
      ),
    ),
    ArcaneSelectorOption(
      value: 'pro',
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.md,
        ),
        children: [
          span([text('⭐')]),
          ArcaneDiv(
            children: [
              ArcaneText('Pro'),
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  fontSize: FontSize.sm,
                  textColor: TextColor.muted,
                ),
                children: [ArcaneText('\$9/month')],
              ),
            ],
          ),
        ],
      ),
    ),
  ],
  onChanged: (v) => setState(() => selectedPlan = v),
)
```

## Examples

### Country Selector

```dart
ArcaneSelector<String>(
  value: country,
  placeholder: ArcaneText('Select a country'),
  options: [
    ArcaneSelectorOption(
      value: 'us',
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.sm,
        ),
        children: [
          span([text('🇺🇸')]),
          ArcaneText('United States'),
        ],
      ),
    ),
    ArcaneSelectorOption(
      value: 'uk',
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.sm,
        ),
        children: [
          span([text('🇬🇧')]),
          ArcaneText('United Kingdom'),
        ],
      ),
    ),
    // More countries...
  ],
  onChanged: (v) => setState(() => country = v),
)
```

### User Selector

```dart
ArcaneSelector<String>(
  value: selectedUser,
  placeholder: ArcaneDiv(
    styles: const ArcaneStyleData(
      display: Display.flex,
      alignItems: AlignItems.center,
      gap: Gap.sm,
    ),
    children: [
      ArcaneAvatar(size: AvatarSize.small),
      ArcaneText('Select assignee'),
    ],
  ),
  options: [
    for (final user in users)
      ArcaneSelectorOption(
        value: user.id,
        child: ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.sm,
          ),
          children: [
            ArcaneAvatar(
              imageUrl: user.avatar,
              size: AvatarSize.small,
            ),
            ArcaneDiv(
              children: [
                ArcaneText(user.name),
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.xs,
                    textColor: TextColor.muted,
                  ),
                  children: [ArcaneText(user.role)],
                ),
              ],
            ),
          ],
        ),
      ),
  ],
  onChanged: (v) => setState(() => selectedUser = v),
)
```

### Color Selector

```dart
ArcaneSelector<String>(
  value: selectedColor,
  options: [
    for (final color in colors)
      ArcaneSelectorOption(
        value: color.name,
        child: ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.sm,
          ),
          children: [
            ArcaneDiv(
              styles: ArcaneStyleData(
                widthCustom: '20px',
                heightCustom: '20px',
                borderRadius: Radius.circle,
                raw: {'background': color.hex},
              ),
              children: [],
            ),
            ArcaneText(color.name),
          ],
        ),
      ),
  ],
  onChanged: (v) => setState(() => selectedColor = v),
)
```

### Project Selector

```dart
ArcaneSelector<String>(
  value: selectedProject,
  options: [
    for (final project in projects)
      ArcaneSelectorOption(
        value: project.id,
        child: ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            widthCustom: '100%',
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                display: Display.flex,
                alignItems: AlignItems.center,
                gap: Gap.sm,
              ),
              children: [
                ArcaneDiv(
                  styles: ArcaneStyleData(
                    widthCustom: '8px',
                    heightCustom: '8px',
                    borderRadius: Radius.circle,
                    raw: {'background': project.color},
                  ),
                  children: [],
                ),
                ArcaneText(project.name),
              ],
            ),
            ArcaneBadge(label: '${project.taskCount}'),
          ],
        ),
      ),
  ],
  onChanged: (v) => setState(() => selectedProject = v),
)
```

## Related Components

- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Simple dropdown select
- [ArcaneCycleButton](/arcane_jaspr/docs/inputs/arcane-cycle-button) - Cycle through options
- [ArcaneRadio](/arcane_jaspr/docs/inputs/arcane-radio) - Radio button selection
