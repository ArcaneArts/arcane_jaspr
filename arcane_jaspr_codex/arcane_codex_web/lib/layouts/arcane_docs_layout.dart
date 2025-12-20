import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/docs_sidebar.dart';
import '../components/docs_header.dart';

/// Custom documentation layout using Arcane UI components
class ArcaneDocsLayout extends PageLayoutBase {
  const ArcaneDocsLayout();

  @override
  Pattern get name => 'docs';

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);
    yield link(rel: 'icon', type: 'image/x-icon', href: '/favicon.ico');
    yield meta(name: 'viewport', content: 'width=device-width, initial-scale=1');
    yield link(rel: 'stylesheet', href: '/styles.css');
  }

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final title = pageData['title'] as String?;
    final description = pageData['description'] as String?;
    final toc = page.data['toc'] as TableOfContents?;
    final componentType = pageData['component'] as String?;

    return _ThemedDocsPage(
      title: title,
      description: description,
      toc: toc,
      currentPath: page.url,
      content: child,
      componentType: componentType,
    );
  }
}

/// Stateful wrapper for theme toggling
class _ThemedDocsPage extends StatefulComponent {
  final String? title;
  final String? description;
  final TableOfContents? toc;
  final String currentPath;
  final Component content;
  final String? componentType;

  const _ThemedDocsPage({
    this.title,
    this.description,
    this.toc,
    required this.currentPath,
    required this.content,
    this.componentType,
  });

  @override
  State<_ThemedDocsPage> createState() => _ThemedDocsPageState();
}

class _ThemedDocsPageState extends State<_ThemedDocsPage> {
  // Start with light theme
  bool _isDark = false;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Component build(BuildContext context) {
    return ArcaneApp(
      theme: ArcaneTheme.supabase(
        accent: AccentTheme.emerald,
        themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      ),
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          minHeight: '100vh',
          background: Background.background,
          textColor: TextColor.primary,
          fontFamily: FontFamily.sans,
        ),
        children: [
          // Sidebar
          DocsSidebar(currentPath: component.currentPath),

          // Main area
          ArcaneDiv(
            styles: const ArcaneStyleData(
              flexGrow: 1,
              display: Display.flex,
              flexDirection: FlexDirection.column,
              minHeight: '100vh',
            ),
            children: [
              // Header with theme toggle
              DocsHeader(
                isDark: _isDark,
                onThemeToggle: _toggleTheme,
              ),

              // Content area
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.flex,
                  gap: Gap.xl,
                  padding: PaddingPreset.xl,
                  maxWidth: MaxWidth.container,
                  margin: MarginPreset.autoX,
                  flexGrow: 1,
                ),
                children: [
                  // Main content area
                  ArcaneDiv(
                    styles: const ArcaneStyleData(
                      flexGrow: 1,
                      raw: {
                        'min-width': '0',
                      },
                    ),
                    children: [
                      // Page title
                      if (component.title != null)
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            margin: MarginPreset.bottomLg,
                            fontSize: FontSize.xl3,
                            fontWeight: FontWeight.bold,
                            textColor: TextColor.primary,
                          ),
                          children: [ArcaneText(component.title!)],
                        ),

                      // Page description
                      if (component.description != null)
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            margin: MarginPreset.bottomXl,
                            textColor: TextColor.muted,
                            fontSize: FontSize.lg,
                          ),
                          children: [ArcaneText(component.description!)],
                        ),

                      // Live demo section (if component type is specified)
                      if (component.componentType != null)
                        _buildLiveDemo(component.componentType!),

                      // Rendered markdown content
                      div(
                        classes: 'prose',
                        [component.content],
                      ),
                    ],
                  ),

                  // Table of contents (right sidebar)
                  if (component.toc != null)
                    ArcaneDiv(
                      styles: const ArcaneStyleData(
                        widthCustom: '220px',
                        flexShrink: 0,
                        position: Position.sticky,
                        overflow: Overflow.auto,
                        raw: {
                          'top': '80px',
                          'align-self': 'flex-start',
                          'max-height': 'calc(100vh - 100px)',
                        },
                      ),
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            fontSize: FontSize.sm,
                            fontWeight: FontWeight.w600,
                            textColor: TextColor.muted,
                            margin: MarginPreset.bottomMd,
                            textTransform: TextTransform.uppercase,
                            letterSpacing: LetterSpacing.wide,
                          ),
                          children: [ArcaneText('On this page')],
                        ),
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            raw: {
                              'border-left': '1px solid var(--border-primary)',
                              'padding-left': '16px',
                            },
                          ),
                          children: [component.toc!.build()],
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build live demo section based on component type
  Component _buildLiveDemo(String componentType) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomXl,
        padding: PaddingPreset.lg,
        borderRadius: Radius.lg,
        raw: {
          'background': 'var(--arcane-surface-variant)',
          'border': '1px solid var(--arcane-outline)',
        },
      ),
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            fontSize: FontSize.sm,
            fontWeight: FontWeight.w600,
            textColor: TextColor.muted,
            margin: MarginPreset.bottomMd,
            textTransform: TextTransform.uppercase,
            letterSpacing: LetterSpacing.wide,
          ),
          children: [ArcaneText('Live Demo')],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            alignItems: AlignItems.center,
            gap: Gap.md,
          ),
          children: _getDemoComponents(componentType),
        ),
      ],
    );
  }

  /// Get demo components based on component type
  List<Component> _getDemoComponents(String componentType) {
    switch (componentType) {
      case 'button':
        return [
          ArcaneButton.primary(label: 'Primary', onPressed: () {}),
          ArcaneButton.secondary(label: 'Secondary', onPressed: () {}),
          ArcaneButton.destructive(label: 'Destructive', onPressed: () {}),
          ArcaneButton.ghost(label: 'Ghost', onPressed: () {}),
          ArcaneButton.outline(label: 'Outline', onPressed: () {}),
          ArcaneButton.link(label: 'Link', onPressed: () {}),
        ];
      case 'icon-button':
        return [
          ArcaneIconButton(icon: ArcaneText('+'), onPressed: () {}),
          ArcaneIconButton(icon: ArcaneText('×'), onPressed: () {}),
          ArcaneIconButton(icon: ArcaneText('⚙'), onPressed: () {}),
        ];
      case 'checkbox':
        return [
          ArcaneCheckbox(checked: false, onChanged: (_) {}),
          ArcaneCheckbox(checked: true, onChanged: (_) {}),
        ];
      case 'toggle-switch':
        return [
          ArcaneToggleSwitch(value: false, onChanged: (_) {}),
          ArcaneToggleSwitch(value: true, onChanged: (_) {}),
        ];
      case 'text-input':
        return [
          ArcaneDiv(
            styles: const ArcaneStyleData(widthCustom: '250px'),
            children: [
              ArcaneTextInput(
                label: 'Username',
                placeholder: 'Enter username',
                name: 'demo-username',
              ),
            ],
          ),
        ];
      case 'badge':
        return [
          ArcaneBadge('Default'),
          ArcaneBadge('Info', style: BadgeStyle.info),
          ArcaneBadge('Success', style: BadgeStyle.success),
          ArcaneBadge('Warning', style: BadgeStyle.warning),
          ArcaneBadge('Destructive', style: BadgeStyle.destructive),
        ];
      case 'avatar':
        return [
          ArcaneAvatar(initials: 'JD'),
          ArcaneAvatar(initials: 'JS'),
          ArcaneAvatar(initials: 'BW'),
        ];
      case 'card':
        return [
          ArcaneCard(
            child: ArcaneDiv(
              styles: const ArcaneStyleData(padding: PaddingPreset.md),
              children: [
                ArcaneText('This is a sample card component'),
              ],
            ),
          ),
        ];
      case 'progress-bar':
        return [
          ArcaneDiv(
            styles: const ArcaneStyleData(widthCustom: '200px'),
            children: [
              ArcaneProgressBar(value: 0.3),
            ],
          ),
          ArcaneDiv(
            styles: const ArcaneStyleData(widthCustom: '200px'),
            children: [
              ArcaneProgressBar(value: 0.7),
            ],
          ),
        ];
      case 'loader':
        return [
          ArcaneLoader(),
        ];
      case 'theme-toggle':
        return [
          ArcaneThemeToggle(isDark: _isDark, onChanged: (_) => _toggleTheme()),
        ];
      default:
        return [
          ArcaneDiv(
            styles: const ArcaneStyleData(
              textColor: TextColor.muted,
              fontStyle: FontStyle.italic,
            ),
            children: [ArcaneText('Demo coming soon...')],
          ),
        ];
    }
  }
}
