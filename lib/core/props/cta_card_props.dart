import 'package:arcane_jaspr/flutter.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

/// CTA (Call-to-Action) card component properties.
///
/// A card with a dashed border, centered content, and a call-to-action button.
/// Used for "request" cards, "suggest" cards, or any action-oriented card.
class CTACardProps {
  /// Icon to display at the top of the card.
  final Widget? icon;

  /// Main title/heading text.
  final String title;

  /// Description text below the title.
  final String? description;

  /// CTA button text.
  final String ctaText;

  /// Link destination (for anchor-based CTAs).
  final String? href;

  /// Callback for click events.
  final void Function()? onTap;

  /// Custom height for the card.
  final String height;

  /// Animation delay in milliseconds for staggered grid animations.
  final int? animationDelayMs;

  /// Whether to show hover effects.
  final bool showHoverEffects;

  /// Accent color (CSS color string) for the icon chip and CTA button.
  /// Defaults to the theme's `var(--primary)` when null.
  final String? accentColor;

  /// Whether the CTA links to an external destination. When true, the anchor
  /// opens in a new tab with `rel="noopener noreferrer"` and shows a trailing
  /// external-link glyph.
  final bool isExternal;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const CTACardProps({
    this.icon,
    required this.title,
    this.description,
    required this.ctaText,
    this.href,
    this.onTap,
    this.height = '420px',
    this.animationDelayMs,
    this.showHoverEffects = true,
    this.accentColor,
    this.isExternal = false,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for CTA card component.
mixin CTACardRendererContract {
  Widget ctaCard(CTACardProps props);
}
