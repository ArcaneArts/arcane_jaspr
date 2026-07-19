---
title: Card Family
description: Composite marketing cards — StatCard, FeatureCard, CtaCard, TestimonialCard, PricingCard, and IconBadge — built on the primary surface
layout: kb
---

# Card Family

The card family is a set of composite, marketing-oriented components built on the primary `package:arcane_jaspr/arcane_jaspr.dart` surface. Each one is themed automatically by the active stylesheet, and most accept the same per-instance `styles:` and `decoration:` surfaces described in [Authoring like Flutter](/docs/concepts/permeability).

Source: `lib/component/card/`

## StatCard and StatCardRow

A compact metric surface: a label, a value, and optional trend, description, and icon.

Source: `lib/component/card/stat_card.dart`

```dart
StatCard(
  label: 'Monthly Revenue',
  value: r'$48,120',
  trend: '+12.5%',
  trendPositive: true,
  description: 'vs. last month',
)
```

Arrange several in a responsive grid with `StatCardRow`:

```dart
StatCardRow(
  columns: 3,
  cards: <Widget>[
    StatCard(label: 'Users', value: '1,204'),
    StatCard(label: 'Sessions', value: '8,932'),
    StatCard(label: 'Bounce', value: '32%', trend: '-4%', trendPositive: true),
  ],
)
```

`StatCard`: `label` and `value` are required. `icon` is a literal text/glyph string rendered inside the icon badge, `iconBackground` is a CSS color for that badge, and `trend` / `trendPositive` / `description` are optional. `StatCardRow`: `cards` is required; `columns` defaults to `4`; `gap` is an optional CSS length.

## FeatureCard and IconCard

`FeatureCard` promotes a single capability with a title, description, optional icon, and optional CTA.

Source: `lib/component/card/feature_card.dart`

```dart
FeatureCard(
  title: 'Type-safe styling',
  description: 'Compile-time checked design tokens with full autocomplete.',
  icon: ArcaneIcon.palette(),
  href: '/docs/concepts/styling',
  showArrow: true,
)
```

The `.accented` constructor requires an `icon` and `accentColor` and always shows a CTA button:

```dart
FeatureCard.accented(
  title: 'External docs',
  description: 'Opens the full API reference in a new tab.',
  icon: ArcaneIcon.bookOpen(),
  accentColor: 'var(--primary)',
  href: 'https://pub.dev/packages/arcane_jaspr',
  isExternal: true,
  ctaText: 'Read the docs',
)
```

Key props: `title` and `description` are required. `accentColor` tints the icon container and gradient border, `isExternal` opens the link in a new tab, `showCta` / `ctaText` control the button, and `horizontal` switches to a side-by-side layout.

`IconCard` is a lighter tile — a required `title` and `icon`, with optional `subtitle`, `onTap`, and `href`:

```dart
IconCard(
  title: 'Settings',
  icon: ArcaneIcon.settings(),
  subtitle: 'Manage your workspace',
  href: '/settings',
)
```

## CtaCard

A call-to-action card with a dashed border, centered content, and an action button. Used for "request", "suggest", or any action-oriented tile.

Source: `lib/component/card/cta_card.dart`

```dart
CtaCard(
  icon: ArcaneIcon.plus(),
  title: 'Request a feature',
  description: 'Tell us what would make Arcane Jaspr better for you.',
  ctaText: 'Open an issue',
  href: 'https://github.com/ArcaneArts/arcane_jaspr/issues',
  accentColor: 'var(--primary)',
  isExternal: true,
)
```

Key props: `title` and `ctaText` are required. `accentColor` colors the icon chip and CTA button (defaults to `var(--primary)`). When `isExternal` is `true` the anchor opens in a new tab with `rel="noopener noreferrer"` and shows a trailing external-link glyph. `height` defaults to `'420px'` and `showHoverEffects` defaults to `true`.

## TestimonialCard and RatingStars

`TestimonialCard` renders a quote, an author, and an optional star rating.

Source: `lib/component/card/testimonial_card.dart`

```dart
TestimonialCard(
  quote: 'Arcane Jaspr made our web build feel like Flutter.',
  authorName: 'Ada Lovelace',
  authorTitle: 'Staff Engineer',
  authorCompany: 'Analytical Engines',
  rating: 5,
  showRatingBadge: true,
  showAccentBorder: true,
)
```

Key props: `quote` and `authorName` are required. When `rating` is set and no `accentColor` is given, the accent color is derived from the rating (5 = success green down to 1 = destructive red). `showQuotes`, `showRatingBadge`, and `showAccentBorder` toggle the decorative treatments.

`RatingStars` is the standalone star control:

```dart
RatingStars(
  rating: 4.5,
  maxStars: 5,
  size: 20,
)
```

`rating` is required. `maxStars` defaults to `5`, `size` (in pixels) to `16`. Set `interactive: true` and provide `onRatingChanged` to let users pick a rating.

## PricingCard and PricingGrid

`PricingCard` renders a full pricing tier: title, price, feature list, optional hardware specs, a badge, and a CTA.

Source: `lib/component/card/pricing_card.dart`

```dart
PricingCard(
  title: 'Pro',
  price: r'$29',
  period: '/month',
  subtitle: 'For growing teams',
  badge: 'Popular',
  badgeVariant: PricingBadgeVariant.popular,
  highlighted: true,
  features: const <String>[
    'Unlimited projects',
    'Priority support',
    'Custom domains',
  ],
  specs: const <SpecEntry>[
    SpecEntry(label: 'Seats', value: '10'),
    SpecEntry(label: 'Storage', value: '1 TB', highlight: true),
  ],
  buttonText: 'Start free trial',
  buttonLink: '/signup',
)
```

Key props: `highlighted` marks the featured card. `variant` (`PricingCardVariant.compact`, `.standard`, `.hero`) sets the density; `.compact` and `.hero` also have dedicated named constructors that require `title` and `price`. `badge` / `badgeVariant` render the corner badge, `specs` is a `List<SpecEntry>` of hardware/feature rows (each with `label`, `value`, and an optional `highlight`), and `accentColor` overrides the accent.

`PricingGrid` lays out several tiers from typed `PricingTier` data:

```dart
PricingGrid(
  columns: 3,
  tiers: const <PricingTier>[
    PricingTier(
      name: 'Starter',
      price: 0,
      description: 'For side projects',
      features: <String>['1 project', 'Community support'],
    ),
    PricingTier(
      name: 'Pro',
      price: 29,
      description: 'For growing teams',
      features: <String>['Unlimited projects', 'Priority support'],
      isPopular: true,
      isHighlighted: true,
    ),
  ],
)
```

## IconBadge

A small tinted chip that frames an icon — the building block behind the icon treatments on the other cards.

Source: `lib/component/view/icon_badge.dart`

```dart
IconBadge(
  icon: ArcaneIcon.zap(),
  accentColor: 'var(--primary)',
  size: 40,
  tintOpacity: 0.12,
)
```

`icon` is required. `accentColor` defaults to `var(--primary)`, `size` to `40`, and `tintOpacity` to `0.12`. Use the `.square` constructor for a rounded-rectangle badge (`radius` defaults to `8`) instead of the default circle.
