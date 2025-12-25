// JavaScript utilities for the documentation site
// Extracted from arcane_docs_layout.dart for better maintainability

/// SVG icons used in the documentation site
class DocsIcons {
  /// Sun icon for light mode
  static const String sun = '''
<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>''';

  /// Moon icon for dark mode
  static const String moon = '''
<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>''';

  /// Copy icon for code blocks
  static const String copy = '''
<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>''';

  /// Checkmark icon for copied state
  static const String check = '''
<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg>''';
}

/// Configuration constants for scripts
class DocsScriptConfig {
  /// Maximum search results to display
  static const int maxSearchResults = 10;

  /// Minimum query length to trigger search
  static const int minSearchQueryLength = 2;

  /// Copy feedback timeout in milliseconds
  static const int copyFeedbackTimeout = 2000;

  /// Default theme preset
  static const String defaultThemePreset = 'green';

  /// Default theme mode
  static const String defaultThemeMode = 'dark';
}

/// Generates the client-side JavaScript for the documentation site
class DocsScripts {
  /// Generate the complete documentation scripts
  static String generate({String basePath = '/arcane_jaspr'}) {
    return '''
document.addEventListener('DOMContentLoaded', function() {
  ${_themeUtilities()}
  ${_themeToggleHandler()}
  ${_themePresetButtons()}
  ${_searchFunctionality(basePath)}
  ${_codeBlockCopyButtons()}
  ${_interactiveComponents()}
});
''';
  }

  static String _themeUtilities() => '''
// ===== THEME UTILITIES =====
function getCurrentTheme() {
  return localStorage.getItem('arcane-theme-preset') || '${DocsScriptConfig.defaultThemePreset}';
}
function getCurrentMode() {
  return localStorage.getItem('arcane-theme-mode') || '${DocsScriptConfig.defaultThemeMode}';
}
function setTheme(preset, mode) {
  localStorage.setItem('arcane-theme-preset', preset);
  localStorage.setItem('arcane-theme-mode', mode);
  document.documentElement.className = 'theme-' + preset + '-' + mode;
  updateModeToggleIcon(mode);
  updateThemeButtons(preset);
}
function updateModeToggleIcon(mode) {
  var themeToggle = document.getElementById('theme-toggle');
  if (!themeToggle) return;
  var iconContainer = themeToggle.querySelector('div > div');
  if (iconContainer) {
    iconContainer.innerHTML = mode === 'dark'
      ? '${DocsIcons.sun.replaceAll('\n', '')}'
      : '${DocsIcons.moon.replaceAll('\n', '')}';
  }
}
function updateThemeButtons(activePreset) {
  document.querySelectorAll('[data-theme-preset]').forEach(function(btn) {
    var isActive = btn.dataset.themePreset === activePreset;
    btn.style.outline = isActive ? '2px solid var(--arcane-accent)' : 'none';
    btn.style.outlineOffset = isActive ? '2px' : '0';
  });
}
''';

  static String _themeToggleHandler() => '''
// ===== THEME MODE TOGGLE (sun/moon button) =====
var themeToggle = document.getElementById('theme-toggle');
if (themeToggle) {
  themeToggle.addEventListener('click', function() {
    var currentMode = getCurrentMode();
    var newMode = currentMode === 'dark' ? 'light' : 'dark';
    setTheme(getCurrentTheme(), newMode);
  });
}
''';

  static String _themePresetButtons() => '''
// ===== THEME PRESET BUTTONS =====
document.querySelectorAll('[data-theme-preset]').forEach(function(btn) {
  btn.addEventListener('click', function() {
    var preset = this.dataset.themePreset;
    setTheme(preset, getCurrentMode());
  });
});
// Initialize button states
updateThemeButtons(getCurrentTheme());
''';

  static String _searchFunctionality(String basePath) => '''
// ===== SEARCH FUNCTIONALITY =====
var searchInput = document.getElementById('docs-search');
var searchResults = document.getElementById('search-results');
var searchIndex = [];

// Build search index from sidebar navigation
document.querySelectorAll('nav a').forEach(function(link) {
  var text = link.textContent.trim();
  var href = link.getAttribute('href');
  if (text && href && href.includes('/docs')) {
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

function filterSearchResults(query) {
  return searchIndex.filter(function(item) {
    return item.searchText.includes(query);
  }).slice(0, ${DocsScriptConfig.maxSearchResults});
}

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
    link.addEventListener('mouseenter', function() { this.style.background = 'var(--arcane-surface-variant)'; });
    link.addEventListener('mouseleave', function() { this.style.background = 'transparent'; });
  });
}

function hideResults() {
  if (searchResults) searchResults.style.display = 'none';
}

if (searchInput) {
  searchInput.addEventListener('input', function() {
    var query = this.value.toLowerCase().trim();
    if (query.length < ${DocsScriptConfig.minSearchQueryLength}) { hideResults(); return; }
    showResults(filterSearchResults(query));
  });
  searchInput.addEventListener('focus', function() {
    if (this.value.length >= ${DocsScriptConfig.minSearchQueryLength}) {
      showResults(filterSearchResults(this.value.toLowerCase().trim()));
    }
  });
  document.addEventListener('click', function(e) {
    if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) hideResults();
  });
  searchInput.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') { hideResults(); this.blur(); }
  });
}
''';

  static String _codeBlockCopyButtons() => '''
// ===== CODE BLOCK COPY BUTTONS =====
document.querySelectorAll('pre').forEach(function(pre) {
  var wrapper = document.createElement('div');
  wrapper.className = 'code-block-wrapper';
  pre.parentNode.insertBefore(wrapper, pre);
  wrapper.appendChild(pre);

  var copyBtn = document.createElement('button');
  copyBtn.className = 'copy-code-btn';
  copyBtn.innerHTML = '${DocsIcons.copy.replaceAll('\n', '')}';
  copyBtn.title = 'Copy code';
  wrapper.appendChild(copyBtn);

  copyBtn.addEventListener('click', function() {
    var code = pre.querySelector('code') || pre;
    navigator.clipboard.writeText(code.textContent).then(function() {
      copyBtn.innerHTML = '${DocsIcons.check.replaceAll('\n', '')}';
      copyBtn.classList.add('copied');
      setTimeout(function() {
        copyBtn.innerHTML = '${DocsIcons.copy.replaceAll('\n', '')}';
        copyBtn.classList.remove('copied');
      }, ${DocsScriptConfig.copyFeedbackTimeout});
    });
  });
});
''';

  // Interactive component scripts are now handled by ArcaneApp's built-in
  // fallback scripts. The scripts are automatically injected when
  // Jaspr client hydration is unavailable.
  static String _interactiveComponents() => '''
// Component interactivity is now handled by ArcaneApp's built-in scripts.
// See: lib/util/interactivity/arcane_scripts.dart
''';
}
