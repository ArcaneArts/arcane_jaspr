/// Tab navigation interactivity scripts.
class TabsScripts {
  TabsScripts._();

  static const String code = r'''
  function bindTabs() {
    document.querySelectorAll('[style*="border-bottom: 2px"]').forEach(function(tab) {
      var container = tab.closest('[style*="display: flex"][style*="gap"]');
      if (!container || container.dataset.arcaneTabsInteractive) return;
      container.dataset.arcaneTabsInteractive = 'true';

      var tabs = container.querySelectorAll('[style*="border-bottom"], [style*="cursor: pointer"][style*="padding"]');
      tabs.forEach(function(t) {
        t.addEventListener('click', function() {
          tabs.forEach(function(other) {
            other.style.borderBottom = '2px solid transparent';
            other.style.color = 'var(--arcane-on-surface-variant)';
          });
          t.style.borderBottom = '2px solid var(--arcane-accent)';
          t.style.color = 'var(--arcane-on-surface)';
        });
      });
    });
  }
''';
}
