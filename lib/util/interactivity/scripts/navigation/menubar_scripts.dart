/// Menubar interactivity scripts.
class MenubarScripts {
  MenubarScripts._();

  static const String code = r'''
  function bindMenubars() {
    document.querySelectorAll('.arcane-menubar').forEach(function(menubar) {
      if (menubar.dataset.arcaneInteractive === 'true') return;
      menubar.dataset.arcaneInteractive = 'true';

      var items = menubar.querySelectorAll('.arcane-menubar-item');
      var activeItem = null;

      items.forEach(function(item) {
        var trigger = item.querySelector('.arcane-menubar-trigger');
        var dropdown = item.querySelector('.arcane-menubar-dropdown');

        if (!trigger || !dropdown) return;

        trigger.addEventListener('click', function(e) {
          e.stopPropagation();

          if (activeItem === item) {
            dropdown.style.display = 'none';
            activeItem = null;
          } else {
            items.forEach(function(other) {
              var d = other.querySelector('.arcane-menubar-dropdown');
              if (d) d.style.display = 'none';
            });

            dropdown.style.display = 'block';
            activeItem = item;
          }
        });

        item.addEventListener('mouseenter', function() {
          if (activeItem && activeItem !== item) {
            var oldDropdown = activeItem.querySelector('.arcane-menubar-dropdown');
            if (oldDropdown) oldDropdown.style.display = 'none';

            dropdown.style.display = 'block';
            activeItem = item;
          }
        });

        dropdown.querySelectorAll('.arcane-menubar-menu-item:not(.disabled)').forEach(function(menuItem) {
          menuItem.addEventListener('click', function() {
            dropdown.style.display = 'none';
            activeItem = null;
          });
        });
      });

      document.addEventListener('click', function(e) {
        if (!menubar.contains(e.target)) {
          items.forEach(function(item) {
            var d = item.querySelector('.arcane-menubar-dropdown');
            if (d) d.style.display = 'none';
          });
          activeItem = null;
        }
      });
    });
  }
''';
}
