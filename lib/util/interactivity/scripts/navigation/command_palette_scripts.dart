/// Command palette interactivity scripts.
class CommandPaletteScripts {
  CommandPaletteScripts._();

  static const String code = r'''
  function bindCommandPalettes() {
    document.querySelectorAll('.arcane-command-overlay').forEach(function(overlay) {
      if (overlay.dataset.arcaneInteractive === 'true') return;
      overlay.dataset.arcaneInteractive = 'true';

      var dialog = overlay.querySelector('.arcane-command-dialog');
      var input = overlay.querySelector('.arcane-command-input');
      var items = overlay.querySelectorAll('.arcane-command-item');
      var selectedIndex = -1;

      function updateSelection() {
        items.forEach(function(item, i) {
          item.classList.toggle('selected', i === selectedIndex);
        });
        if (selectedIndex >= 0 && items[selectedIndex]) {
          items[selectedIndex].scrollIntoView({ block: 'nearest' });
        }
      }

      overlay.addEventListener('keydown', function(e) {
        if (e.key === 'ArrowDown') {
          e.preventDefault();
          selectedIndex = Math.min(selectedIndex + 1, items.length - 1);
          updateSelection();
        } else if (e.key === 'ArrowUp') {
          e.preventDefault();
          selectedIndex = Math.max(selectedIndex - 1, 0);
          updateSelection();
        } else if (e.key === 'Enter' && selectedIndex >= 0) {
          e.preventDefault();
          items[selectedIndex].click();
        } else if (e.key === 'Escape') {
          overlay.style.display = 'none';
        }
      });

      if (input) {
        input.addEventListener('input', function() {
          var query = input.value.toLowerCase();
          items.forEach(function(item) {
            var label = item.textContent.toLowerCase();
            item.style.display = label.includes(query) ? '' : 'none';
          });
          selectedIndex = -1;
          updateSelection();
        });
      }

      overlay.addEventListener('click', function(e) {
        if (!dialog.contains(e.target)) {
          overlay.style.display = 'none';
        }
      });

      items.forEach(function(item) {
        item.addEventListener('click', function() {
          if (!item.classList.contains('disabled')) {
            overlay.style.display = 'none';
          }
        });
      });
    });
  }
''';
}
