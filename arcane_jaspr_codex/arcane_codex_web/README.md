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

## Architecture

### Content-Driven Static Generation

The site uses Jaspr's static site generation with markdown content:

1. **Content Layer** (`content/`) - Markdown files with YAML frontmatter
2. **Layout Layer** (`lib/layouts/`) - Jaspr components that wrap content
3. **Demo Layer** (`lib/demos/`) - Live component demonstrations
4. **Client Layer** (`lib/main.client.dart`) - JavaScript hydration for interactivity

### Demo Registry Pattern

The demo system uses a **Map-based registry** for O(1) lookups:

```dart
// Static demos (stateless) - just return components
static final Map<String, DemoBuilder> _staticDemos = {
  'button': InputDemos.button,
  'text-input': InputDemos.textInput,
};

// Interactive demos (stateful) - return StatefulComponent instances
static final Map<String, Component> _interactiveDemos = {
  'checkbox': const CheckboxDemo(),
  'slider': const SliderDemo(),
};
```

### Script Extraction

Client-side JavaScript is modularized in `lib/utils/docs_scripts.dart`:
- `DocsIcons` - SVG icon definitions
- `DocsScriptConfig` - Configuration constants
- `DocsScripts.generate()` - Full interactive script generation

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
│   │   ├── demo_registry.dart # Demo component registry (Map-based)
│   │   ├── demo_utils.dart    # Reusable demo utilities
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
│       ├── constants.dart     # Site configuration
│       └── docs_scripts.dart  # Extracted JavaScript utilities
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

For **static demos** (no state), add to `_staticDemos` map:
```dart
static final Map<String, DemoBuilder> _staticDemos = {
  // ... existing entries
  'my-component': InputDemos.myComponent,
};
```

For **interactive demos** (stateful), add to `_interactiveDemos` map:
```dart
static final Map<String, Component> _interactiveDemos = {
  // ... existing entries
  'my-component': const MyComponentDemo(),
};
```

3. Reference in markdown with demo tag:

```markdown
::demo{component="my-component"}
```

### Demo Utilities

Use `DemoUtils` for consistent demo layouts:

```dart
import 'demo_utils.dart';

static List<Component> myDemo() {
  return [
    DemoUtils.section(
      title: 'Basic Usage',
      children: [
        DemoUtils.row(children: [MyComponent(), MyComponent()]),
        DemoUtils.statusText('Interactive demo'),
      ],
    ),
  ];
}
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

## Documented Components

### Input Components
- **Basic**: Button, IconButton, TextInput, TextArea, Search
- **Selection**: Checkbox, Radio, ToggleSwitch, Selector, Combobox
- **Specialized**: Slider, RangeSlider, NumberInput, ColorInput, TagInput, FileUpload
- **Time & Date**: TimePicker, FormattedInput, Calendar, DatePicker
- **Toggle**: CycleButton, ToggleButton, ThemeToggle, OtpInput

### Layout Components
- **Flex**: Div, Row, Column, Center
- **Container**: Card, Section, Container, Gutter
- **Panels**: Sheet, ActionSheet, Drawer, Tabs
- **Scroll**: ScrollRail, ScrollArea, AspectRatio, Resizable

### View Components
- **Display**: Avatar, AvatarBadge, Badge, Chip, Divider
- **Progress**: ProgressBar, Loader, Skeleton
- **Info**: Tooltip, Popover, Hovercard
- **Lists**: Accordion, DataTable, TreeView, CheckList
- **Animation**: Switcher, SurfaceCard
- **Metrics**: Tracker, UptimeTracker, DotIndicator, StepIndicator
- **Timeline**: Timeline, Stepper
- **Code**: CodeWindow, CodeSnippet

### Navigation Components
Bar, Sidebar, BottomNav, Breadcrumbs, Pagination, DropdownMenu, ContextMenu, Menubar, MobileMenu

### Feedback & Dialog Components
Dialog, Toast, AlertBanner, EmailDialog, TimeDialog, ItemPicker, Command

### Screen Components
Screen, FillScreen, NavigationScreen, ChatScreen

### Authentication
LoginCard, SignupCard, ForgotPasswordCard, AuthProvider, AuthGuard, GuestGuard, Social Sign-In Buttons (GitHub, Google, Apple, etc.)
