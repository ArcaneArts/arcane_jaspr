import 'package:arcane_jaspr/arcane_jaspr.dart' hide TableOfContents;
import 'package:jaspr_content/jaspr_content.dart';

import '../components/docs_sidebar.dart';
import '../components/docs_header.dart';
import '../components/interactive_demo.dart';
import '../demos/demo_registry.dart';
import '../utils/constants.dart';
import '../utils/docs_scripts.dart';

/// Custom documentation layout using Arcane UI components
class ArcaneDocsLayout extends PageLayoutBase {
  const ArcaneDocsLayout();

  @override
  Pattern get name => 'docs';

  /// Generate CSS variable declarations for a theme
  static String _generateThemeCss(ArcaneTheme theme) {
    final vars = theme.cssVariables;
    return vars.entries.map((e) => '  ${e.key}: ${e.value};').join('\n');
  }

  /// All available theme presets with their CSS class names
  static const List<(String id, String name, ArcaneTheme theme)> _allThemes = [
    // Primary colors
    ('red', 'Red', ArcaneTheme.red),
    ('orange', 'Orange', ArcaneTheme.orange),
    ('yellow', 'Yellow', ArcaneTheme.yellow),
    ('green', 'Green', ArcaneTheme.green),
    ('blue', 'Blue', ArcaneTheme.blue),
    ('indigo', 'Indigo', ArcaneTheme.indigo),
    ('purple', 'Purple', ArcaneTheme.purple),
    ('pink', 'Pink', ArcaneTheme.pink),
    // Neutrals
    ('dark-grey', 'Dark Grey', ArcaneTheme.darkGrey),
    ('grey', 'Grey', ArcaneTheme.grey),
    ('light-grey', 'Light Grey', ArcaneTheme.lightGrey),
    ('white', 'White', ArcaneTheme.white),
    ('black', 'Black', ArcaneTheme.black),
    // OLED
    ('oled-red', 'OLED Red', ArcaneTheme.oledRed),
    ('oled-green', 'OLED Green', ArcaneTheme.oledGreen),
    ('oled-blue', 'OLED Blue', ArcaneTheme.oledBlue),
    ('oled-purple', 'OLED Purple', ArcaneTheme.oledPurple),
    ('oled-white', 'OLED White', ArcaneTheme.oledWhite),
  ];

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);

    // Note: super.buildHead already handles the base tag, so we don't add another one
    final assetPrefix = AppConstants.baseUrl.isNotEmpty ? AppConstants.baseUrl : '';
    yield link(
        rel: 'icon', type: 'image/x-icon', href: '$assetPrefix/favicon.ico');
    yield meta(name: 'viewport', content: 'width=device-width, initial-scale=1');

    // Generate CSS variables for ALL themes (dark and light modes)
    final cssBuffer = StringBuffer();

    // Default theme (green dark) for :root
    final defaultTheme =
        ArcaneTheme.green.copyWith(themeMode: ThemeMode.dark);
    cssBuffer.writeln(':root {');
    cssBuffer.writeln(_generateThemeCss(defaultTheme));
    cssBuffer.writeln('}');

    // Generate CSS for each theme in both dark and light modes
    for (final (id, _, theme) in _allThemes) {
      final darkTheme = theme.copyWith(themeMode: ThemeMode.dark);
      final lightTheme = theme.copyWith(themeMode: ThemeMode.light);

      cssBuffer.writeln('html.theme-$id-dark, .theme-$id-dark {');
      cssBuffer.writeln(_generateThemeCss(darkTheme));
      cssBuffer.writeln('}');

      cssBuffer.writeln('html.theme-$id-light, .theme-$id-light {');
      cssBuffer.writeln(_generateThemeCss(lightTheme));
      cssBuffer.writeln('}');
    }

    yield Component.element(
      tag: 'style',
      attributes: {'id': 'arcane-theme-vars'},
      children: [RawText(cssBuffer.toString())],
    );

    // Load stylesheet AFTER theme variables so our overrides take precedence
    yield link(rel: 'stylesheet', href: '$assetPrefix/styles.css');

    // Theme initialization script - runs before page renders to prevent flash
    yield script(content: '''
      (function() {
        var savedTheme = localStorage.getItem('arcane-theme-preset') || 'green';
        var savedMode = localStorage.getItem('arcane-theme-mode') || 'dark';
        document.documentElement.className = 'theme-' + savedTheme + '-' + savedMode;
      })();
    ''');
  }

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    return ThemedDocsPage(
      title: pageData['title'] as String?,
      description: pageData['description'] as String?,
      toc: page.data['toc'] as TableOfContents?,
      currentPath: page.url,
      content: child,
      componentType: pageData['component'] as String?,
    );
  }
}

/// Stateful wrapper for theme toggling
class ThemedDocsPage extends StatefulComponent {
  final String? title;
  final String? description;
  final TableOfContents? toc;
  final String currentPath;
  final Component content;
  final String? componentType;

  const ThemedDocsPage({
    this.title,
    this.description,
    this.toc,
    required this.currentPath,
    required this.content,
    this.componentType,
  });

  @override
  State<ThemedDocsPage> createState() => _ThemedDocsPageState();
}

class _ThemedDocsPageState extends State<ThemedDocsPage> {
  bool _isDark = true; // Default to dark theme

  @override
  void initState() {
    super.initState();
    // Theme is read from localStorage via JavaScript on client side
    // The initial _isDark value stays true (dark mode default)
    // JavaScript in the page handles initial theme application
  }

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
    // The actual DOM update happens via JavaScript called from the button onClick
    // This state update is just for re-rendering components with the new theme
  }

  @override
  Component build(BuildContext context) {
    final demoRegistry = DemoRegistry(
      isDark: _isDark,
      onThemeToggle: _toggleTheme,
    );
    final theme = ArcaneTheme.green.copyWith(
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
    );

    // Don't use ArcaneApp - it applies inline CSS that overrides class-based theming
    // Instead use a simple wrapper that respects CSS variables from <head>
    return ArcaneThemeProvider(
      theme: theme,
      child: div(
        id: 'arcane-root',
        styles: const Styles(raw: {
          'min-height': '100vh',
          'background-color': 'var(--arcane-surface)',
          'color': 'var(--arcane-on-surface)',
          'font-family': 'var(--font-sans)',
          '-webkit-font-smoothing': 'antialiased',
          '-moz-osx-font-smoothing': 'grayscale',
        }),
        [
          _buildPageLayout(demoRegistry),
          ..._buildScripts(),
        ],
      ),
    );
  }

  /// Main page layout structure
  Component _buildPageLayout(DemoRegistry demoRegistry) {
    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'min-height': '100vh',
        'background': 'var(--arcane-surface)',
        'color': 'var(--arcane-on-surface)',
        'font-family': 'inherit',
      }),
      [
        DocsSidebar(currentPath: component.currentPath),
        _buildMainArea(demoRegistry),
      ],
    );
  }

  /// Main content area with header
  Component _buildMainArea(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        flexGrow: 1,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        minHeight: '100vh',
      ),
      children: [
        DocsHeader(isDark: _isDark, onThemeToggle: _toggleTheme),
        _buildContentArea(demoRegistry),
      ],
    );
  }

  /// Content area with main content and TOC
  Component _buildContentArea(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        gap: Gap.xl,
        padding: PaddingPreset.xl,
        maxWidth: MaxWidth.container,
        margin: MarginPreset.autoX,
        flexGrow: 1,
      ),
      children: [
        _buildMainContent(demoRegistry),
        if (component.toc != null) _buildTableOfContents(),
      ],
    );
  }

  /// Main content section
  Component _buildMainContent(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        flex: FlexPreset.expand,
        minWidth: '0',
      ),
      children: [
        if (component.title != null) _buildTitle(),
        if (component.description != null) _buildDescription(),
        // Use @client InteractiveDemo for hydrated, interactive demos
        if (component.componentType != null)
          InteractiveDemo(componentType: component.componentType!),
        div(classes: 'prose', [component.content]),
      ],
    );
  }

  Component _buildTitle() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomLg,
        fontSize: FontSize.xl3,
        fontWeight: FontWeight.bold,
        textColor: TextColor.primary,
      ),
      children: [ArcaneText(component.title!)],
    );
  }

  Component _buildDescription() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomXl,
        textColor: TextColor.muted,
        fontSize: FontSize.lg,
      ),
      children: [ArcaneText(component.description!)],
    );
  }


  /// Table of contents sidebar
  Component _buildTableOfContents() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '240px',
        flexShrink: 0,
        position: Position.sticky,
        overflow: Overflow.auto,
        top: '80px',
        alignSelf: CrossAxisAlignment.start,
        maxHeight: 'calc(100vh - 100px)',
      ),
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            borderRadius: Radius.lg,
            background: Background.surface,
            border: BorderPreset.subtle,
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                fontWeight: FontWeight.w700,
                margin: MarginPreset.bottomMd,
                textTransform: TextTransform.uppercase,
                letterSpacing: LetterSpacing.wide,
                textColor: TextColor.onSurfaceVariant,
                padding: PaddingPreset.bottomMd,
                borderBottom: BorderPreset.subtle,
              ),
              children: [ArcaneText('On this page')],
            ),
            div(classes: 'toc-content', [component.toc!.build()]),
          ],
        ),
      ],
    );
  }

  /// JavaScript for static site functionality
  Iterable<Component> _buildScripts() sync* {
    final basePath = AppConstants.baseUrl.isNotEmpty ? AppConstants.baseUrl : '/arcane_jaspr';
    yield script(content: DocsScripts.generate(basePath: basePath));
    // Component interactivity scripts from arcane_jaspr
    yield const ArcaneScriptsComponent();
  }
}
