# ArcaneCodex Web

Static documentation site for arcane_jaspr built with Jaspr.

## Quick Start

```bash
# Install dependencies
dart pub get

# Development server (http://localhost:8080)
jaspr serve

# Release mode dev server
jaspr serve --release

# Build static site to build/jaspr/
jaspr build

# Clean build artifacts
jaspr clean
```

## Project Structure

```
arcane_codex_web/
├── content/                    # Markdown documentation
│   ├── docs/
│   │   ├── index.md           # Docs landing page
│   │   ├── installation.md
│   │   ├── quick-start.md
│   │   ├── concepts/          # Core concepts (theming, styling, tokens)
│   │   ├── styles/            # Style reference (display, spacing, etc.)
│   │   ├── inputs/            # Input component docs
│   │   ├── layout/            # Layout component docs
│   │   ├── typography/        # Typography component docs
│   │   ├── view/              # View component docs
│   │   ├── navigation/        # Navigation component docs
│   │   ├── feedback/          # Feedback component docs
│   │   ├── forms/             # Form component docs
│   │   ├── auth/              # Authentication docs
│   │   └── screens/           # Screen component docs
│   └── guides/
│       └── deployment.md
├── lib/
│   ├── main.server.dart       # Server entry (static generation)
│   ├── main.client.dart       # Client entry (hydration)
│   ├── components/
│   │   ├── docs_sidebar.dart  # Navigation sidebar
│   │   └── docs_header.dart   # Page header
│   ├── demos/
│   │   ├── demo_registry.dart # Demo component registry
│   │   ├── input_demos.dart   # Input component demos
│   │   ├── layout_demos.dart  # Layout component demos
│   │   ├── typography_demos.dart
│   │   ├── view_demos.dart
│   │   ├── navigation_demos.dart
│   │   ├── feedback_demos.dart
│   │   ├── form_demos.dart
│   │   ├── screen_demos.dart
│   │   └── auth_demos.dart    # Authentication demos
│   ├── layouts/
│   │   └── arcane_docs_layout.dart
│   └── utils/
│       └── constants.dart     # Site configuration
└── web/
    ├── index.html             # Entry HTML
    └── styles.css             # Global styles
```

## Adding Content

### New Documentation Page

1. Create markdown file in `content/docs/`:

```markdown
---
title: Page Title
description: Brief description of the page
layout: docs
---

# Page Title

Content here...

## Section

More content...
```

2. Add navigation entry in `lib/components/docs_sidebar.dart`:

```dart
_buildNavItem(label: 'Page Title', href: '/docs/category/page-slug'),
```

### Component Demo

1. Add demo method in appropriate file (e.g., `lib/demos/input_demos.dart`):

```dart
static List<Component> myComponent() {
  return [
    ArcaneDiv(
      styles: const ArcaneStyleData(padding: PaddingPreset.lg),
      children: [
        MyComponent(...),
      ],
    ),
  ];
}
```

2. Register in `lib/demos/demo_registry.dart`:

```dart
case 'my-component':
  return InputDemos.myComponent();
```

3. Reference in markdown with demo tag:

```markdown
::demo{component="my-component"}
```

## Dependencies

- `jaspr: ^0.22.0` - Web framework
- `jaspr_content: ^0.4.5` - Markdown/content processing
- `arcane_jaspr` (path: `../../`) - UI components (local dev)

## Configuration

Site settings in `lib/utils/constants.dart`:

```dart
class AppConstants {
  static const String siteName = 'ArcaneCodex';
  static const String siteUrl = 'https://arcanecodex.example.com';
  // ...
}
```

## Deployment

### Firebase Hosting

```bash
jaspr build
cd ..
firebase deploy --only hosting
```

### Other Static Hosts

Upload `build/jaspr/` contents to any static hosting:
- Vercel
- Netlify
- GitHub Pages
- Cloudflare Pages

## Theme

The documentation site uses:
- Supabase theme preset
- Emerald accent
- Dark mode by default

Configured in `lib/layouts/arcane_docs_layout.dart`:

```dart
ArcaneApp(
  theme: ArcaneTheme.supabase(
    accent: AccentTheme.emerald,
    themeMode: ThemeMode.dark,
  ),
  child: ...,
)
```
