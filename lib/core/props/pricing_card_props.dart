import 'package:arcane_jaspr/flutter.dart';

/// Visual variant for pricing cards.
enum PricingCardVariant {
  /// Minimal card for grids.
  compact,

  /// Default full-featured card.
  standard,

  /// Large featured card for landing pages.
  hero,
}

/// Badge variant for pricing cards.
enum PricingBadgeVariant {
  popular,
  recommended,
  isNew,
  primary,
}

/// Hardware/feature specification entry.
class SpecEntry {
  final String label;
  final String value;
  final bool highlight;

  const SpecEntry({
    required this.label,
    required this.value,
    this.highlight = false,
  });
}

/// Pricing tier data.
class PricingTier {
  final String name;
  final double? price;
  final String period;
  final String currency;
  final String description;
  final List<String> features;
  final String ctaText;
  final bool isPopular;
  final bool isHighlighted;

  const PricingTier({
    required this.name,
    this.price,
    this.period = 'month',
    this.currency = '\$',
    required this.description,
    required this.features,
    this.ctaText = 'Get Started',
    this.isPopular = false,
    this.isHighlighted = false,
  });
}

/// Pricing card component properties.
class PricingCardProps {
  /// Tier data (legacy - prefer individual properties).
  final PricingTier? tier;

  /// CTA callback (legacy - prefer onButtonClick).
  final void Function()? onCtaPressed;

  // ---- Core content ----

  /// Card title (plan name).
  final String? title;

  /// Optional subtitle/description.
  final String? subtitle;

  /// Price display (e.g., "\$9.99").
  final String? price;

  /// Price period (e.g., "/month").
  final String period;

  /// Original price for strikethrough (sale pricing).
  final String? originalPrice;

  // ---- Badge configuration ----

  /// Badge text (e.g., "Popular", "Best Value").
  final String? badge;

  /// Badge variant.
  final PricingBadgeVariant badgeVariant;

  // ---- Features and specs ----

  /// List of included features.
  final List<String> features;

  /// List of excluded features (shown with strikethrough).
  final List<String> excludedFeatures;

  /// Hardware/specification entries.
  final List<SpecEntry>? specs;

  // ---- Call-to-action ----

  /// CTA button text.
  final String buttonText;

  /// CTA button link.
  final String? buttonLink;

  /// CTA button click handler.
  final void Function()? onButtonClick;

  // ---- Styling and behavior ----

  /// Visual variant.
  final PricingCardVariant variant;

  /// Whether this card is highlighted (featured).
  final bool highlighted;

  /// Custom accent color (CSS color value).
  final String? accentColor;

  /// Custom icon component for header.
  final Widget? icon;

  const PricingCardProps({
    this.tier,
    this.onCtaPressed,
    this.title,
    this.subtitle,
    this.price,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const [],
    this.excludedFeatures = const [],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.variant = PricingCardVariant.standard,
    this.highlighted = false,
    this.accentColor,
    this.icon,
  });

  /// Creates a compact pricing card for grids.
  const PricingCardProps.compact({
    required String this.title,
    required String this.price,
    this.subtitle,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const [],
    this.excludedFeatures = const [],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.highlighted = false,
    this.accentColor,
    this.icon,
  })  : tier = null,
        onCtaPressed = null,
        variant = PricingCardVariant.compact;

  /// Creates a hero pricing card for landing pages.
  const PricingCardProps.hero({
    required String this.title,
    required String this.price,
    this.subtitle,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const [],
    this.excludedFeatures = const [],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.highlighted = false,
    this.accentColor,
    this.icon,
  })  : tier = null,
        onCtaPressed = null,
        variant = PricingCardVariant.hero;

  /// Gets the effective title (from tier or direct property).
  String get effectiveTitle => title ?? tier?.name ?? '';

  /// Gets the effective price display.
  String get effectivePrice =>
      price ?? (tier?.price != null ? '${tier!.currency}${tier!.price}' : '');

  /// Gets the effective period.
  String get effectivePeriod => tier?.period != null ? '/${tier!.period}' : period;

  /// Gets the effective subtitle.
  String? get effectiveSubtitle => subtitle ?? tier?.description;

  /// Gets the effective features.
  List<String> get effectiveFeatures =>
      features.isNotEmpty ? features : (tier?.features ?? []);

  /// Gets the effective CTA text.
  String get effectiveCtaText =>
      buttonText != 'Get Started' ? buttonText : (tier?.ctaText ?? buttonText);

  /// Gets whether the card is effectively highlighted.
  bool get effectiveHighlighted => highlighted || (tier?.isHighlighted ?? false);

  /// Gets whether to show popular badge.
  bool get isPopular => badge != null || (tier?.isPopular ?? false);

  /// Gets the effective badge text.
  String? get effectiveBadge => badge ?? (tier?.isPopular == true ? 'Popular' : null);
}

/// Pricing grid component properties.
class PricingGridProps {
  final List<PricingTier> tiers;
  final void Function(PricingTier tier)? onTierSelected;
  final int? columns;

  const PricingGridProps({
    required this.tiers,
    this.onTierSelected,
    this.columns,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for pricing card components.
mixin PricingCardRendererContract {
  Widget pricingCard(PricingCardProps props);
  Widget pricingGrid(PricingGridProps props);
}
