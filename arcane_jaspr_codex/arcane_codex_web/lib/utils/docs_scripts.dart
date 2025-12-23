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

  static String _interactiveComponents() => '''
// ===== INTERACTIVE DEMO COMPONENTS =====

// Toggle helper for checkbox/switch state
function toggleCheckState(element, isChecked) {
  if (isChecked) {
    element.style.background = 'transparent';
    element.style.backgroundColor = 'transparent';
    element.style.border = '2px solid var(--arcane-border)';
    element.innerHTML = '';
  } else {
    element.style.background = 'var(--arcane-success)';
    element.style.backgroundColor = 'var(--arcane-success)';
    element.style.border = '2px solid var(--arcane-success)';
    element.innerHTML = '<span style="color: var(--arcane-success-foreground); font-size: 0.8125rem; font-weight: 700; line-height: 1">✓</span>';
  }
}

function toggleSwitchState(toggle, thumb, isOn) {
  if (isOn) {
    toggle.style.background = 'var(--arcane-surface-variant)';
    toggle.style.backgroundColor = 'var(--arcane-surface-variant)';
    if (thumb) thumb.style.transform = 'translateX(0)';
  } else {
    toggle.style.background = 'var(--arcane-success)';
    toggle.style.backgroundColor = 'var(--arcane-success)';
    if (thumb) thumb.style.transform = 'translateX(20px)';
  }
}

// Make checkboxes interactive
document.querySelectorAll('[style*="width: 20px"][style*="height: 20px"][style*="border-radius"]').forEach(function(checkbox) {
  var wrapper = checkbox.closest('[style*="cursor: pointer"]');
  if (!wrapper) return;
  wrapper.addEventListener('click', function(e) {
    e.preventDefault();
    var isChecked = checkbox.style.background.includes('success') || checkbox.style.backgroundColor.includes('success');
    toggleCheckState(checkbox, isChecked);
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
    toggleSwitchState(toggle, thumb, isOn);
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
        menu = document.createElement('div');
        menu.className = 'arcane-dropdown-menu';
        menu.style.cssText = 'position: absolute; top: 100%; left: 0; z-index: 100; margin-top: 8px; min-width: 200px; padding: 8px; background-color: var(--arcane-surface); border: 1px solid var(--arcane-border); border-radius: var(--arcane-radius-md); box-shadow: var(--arcane-shadow-lg); animation: arcane-dropdown-fade 0.15s ease-out;';
        menu.innerHTML = '<div style="padding: 10px 12px; cursor: pointer; border-radius: var(--arcane-radius-sm); transition: background 0.15s;">Option 1</div><div style="padding: 10px 12px; cursor: pointer; border-radius: var(--arcane-radius-sm); transition: background 0.15s;">Option 2</div>';
        dropdown.appendChild(menu);
      } else {
        menu.style.display = 'block';
      }
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
  btn.addEventListener('mousedown', function() { this.style.transform = 'scale(0.98)'; });
  btn.addEventListener('mouseup', function() { this.style.transform = 'scale(1)'; });
  btn.addEventListener('mouseleave', function() { this.style.transform = 'scale(1)'; });
});

// Make pagination interactive
document.querySelectorAll('[style*="arcane-pagination"], .arcane-pagination').forEach(function(pagination) {
  var buttons = pagination.querySelectorAll('button, [style*="cursor: pointer"]');
  buttons.forEach(function(btn) {
    btn.addEventListener('click', function(e) {
      buttons.forEach(function(b) {
        b.style.background = 'transparent';
        b.style.color = 'var(--arcane-on-surface-variant)';
      });
      this.style.background = 'var(--arcane-accent)';
      this.style.color = 'var(--arcane-on-accent)';
    });
  });
});
''';
}
