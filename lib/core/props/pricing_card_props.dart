import 'package:arcane_jaspr/flutter.dart';
import '../../component/view/icon.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

/// Visual variant for pricing cards.
enum PricingCardVariant {
  /// Minimal card for grids.
  compact,

  /// Default full-featured card.
  standard,
}

/// Hardware/feature specification entry.
class SpecEntry {
  final String label;
  final String value;

  const SpecEntry({required this.label, required this.value});
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

  const PricingTier({
    required this.name,
    this.price,
    this.period = 'month',
    this.currency = '\$',
    required this.description,
    required this.features,
    this.ctaText = 'Get Started',
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

  /// Custom icon component for header.
  final ArcaneGlyph? icon;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const PricingCardProps({
    this.tier,
    this.onCtaPressed,
    this.title,
    this.subtitle,
    this.price,
    this.period = '/month',
    this.features = const [],
    this.excludedFeatures = const [],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.variant = PricingCardVariant.standard,
    this.icon,
    this.styles,
    this.decoration,
  });

  /// Creates a compact pricing card for grids.
  const PricingCardProps.compact({
    required String this.title,
    required String this.price,
    this.subtitle,
    this.period = '/month',
    this.features = const [],
    this.excludedFeatures = const [],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.icon,
    this.styles,
    this.decoration,
  }) : tier = null,
       onCtaPressed = null,
       variant = PricingCardVariant.compact;

  /// Gets the effective title (from tier or direct property).
  String get effectiveTitle => title ?? tier?.name ?? '';

  /// Gets the effective price display.
  String get effectivePrice =>
      price ?? (tier?.price != null ? '${tier!.currency}${tier!.price}' : '');

  /// Gets the effective period.
  String get effectivePeriod =>
      tier?.period != null ? '/${tier!.period}' : period;

  /// Gets the effective subtitle.
  String? get effectiveSubtitle => subtitle ?? tier?.description;

  /// Gets the effective features.
  List<String> get effectiveFeatures =>
      features.isNotEmpty ? features : (tier?.features ?? []);

  /// Gets the effective CTA text.
  String get effectiveCtaText =>
      buttonText != 'Get Started' ? buttonText : (tier?.ctaText ?? buttonText);
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
