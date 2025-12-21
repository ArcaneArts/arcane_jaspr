import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Branding panel content for split-screen auth layouts.
///
/// Displays logo, tagline, feature list, and optional testimonial
/// with a dark gaming-themed design.
class AuthBrandingPanel extends StatelessComponent {
  /// URL to the logo image
  final String? logoUrl;

  /// Main tagline text
  final String tagline;

  /// Optional description text below tagline
  final String? description;

  /// List of feature highlights with checkmarks
  final List<String>? features;

  /// Optional testimonial quote
  final String? testimonialQuote;

  /// Optional testimonial author
  final String? testimonialAuthor;

  /// Optional testimonial author title/company
  final String? testimonialTitle;

  const AuthBrandingPanel({
    super.key,
    this.logoUrl,
    required this.tagline,
    this.description,
    this.features,
    this.testimonialQuote,
    this.testimonialAuthor,
    this.testimonialTitle,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        justifyContent: JustifyContent.center,
        height: Size.full,
      ),
      children: [
        // Logo
        if (logoUrl != null)
          ArcaneDiv(
            styles: ArcaneStyleData(
              margin: MarginPreset.bottomXxl,
            ),
            children: [
              img(
                src: logoUrl!,
                alt: 'Logo',
                styles: Styles(raw: {
                  'width': '48px',
                  'height': '48px',
                  'border-radius': ArcaneRadius.lg,
                  'object-fit': 'contain',
                }),
              ),
            ],
          ),

        // Tagline
        ArcaneDiv(
          styles: ArcaneStyleData(
            fontSize: FontSize.xl3,
            fontWeight: FontWeight.bold,
            textColor: TextColor.primary,
            margin: MarginPreset.bottomMd,
            lineHeight: LineHeight.tight,
            letterSpacing: LetterSpacing.tight,
          ),
          children: [Component.text(tagline)],
        ),

        // Description
        if (description != null)
          ArcaneDiv(
            styles: ArcaneStyleData(
              fontSize: FontSize.base,
              textColor: TextColor.muted,
              margin: MarginPreset.bottomXl,
              lineHeight: LineHeight.relaxed,
            ),
            children: [Component.text(description!)],
          ),

        // Features list
        if (features != null && features!.isNotEmpty)
          ArcaneDiv(
            styles: ArcaneStyleData(
              display: Display.flex,
              flexDirection: FlexDirection.column,
              gap: Gap.md,
              margin: MarginPreset.bottomXxl,
            ),
            children: [
              for (final feature in features!) _buildFeatureItem(feature),
            ],
          ),

        // Testimonial
        if (testimonialQuote != null) _buildTestimonial(),
      ],
    );
  }

  Component _buildFeatureItem(String text) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.flexStart,
        gap: Gap.sm,
      ),
      children: [
        // Checkmark icon
        div(
          styles: Styles(raw: {
            'width': '20px',
            'height': '20px',
            'border-radius': ArcaneRadius.full,
            'background': ArcaneColors.accentContainer,
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'margin-top': '2px',
          }),
          [
            RawText('''
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" style="color: ${ArcaneColors.accent}">
                <polyline points="20 6 9 17 4 12"></polyline>
              </svg>
            '''),
          ],
        ),
        // Feature text
        ArcaneDiv(
          styles: ArcaneStyleData(
            fontSize: FontSize.sm,
            textColor: TextColor.primary,
            lineHeight: LineHeight.normal,
          ),
          children: [Component.text(text)],
        ),
      ],
    );
  }

  Component _buildTestimonial() {
    return div(
      styles: Styles(raw: {
        'padding': ArcaneSpacing.lg,
        'background': 'rgba(24, 24, 27, 0.5)',
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'margin-top': 'auto',
      }),
      [
        // Quote
        ArcaneDiv(
          styles: ArcaneStyleData(
            fontSize: FontSize.sm,
            textColor: TextColor.primary,
            margin: MarginPreset.bottomMd,
            lineHeight: LineHeight.relaxed,
            fontStyle: FontStyle.italic,
          ),
          children: [Component.text('"$testimonialQuote"')],
        ),
        // Author
        if (testimonialAuthor != null)
          ArcaneDiv(
            styles: ArcaneStyleData(
              display: Display.flex,
              alignItems: AlignItems.center,
              gap: Gap.sm,
            ),
            children: [
              // Avatar placeholder
              div(
                styles: Styles(raw: {
                  'width': '36px',
                  'height': '36px',
                  'border-radius': ArcaneRadius.full,
                  'background':
                      'linear-gradient(135deg, ${ArcaneColors.accent} 0%, #0891B2 100%)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': ArcaneTypography.fontSizeSm,
                  'font-weight': '600',
                  'color': ArcaneColors.white,
                }),
                [Component.text(testimonialAuthor![0].toUpperCase())],
              ),
              ArcaneDiv(
                children: [
                  ArcaneDiv(
                    styles: ArcaneStyleData(
                      fontSize: FontSize.sm,
                      fontWeight: FontWeight.w600,
                      textColor: TextColor.primary,
                    ),
                    children: [Component.text(testimonialAuthor!)],
                  ),
                  if (testimonialTitle != null)
                    ArcaneDiv(
                      styles: ArcaneStyleData(
                        fontSize: FontSize.xs,
                        textColor: TextColor.muted,
                      ),
                      children: [Component.text(testimonialTitle!)],
                    ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
