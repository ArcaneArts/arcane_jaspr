/// Pagination interactivity scripts.
class PaginationScripts {
  PaginationScripts._();

  static const String code = r'''
  function bindPagination() {
    document.querySelectorAll('nav[aria-label="Pagination"]').forEach(function(nav) {
      if (nav.dataset.arcaneInteractive) return;
      nav.dataset.arcaneInteractive = 'true';

      nav.querySelectorAll('button').forEach(function(btn) {
        btn.addEventListener('click', function() {
          if (btn.disabled) return;

          nav.querySelectorAll('button').forEach(function(b) {
            if (b.getAttribute('aria-current') === 'page') {
              b.removeAttribute('aria-current');
              if (b.style.background?.includes('accent')) {
                b.style.background = 'transparent';
                b.style.border = '1px solid var(--arcane-border)';
              } else {
                b.style.background = 'var(--arcane-surface-variant)';
              }
              b.style.fontWeight = 'normal';
            }
          });

          var pageNum = parseInt(btn.textContent);
          if (!isNaN(pageNum)) {
            btn.setAttribute('aria-current', 'page');
            btn.style.background = 'var(--arcane-accent)';
            btn.style.border = '1px solid var(--arcane-accent)';
            btn.style.fontWeight = '500';
          }
        });
      });
    });
  }
''';
}
