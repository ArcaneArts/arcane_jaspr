---
title: Arcane Jaspr
description: A modern UI component library for Dart web applications
layout: docs
---

# Arcane Jaspr

A comprehensive UI component library built for [Jaspr](https://jaspr.dev), bringing the elegance of modern design systems to Dart web development.

## What is Arcane Jaspr?

Arcane Jaspr is the web implementation of the Arcane UI design system. It provides over 75 production-ready components that render to semantic HTML with CSS styling, giving you complete control over your application's look and feel.

Whether you're building a documentation site, a dashboard, or a full-featured web application, Arcane Jaspr gives you the building blocks to ship faster without sacrificing quality.

## Why Jaspr over Flutter Web?

| Feature | Flutter Web | Jaspr + Arcane Jaspr |
|---------|-------------|----------------------|
| SEO | Poor (canvas-based) | Excellent (semantic HTML) |
| Bundle Size | 2-5MB+ | 100-500KB |
| Time to First Paint | 2-5 seconds | Under 1 second |
| Browser DevTools | Limited | Full support |
| Text Selection | Custom | Native |

Read our detailed [Why Jaspr?](/arcane_jaspr/docs/why-jaspr) guide to understand when Jaspr is the right choice.

## Key Features

**Type-Safe Styling** - Use `ArcaneStyleData` for compile-time verified CSS properties, or drop down to raw CSS when you need full control.

**Dark-First Design** - Every component looks great in both light and dark modes out of the box. Theming is built into the core, not bolted on.

**Semantic HTML** - Components render to proper HTML elements with accessibility in mind. No div soup here.

**Firebase Auth Ready** - Built-in authentication components and guards for Firebase, so you can add login flows in minutes.

## Quick Start

The fastest way to get started is with Oracular:

```bash
dart pub global activate oracular

# Create a web app
oracular create app --template arcane_jaspr_app --name my_app

# Create a documentation site
oracular create app --template arcane_jaspr_docs --name my_docs
```

Or add to an existing project:

```yaml
dependencies:
  arcane_jaspr: ^2.7.0
```

## Quick Links

- [Why Jaspr?](/arcane_jaspr/docs/why-jaspr) - When to choose Jaspr over Flutter
- [Installation](/arcane_jaspr/docs/installation) - Add Arcane Jaspr to your project
- [Quick Start](/arcane_jaspr/docs/quick-start) - Build something in 5 minutes
- [Components](/arcane_jaspr/docs/layout/arcane-card) - Browse the component library
