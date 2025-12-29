---
title: Installation
description: How to add Arcane Jaspr to your project
layout: docs
previous:
  url: /docs
  title: Introduction
next:
  url: /docs/quick-start
  title: Quick Start
---

# Installation

There are two ways to get started with Arcane Jaspr: using Oracular (recommended) or manual setup.

## Option 1: Using Oracular (Recommended)

Oracular is the official scaffolding tool for Arcane projects. It creates production-ready projects with best practices built in.

### Install Oracular

```bash
dart pub global activate oracular
```

### Create a New Project

```bash
# Interactive wizard
oracular

# Or create directly:
# Web application
oracular create app --template arcane_jaspr_app --name my_app

# Documentation site
oracular create app --template arcane_jaspr_docs --name my_docs
```

This creates a complete project structure with:
- Arcane Jaspr 2.7.0 pre-configured
- Theming setup with ArcaneApp
- Sample screens and components
- Proper routing configuration
- Development and production build scripts

## Option 2: Manual Setup

### Prerequisites

- **Dart SDK** >= 3.10.0
- **Jaspr CLI** (optional but recommended)

```bash
dart pub global activate jaspr_cli
```

### Create a Jaspr Project

```bash
jaspr create my_app
cd my_app
```

### Add Arcane Jaspr

Add to your `pubspec.yaml`:

```yaml
dependencies:
  arcane_jaspr: ^2.7.0
```

Then run:

```bash
dart pub get
```

### Configure Your App

Wrap your app with `ArcaneApp` for theming:

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

class App extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return ArcaneApp(
      theme: ArcaneTheme.green,  // Choose your theme
      child: MyHomePage(),
    );
  }
}
```

## Project Structure

After setup, your project should look like:

```
my_app/
├── lib/
│   ├── main.server.dart      # Server entry (static generation)
│   ├── main.client.dart      # Client entry (hydration)
│   ├── app.dart              # App component with theming
│   ├── screens/              # Page components
│   └── components/           # Reusable components
├── web/
│   ├── index.html            # HTML shell
│   └── styles.css            # Global styles
├── content/                  # Markdown content (optional)
└── pubspec.yaml
```

## Development Server

```bash
jaspr serve
```

Visit `http://localhost:8080` to see your app.

## Build for Production

```bash
jaspr build
```

Static files are generated in `build/jaspr/` ready for deployment.

## Choosing Between Templates

| Use Case | Template |
|----------|----------|
| Interactive web app | arcane_jaspr_app |
| Documentation site | arcane_jaspr_docs |
| Marketing landing page | arcane_jaspr_app |
| Technical docs with markdown | arcane_jaspr_docs |

## Why Jaspr + Arcane Jaspr?

Compared to Flutter web:

| Feature | Flutter Web | Jaspr + Arcane Jaspr |
|---------|-------------|----------------------|
| SEO | Poor (canvas) | Excellent (HTML) |
| Bundle Size | 2-5MB+ | 100-500KB |
| Initial Load | Slower | Faster |
| Browser DevTools | Limited | Full support |
| Text Selection | Custom | Native |

See the full [Platform Comparison](https://github.com/ArcaneArts/Oracular/blob/main/docs/PLATFORM_COMPARISON.md) for more details.
