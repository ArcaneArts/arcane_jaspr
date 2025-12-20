import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:web/web.dart' as web;

/// A code block component with syntax highlighting and copy-to-clipboard functionality.
///
/// Displays code in a styled container with a language label and copy button.
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
        raw: {
          'background': 'var(--code-background, #1a1a2e)',
          'border': '1px solid var(--border-primary)',
        },
      ),
      children: [
        // Header with language label and copy button
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            padding: PaddingPreset.smMd,
            raw: {
              'background': 'rgba(255, 255, 255, 0.03)',
              'border-bottom': '1px solid var(--border-primary)',
            },
          ),
          children: [
            // Language label
            ArcaneDiv(
              styles: const ArcaneStyleData(
                display: Display.flex,
                alignItems: AlignItems.center,
                gap: Gap.sm,
              ),
              children: [
                if (component.title != null)
                  ArcaneSpan(
                    styles: const ArcaneStyleData(
                      fontSize: FontSize.sm,
                      textColor: TextColor.muted,
                    ),
                    child: ArcaneText(component.title!),
                  ),
                if (component.language != null)
                  ArcaneSpan(
                    styles: const ArcaneStyleData(
                      fontSize: FontSize.xs,
                      textColor: TextColor.muted,
                      raw: {
                        'padding': '2px 8px',
                        'background': 'rgba(255, 255, 255, 0.05)',
                        'border-radius': '4px',
                      },
                    ),
                    child: ArcaneText(component.language!),
                  ),
              ],
            ),

            // Copy button
            ArcaneButton.ghost(
              size: ButtonSize.small,
              label: _copied ? 'Copied!' : 'Copy',
              onPressed: _copyToClipboard,
            ),
          ],
        ),

        // Code content
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            overflow: Overflow.auto,
            raw: {
              'max-height': '500px',
            },
          ),
          children: [
            ArcanePre(
              styles: const ArcaneStyleData(
                raw: {
                  'margin': '0',
                  'padding': '0',
                  'background': 'transparent',
                  'font-family': 'var(--font-mono, "Fira Code", monospace)',
                  'font-size': '14px',
                  'line-height': '1.6',
                  'color': 'var(--text-primary)',
                  'white-space': 'pre-wrap',
                  'word-break': 'break-word',
                },
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
        raw: {
          'padding': '2px 6px',
          'background': 'rgba(255, 255, 255, 0.08)',
          'border-radius': '4px',
          'color': 'var(--accent, #10b981)',
        },
      ),
      child: ArcaneText(code),
    );
  }
}
