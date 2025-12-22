import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:web/web.dart' as web;

/// A wrapper component that displays a live component demo alongside its code.
///
/// Use this to show users what a component looks like and how to implement it.
class ComponentDemo extends StatelessComponent {
  /// The title of the demo (optional)
  final String? title;

  /// Description of the demo (optional)
  final String? description;

  /// The live component to render
  final Component child;

  /// The code that produces the component
  final String code;

  /// The programming language for syntax highlighting
  final String language;

  /// Background style for the preview area
  final DemoBackground background;

  /// Padding around the preview component
  final PaddingPreset padding;

  const ComponentDemo({
    super.key,
    this.title,
    this.description,
    required this.child,
    required this.code,
    this.language = 'dart',
    this.background = DemoBackground.default_,
    this.padding = PaddingPreset.lg,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomXl,
        borderRadius: Radius.lg,
        overflow: Overflow.hidden,
        border: BorderPreset.standard,
      ),
      children: [
        // Title and description (if provided)
        if (title != null || description != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              padding: PaddingPreset.md,
              background: Background.backgroundSecondary,
              borderBottom: BorderPreset.standard,
            ),
            children: [
              if (title != null)
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.base,
                    textColor: TextColor.primary,
                    margin: MarginPreset.bottomXs,
                  ),
                  children: [ArcaneText(title!)],
                ),
              if (description != null)
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.sm,
                    textColor: TextColor.muted,
                  ),
                  children: [ArcaneText(description!)],
                ),
            ],
          ),

        // Preview area
        ArcaneDiv(
          styles: ArcaneStyleData(
            padding: padding,
            display: Display.flex,
            alignItems: AlignItems.center,
            justifyContent: JustifyContent.center,
            minHeight: '120px',
            raw: {
              'background': background.css,
            },
          ),
          children: [child],
        ),

        // Code block
        ArcaneDiv(
          styles: const ArcaneStyleData(
            borderTop: BorderPreset.standard,
          ),
          children: [
            _DemoCodeBlock(code: code, language: language),
          ],
        ),
      ],
    );
  }
}

/// Internal code block without margins for use in ComponentDemo
class _DemoCodeBlock extends StatefulComponent {
  final String code;
  final String language;

  const _DemoCodeBlock({
    required this.code,
    required this.language,
  });

  @override
  State<_DemoCodeBlock> createState() => _DemoCodeBlockState();
}

class _DemoCodeBlockState extends State<_DemoCodeBlock> {
  bool _expanded = false;
  bool _copied = false;

  void _toggleExpanded() {
    setState(() => _expanded = !_expanded);
  }

  void _copyToClipboard() {
    web.window.navigator.clipboard.writeText(component.code);
    setState(() => _copied = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final lines = component.code.split('\n');
    final isLong = lines.length > 10;
    final displayCode = _expanded || !isLong ? component.code : '${lines.take(10).join('\n')}\n...';

    return ArcaneDiv(
      styles: const ArcaneStyleData(
        background: Background.code,
        position: Position.relative,
      ),
      children: [
        // Copy button overlay - top right
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.absolute,
            raw: {'top': '8px', 'right': '8px', 'z-index': '10'},
            display: Display.flex,
            gap: Gap.sm,
          ),
          children: [
            // Language badge
            ArcaneSpan(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                textColor: TextColor.muted,
                padding: PaddingPreset.badge,
                background: Background.glassTint,
                borderRadius: Radius.xs,
              ),
              child: ArcaneText(component.language),
            ),
            if (isLong)
              ArcaneButton(
                style: ButtonStyle.ghost,
                size: ButtonSize.small,
                label: _expanded ? 'Collapse' : 'Expand',
                onPressed: _toggleExpanded,
              ),
            ArcaneButton(
              style: ButtonStyle.ghost,
              size: ButtonSize.small,
              label: _copied ? 'Copied!' : 'Copy',
              onPressed: _copyToClipboard,
            ),
          ],
        ),

        // Code content with padding for buttons
        ArcaneDiv(
          styles: ArcaneStyleData(
            padding: PaddingPreset.md,
            overflow: Overflow.auto,
            maxHeight: _expanded ? 'none' : '300px',
            raw: const {'padding-top': '48px'}, // Space for overlay buttons
          ),
          children: [
            ArcaneCodeBlock(
              style: CodeBlockStyle.minimal,
              styles: const ArcaneStyleData(
                margin: MarginPreset.none,
                textColor: TextColor.primary,
              ),
              children: [
                ArcaneText(displayCode),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Background styles for the demo preview area
enum DemoBackground {
  default_('var(--background-secondary)'),
  dark('#0a0a0f'),
  light('#f5f5f5'),
  transparent('transparent'),
  checkered('repeating-conic-gradient(#1a1a2e 0% 25%, #0f0f1a 0% 50%) 50% / 20px 20px');

  final String css;
  const DemoBackground(this.css);
}

/// A simple demo component for showing multiple variants in a row
class ComponentDemoRow extends StatelessComponent {
  final String? title;
  final List<Component> children;
  final Gap gap;

  const ComponentDemoRow({
    super.key,
    this.title,
    required this.children,
    this.gap = Gap.md,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomLg,
      ),
      children: [
        if (title != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
              margin: MarginPreset.bottomSm,
            ),
            children: [ArcaneText(title!)],
          ),
        ArcaneDiv(
          styles: ArcaneStyleData(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            alignItems: AlignItems.center,
            gap: gap,
            padding: PaddingPreset.lg,
            borderRadius: Radius.lg,
            background: Background.backgroundSecondary,
            border: BorderPreset.standard,
          ),
          children: children,
        ),
      ],
    );
  }
}
