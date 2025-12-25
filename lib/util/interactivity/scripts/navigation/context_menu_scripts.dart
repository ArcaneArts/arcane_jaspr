/// Context menu interactivity scripts.
class ContextMenuScripts {
  ContextMenuScripts._();

  static const String code = r'''
  function bindContextMenus() {
    document.querySelectorAll('.arcane-context-menu-trigger').forEach(function(trigger) {
      if (trigger.dataset.arcaneInteractive === 'true') return;
      trigger.dataset.arcaneInteractive = 'true';

      var menu = trigger.querySelector('.arcane-context-menu');
      if (!menu) return;

      trigger.addEventListener('contextmenu', function(e) {
        e.preventDefault();

        document.querySelectorAll('.arcane-context-menu').forEach(function(m) {
          m.style.display = 'none';
        });

        menu.style.display = 'block';
        menu.style.left = e.clientX + 'px';
        menu.style.top = e.clientY + 'px';

        var rect = menu.getBoundingClientRect();
        if (rect.right > window.innerWidth) {
          menu.style.left = (e.clientX - rect.width) + 'px';
        }
        if (rect.bottom > window.innerHeight) {
          menu.style.top = (e.clientY - rect.height) + 'px';
        }
      });

      menu.querySelectorAll('.arcane-context-menu-item:not(.disabled)').forEach(function(item) {
        item.addEventListener('click', function() {
          menu.style.display = 'none';
        });
      });
    });

    document.addEventListener('click', function() {
      document.querySelectorAll('.arcane-context-menu').forEach(function(m) {
        m.style.display = 'none';
      });
    });

    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        document.querySelectorAll('.arcane-context-menu').forEach(function(m) {
          m.style.display = 'none';
        });
      }
    });
  }
''';
}
