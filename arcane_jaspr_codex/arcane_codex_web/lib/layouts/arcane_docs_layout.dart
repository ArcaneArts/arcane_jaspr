import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr/dom.dart' show RawText;
import 'package:jaspr_content/jaspr_content.dart';
import 'package:web/web.dart' as web;

import '../components/docs_sidebar.dart';
import '../components/docs_header.dart';
import '../demos/demo_registry.dart';

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

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);
    yield link(rel: 'icon', type: 'image/x-icon', href: '/favicon.ico');
    yield meta(name: 'viewport', content: 'width=device-width, initial-scale=1');

    // Generate CSS variables for both themes
    final darkTheme = ArcaneTheme.supabase(
      accent: AccentTheme.emerald,
      themeMode: ThemeMode.dark,
    );
    final lightTheme = ArcaneTheme.supabase(
      accent: AccentTheme.emerald,
      themeMode: ThemeMode.light,
    );

    // Inject theme CSS variables FIRST
    // Use :root for dark theme (default) so variables work immediately without a class
    yield Component.element(
      tag: 'style',
      attributes: {'id': 'arcane-theme-vars'},
      children: [
        RawText('''
:root, html.arcane-dark, .arcane-dark {
${_generateThemeCss(darkTheme)}
}

html.arcane-light, .arcane-light {
${_generateThemeCss(lightTheme)}
}
'''),
      ],
    );

    // Load stylesheet AFTER theme variables so our overrides take precedence
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

  @override
  void initState() {
    super.initState();
    try {
      final storedTheme = web.window.localStorage.getItem('arcane-theme');
      if (storedTheme == 'light') {
        _isDark = false;
      }
    } catch (_) {
      // Ignore when localStorage is unavailable (SSR or restricted contexts).
    }
  }

  void _toggleTheme() {
    final nextIsDark = !_isDark;
    setState(() => _isDark = nextIsDark);
    try {
      final themeName = nextIsDark ? 'dark' : 'light';
      web.window.localStorage.setItem('arcane-theme', themeName);
      web.document.documentElement?.className = 'arcane-$themeName';
    } catch (_) {
      // Ignore when document or localStorage is unavailable.
    }
  }

  @override
  Component build(BuildContext context) {
    final demoRegistry = DemoRegistry(
      isDark: _isDark,
      onThemeToggle: _toggleTheme,
    );
    final theme = ArcaneTheme.supabase(
      accent: AccentTheme.emerald,
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
          'font-family':
              '"GeistSans", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
          '-webkit-font-smoothing': 'antialiased',
          '-moz-osx-font-smoothing': 'grayscale',
        }),
        [
          _buildPageLayout(demoRegistry),
          _buildScripts(),
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
        background: Background.surfaceVariant,
        border: BorderPreset.subtle,
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
  Component _buildScripts() {
    return script(content: '''
      document.addEventListener('DOMContentLoaded', function() {
        // ===== SEARCH FUNCTIONALITY =====
        var searchInput = document.getElementById('docs-search');
        var searchResults = document.getElementById('search-results');

        // Build search index from sidebar navigation
        var basePath = '/arcane_jaspr';
        var searchIndex = [];
        document.querySelectorAll('nav a').forEach(function(link) {
          var text = link.textContent.trim();
          var href = link.getAttribute('href');
          if (text && href && href.includes('/docs')) {
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

        // ===== INTERACTIVE DEMO COMPONENTS =====

        // Make checkboxes interactive (20x20 boxes with border)
        document.querySelectorAll('[style*="width: 20px"][style*="height: 20px"][style*="border-radius"]').forEach(function(checkbox) {
          var wrapper = checkbox.closest('[style*="cursor: pointer"]');
          if (!wrapper) return;

          wrapper.addEventListener('click', function(e) {
            e.preventDefault();
            var isChecked = checkbox.style.background.includes('success') || checkbox.style.backgroundColor.includes('success');

            if (isChecked) {
              // Uncheck
              checkbox.style.background = 'transparent';
              checkbox.style.backgroundColor = 'transparent';
              checkbox.style.border = '2px solid var(--arcane-border)';
              checkbox.innerHTML = '';
            } else {
              // Check
              checkbox.style.background = 'var(--arcane-success)';
              checkbox.style.backgroundColor = 'var(--arcane-success)';
              checkbox.style.border = '2px solid var(--arcane-success)';
              checkbox.innerHTML = '<span style="color: var(--arcane-success-foreground); font-size: 0.8125rem; font-weight: 700; line-height: 1">✓</span>';
            }
          });
        });

        // Make toggle switches interactive
        document.querySelectorAll('.arcane-toggle-switch, [style*="width: 44px"][style*="height: 24px"]').forEach(function(toggle) {
          if (toggle.dataset.interactive) return;
          toggle.dataset.interactive = 'true';

          toggle.style.cursor = 'pointer';
          toggle.addEventListener('click', function(e) {
            e.preventDefault();
            var thumb = toggle.querySelector('[style*="width: 20px"]') || toggle.querySelector('[style*="width: 18px"]');
            var isOn = toggle.style.background.includes('success') || toggle.style.backgroundColor.includes('success');

            if (isOn) {
              toggle.style.background = 'var(--arcane-surface-variant)';
              toggle.style.backgroundColor = 'var(--arcane-surface-variant)';
              if (thumb) thumb.style.transform = 'translateX(0)';
            } else {
              toggle.style.background = 'var(--arcane-success)';
              toggle.style.backgroundColor = 'var(--arcane-success)';
              if (thumb) thumb.style.transform = 'translateX(20px)';
            }
          });
        });

        // Make dropdown menus interactive
        document.querySelectorAll('.arcane-dropdown').forEach(function(dropdown) {
          var trigger = dropdown.querySelector('.arcane-dropdown-trigger');
          var menu = dropdown.querySelector('.arcane-dropdown-menu');
          var backdrop = dropdown.querySelector('.arcane-dropdown-backdrop');

          if (!trigger) return;

          trigger.addEventListener('click', function(e) {
            e.stopPropagation();
            var isOpen = dropdown.classList.contains('open');

            // Close all other dropdowns
            document.querySelectorAll('.arcane-dropdown.open').forEach(function(d) {
              d.classList.remove('open');
              var m = d.querySelector('.arcane-dropdown-menu');
              var b = d.querySelector('.arcane-dropdown-backdrop');
              if (m) m.style.display = 'none';
              if (b) b.style.display = 'none';
            });

            if (!isOpen) {
              dropdown.classList.add('open');
              if (!menu) {
                // Create menu dynamically
                menu = document.createElement('div');
                menu.className = 'arcane-dropdown-menu';
                menu.style.cssText = 'position: absolute; top: 100%; left: 0; z-index: 100; margin-top: 8px; min-width: 200px; padding: 8px; background-color: var(--arcane-surface); border: 1px solid var(--arcane-border); border-radius: var(--arcane-radius-md); box-shadow: var(--arcane-shadow-lg); animation: arcane-dropdown-fade 0.15s ease-out;';
                menu.innerHTML = '<div style="padding: 10px 12px; cursor: pointer; border-radius: var(--arcane-radius-sm); transition: background 0.15s;">Option 1</div><div style="padding: 10px 12px; cursor: pointer; border-radius: var(--arcane-radius-sm); transition: background 0.15s;">Option 2</div>';
                dropdown.appendChild(menu);
              } else {
                menu.style.display = 'block';
              }

              // Create backdrop
              if (!backdrop) {
                backdrop = document.createElement('div');
                backdrop.className = 'arcane-dropdown-backdrop';
                backdrop.style.cssText = 'position: fixed; inset: 0; z-index: 99;';
                dropdown.appendChild(backdrop);
              } else {
                backdrop.style.display = 'block';
              }

              backdrop.addEventListener('click', function() {
                dropdown.classList.remove('open');
                if (menu) menu.style.display = 'none';
                backdrop.style.display = 'none';
              });
            }
          });
        });

        // Make buttons show click feedback
        document.querySelectorAll('.arcane-button, button[class*="arcane"]').forEach(function(btn) {
          btn.addEventListener('mousedown', function() {
            this.style.transform = 'scale(0.98)';
          });
          btn.addEventListener('mouseup', function() {
            this.style.transform = 'scale(1)';
          });
          btn.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
          });
        });

        // Make pagination interactive
        document.querySelectorAll('[style*="arcane-pagination"], .arcane-pagination').forEach(function(pagination) {
          var buttons = pagination.querySelectorAll('button, [style*="cursor: pointer"]');
          buttons.forEach(function(btn) {
            btn.addEventListener('click', function(e) {
              // Remove active state from all
              buttons.forEach(function(b) {
                b.style.background = 'transparent';
                b.style.color = 'var(--arcane-on-surface-variant)';
              });
              // Add active state to clicked
              this.style.background = 'var(--arcane-accent)';
              this.style.color = 'var(--arcane-on-accent)';
            });
          });
        });
      });
    ''');
  }
}
