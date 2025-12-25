/// Selector (dropdown select) interactivity scripts.
class SelectorScripts {
  SelectorScripts._();

  static const String code = r'''
  function bindSelectors() {
    document.querySelectorAll('.arcane-selector').forEach(function(selector) {
      if (selector.dataset.arcaneInteractive) return;
      selector.dataset.arcaneInteractive = 'true';

      var wrapper = selector.closest('.arcane-selector-wrapper');
      if (!wrapper) return;

      selector.addEventListener('click', function(e) {
        e.stopPropagation();
        var dropdown = wrapper.querySelector('.arcane-selector-dropdown');
        var arrow = selector.querySelector('[style*="transform"]');

        if (dropdown) {
          var isOpen = dropdown.style.display !== 'none';
          dropdown.style.display = isOpen ? 'none' : 'block';
          if (arrow) arrow.style.transform = isOpen ? 'rotate(0)' : 'rotate(180deg)';
        } else {
          if (arrow) {
            var isRotated = arrow.style.transform.includes('180');
            arrow.style.transform = isRotated ? 'rotate(0)' : 'rotate(180deg)';
          }
        }
      });

      document.addEventListener('click', function(e) {
        if (!wrapper.contains(e.target)) {
          var dropdown = wrapper.querySelector('.arcane-selector-dropdown');
          var arrow = selector.querySelector('[style*="transform"]');
          if (dropdown) dropdown.style.display = 'none';
          if (arrow) arrow.style.transform = 'rotate(0)';
        }
      });
    });

    document.querySelectorAll('.arcane-selector-option').forEach(function(option) {
      if (option.dataset.arcaneOptionInteractive) return;
      option.dataset.arcaneOptionInteractive = 'true';

      option.addEventListener('click', function() {
        var wrapper = option.closest('.arcane-selector-wrapper');
        var selector = wrapper?.querySelector('.arcane-selector');
        var dropdown = wrapper?.querySelector('.arcane-selector-dropdown');
        var label = option.querySelector('span');

        if (selector && label) {
          var valueSpan = selector.querySelector('span');
          if (valueSpan) {
            valueSpan.textContent = label.textContent;
            valueSpan.style.color = 'var(--arcane-on-surface)';
          }
        }

        wrapper?.querySelectorAll('.arcane-selector-option').forEach(function(opt) {
          opt.style.backgroundColor = 'transparent';
          opt.style.color = 'var(--arcane-on-surface)';
          var check = opt.querySelector('span:last-child');
          if (check && check.textContent === '✓') check.remove();
        });

        option.style.backgroundColor = 'var(--arcane-accent-container)';
        option.style.color = 'var(--arcane-accent)';

        if (dropdown) dropdown.style.display = 'none';
        var arrow = selector?.querySelector('[style*="transform"]');
        if (arrow) arrow.style.transform = 'rotate(0)';
      });
    });
  }
''';
}
