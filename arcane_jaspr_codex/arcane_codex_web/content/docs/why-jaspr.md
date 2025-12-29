---
title: Why Jaspr?
description: When to choose Jaspr over Flutter for web development
layout: docs
---

# Why Jaspr + Arcane Jaspr?

This guide helps you understand when Jaspr is the right choice for your web project, especially compared to Flutter web.

## The Core Difference

**Flutter Web** renders your UI to a canvas element. The browser sees a single `<canvas>` tag, not your buttons, text, or links.

**Jaspr** renders to semantic HTML. Your button is a `<button>`, your text is a `<p>`, your link is an `<a>`. The browser understands your content.

This fundamental difference affects everything.

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

**Bottom Line:** If people need to find your site via Google or share it on social media, Jaspr is the clear choice.

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

**Note:** Flutter has better runtime performance for complex animations, but most websites do not need this level of performance.

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

### Choose Jaspr When Building:

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

### Choose Flutter When Building:

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

### Shared Features

| Feature | Flutter Arcane | Jaspr Arcane |
|---------|---------------|--------------|
| Theme Presets | 18+ colors | 18+ colors |
| Dark Mode | Built-in | Built-in |
| Component Library | 100+ widgets | 75+ components |
| Consistent Design | Yes | Yes |

### Implementation Differences

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

If you have a Flutter web app that needs better SEO:

1. **Evaluate Complexity:** Simple UIs migrate easily. Complex custom painting does not.
2. **Identify Components:** Most Arcane widgets have Arcane Jaspr equivalents.
3. **Plan Routing:** jaspr_router uses different patterns than Navigator.
4. **Test SEO:** Verify Google can index your new site.

### Keeping Both

Many teams use both:
- **Flutter** for native mobile/desktop apps
- **Jaspr** for marketing site, docs, blog

The Arcane design system ensures visual consistency across both platforms.

---

## Getting Started

Ready to build with Jaspr + Arcane Jaspr?

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
