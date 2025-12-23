---
title: ArcaneExpander
description: Single expandable/collapsible content section
layout: docs
component: expander
---

# ArcaneExpander

A single expandable/collapsible component for showing and hiding content. Use this when you need a standalone collapsible section. For multiple collapsible sections, see [ArcaneAccordion](/arcane_jaspr/docs/view/arcane-accordion).

## Basic Usage

```dart
ArcaneExpander(
  header: ArcaneText('Click to expand'),
  child: ArcaneText('This is the expanded content.'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `header` | `Component` | required | Header content (always visible) |
| `child` | `Component` | required | Expandable content |
| `initiallyExpanded` | `bool` | `false` | Whether initially expanded |
| `onExpansionChanged` | `void Function(bool)?` | `null` | Callback when expansion changes |
| `leading` | `Component?` | `null` | Custom leading icon |
| `showIcon` | `bool` | `true` | Whether to show expansion icon |
| `contentPadding` | `EdgeInsets?` | `null` | Custom padding for content |
| `maintainState` | `bool` | `true` | Maintain child state when collapsed |

## Initially Expanded

```dart
ArcaneExpander(
  header: ArcaneText('Expanded by default'),
  initiallyExpanded: true,
  child: ArcaneText('This content is visible on load.'),
)
```

## With Leading Icon

```dart
ArcaneExpander(
  leading: ArcaneIcon.info(),
  header: ArcaneText('More Information'),
  child: ArcaneText('Additional details go here.'),
)
```

## Without Expansion Icon

```dart
ArcaneExpander(
  showIcon: false,
  header: ArcaneText('Click anywhere on header'),
  child: ArcaneText('The chevron icon is hidden.'),
)
```

## Listening to Changes

```dart
ArcaneExpander(
  header: ArcaneText('Tracked expansion'),
  onExpansionChanged: (isExpanded) {
    print('Expander is now: ${isExpanded ? 'open' : 'closed'}');
  },
  child: ArcaneText('Expansion state is tracked.'),
)
```

## Custom Content Padding

```dart
ArcaneExpander(
  header: ArcaneText('Custom padding'),
  contentPadding: EdgeInsets.all(32),
  child: ArcaneText('This content has more padding.'),
)
```

## Examples

### Help Section

```dart
ArcaneExpander(
  header: ArcaneRow(
    gapSize: Gap.sm,
    children: [
      ArcaneIcon.help(),
      ArcaneText('Need help?', weight: FontWeight.w500),
    ],
  ),
  child: ArcaneColumn(
    gapSize: Gap.md,
    children: [
      ArcaneText('Contact our support team:'),
      ArcaneText('Email: support@example.com'),
      ArcaneButton.secondary(
        label: 'Open Support Chat',
        onPressed: openChat,
      ),
    ],
  ),
)
```

### Advanced Options

```dart
ArcaneCard(
  child: ArcaneColumn(
    children: [
      // Main settings always visible
      ArcaneTextInput(label: 'Name'),
      ArcaneTextInput(label: 'Email'),

      // Advanced options in expander
      ArcaneExpander(
        header: ArcaneText('Advanced Options'),
        child: ArcaneColumn(
          gapSize: Gap.md,
          children: [
            ArcaneCheckbox(
              label: 'Enable notifications',
              checked: notifications,
              onChanged: setNotifications,
            ),
            ArcaneSelect(
              label: 'Timezone',
              value: timezone,
              options: timezoneOptions,
              onChange: setTimezone,
            ),
          ],
        ),
      ),
    ],
  ),
)
```

### Read More

```dart
ArcaneExpander(
  header: ArcaneText('Read more...', color: TextColor.accent),
  showIcon: false,
  child: ArcaneParagraph(
    text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
)
```

## Related Components

- [ArcaneAccordion](/arcane_jaspr/docs/view/arcane-accordion) - Multiple collapsible sections
- [ArcaneCard](/arcane_jaspr/docs/layout/arcane-card) - Card container
- [ArcaneCallout](/arcane_jaspr/docs/view/arcane-callout) - Highlighted information
