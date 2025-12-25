# Arcane Jaspr Changes for QualityNode

This file tracks changes made to arcane_jaspr to support QualityNode's design requirements.

---

## 2025-12-25

### Added `uniformBackgrounds` theme option

**File:** `lib/util/appearance/theme.dart`

**Purpose:** Allow sleek, uniform dark designs without section contrast.

**Changes:**
1. Added `uniformBackgrounds` boolean field to `ArcaneTheme` class (default: `false`)
2. Updated `cssVariables` getter to use uniform backgrounds when enabled:
   - `--arcane-background-secondary` now equals `--arcane-background` when `uniformBackgrounds: true`
   - `--arcane-background-tertiary` now equals `--arcane-background` when `uniformBackgrounds: true`
3. Added `uniformBackgrounds` parameter to `copyWith()` method

**Usage in QualityNode:**
```dart
ArcaneApp(
  theme: ArcaneTheme.oledGreen.copyWith(
    themeMode: ThemeMode.dark,
    uniformBackgrounds: true, // Sleek uniform black backgrounds
  ),
  child: ...
)
```

**Benefit:** QualityNode can now use standard arcane color tokens (`ArcaneColors.backgroundSecondary`, `Background.backgroundSecondary`, etc.) while still achieving the uniform pure-black design aesthetic.

---

### Added `ArcaneColors.accentGradient` token

**File:** `lib/util/tokens/tokens.dart`

**Purpose:** Provide a standard gradient token for accent-colored gradients.

**Usage:**
```dart
ArcaneColors.accentGradient
// Returns: 'linear-gradient(135deg, var(--arcane-accent) 0%, var(--arcane-secondary) 100%)'
```

---

### Added `ArcaneCtaLink` component

**File:** `lib/component/button/cta_link.dart`

**Purpose:** CTA link buttons with multiple variants for different visual hierarchies.

**Variants:**
- `ArcaneCtaLink.primary()` - Solid accent background
- `ArcaneCtaLink.secondary()` - Outline/border style
- `ArcaneCtaLink.ghost()` - Text-only style
- `ArcaneCtaLink.accent()` - Gradient background

**Sizes:** `CtaLinkSize.sm`, `CtaLinkSize.md`, `CtaLinkSize.lg`

**Usage:**
```dart
ArcaneCtaLink.primary(
  label: 'Get Started',
  href: '/signup',
  showArrow: true,
  size: CtaLinkSize.lg,
)
```

---

### Added `ArcaneSectionHeader` component

**File:** `lib/component/layout/section_header.dart`

**Purpose:** Reusable section headers with label, heading, and description.

**Usage:**
```dart
ArcaneSectionHeader(
  label: 'Features',
  heading: 'Why Choose Us',
  description: 'Discover what makes us different.',
  align: SectionHeaderAlign.center,
)
```

---

### Added `ArcaneStatusBadge` component

**File:** `lib/component/feedback/status_badge.dart`

**Purpose:** Status indicator badges with pulse animation for system status displays.

**Variants:**
- `ArcaneStatusBadge.success()` - Green, operational
- `ArcaneStatusBadge.warning()` - Yellow, degraded
- `ArcaneStatusBadge.error()` - Red, down
- `ArcaneStatusBadge.info()` - Blue, informational
- `ArcaneStatusBadge.offline()` - Gray, offline

**Usage:**
```dart
ArcaneStatusBadge.success('All Systems Operational')
```

---

### Added `ArcaneFadeEdge` component

**File:** `lib/component/view/fade_edge.dart`

**Purpose:** Gradient fade overlays for carousels and scrolling content edges.

**Directions:** `.left()`, `.right()`, `.top()`, `.bottom()`

**Usage:**
```dart
Stack([
  ScrollContent(...),
  ArcaneFadeEdge.left(color: '#09090b'),
  ArcaneFadeEdge.right(color: '#09090b'),
])
```

---

### Added `ArcaneMarquee` component

**File:** `lib/component/view/marquee.dart`

**Purpose:** Infinite scrolling marquee/carousel with optional fade edges.

**Features:**
- Automatic content duplication for seamless looping
- Configurable speed via `duration`
- Optional fade edges
- Pause on hover support
- Reverse direction variant (`ArcaneMarqueeReverse`)

**Usage:**
```dart
ArcaneMarquee(
  children: [
    for (final item in items) ItemCard(item),
  ],
  duration: '30s',
  showFadeEdges: true,
  pauseOnHover: true,
)
```

---

### Added `ArcaneFooterColumn` component

**File:** `lib/component/layout/footer_column.dart`

**Purpose:** Footer columns with title and link lists, plus brand column variant.

**Components:**
- `ArcaneFooterColumn` - Column with title and list of `FooterLink` items
- `ArcaneFooterBrandColumn` - Brand section with logo, description, and optional bottom content

**Usage:**
```dart
ArcaneFooterColumn(
  title: 'Resources',
  links: [
    FooterLink(label: 'Documentation', href: '/docs'),
    FooterLink(label: 'API Reference', href: '/api'),
    FooterLink(label: 'Support', href: '/support'),
  ],
)

ArcaneFooterBrandColumn(
  logo: MyLogo(),
  description: 'Premium game server hosting.',
  bottomContent: ArcaneStatusBadge.success('All Systems Operational'),
)
```

---

### Added `ArcaneStatDisplay` component

**File:** `lib/component/view/stat_display.dart`

**Purpose:** Metric/stat display with large value and label for trust indicators.

**Components:**
- `ArcaneStatDisplay` - Single stat with value and label
- `ArcaneStatRow` - Container for multiple stats

**Variants:**
- `ArcaneStatDisplay.accent()` - Accent-colored value
- `ArcaneStatDisplay.brand()` - Brand-colored value

**Layouts:** `vertical` (default), `horizontal`

**Usage:**
```dart
ArcaneStatRow(
  stats: [
    ArcaneStatDisplay(value: '99.9%', label: 'Uptime SLA'),
    ArcaneStatDisplay(value: '10K+', label: 'Active Servers'),
    ArcaneStatDisplay(value: '<60s', label: 'Deploy Time'),
  ],
)
```

---

### Added `ArcaneAuthorCard` component

**File:** `lib/component/view/author_card.dart`

**Purpose:** Author attribution card with avatar, name, and role.

**Features:**
- Size variants: `sm`, `md`, `lg`
- Supports avatar URL or initials fallback
- Customizable colors

**Usage:**
```dart
ArcaneAuthorCard(
  avatarUrl: 'https://example.com/avatar.jpg',
  name: 'John Doe',
  role: 'Software Engineer',
  size: AuthorCardSize.md,
)

ArcaneAuthorCard.lg(
  name: 'Jane Smith',
  role: 'CEO',
  initials: 'JS',
)
```

---

### Added `ArcaneCodeWindow` component

**File:** `lib/component/view/code_window.dart`

**Purpose:** Code display with macOS-style window chrome (traffic light buttons).

**Components:**
- `ArcaneCodeWindow` - Full window with header and code
- `ArcaneCodeSnippet` - Compact code display without window chrome

**Styles:** `dark`, `light`, `terminal`

**Usage:**
```dart
ArcaneCodeWindow(
  title: 'main.dart',
  code: '''
void main() {
  print('Hello, World!');
}
''',
)

ArcaneCodeWindow.terminal(
  code: '\$ npm install\n\$ npm start',
)
```

---

### Added `ArcaneCheckList` component

**File:** `lib/component/view/check_list.dart`

**Purpose:** Lists with checkmark icons for features, benefits, and requirements.

**Components:**
- `ArcaneCheckItem` - Single item with icon and text
- `ArcaneCheckList` - List of check items
- `ArcaneFeatureRow` - Feature row with included/excluded state

**Icon Styles:** `check`, `bullet`, `arrow`, `plus`, `star`

**Usage:**
```dart
ArcaneCheckList.brand(
  items: [
    'Shared models across web and server',
    'Type-safe API calls',
    'Hot reload in development',
  ],
)

ArcaneFeatureRow(
  feature: 'Unlimited API calls',
  included: true,
)
```

---
