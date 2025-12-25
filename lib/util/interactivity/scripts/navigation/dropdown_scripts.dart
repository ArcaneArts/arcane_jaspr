/// Dropdown menu interactivity scripts.
class DropdownScripts {
  DropdownScripts._();

  static const String code = r'''
  function bindDropdowns() {
    document.querySelectorAll('.arcane-dropdown').forEach(function(dropdown) {
      var trigger = dropdown.querySelector('.arcane-dropdown-trigger');
      var menu = dropdown.querySelector('.arcane-dropdown-menu');
      if (!trigger || dropdown.dataset.arcaneInteractive) return;
      dropdown.dataset.arcaneInteractive = 'true';

      trigger.addEventListener('click', function(e) {
        e.stopPropagation();
        var isOpen = dropdown.classList.contains('open');

        document.querySelectorAll('.arcane-dropdown.open').forEach(function(d) {
          d.classList.remove('open');
          var m = d.querySelector('.arcane-dropdown-menu');
          if (m) m.style.display = 'none';
        });

        if (!isOpen && menu) {
          dropdown.classList.add('open');
          menu.style.display = 'block';
        }
      });

      document.addEventListener('click', function() {
        dropdown.classList.remove('open');
        if (menu) menu.style.display = 'none';
      });
    });
  }
''';
}
