import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Container card for authentication form content.
///
/// Provides consistent styling with title, optional subtitle,
/// and content area for form fields.
class AuthFormCard extends StatelessComponent {
  /// Title displayed at the top
  final String title;

  /// Optional subtitle below the title
  final String? subtitle;

  /// Form content
  final Component child;

  /// Optional footer content (links, etc)
  final Component? footer;

  const AuthFormCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.footer,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        width: Size.full,
      ),
      children: [
        // Header
        ArcaneDiv(
          styles: ArcaneStyleData(
            margin: MarginPreset.bottomXl,
            textAlign: TextAlign.center,
          ),
          children: [
            ArcaneDiv(
              styles: ArcaneStyleData(
                fontSize: FontSize.xl2,
                fontWeight: FontWeight.bold,
                textColor: TextColor.primary,
                margin: MarginPreset.bottomXs,
                letterSpacing: LetterSpacing.tight,
              ),
              children: [Component.text(title)],
            ),
            if (subtitle != null)
              ArcaneDiv(
                styles: ArcaneStyleData(
                  fontSize: FontSize.sm,
                  textColor: TextColor.muted,
                  lineHeight: LineHeight.normal,
                ),
                children: [Component.text(subtitle!)],
              ),
          ],
        ),
        // Form content
        child,
        // Footer
        if (footer != null)
          ArcaneDiv(
            styles: ArcaneStyleData(
              margin: MarginPreset.topLg,
              textAlign: TextAlign.center,
            ),
            children: [footer!],
          ),
      ],
    );
  }
}
