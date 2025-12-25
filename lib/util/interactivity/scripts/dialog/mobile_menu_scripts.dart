/// Mobile menu interactivity scripts.
class MobileMenuScripts {
  MobileMenuScripts._();

  static const String code = r'''
  function bindMobileMenus() {
    document.querySelectorAll('.arcane-mobile-menu-trigger, [aria-label*="Menu"]').forEach(function(trigger) {
      if (trigger.dataset.arcaneInteractive === 'true') return;
      trigger.dataset.arcaneInteractive = 'true';

      trigger.addEventListener('click', function() {
        var overlay = document.querySelector('.arcane-mobile-menu-overlay');
        var menu = document.querySelector('.arcane-mobile-menu');

        if (overlay && menu) {
          var isOpen = overlay.style.display === 'flex';

          if (isOpen) {
            overlay.style.opacity = '0';
            menu.style.transform = 'translateX(-100%)';
            setTimeout(function() {
              overlay.style.display = 'none';
              document.body.style.overflow = '';
            }, 200);
          } else {
            document.body.style.overflow = 'hidden';
            overlay.style.display = 'flex';
            requestAnimationFrame(function() {
              overlay.style.opacity = '1';
              menu.style.transform = 'translateX(0)';
            });
          }
        }
      });
    });

    var overlay = document.querySelector('.arcane-mobile-menu-overlay');
    if (overlay && !overlay.dataset.arcaneInteractive) {
      overlay.dataset.arcaneInteractive = 'true';

      overlay.addEventListener('click', function(e) {
        var menu = overlay.querySelector('.arcane-mobile-menu');
        if (e.target === overlay) {
          overlay.style.opacity = '0';
          if (menu) menu.style.transform = 'translateX(-100%)';
          setTimeout(function() {
            overlay.style.display = 'none';
            document.body.style.overflow = '';
          }, 200);
        }
      });

      var closeBtn = overlay.querySelector('.arcane-mobile-menu-close');
      if (closeBtn) {
        closeBtn.addEventListener('click', function() {
          var menu = overlay.querySelector('.arcane-mobile-menu');
          overlay.style.opacity = '0';
          if (menu) menu.style.transform = 'translateX(-100%)';
          setTimeout(function() {
            overlay.style.display = 'none';
            document.body.style.overflow = '';
          }, 200);
        });
      }
    }
  }
''';
}
