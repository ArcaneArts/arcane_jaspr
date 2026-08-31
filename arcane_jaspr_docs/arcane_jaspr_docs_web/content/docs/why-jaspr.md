---
title: Why Jaspr?
description: When to choose Jaspr over Flutter for web development
layout: kb
---

# Why Jaspr + Arcane Jaspr?

Jaspr and Flutter web use different rendering models. Choose between them based on the browser behavior your project needs.

## The Core Difference

Flutter web can render an app through a canvas-based surface. In that mode, browser tools do not receive the same element tree as a normal HTML page.

Jaspr renders semantic HTML. A button is a `<button>`, text can be a `<p>`, and a link is an `<a>`.

That distinction affects indexing, browser tools, accessibility, and page behavior.

---

## SEO and Discoverability

### Search Engine Indexing

| Aspect | Flutter Web | Jaspr |
|--------|-------------|-------|
| Google Crawling | Cannot read canvas content | Full HTML indexing |
| Page Titles | Manual meta tags | Automatic per-page |
| Meta Descriptions | Complex setup | Simple frontmatter |
| Sitemap Generation | Manual | Automatic |
| Structured Data | Very difficult | Standard implementation |

### Social Media Sharing

| Aspect | Flutter Web | Jaspr |
|--------|-------------|-------|
| Link Previews | Requires pre-rendering | Works automatically |
| Open Graph Tags | Complex workarounds | Simple meta tags |
| Twitter Cards | Complex workarounds | Simple meta tags |
| WhatsApp/Telegram Previews | Often broken | Works correctly |

Jaspr exposes page content as HTML for indexing and link previews.

---

## Performance

### Initial Load

| Metric | Flutter Web | Jaspr |
|--------|-------------|-------|
| Bundle Size | 2-5MB+ | 100-500KB |
| Time to First Paint | 2-5 seconds | Under 1 second |
| Time to Interactive | 3-8 seconds | Under 2 seconds |
| Core Web Vitals | Often fails | Typically passes |

### Why This Matters

- **Bounce Rate:** Users leave slow sites. Every second of load time increases bounce rate by 7%.
- **SEO Ranking:** Google uses Core Web Vitals as a ranking factor.
- **Mobile Users:** Large bundles hurt users on slower connections.
- **Conversion Rate:** Faster sites convert better.

### Runtime Performance

| Aspect | Flutter Web | Jaspr |
|--------|-------------|-------|
| 60fps Animations | Yes (Skia) | Depends on CSS |
| Complex UI Updates | Excellent | Good |
| Memory Usage | Higher | Lower |
| CPU Usage | Higher | Lower |

Flutter's canvas renderer is often a better fit for animation-heavy application interfaces. Jaspr keeps document-oriented sites in the browser's HTML model.

---

## Developer Experience

### Debugging

| Tool | Flutter Web | Jaspr |
|------|-------------|-------|
| Browser DevTools | Limited (canvas inspection) | Full DOM/CSS inspection |
| Element Inspection | Not possible | Native support |
| CSS Debugging | Not applicable | Full support |
| Network Tab | Works | Works |
| Performance Tab | Limited | Full support |

### Common Web Features

| Feature | Flutter Web | Jaspr |
|---------|-------------|-------|
| Browser Find (Ctrl+F) | Does not work | Works |
| Text Selection | Custom implementation | Native |
| Right-click Context Menu | Custom implementation | Native |
| Browser Password Manager | Often broken | Works |
| Browser Translate | Does not work | Works |
| Screen Readers | Requires extra work | Semantic HTML helps |

---

## Use Case Comparison

### Choose Jaspr when building

| Use Case | Why Jaspr |
|----------|-----------|
| Marketing websites | SEO is critical |
| Documentation sites | Content discoverability |
| Blogs | Social sharing, SEO |
| Landing pages | Fast load times, conversions |
| E-commerce storefronts | Product SEO, performance |
| Portfolio sites | Shareability, speed |
| Company websites | Professional presence |
| SaaS marketing pages | Lead generation |

### Choose Flutter when building

| Use Case | Why Flutter |
|----------|-------------|
| Cross-platform apps | iOS, Android, Desktop, Web |
| Complex data visualization | Canvas performance |
| Games | Skia rendering |
| Offline-first apps | Native capabilities |
| Apps with heavy animations | 60fps guaranteed |
| Internal tools | No SEO needed |

---

## Arcane Design System Comparison

Both platforms use the Arcane design system, but implementations differ:

### Shared features

| Feature | Flutter Arcane | Jaspr Arcane |
|---------|---------------|--------------|
| Theme Presets | 18+ colors | 18+ colors |
| Dark Mode | Built-in | Built-in |
| Component Library | 100+ widgets | 75+ components |
| Consistent Design | Yes | Yes |

### Implementation differences

| Aspect | Flutter Arcane | Jaspr Arcane |
|--------|---------------|--------------|
| Styling | Widget properties | ArcaneStyleData + CSS |
| Theming | ThemeData | CSS variables |
| Custom Styles | Widget parameters | Raw CSS escape hatch |
| Responsive | MediaQuery | CSS media queries |
| Animations | Animation controllers | CSS transitions |

---

## Migration Considerations

### From Flutter Web to Jaspr

For a Flutter web app that needs HTML output:

1. Check whether the interface depends on custom painting or canvas behavior.
2. Map the existing widgets to their Arcane Jaspr equivalents.
3. Replace Navigator routes with the project's Jaspr routing setup.
4. Verify the built HTML and metadata with browser and indexing tools.

### Keeping Both

The two frameworks can share a product without sharing a renderer:

- Use Flutter for native mobile and desktop applications.
- Use Jaspr for HTML documentation and public web pages.

The Arcane packages keep related component names and theme concepts across both platforms.

---

## Getting Started

Create an Arcane Jaspr project:

```bash
# Install Oracular
dart pub global activate oracular

# Create a new project
oracular create app --template arcane_jaspr_app --name my_site

# Start developing
cd my_site
jaspr serve
```

See the [Installation Guide](/arcane_jaspr/docs/installation) for detailed setup instructions.
