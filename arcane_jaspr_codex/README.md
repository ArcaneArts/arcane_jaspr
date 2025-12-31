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

## Component Categories

The documentation covers all arcane_jaspr components:

### Input Components
Button, IconButton, TextInput, TextArea, Search, Checkbox, Radio, ToggleSwitch, Slider, RangeSlider, NumberInput, ColorInput, TagInput, FileUpload, TimePicker, FormattedInput, Selector, CycleButton, ToggleButton, OtpInput, Combobox, Calendar, DatePicker

### Layout Components
Div, Row, Column, Card, Section, Container, Gutter, Tabs, Sheet, ActionSheet, ScrollRail, ScrollArea, AspectRatio, Resizable, Drawer

### View Components
Avatar, AvatarBadge, Badge, Chip, Divider, ProgressBar, Loader, Skeleton, Tooltip, Accordion, DataTable, Switcher, SurfaceCard, Tracker, UptimeTracker, DotIndicator, StepIndicator, Timeline, Stepper, TreeView, Popover, Hovercard, CodeWindow, CheckList

### Navigation Components
Bar, Sidebar, BottomNav, Breadcrumbs, Pagination, DropdownMenu, ContextMenu, Menubar, MobileMenu

### Feedback & Dialog Components
Dialog, Toast, AlertBanner, Sheet, EmailDialog, TimeDialog, ItemPicker, Command

### Screen Components
Screen, FillScreen, NavigationScreen, ChatScreen

### Authentication Components
LoginCard, SignupCard, ForgotPasswordCard, AuthProvider, AuthGuard, GuestGuard, Social Sign-In Buttons

## Related

- [arcane_jaspr](../) - Main UI component library
- [Jaspr Documentation](https://docs.jaspr.site)
