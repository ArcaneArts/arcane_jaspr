import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Split-screen layout for authentication pages.
///
/// Renders a two-column layout with branding content on the left
/// and form content on the right. On mobile, only the form panel
/// is shown with an optional header.
class AuthSplitLayout extends StatelessComponent {
  /// Content for the left branding panel
  final Component brandingContent;

  /// Content for the right form panel
  final Component formContent;

  /// Optional header shown on mobile (when branding panel is hidden)
  final Component? mobileHeader;

  /// Swap the left and right panels
  final bool reverseSides;

  const AuthSplitLayout({
    super.key,
    required this.brandingContent,
    required this.formContent,
    this.mobileHeader,
    this.reverseSides = false,
  });

  @override
  Component build(BuildContext context) {
    final leftPanel = _buildBrandingPanel();
    final rightPanel = _buildFormPanel();

    return ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        minHeight: '100vh',
        background: Background.background,
      ),
      children: [
        // Branding panel (hidden on mobile)
        if (!reverseSides) leftPanel else rightPanel,
        // Form panel
        if (!reverseSides) rightPanel else leftPanel,
      ],
    );
  }

  Component _buildBrandingPanel() {
    // Using raw div for complex media query styling
    return div(
      styles: Styles(raw: {
        'flex': '1',
        'display': 'flex',
        'flex-direction': 'column',
        'justify-content': 'center',
        'padding': ArcaneSpacing.xxxl,
        'position': 'relative',
        'overflow': 'hidden',
        'background': ArcaneColors.backgroundSecondary,
      }),
      classes: 'auth-branding-panel',
      [
        // Background gradient glow
        ArcaneDiv(
          styles: ArcaneStyleData(
            position: Position.absolute,
            inset: '0',
            pointerEvents: PointerEvents.none,
          ),
          children: [
            // Top-left green glow
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'top': '-20%',
                'left': '-10%',
                'width': '60%',
                'height': '60%',
                'background':
                    'radial-gradient(circle, ${ArcaneColors.accentContainer} 0%, transparent 70%)',
              }),
              [],
            ),
            // Bottom-right cyan glow
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'bottom': '-20%',
                'right': '-10%',
                'width': '50%',
                'height': '50%',
                'background':
                    'radial-gradient(circle, rgba(6, 182, 212, 0.08) 0%, transparent 70%)',
              }),
              [],
            ),
            // Subtle grid pattern
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'inset': '0',
                'background-image':
                    'linear-gradient(rgba(255, 255, 255, 0.02) 1px, transparent 1px), linear-gradient(90deg, rgba(255, 255, 255, 0.02) 1px, transparent 1px)',
                'background-size': '40px 40px',
              }),
              [],
            ),
          ],
        ),
        // Content
        ArcaneDiv(
          styles: ArcaneStyleData(
            position: Position.relative,
            zIndex: ZIndex.base,
            maxWidth: MaxWidth.form,
            margin: MarginPreset.auto,
          ),
          children: [brandingContent],
        ),
      ],
    );
  }

  Component _buildFormPanel() {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        flexGrow: 1,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        justifyContent: JustifyContent.center,
        alignItems: AlignItems.center,
        padding: PaddingPreset.lgXl,
        background: Background.background,
        minHeight: '100vh',
      ),
      children: [
        // Mobile header (only shown on mobile when branding panel is hidden)
        if (mobileHeader != null)
          div(
            styles: Styles(raw: {
              'display': 'none',
              'margin-bottom': ArcaneSpacing.xl,
            }),
            classes: 'auth-mobile-header',
            [mobileHeader!],
          ),
        // Form content
        ArcaneDiv(
          styles: ArcaneStyleData(
            width: Size.full,
            maxWidthCustom: '420px',
          ),
          children: [formContent],
        ),
      ],
    );
  }
}
