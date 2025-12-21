import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/docs_sidebar.dart';
import '../components/docs_header.dart';
import '../demos/demo_registry.dart';

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
    // Theme initialization script - runs before page renders to prevent flash
    yield script(content: '''
      (function() {
        var theme = localStorage.getItem('arcane-theme') || 'dark';
        document.documentElement.className = 'arcane-' + theme;
      })();
    ''');
  }

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    return _ThemedDocsPage(
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
  bool _isDark = true; // Default to dark theme

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Component build(BuildContext context) {
    final demoRegistry = DemoRegistry(
      isDark: _isDark,
      onThemeToggle: _toggleTheme,
    );

    return ArcaneApp(
      theme: ArcaneTheme.supabase(
        accent: AccentTheme.emerald,
        themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      ),
      child: div([
        _buildPageLayout(demoRegistry),
        _buildScripts(),
      ]),
    );
  }

  /// Main page layout structure
  Component _buildPageLayout(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        minHeight: '100vh',
        background: Background.background,
        textColor: TextColor.primary,
        fontFamily: FontFamily.sans,
      ),
      children: [
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
        flexGrow: 1,
        raw: {'min-width': '0'},
      ),
      children: [
        if (component.title != null) _buildTitle(),
        if (component.description != null) _buildDescription(),
        if (component.componentType != null)
          _buildLiveDemo(demoRegistry, component.componentType!),
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

  /// Live demo section
  Component _buildLiveDemo(DemoRegistry demoRegistry, String componentType) {
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
          children: demoRegistry.getDemo(componentType),
        ),
      ],
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
        raw: {
          'top': '80px',
          'align-self': 'flex-start',
          'max-height': 'calc(100vh - 100px)',
        },
      ),
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            borderRadius: Radius.lg,
            raw: {
              'background': 'var(--arcane-surface)',
              'border': '1px solid var(--arcane-outline)',
            },
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                fontWeight: FontWeight.w700,
                margin: MarginPreset.bottomMd,
                textTransform: TextTransform.uppercase,
                letterSpacing: LetterSpacing.wide,
                raw: {
                  'color': 'var(--arcane-on-surface-variant)',
                  'padding-bottom': '8px',
                  'border-bottom': '1px solid var(--arcane-outline-variant)',
                },
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
  Component _buildScripts() {
    return script(content: '''
      document.addEventListener('DOMContentLoaded', function() {
        // ===== THEME TOGGLE =====
        var themeToggle = document.getElementById('theme-toggle');
        var sunIcon = document.getElementById('sun-icon');
        var moonIcon = document.getElementById('moon-icon');

        function updateThemeIcons() {
          var isDark = document.documentElement.classList.contains('arcane-dark');
          if (sunIcon && moonIcon) {
            sunIcon.style.display = isDark ? 'inline' : 'none';
            moonIcon.style.display = isDark ? 'none' : 'inline';
          }
        }

        // Initialize icons based on current theme
        updateThemeIcons();

        if (themeToggle) {
          themeToggle.addEventListener('click', function() {
            var html = document.documentElement;
            var isDark = html.classList.contains('arcane-dark');
            html.className = isDark ? 'arcane-light' : 'arcane-dark';
            localStorage.setItem('arcane-theme', isDark ? 'light' : 'dark');
            updateThemeIcons();
          });
        }

        // ===== SEARCH FUNCTIONALITY =====
        var searchInput = document.getElementById('docs-search');
        var searchResults = document.getElementById('search-results');

        // Build search index from sidebar navigation
        var searchIndex = [];
        document.querySelectorAll('nav a').forEach(function(link) {
          var text = link.textContent.trim();
          var href = link.getAttribute('href');
          if (text && href && href.startsWith('/docs')) {
            // Extract category from URL
            var parts = href.split('/');
            var category = parts.length > 2 ? parts[2] : 'docs';
            category = category.charAt(0).toUpperCase() + category.slice(1).replace(/-/g, ' ');

            searchIndex.push({
              title: text,
              href: href,
              category: category,
              searchText: text.toLowerCase()
            });
          }
        });

        function showResults(results) {
          if (!searchResults) return;

          if (results.length === 0) {
            searchResults.innerHTML = '<div style="padding: 12px; color: var(--arcane-on-surface-variant); text-align: center;">No results found</div>';
            searchResults.style.display = 'block';
            return;
          }

          var html = results.map(function(item) {
            return '<a href="' + item.href + '" style="display: block; padding: 10px 12px; text-decoration: none; border-bottom: 1px solid var(--arcane-outline-variant); transition: background 0.15s;">' +
              '<div style="font-weight: 500; color: var(--arcane-on-surface);">' + item.title + '</div>' +
              '<div style="font-size: 12px; color: var(--arcane-on-surface-variant);">' + item.category + '</div>' +
            '</a>';
          }).join('');

          searchResults.innerHTML = html;
          searchResults.style.display = 'block';

          // Add hover effects
          searchResults.querySelectorAll('a').forEach(function(link) {
            link.addEventListener('mouseenter', function() {
              this.style.background = 'var(--arcane-surface-variant)';
            });
            link.addEventListener('mouseleave', function() {
              this.style.background = 'transparent';
            });
          });
        }

        function hideResults() {
          if (searchResults) {
            searchResults.style.display = 'none';
          }
        }

        if (searchInput) {
          searchInput.addEventListener('input', function() {
            var query = this.value.toLowerCase().trim();

            if (query.length < 2) {
              hideResults();
              return;
            }

            var results = searchIndex.filter(function(item) {
              return item.searchText.includes(query);
            }).slice(0, 10);

            showResults(results);
          });

          searchInput.addEventListener('focus', function() {
            if (this.value.length >= 2) {
              var query = this.value.toLowerCase().trim();
              var results = searchIndex.filter(function(item) {
                return item.searchText.includes(query);
              }).slice(0, 10);
              showResults(results);
            }
          });

          // Close results when clicking outside
          document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
              hideResults();
            }
          });

          // Keyboard navigation
          searchInput.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
              hideResults();
              this.blur();
            }
          });
        }

        // ===== CODE BLOCK COPY BUTTONS =====
        document.querySelectorAll('pre').forEach(function(pre) {
          var wrapper = document.createElement('div');
          wrapper.className = 'code-block-wrapper';
          pre.parentNode.insertBefore(wrapper, pre);
          wrapper.appendChild(pre);

          var copyBtn = document.createElement('button');
          copyBtn.className = 'copy-code-btn';
          copyBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>';
          copyBtn.title = 'Copy code';
          wrapper.appendChild(copyBtn);

          copyBtn.addEventListener('click', function() {
            var code = pre.querySelector('code') || pre;
            navigator.clipboard.writeText(code.textContent).then(function() {
              copyBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg>';
              copyBtn.classList.add('copied');
              setTimeout(function() {
                copyBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>';
                copyBtn.classList.remove('copied');
              }, 2000);
            });
          });
        });
      });
    ''');
  }
}
