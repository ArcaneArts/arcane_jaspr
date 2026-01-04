import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import 'icon.dart';

/// A code snippet component with copy button overlaid in top-right corner
class ArcaneCodeSnippet extends StatefulComponent {
  /// The code to display
  final String code;

  /// Programming language (for syntax highlighting hints)
  final String? language;

  /// Whether to show line numbers
  final bool showLineNumbers;

  /// Whether to show copy button
  final bool showCopyButton;

  /// Maximum height (scrollable if exceeded)
  final double? maxHeight;

  /// Title/filename
  final String? title;

  const ArcaneCodeSnippet({
    required this.code,
    this.language,
    this.showLineNumbers = false,
    this.showCopyButton = true,
    this.maxHeight,
    this.title,
    super.key,
  });

  @override
  State<ArcaneCodeSnippet> createState() => _CodeSnippetState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-code-copy-btn:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

class _CodeSnippetState extends State<ArcaneCodeSnippet> {
  bool _copied = false;

  void _copyToClipboard() {
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
    final List<String> lines = component.code.split('\n');

    return div(
      classes: 'arcane-code-snippet',
      styles: const Styles(raw: {
        'position': 'relative',
        'background-color': ArcaneColors.codeBackground,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
        'overflow': 'hidden',
      }),
      [
        // Language/title label (top-left, if present)
        if (component.title != null || component.language != null)
          div(
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
              'z-index': '1',
            }),
            [
              if (component.title != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontSm,
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.muted,
                  }),
                  [text(component.title!)],
                )
              else if (component.language != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontXs,
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.muted,
                    'text-transform': 'uppercase',
                    'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                    'background-color': ArcaneColors.surfaceVariant,
                    'border-radius': ArcaneRadius.xs,
                  }),
                  [text(component.language!)],
                ),
            ],
          ),

        // Copy button (top-right, overlaid)
        if (component.showCopyButton)
          div(
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'right': '0',
              'padding': ArcaneSpacing.sm,
              'z-index': '2',
            }),
            [
              button(
                classes: 'arcane-code-copy-btn',
                attributes: {
                  'type': 'button',
                  'aria-label': 'Copy code',
                  'data-code': component.code,
                },
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'padding': '0',
                  'color': _copied ? ArcaneColors.success : ArcaneColors.muted,
                  'background': ArcaneColors.transparent,
                  'border': 'none',
                  'border-radius': ArcaneRadius.sm,
                  'cursor': 'pointer',
                  'transition': ArcaneEffects.transitionFast,
                }),
                events: {
                  'click': (e) => _copyToClipboard(),
                },
                [
                  _copied
                      ? ArcaneIcon.check(size: IconSize.sm)
                      : ArcaneIcon.copy(size: IconSize.sm),
                ],
              ),
            ],
          ),

        // Code content
        div(
          classes: 'arcane-code-snippet-content',
          styles: Styles(raw: {
            'overflow': 'auto',
            if (component.maxHeight != null) 'max-height': '${component.maxHeight}px',
            // Add top padding when there's a language label or title
            if (component.title != null || component.language != null)
              'padding-top': '40px',
          }),
          [
            Component.element(
              tag: 'pre',
              classes: 'arcane-code-pre',
              styles: const Styles(raw: {
                'margin': '0',
                'padding': ArcaneSpacing.lg,
                'overflow-x': 'auto',
              }),
              children: [
                if (component.showLineNumbers)
                  div(
                    classes: 'arcane-code-with-lines',
                    styles: const Styles(raw: {
                      'display': 'flex',
                    }),
                    [
                      // Line numbers
                      div(
                        classes: 'arcane-code-line-numbers',
                        styles: const Styles(raw: {
                          'display': 'flex',
                          'flex-direction': 'column',
                          'padding-right': ArcaneSpacing.lg,
                          'border-right': '1px solid ${ArcaneColors.border}',
                          'margin-right': ArcaneSpacing.lg,
                          'user-select': 'none',
                        }),
                        [
                          for (var i = 0; i < lines.length; i++)
                            span(
                              styles: Styles(raw: {
                                'font-family': ArcaneTypography.fontFamilyMono,
                                'font-size': ArcaneTypography.fontSm,
                                'line-height': ArcaneTypography.leadingRelaxed,
                                'color': ArcaneColors.muted,
                                'text-align': 'right',
                                'min-width': '${lines.length.toString().length * 8 + 8}px',
                              }),
                              [text('${i + 1}')],
                            ),
                        ],
                      ),
                      // Code
                      Component.element(
                        tag: 'code',
                        classes: component.language != null
                            ? 'arcane-code language-${component.language}'
                            : 'arcane-code',
                        styles: const Styles(raw: {
                          'font-family': ArcaneTypography.fontFamilyMono,
                          'font-size': ArcaneTypography.fontSm,
                          'line-height': ArcaneTypography.leadingRelaxed,
                          'color': ArcaneColors.onSurface,
                          'white-space': 'pre',
                        }),
                        children: [text(component.code)],
                      ),
                    ],
                  )
                else
                  Component.element(
                    tag: 'code',
                    classes: component.language != null
                        ? 'arcane-code language-${component.language}'
                        : 'arcane-code',
                    styles: const Styles(raw: {
                      'font-family': ArcaneTypography.fontFamilyMono,
                      'font-size': ArcaneTypography.fontSm,
                      'line-height': ArcaneTypography.leadingRelaxed,
                      'color': ArcaneColors.onSurface,
                      'white-space': 'pre',
                    }),
                    children: [text(component.code)],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// An inline code component
class ArcaneInlineCode extends StatelessComponent {
  /// Code text
  final String code;

  const ArcaneInlineCode(this.code, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'code',
      classes: 'arcane-inline-code',
      styles: const Styles(raw: {
        'display': 'inline',
        'padding': '2px 6px',
        'font-family': ArcaneTypography.fontFamilyMono,
        'font-size': '0.875em',
        'background-color': ArcaneColors.surfaceVariant,
        'border-radius': ArcaneRadius.sm,
        'color': ArcaneColors.accent,
      }),
      children: [text(code)],
    );
  }
}

/// A terminal/command line component with copy button overlaid in top-right
class ArcaneTerminal extends StatefulComponent {
  /// Commands to display
  final List<String> commands;

  /// Prompt symbol
  final String prompt;

  /// Title
  final String? title;

  /// Whether to show copy button
  final bool showCopyButton;

  const ArcaneTerminal({
    required this.commands,
    this.prompt = '\$',
    this.title,
    this.showCopyButton = true,
    super.key,
  });

  @override
  State<ArcaneTerminal> createState() => _TerminalState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-terminal-copy:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

class _TerminalState extends State<ArcaneTerminal> {
  bool _copied = false;

  void _copyToClipboard() {
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
    final String allCommands = component.commands.join('\n');

    return div(
      classes: 'arcane-terminal',
      styles: const Styles(raw: {
        'position': 'relative',
        'background-color': ArcaneColors.codeBackground,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
        'overflow': 'hidden',
      }),
      [
        // Terminal header with window dots
        div(
          classes: 'arcane-terminal-header',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.md,
            'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
            'background-color': ArcaneColors.surfaceVariant,
            'border-bottom': '1px solid ${ArcaneColors.border}',
          }),
          [
            // Window controls
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'gap': ArcaneSpacing.sm,
              }),
              [
                _windowDot(ArcaneColors.error),
                _windowDot(ArcaneColors.warning),
                _windowDot(ArcaneColors.success),
              ],
            ),
            // Title
            if (component.title != null)
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                  'flex': '1',
                }),
                [text(component.title!)],
              ),
          ],
        ),

        // Copy button (top-right, overlaid over content area)
        if (component.showCopyButton)
          div(
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '40px', // Below header
              'right': '0',
              'padding': ArcaneSpacing.sm,
              'z-index': '2',
            }),
            [
              button(
                classes: 'arcane-terminal-copy',
                attributes: {
                  'type': 'button',
                  'aria-label': 'Copy commands',
                  'data-code': allCommands,
                },
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'padding': '0',
                  'color': _copied ? ArcaneColors.success : ArcaneColors.muted,
                  'background': ArcaneColors.transparent,
                  'border': 'none',
                  'border-radius': ArcaneRadius.sm,
                  'cursor': 'pointer',
                  'transition': ArcaneEffects.transitionFast,
                }),
                events: {
                  'click': (e) => _copyToClipboard(),
                },
                [
                  _copied
                      ? ArcaneIcon.check(size: IconSize.sm)
                      : ArcaneIcon.copy(size: IconSize.sm),
                ],
              ),
            ],
          ),

        // Terminal content
        Component.element(
          tag: 'pre',
          classes: 'arcane-terminal-content',
          styles: const Styles(raw: {
            'margin': '0',
            'padding': ArcaneSpacing.lg,
            'overflow-x': 'auto',
          }),
          children: [
            for (final cmd in component.commands) ...[
              span(
                styles: const Styles(raw: {
                  'color': ArcaneColors.success,
                  'font-family': ArcaneTypography.fontFamilyMono,
                  'font-size': ArcaneTypography.fontSm,
                }),
                [text('${component.prompt} ')],
              ),
              span(
                styles: const Styles(raw: {
                  'color': ArcaneColors.onSurface,
                  'font-family': ArcaneTypography.fontFamilyMono,
                  'font-size': ArcaneTypography.fontSm,
                }),
                [text(cmd)],
              ),
              text('\n'),
            ],
          ],
        ),
      ],
    );
  }

  Component _windowDot(String color) {
    return div(
      styles: Styles(raw: {
        'width': '12px',
        'height': '12px',
        'border-radius': ArcaneRadius.full,
        'background-color': color,
      }),
      [],
    );
  }
}
