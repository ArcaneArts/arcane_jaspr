---
title: ArcaneAspectRatio
description: Container that maintains a specific aspect ratio
layout: docs
component: aspect-ratio
---

# ArcaneAspectRatio

Container that maintains a specific aspect ratio for its content.

## Basic Usage

```dart
ArcaneAspectRatio(
  ratio: 16 / 9,
  child: ArcaneImage(src: 'video-thumbnail.jpg'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `ratio` | `double` | required | Aspect ratio (width/height) |
| `child` | `Component` | required | Child component |
| `classes` | `String?` | - | Additional CSS classes |
| `styles` | `Map<String, String>?` | - | Additional inline styles |

## Presets

### Square (1:1)

```dart
ArcaneAspectRatio.square(
  child: ArcaneAvatar(name: 'User'),
)
```

### Video (16:9)

```dart
ArcaneAspectRatio.video(
  child: video(src: 'intro.mp4'),
)
```

### Portrait (3:4)

```dart
ArcaneAspectRatio.portrait(
  child: ArcaneImage(src: 'portrait.jpg'),
)
```

### Photo (4:3)

```dart
ArcaneAspectRatio.photo(
  child: ArcaneImage(src: 'landscape.jpg'),
)
```

### Golden Ratio (1.618:1)

```dart
ArcaneAspectRatio.golden(
  child: content,
)
```

### Ultrawide (21:9)

```dart
ArcaneAspectRatio.ultrawide(
  child: bannerImage,
)
```

## Custom Ratios

```dart
// Cinema scope (2.35:1)
ArcaneAspectRatio(
  ratio: 2.35,
  child: moviePoster,
)

// Instagram square
ArcaneAspectRatio(
  ratio: 1.0,
  child: instagramPost,
)

// Twitter header (3:1)
ArcaneAspectRatio(
  ratio: 3.0,
  child: headerImage,
)
```

## Common Use Cases

### Responsive Image Container

```dart
ArcaneAspectRatio.video(
  child: ArcaneImage(
    src: 'thumbnail.jpg',
    fit: ObjectFit.cover,
  ),
)
```

### Video Player

```dart
ArcaneAspectRatio.video(
  child: iframe(
    src: 'https://youtube.com/embed/...',
    attributes: {'allowfullscreen': 'true'},
  ),
)
```

### Card Preview

```dart
ArcaneCard(
  child: ArcaneColumn(children: [
    ArcaneAspectRatio.photo(
      child: ArcaneImage(src: 'product.jpg'),
    ),
    ArcaneDiv(children: [
      ArcaneText('Product Name'),
    ]),
  ]),
)
```
