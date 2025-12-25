/// Combobox interactivity scripts.
class ComboboxScripts {
  ComboboxScripts._();

  static const String code = r'''
  function bindComboboxes() {
    document.querySelectorAll('.arcane-combobox').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var trigger = container.querySelector('.arcane-combobox-trigger');
      var dropdown = container.querySelector('.arcane-combobox-dropdown');
      var searchInput = container.querySelector('.arcane-combobox-search');
      var options = container.querySelectorAll('.arcane-combobox-option');

      if (!trigger) return;

      var isOpen = false;
      var selectedIndex = -1;

      function openDropdown() {
        if (dropdown) {
          dropdown.style.display = 'block';
          isOpen = true;
          container.classList.add('open');
          if (searchInput) searchInput.focus();
        }
      }

      function closeDropdown() {
        if (dropdown) {
          dropdown.style.display = 'none';
          isOpen = false;
          container.classList.remove('open');
          selectedIndex = -1;
        }
      }

      function updateHighlight() {
        options.forEach(function(opt, i) {
          opt.style.backgroundColor = i === selectedIndex ? 'var(--arcane-surface-variant)' : '';
        });
      }

      trigger.addEventListener('click', function(e) {
        e.stopPropagation();
        if (isOpen) closeDropdown();
        else openDropdown();
      });

      if (searchInput) {
        searchInput.addEventListener('input', function() {
          var query = searchInput.value.toLowerCase();
          options.forEach(function(opt) {
            var label = opt.textContent.toLowerCase();
            opt.style.display = label.includes(query) ? '' : 'none';
          });
        });
      }

      container.addEventListener('keydown', function(e) {
        if (!isOpen) return;

        if (e.key === 'ArrowDown') {
          e.preventDefault();
          selectedIndex = Math.min(selectedIndex + 1, options.length - 1);
          updateHighlight();
        } else if (e.key === 'ArrowUp') {
          e.preventDefault();
          selectedIndex = Math.max(selectedIndex - 1, 0);
          updateHighlight();
        } else if (e.key === 'Enter' && selectedIndex >= 0) {
          e.preventDefault();
          options[selectedIndex].click();
        } else if (e.key === 'Escape') {
          closeDropdown();
        }
      });

      options.forEach(function(opt) {
        opt.addEventListener('click', function() {
          var label = opt.querySelector('div > div')?.textContent || opt.textContent;
          var valueSpan = trigger.querySelector('span');
          if (valueSpan) {
            valueSpan.textContent = label;
            valueSpan.style.color = 'var(--arcane-on-surface)';
          }
          closeDropdown();
        });
      });

      document.addEventListener('click', function(e) {
        if (!container.contains(e.target)) closeDropdown();
      });
    });
  }
''';
}
