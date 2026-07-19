import 'package:arcane_jaspr/flutter.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

// ============================================================================
// ENUMS
// ============================================================================

/// Position for the corner promo toast.
enum PromoCornerPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// Position for the sliding sidebar.
enum PromoSidebarPosition {
  left,
  right,
}

/// Style variants for the inline hero banner.
enum PromoInlineHeroBannerStyle {
  badge,
  ribbon,
  pill,
  card,
}

// ============================================================================
// TOP ANNOUNCEMENT BAR PROPS
// ============================================================================

/// Props for the top announcement bar.
///
/// A thin sticky announcement bar at the top of the page.
/// Shows promo message with optional CTA button and dismiss functionality.
class TopAnnouncementBarProps {
  /// The main promotional message to display.
  final String message;

  /// Optional promo code to show.
  final String? promoCode;

  /// Text for the call-to-action button.
  final String? ctaText;

  /// URL for the CTA button.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when the bar is dismissed.
  final void Function()? onDismiss;

  /// Whether to show the copy button for the promo code.
  final bool showCopyButton;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const TopAnnouncementBarProps({
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.showCopyButton = true,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// BOTTOM FLOATING BANNER PROPS
// ============================================================================

/// Props for the bottom floating banner.
///
/// Bottom floating banner that slides up with optional countdown timer.
/// Great for limited-time offers and flash sales.
class BottomFloatingBannerProps {
  /// Banner title.
  final String title;

  /// Banner message.
  final String message;

  /// Optional promo code.
  final String? promoCode;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when the banner is dismissed.
  final void Function()? onDismiss;

  /// Countdown duration (e.g., time until offer expires).
  final Duration? countdownDuration;

  /// Specific expiration date/time.
  final DateTime? expiresAt;

  /// Delay in milliseconds before showing the banner.
  final int delayMs;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const BottomFloatingBannerProps({
    required this.title,
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.countdownDuration,
    this.expiresAt,
    this.delayMs = 2000,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// CORNER PROMO TOAST PROPS
// ============================================================================

/// Props for the corner promo toast.
///
/// A corner toast-style promo notification that slides in from a corner.
/// Less intrusive than a modal, great for subtle promotions.
class CornerPromoToastProps {
  /// Toast title.
  final String title;

  /// Toast message.
  final String message;

  /// Optional promo code.
  final String? promoCode;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when the toast is dismissed.
  final void Function()? onDismiss;

  /// Which corner to position the toast.
  final PromoCornerPosition position;

  /// Delay in milliseconds before showing.
  final int delayMs;

  /// Optional icon to display.
  final Widget? icon;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const CornerPromoToastProps({
    required this.title,
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.position = PromoCornerPosition.bottomRight,
    this.delayMs = 3000,
    this.icon,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// PROMO MODAL PROPS
// ============================================================================

/// Props for the promo modal.
///
/// Full-screen modal popup for high-priority promotions.
/// Use sparingly - best for first-time visitors or major sales events.
class PromoModalProps {
  /// Modal title.
  final String title;

  /// Modal subtitle (shown above title).
  final String subtitle;

  /// Optional description text.
  final String? description;

  /// Optional promo code.
  final String? promoCode;

  /// Discount text (e.g., "15% OFF").
  final String? discount;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when modal is dismissed.
  final void Function()? onDismiss;

  /// Delay in milliseconds before showing.
  final int delayMs;

  /// Countdown duration for urgency.
  final Duration? countdownDuration;

  /// Optional hero image component.
  final Widget? heroImage;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const PromoModalProps({
    required this.title,
    required this.subtitle,
    this.description,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.delayMs = 1000,
    this.countdownDuration,
    this.heroImage,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// INLINE HERO BANNER PROPS
// ============================================================================

/// Props for the inline hero banner.
///
/// An inline promotional banner that integrates with the hero section.
/// Can be displayed as a badge, ribbon, pill, or card style.
class InlineHeroBannerProps {
  /// Banner message.
  final String message;

  /// Optional promo code.
  final String? promoCode;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when dismissed.
  final void Function()? onDismiss;

  /// Visual style variant.
  final PromoInlineHeroBannerStyle variant;

  /// Whether the banner can be dismissed.
  final bool dismissible;

  /// Optional icon to display.
  final Widget? icon;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const InlineHeroBannerProps({
    required this.message,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.variant = PromoInlineHeroBannerStyle.pill,
    this.dismissible = true,
    this.icon,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// SLIDING SIDEBAR BANNER PROPS
// ============================================================================

/// Props for the sliding sidebar banner.
///
/// A vertical sidebar banner that slides in from the edge of the screen.
/// Great for detailed promotions with more content space.
class SlidingSidebarBannerProps {
  /// Banner title.
  final String title;

  /// Optional subtitle.
  final String? subtitle;

  /// Banner message.
  final String message;

  /// Optional promo code.
  final String? promoCode;

  /// Discount text (e.g., "15% OFF").
  final String? discount;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when dismissed.
  final void Function()? onDismiss;

  /// Which side to show the sidebar.
  final PromoSidebarPosition position;

  /// Delay in milliseconds before showing.
  final int delayMs;

  /// Optional list of features to display.
  final List<String>? features;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const SlidingSidebarBannerProps({
    required this.title,
    required this.message,
    this.subtitle,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.position = PromoSidebarPosition.right,
    this.delayMs = 3000,
    this.features,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// MARQUEE TICKER BAR PROPS
// ============================================================================

/// Props for the marquee ticker bar.
///
/// A scrolling marquee-style announcement bar.
/// Great for creating urgency with continuous movement.
class MarqueeTickerBarProps {
  /// List of messages to scroll.
  final List<String> messages;

  /// Optional promo code.
  final String? promoCode;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when dismissed.
  final void Function()? onDismiss;

  /// Whether to show at bottom instead of top.
  final bool showAtBottom;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const MarqueeTickerBarProps({
    required this.messages,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.showAtBottom = false,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// EXPANDING FAB PROMO PROPS
// ============================================================================

/// Props for the expanding FAB promo.
///
/// A floating action button that expands to reveal a promo.
/// Minimally intrusive - user initiates the interaction.
class ExpandingFabPromoProps {
  /// Promo title.
  final String title;

  /// Promo message.
  final String message;

  /// Optional promo code.
  final String? promoCode;

  /// Discount text (e.g., "15%").
  final String? discount;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when dismissed.
  final void Function()? onDismiss;

  /// Optional icon to display on the FAB.
  final Widget? icon;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const ExpandingFabPromoProps({
    required this.title,
    required this.message,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.icon,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// PROGRESS CLAIM BANNER PROPS
// ============================================================================

/// Props for the progress claim banner.
///
/// A banner showing how many people have claimed an offer.
/// Creates urgency through social proof and scarcity.
class ProgressClaimBannerProps {
  /// Banner title.
  final String title;

  /// Banner message.
  final String message;

  /// Optional promo code.
  final String? promoCode;

  /// Number of offers already claimed.
  final int claimedCount;

  /// Total number of offers available.
  final int totalCount;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when dismissed.
  final void Function()? onDismiss;

  /// Delay in milliseconds before showing.
  final int delayMs;

  /// Whether to simulate progress increasing over time.
  final bool simulateProgress;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const ProgressClaimBannerProps({
    required this.title,
    required this.message,
    required this.claimedCount,
    required this.totalCount,
    this.promoCode,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.delayMs = 2000,
    this.simulateProgress = true,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// MINIMIZABLE PROMO PROPS
// ============================================================================

/// Props for the minimizable promo.
///
/// A promo drawer that slides in from the right edge.
/// When minimized, only a slim tab is visible. Click to expand the full panel.
class MinimizablePromoProps {
  /// Promo title.
  final String title;

  /// Promo message.
  final String message;

  /// Optional promo code.
  final String? promoCode;

  /// Discount text (e.g., "15% OFF").
  final String? discount;

  /// CTA button text.
  final String? ctaText;

  /// CTA button URL.
  final String? ctaHref;

  /// Callback when CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when dismissed.
  final void Function()? onDismiss;

  /// Label shown on the minimized tab.
  final String tabLabel;

  /// Delay in milliseconds before showing.
  final int delayMs;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const MinimizablePromoProps({
    required this.title,
    required this.message,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.onCtaClick,
    this.onDismiss,
    this.tabLabel = 'DEAL',
    this.delayMs = 2000,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// FULLSCREEN TAKEOVER PROPS
// ============================================================================

/// Props for the fullscreen takeover.
///
/// A dramatic full-screen takeover for major promotions.
/// Use very sparingly - only for major sales events or first-time visitors.
class FullscreenTakeoverProps {
  /// Large headline text.
  final String headline;

  /// Subheadline (shown above headline).
  final String subheadline;

  /// Optional description text.
  final String? description;

  /// Optional promo code.
  final String? promoCode;

  /// Discount text (e.g., "15% OFF").
  final String? discount;

  /// Primary CTA button text.
  final String? ctaText;

  /// Primary CTA button URL.
  final String? ctaHref;

  /// Secondary CTA button text.
  final String? secondaryCtaText;

  /// Callback when primary CTA is clicked.
  final void Function()? onCtaClick;

  /// Callback when dismissed.
  final void Function()? onDismiss;

  /// Delay in milliseconds before showing.
  final int delayMs;

  /// Countdown duration for urgency.
  final Duration? countdownDuration;

  /// Optional custom styles for the component.
  final ArcaneStyleData? styles;

  /// Optional decoration for the component.
  final ArcaneDecoration? decoration;

  const FullscreenTakeoverProps({
    required this.headline,
    required this.subheadline,
    this.description,
    this.promoCode,
    this.discount,
    this.ctaText,
    this.ctaHref,
    this.secondaryCtaText,
    this.onCtaClick,
    this.onDismiss,
    this.delayMs = 2000,
    this.countdownDuration,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for promo components.
mixin PromoRendererContract {
  /// Render a top announcement bar component.
  Widget topAnnouncementBar(TopAnnouncementBarProps props);

  /// Render a bottom floating banner component.
  Widget bottomFloatingBanner(BottomFloatingBannerProps props);

  /// Render a corner promo toast component.
  Widget cornerPromoToast(CornerPromoToastProps props);

  /// Render a promo modal component.
  Widget promoModal(PromoModalProps props);

  /// Render an inline hero banner component.
  Widget inlineHeroBanner(InlineHeroBannerProps props);

  /// Render a sliding sidebar banner component.
  Widget slidingSidebarBanner(SlidingSidebarBannerProps props);

  /// Render a marquee ticker bar component.
  Widget marqueeTickerBar(MarqueeTickerBarProps props);

  /// Render an expanding FAB promo component.
  Widget expandingFabPromo(ExpandingFabPromoProps props);

  /// Render a progress claim banner component.
  Widget progressClaimBanner(ProgressClaimBannerProps props);

  /// Render a minimizable promo component.
  Widget minimizablePromo(MinimizablePromoProps props);

  /// Render a fullscreen takeover component.
  Widget fullscreenTakeover(FullscreenTakeoverProps props);
}
