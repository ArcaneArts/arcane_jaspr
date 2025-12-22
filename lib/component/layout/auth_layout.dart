import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// A layout for authentication screens with centered content and optional background effects.
///
/// Provides a full-viewport container with optional grid pattern and glow effects,
/// perfect for login, signup, and password reset screens.
class ArcaneAuthLayout extends StatelessComponent {
  /// The main content (typically an auth card/form)
  final Component child;

  /// Optional header content (typically a logo) displayed above the main content
  final Component? header;

  /// Optional footer content (typically a "back to home" link)
  final Component? footer;

  /// Whether to show the grid pattern background
  final bool showGrid;

  /// Whether to show the glow effects
  final bool showGlows;

  /// Primary glow color (top-left)
  final String primaryGlowColor;

  /// Secondary glow color (bottom-right)
  final String secondaryGlowColor;

  /// Grid line color
  final String gridColor;

  /// Maximum width of the content area
  final String maxWidth;

  /// Background color
  final String backgroundColor;

  const ArcaneAuthLayout({
    super.key,
    required this.child,
    this.header,
    this.footer,
    this.showGrid = true,
    this.showGlows = true,
    this.primaryGlowColor = ArcaneColors.accentGlow,
    this.secondaryGlowColor = ArcaneColors.secondaryGlow,
    this.gridColor = ArcaneColors.gridColor,
    this.maxWidth = '420px',
    this.backgroundColor = ArcaneColors.background,
  });

  /// Creates an auth layout with accent-colored glows based on theme
  const ArcaneAuthLayout.themed({
    super.key,
    required this.child,
    this.header,
    this.footer,
    this.showGrid = true,
    this.showGlows = true,
    this.maxWidth = '420px',
    this.backgroundColor = ArcaneColors.background,
  })  : primaryGlowColor = ArcaneColors.accentGlow,
        secondaryGlowColor = ArcaneColors.secondaryGlow,
        gridColor = ArcaneColors.gridColor;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-auth-layout',
      styles: Styles(raw: {
        'min-height': '100vh',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'background': backgroundColor,
        'padding': ArcaneSpacing.lg,
        'position': 'relative',
        'overflow': 'hidden',
      }),
      [
        // Background effects
        if (showGrid || showGlows) _buildBackgroundEffects(),
        // Content container
        div(
          classes: 'arcane-auth-content',
          styles: Styles(raw: {
            'width': '100%',
            'max-width': maxWidth,
            'position': 'relative',
            'z-index': '1',
          }),
          [
            // Header (logo)
            if (header != null)
              div(
                classes: 'arcane-auth-header',
                styles: const Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'margin-bottom': ArcaneSpacing.xl,
                }),
                [header!],
              ),
            // Main content (auth card)
            child,
            // Footer (back link)
            if (footer != null)
              div(
                classes: 'arcane-auth-footer',
                styles: const Styles(raw: {
                  'text-align': 'center',
                  'margin-top': ArcaneSpacing.xl,
                }),
                [footer!],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildBackgroundEffects() {
    return div(
      classes: 'arcane-auth-background',
      styles: const Styles(raw: {
        'position': 'absolute',
        'inset': '0',
        'pointer-events': 'none',
        'overflow': 'hidden',
      }),
      [
        // Grid pattern
        if (showGrid)
          div(
            classes: 'arcane-auth-grid',
            styles: Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background-image':
                  'linear-gradient($gridColor 1px, transparent 1px), linear-gradient(90deg, $gridColor 1px, transparent 1px)',
              'background-size': '50px 50px',
            }),
            [],
          ),
        // Top left glow
        if (showGlows)
          div(
            classes: 'arcane-auth-glow-primary',
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '-200px',
              'left': '-200px',
              'width': '500px',
              'height': '500px',
              'background': 'radial-gradient(circle, $primaryGlowColor 0%, transparent 70%)',
            }),
            [],
          ),
        // Bottom right glow
        if (showGlows)
          div(
            classes: 'arcane-auth-glow-secondary',
            styles: Styles(raw: {
              'position': 'absolute',
              'bottom': '-200px',
              'right': '-200px',
              'width': '500px',
              'height': '500px',
              'background': 'radial-gradient(circle, $secondaryGlowColor 0%, transparent 70%)',
            }),
            [],
          ),
      ],
    );
  }
}

/// A simple "back to" link for auth layouts.
class ArcaneAuthBackLink extends StatelessComponent {
  /// The href to navigate to
  final String href;

  /// The link text (defaults to "Back to home")
  final String text;

  const ArcaneAuthBackLink({
    super.key,
    required this.href,
    this.text = 'Back to home',
  });

  @override
  Component build(BuildContext context) {
    return a(
      href: href,
      classes: 'arcane-auth-back-link',
      styles: const Styles(raw: {
        'font-size': ArcaneTypography.fontSm,
        'color': ArcaneColors.muted,
        'text-decoration': 'none',
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
        'transition': ArcaneEffects.transitionFast,
      }),
      [Component.text('\u2190 $text')],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-auth-back-link:hover').styles(raw: {
      'color': ArcaneColors.accent,
    }),
  ];
}
