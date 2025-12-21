import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Divider with centered text for authentication forms.
///
/// Typically used to separate OAuth buttons from email/password form
/// with text like "or continue with email".
class AuthDivider extends StatelessComponent {
  /// Text to display in the center of the divider
  final String text;

  const AuthDivider({
    super.key,
    this.text = 'or continue with',
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.md,
        margin: MarginPreset.verticalLg,
      ),
      children: [
        // Left line
        ArcaneDiv(
          styles: ArcaneStyleData(
            flexGrow: 1,
            heightCustom: '1px',
            backgroundCustom: ArcaneColors.border,
          ),
          children: [],
        ),
        // Text
        ArcaneDiv(
          styles: ArcaneStyleData(
            fontSize: FontSize.xs,
            textColor: TextColor.muted,
            textTransform: TextTransform.lowercase,
            whiteSpace: WhiteSpace.nowrap,
          ),
          children: [Component.text(text)],
        ),
        // Right line
        ArcaneDiv(
          styles: ArcaneStyleData(
            flexGrow: 1,
            heightCustom: '1px',
            backgroundCustom: ArcaneColors.border,
          ),
          children: [],
        ),
      ],
    );
  }
}
