import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:web/web.dart' as web;

/// A code block component with syntax highlighting and copy-to-clipboard functionality.
///
/// Displays code in a styled container with a language label and copy button
/// overlaid in the top-right corner.
class CodeBlock extends StatefulComponent {
  final String code;
  final String? language;
  final String? title;

  const CodeBlock({
    super.key,
    required this.code,
    this.language,
    this.title,
  });

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  bool _copied = false;

  void _copyToClipboard() {
    web.window.navigator.clipboard.writeText(component.code);
    setState(() => _copied = true);

    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.relative,
        margin: MarginPreset.bottomMd,
        borderRadius: Radius.lg,
        overflow: Overflow.hidden,
        background: Background.code,
        border: BorderPreset.standard,
      ),
      children: [
        // Language label (top-left, if present)
        if (component.language != null || component.title != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              position: Position.absolute,
              top: '0',
              left: '0',
              padding: PaddingPreset.smMd,
              zIndex: ZIndex.base,
            ),
            children: [
              if (component.title != null)
                ArcaneSpan(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.xs,
                    textColor: TextColor.muted,
                  ),
                  child: ArcaneText(component.title!),
                )
              else if (component.language != null)
                ArcaneSpan(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.xs,
                    textColor: TextColor.muted,
                    padding: PaddingPreset.badge,
                    background: Background.glassTint,
                    borderRadius: Radius.xs,
                  ),
                  child: ArcaneText(component.language!),
                ),
            ],
          ),

        // Copy button (top-right, overlaid)
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.absolute,
            top: '0',
            right: '0',
            padding: PaddingPreset.sm,
            zIndex: ZIndex.dropdown,
          ),
          children: [
            ArcaneIconButton.ghost(
              icon: _copied ? ArcaneIcon.check(size: IconSize.sm) : ArcaneIcon.copy(size: IconSize.sm),
              size: IconButtonSize.small,
              onPressed: _copyToClipboard,
            ),
          ],
        ),

        // Code content
        ArcaneDiv(
          styles: ArcaneStyleData(
            padding: PaddingPreset.lg,
            overflow: Overflow.auto,
            maxHeight: '500px',
            // Add top padding when there's a language label or title
            raw: (component.language != null || component.title != null)
                ? const {'padding-top': '40px'}
                : null,
          ),
          children: [
            ArcaneCodeBlock(
              style: CodeBlockStyle.minimal,
              styles: const ArcaneStyleData(
                margin: MarginPreset.none,
                textColor: TextColor.primary,
              ),
              children: [
                ArcaneText(component.code),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Inline code component for short code snippets within text.
class InlineCodeBlock extends StatelessComponent {
  final String code;

  const InlineCodeBlock({
    super.key,
    required this.code,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneSpan(
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        fontSize: FontSize.sm,
        padding: PaddingPreset.inlineCode,
        background: Background.glassOverlay,
        borderRadius: Radius.xs,
        textColor: TextColor.accent,
      ),
      child: ArcaneText(code),
    );
  }
}
