---
title: Ergonomics
description: The cx class-join helper and semantic tag on Container
layout: kb
---

# Ergonomics

A couple of small helpers remove boilerplate that otherwise gets copy-pasted across a codebase.

## cx: joining class names

`cx` joins CSS class names into a single space-separated string, skipping `null` and blank entries. It replaces the ad-hoc `_joinClasses` helper that tends to get reinvented at every call site that composes conditional classes.

Source: `lib/util/classes.dart`

```dart
String cx(List<String?> classes);
```

Pass it to any `classes:` parameter, mixing always-on classes with conditional ones:

```dart
div(
  classes: cx(<String?>[
    'card',
    isActive ? 'is-active' : null,
    size,
  ]),
  children,
);
```

`null` and whitespace-only entries are dropped, so a `false` branch simply contributes nothing:

```dart
cx(<String?>['btn', disabled ? 'btn-disabled' : null]);
// disabled == false -> 'btn'
// disabled == true  -> 'btn btn-disabled'
```

## Semantic tags on Container

`Container` renders a `div` by default, but the `tag:` parameter can emit `nav`, `section`, `header`, `main`, `aside`, or another semantic HTML element. Layout code stays Flutter-shaped while the output uses the requested tag.

Source: `lib/component/layout/flow.dart`

```dart
Container(
  tag: 'section',
  padding: const EdgeInsets.all(24),
  child: const Text.body('Rendered as a <section>, not a <div>.'),
)
```

```dart
Container(
  tag: 'nav',
  child: navigationLinks,
)
```

When `tag` is omitted the output is byte-identical to the previous `div`-only behavior, so it is a safe, opt-in addition to any existing layout.
