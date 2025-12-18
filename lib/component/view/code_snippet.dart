import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A code snippet component with copy button (Supabase-style)
class CodeSnippet extends StatefulComponent {
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

  const CodeSnippet({
    required this.code,
    this.language,
    this.showLineNumbers = false,
    this.showCopyButton = true,
    this.maxHeight,
    this.title,
    super.key,
  });

  @override
  State<CodeSnippet> createState() => _CodeSnippetState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-code-copy-btn:hover').styles(raw: {
      'color': 'var(--arcane-on-surface)',
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}

class _CodeSnippetState extends State<CodeSnippet> {
  bool _copied = false;

  void _copyToClipboard() {
    // In Jaspr/web, we use the clipboard API
    // This will be handled via JavaScript interop
    setState(() => _copied = true);
    // Reset after 2 seconds would need a timer
  }

  @override
  Component build(BuildContext context) {
    final lines = component.code.split('\n');

    return div(
      classes: 'arcane-code-snippet',
      styles: Styles(raw: {
        'position': 'relative',
        'background-color': 'var(--arcane-code-bg)',
        'border': '1px solid var(--arcane-border)',
        'border-radius': 'var(--arcane-radius)',
        'overflow': 'hidden',
      }),
      [
        // Header with title and copy button
        if (component.title != null || component.showCopyButton)
          div(
            classes: 'arcane-code-snippet-header',
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'padding': '8px 12px',
              'background-color': 'var(--arcane-surface-variant)',
              'border-bottom': '1px solid var(--arcane-border)',
            }),
            [
              // Title/Language
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '8px',
                }),
                [
                  if (component.title != null)
                    span(
                      styles: Styles(raw: {
                        'font-size': '0.8125rem',
                        'font-weight': '500',
                        'color': 'var(--arcane-on-surface)',
                      }),
                      [text(component.title!)],
                    )
                  else if (component.language != null)
                    span(
                      styles: Styles(raw: {
                        'font-size': '0.75rem',
                        'font-weight': '500',
                        'color': 'var(--arcane-muted)',
                        'text-transform': 'uppercase',
                      }),
                      [text(component.language!)],
                    ),
                ],
              ),

              // Copy button
              if (component.showCopyButton)
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
                    'gap': '6px',
                    'padding': '4px 8px',
                    'font-size': '0.75rem',
                    'font-weight': '500',
                    'color': _copied ? 'var(--arcane-success)' : 'var(--arcane-muted)',
                    'background': 'transparent',
                    'border': '1px solid var(--arcane-border)',
                    'border-radius': 'var(--arcane-radius-sm)',
                    'cursor': 'pointer',
                    'transition': 'var(--arcane-transition-fast)',
                  }),
                  events: {
                    'click': (e) => _copyToClipboard(),
                  },
                  [
                    text(_copied ? 'Copied!' : 'Copy'),
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
          }),
          [
            Component.element(
              tag: 'pre',
              classes: 'arcane-code-pre',
              styles: Styles(raw: {
                'margin': '0',
                'padding': '16px',
                'overflow-x': 'auto',
              }),
              children: [
                if (component.showLineNumbers)
                  div(
                    classes: 'arcane-code-with-lines',
                    styles: Styles(raw: {
                      'display': 'flex',
                    }),
                    [
                      // Line numbers
                      div(
                        classes: 'arcane-code-line-numbers',
                        styles: Styles(raw: {
                          'display': 'flex',
                          'flex-direction': 'column',
                          'padding-right': '16px',
                          'border-right': '1px solid var(--arcane-border)',
                          'margin-right': '16px',
                          'user-select': 'none',
                        }),
                        [
                          for (var i = 0; i < lines.length; i++)
                            span(
                              styles: Styles(raw: {
                                'font-family': 'var(--arcane-font-mono)',
                                'font-size': '0.8125rem',
                                'line-height': '1.6',
                                'color': 'var(--arcane-muted)',
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
                        styles: Styles(raw: {
                          'font-family': 'var(--arcane-font-mono)',
                          'font-size': '0.8125rem',
                          'line-height': '1.6',
                          'color': 'var(--arcane-on-surface)',
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
                    styles: Styles(raw: {
                      'font-family': 'var(--arcane-font-mono)',
                      'font-size': '0.8125rem',
                      'line-height': '1.6',
                      'color': 'var(--arcane-on-surface)',
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
class InlineCode extends StatelessComponent {
  /// Code text
  final String code;

  const InlineCode(this.code, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'code',
      classes: 'arcane-inline-code',
      styles: Styles(raw: {
        'display': 'inline',
        'padding': '2px 6px',
        'font-family': 'var(--arcane-font-mono)',
        'font-size': '0.875em',
        'background-color': 'var(--arcane-surface-variant)',
        'border-radius': 'var(--arcane-radius-sm)',
        'color': 'var(--arcane-accent)',
      }),
      children: [text(code)],
    );
  }
}

/// A terminal/command line component
class Terminal extends StatelessComponent {
  /// Commands to display
  final List<String> commands;

  /// Prompt symbol
  final String prompt;

  /// Title
  final String? title;

  /// Whether to show copy button
  final bool showCopyButton;

  const Terminal({
    required this.commands,
    this.prompt = '\$',
    this.title,
    this.showCopyButton = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final allCommands = commands.join('\n');

    return div(
      classes: 'arcane-terminal',
      styles: Styles(raw: {
        'background-color': '#0A0A0B',
        'border': '1px solid var(--arcane-border)',
        'border-radius': 'var(--arcane-radius)',
        'overflow': 'hidden',
      }),
      [
        // Terminal header
        div(
          classes: 'arcane-terminal-header',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'padding': '10px 14px',
            'background-color': '#18181B',
            'border-bottom': '1px solid var(--arcane-border)',
          }),
          [
            // Window controls
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'gap': '8px',
              }),
              [
                _windowDot('#EF4444'),
                _windowDot('#F59E0B'),
                _windowDot('#10B981'),
              ],
            ),
            // Title
            if (title != null)
              span(
                styles: Styles(raw: {
                  'font-size': '0.8125rem',
                  'color': '#71717A',
                }),
                [text(title!)],
              )
            else
              span([]),
            // Copy button
            if (showCopyButton)
              button(
                classes: 'arcane-terminal-copy',
                attributes: {
                  'type': 'button',
                  'aria-label': 'Copy commands',
                  'data-code': allCommands,
                },
                styles: Styles(raw: {
                  'padding': '4px 8px',
                  'font-size': '0.75rem',
                  'color': '#71717A',
                  'background': 'transparent',
                  'border': '1px solid #27272A',
                  'border-radius': '4px',
                  'cursor': 'pointer',
                  'transition': 'color 0.15s, border-color 0.15s',
                }),
                [text('Copy')],
              )
            else
              span([]),
          ],
        ),
        // Terminal content
        Component.element(
          tag: 'pre',
          classes: 'arcane-terminal-content',
          styles: Styles(raw: {
            'margin': '0',
            'padding': '16px',
            'overflow-x': 'auto',
          }),
          children: [
            for (final cmd in commands) ...[
              span(
                styles: Styles(raw: {
                  'color': '#10B981',
                  'font-family': 'var(--arcane-font-mono)',
                  'font-size': '0.875rem',
                }),
                [text('$prompt ')],
              ),
              span(
                styles: Styles(raw: {
                  'color': '#FAFAFA',
                  'font-family': 'var(--arcane-font-mono)',
                  'font-size': '0.875rem',
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
        'border-radius': '50%',
        'background-color': color,
      }),
      [],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-terminal-copy:hover').styles(raw: {
      'color': '#FAFAFA',
      'border-color': '#3F3F46',
    }),
  ];
}
