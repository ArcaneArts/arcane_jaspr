# ArcaneCodex

Documentation site for the `arcane_jaspr` UI component library. Built with Jaspr and rendered as a static site.

## Project Structure

```
arcane_jaspr_codex/
└── arcane_codex_web/     # Static documentation site
    ├── content/          # Markdown documentation pages
    │   ├── docs/         # Component & API documentation
    │   └── guides/       # Usage guides
    ├── lib/
    │   ├── components/   # Site components (sidebar, header)
    │   ├── demos/        # Interactive component demos
    │   ├── layouts/      # Page layouts
    │   └── utils/        # Site utilities
    └── web/              # Static assets
```

## Getting Started

```bash
cd arcane_codex_web

# Install dependencies
dart pub get

# Start development server
jaspr serve

# Build static site
jaspr build
```

The development server runs at `http://localhost:8080`.

## Adding Documentation

### 1. Create Markdown Page

Create a new file in `content/docs/` with YAML frontmatter:

```markdown
---
title: Component Name
description: Brief description
layout: docs
---

# Component Name

Documentation content here...
```

### 2. Add Navigation Entry

In `lib/components/docs_sidebar.dart`, add a nav item:

```dart
_buildNavItem(label: 'ComponentName', href: '/docs/category/component-name'),
```

### 3. Add Demo (Optional)

For components with interactive demos:

1. Create demo method in `lib/demos/` (e.g., `input_demos.dart`)
2. Register in `lib/demos/demo_registry.dart`

## Development

The site uses:
- **Jaspr** for static site generation
- **jaspr_content** for markdown processing
- **arcane_jaspr** (local path dependency) for UI components

## Build & Deploy

```bash
# Build static files
jaspr build

# Output in build/jaspr/
```

Deploy the `build/jaspr/` directory to any static hosting service (Firebase, Vercel, Netlify, etc.).

## Related

- [arcane_jaspr](../) - Main UI component library
- [Jaspr Documentation](https://docs.jaspr.site)
