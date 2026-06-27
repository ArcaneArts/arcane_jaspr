import 'package:arcane_jaspr/flutter.dart';

/// Supported game platforms for display icons.
enum GamePlatform {
  pc,
  xbox,
  playstation,
  crossplay,
  mobile,
}

/// Visual variant for game tiles.
enum GameTileVariant {
  /// Compact selection tile with centered icon (default).
  compact,

  /// Full card layout with large image and info section.
  card,

  /// Hero/featured tile with larger dimensions.
  hero,
}

/// Game tile component properties.
class GameTileProps {
  final String name;
  final String? iconUrl;
  final Widget? icon;
  final bool selected;
  final void Function()? onTap;
  final bool popular;
  final String? badge;
  final String? subtitle;

  /// Whether the game is new (shows NEW badge).
  final bool isNew;

  /// List of supported platforms (for platform icons).
  final List<GamePlatform> platforms;

  /// Link destination (alternative to onTap for navigation).
  final String? href;

  /// Whether to show hover effects (scale, shadow).
  final bool showHoverEffects;

  /// Whether to show platform icons.
  final bool showPlatformIcons;

  /// CTA button text (e.g., "Get Started").
  final String? ctaText;

  /// Custom height for the tile.
  final String? height;

  /// Visual variant of the tile.
  final GameTileVariant variant;

  /// Animation delay in milliseconds for staggered grid animations.
  final int? animationDelayMs;

  const GameTileProps({
    required this.name,
    this.iconUrl,
    this.icon,
    this.selected = false,
    this.onTap,
    this.popular = false,
    this.badge,
    this.subtitle,
    this.isNew = false,
    this.platforms = const [],
    this.href,
    this.showHoverEffects = true,
    this.showPlatformIcons = true,
    this.ctaText,
    this.height,
    this.variant = GameTileVariant.compact,
    this.animationDelayMs,
  });

  /// Creates a card-style game tile with image and info sections.
  const GameTileProps.card({
    required this.name,
    this.iconUrl,
    this.icon,
    this.selected = false,
    this.onTap,
    this.popular = false,
    this.badge,
    this.subtitle,
    this.isNew = false,
    this.platforms = const [],
    this.href,
    this.showHoverEffects = true,
    this.showPlatformIcons = true,
    this.ctaText = 'Get Started',
    this.height = '420px',
    this.animationDelayMs,
  }) : variant = GameTileVariant.card;
}

/// Game selector component properties.
class GameSelectorProps {
  final List<GameTileProps> games;
  final int columns;
  final double gap;
  final String? title;
  final String? description;

  const GameSelectorProps({
    required this.games,
    this.columns = 4,
    this.gap = 16,
    this.title,
    this.description,
  });
}

/// Game card component properties.
class GameCardProps {
  final String name;
  final String? description;
  final String? iconUrl;
  final Widget? icon;
  final String? backgroundUrl;
  final String? status;
  final List<String>? features;
  final void Function()? onTap;
  final String? ctaText;

  const GameCardProps({
    required this.name,
    this.description,
    this.iconUrl,
    this.icon,
    this.backgroundUrl,
    this.status,
    this.features,
    this.onTap,
    this.ctaText,
  });
}

/// Game link (navigation tile) component properties.
///
/// Used for horizontal navigation links with icon, name, and optional badge.
/// Features accent color theming for glows, gradients, and borders.
class GameLinkProps {
  /// Game name to display.
  final String name;

  /// Link destination.
  final String href;

  /// Accent color for theming (CSS color value).
  /// Used for gradient backgrounds, glows, and borders.
  final String accentColor;

  /// URL to the game icon image.
  final String? iconUrl;

  /// Custom icon component (alternative to iconUrl).
  final Widget? icon;

  /// Optional badge text (e.g., "NEW", "POPULAR").
  final String? badge;

  /// Whether to use compact/mini sizing.
  final bool mini;

  const GameLinkProps({
    required this.name,
    required this.href,
    required this.accentColor,
    this.iconUrl,
    this.icon,
    this.badge,
    this.mini = false,
  });

  /// Creates a mini (compact) game link.
  const GameLinkProps.mini({
    required this.name,
    required this.href,
    required this.accentColor,
    this.iconUrl,
    this.icon,
    this.badge,
  }) : mini = true;
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for game tile components.
mixin GameTileRendererContract {
  Widget gameTile(GameTileProps props);
  Widget gameSelector(GameSelectorProps props);
  Widget gameCard(GameCardProps props);
  Widget gameLink(GameLinkProps props);
}
