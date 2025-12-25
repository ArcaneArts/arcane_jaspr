/// Back to top button interactivity scripts.
class BackToTopScripts {
  BackToTopScripts._();

  static const String code = r'''
  function bindBackToTop() {
    document.querySelectorAll('[title="Back to top"], button[style*="position: fixed"][style*="bottom"]').forEach(function(btn) {
      if (btn.dataset.arcaneInteractive) return;
      btn.dataset.arcaneInteractive = 'true';

      btn.addEventListener('click', function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });

      window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
          btn.style.opacity = '1';
          btn.style.pointerEvents = 'auto';
        } else {
          btn.style.opacity = '0';
          btn.style.pointerEvents = 'none';
        }
      });
    });
  }
''';
}
