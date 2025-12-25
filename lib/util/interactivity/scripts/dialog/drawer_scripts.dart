/// Drawer interactivity scripts.
class DrawerScripts {
  DrawerScripts._();

  static const String code = r'''
  function bindDrawers() {
    document.querySelectorAll('.arcane-drawer-overlay').forEach(function(overlay) {
      if (overlay.dataset.arcaneInteractive === 'true') return;
      overlay.dataset.arcaneInteractive = 'true';

      var drawer = overlay.querySelector('.arcane-drawer');
      var closeBtn = overlay.querySelector('.arcane-drawer-close');

      function closeDrawer() {
        overlay.style.opacity = '0';
        if (drawer) {
          var position = drawer.dataset.position || 'right';
          if (position === 'left') {
            drawer.style.transform = 'translateX(-100%)';
          } else if (position === 'right') {
            drawer.style.transform = 'translateX(100%)';
          } else if (position === 'top') {
            drawer.style.transform = 'translateY(-100%)';
          } else if (position === 'bottom') {
            drawer.style.transform = 'translateY(100%)';
          }
        }
        setTimeout(function() {
          overlay.style.display = 'none';
          document.body.style.overflow = '';
        }, 200);
      }

      if (closeBtn) {
        closeBtn.addEventListener('click', closeDrawer);
      }

      overlay.addEventListener('click', function(e) {
        if (e.target === overlay) {
          closeDrawer();
        }
      });
    });

    document.querySelectorAll('button').forEach(function(btn) {
      var text = (btn.textContent || '').toLowerCase();
      if (text.includes('open drawer') || text.includes('show drawer')) {
        if (btn.dataset.arcaneDrawerBound) return;
        btn.dataset.arcaneDrawerBound = 'true';

        btn.addEventListener('click', function() {
          var overlay = document.querySelector('.arcane-drawer-overlay');
          if (overlay) {
            document.body.style.overflow = 'hidden';
            overlay.style.display = 'flex';
            requestAnimationFrame(function() {
              overlay.style.opacity = '1';
              var drawer = overlay.querySelector('.arcane-drawer');
              if (drawer) {
                drawer.style.transform = 'translateX(0)';
              }
            });
          }
        });
      }
    });
  }
''';
}
