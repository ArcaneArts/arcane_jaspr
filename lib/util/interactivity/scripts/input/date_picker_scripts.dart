/// Date picker interactivity scripts.
class DatePickerScripts {
  DatePickerScripts._();

  static const String code = r'''
  function bindDatePickers() {
    document.querySelectorAll('.arcane-date-picker').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var trigger = container.querySelector('.arcane-date-picker-trigger');
      var dropdown = container.querySelector('.arcane-date-picker-dropdown');
      var clearBtn = container.querySelector('.arcane-date-picker-clear');

      if (!trigger) return;

      var isOpen = false;

      function toggleDropdown() {
        isOpen = !isOpen;
        if (dropdown) dropdown.style.display = isOpen ? 'block' : 'none';
        container.classList.toggle('open', isOpen);
      }

      trigger.addEventListener('click', function(e) {
        if (e.target.closest('.arcane-date-picker-clear')) return;
        e.stopPropagation();
        toggleDropdown();
      });

      if (clearBtn) {
        clearBtn.addEventListener('click', function(e) {
          e.stopPropagation();
          var valueSpan = trigger.querySelector('span:nth-child(2)');
          if (valueSpan) {
            valueSpan.textContent = container.dataset.placeholder || 'Select date...';
            valueSpan.style.color = 'var(--arcane-muted)';
          }
        });
      }

      document.addEventListener('click', function(e) {
        if (!container.contains(e.target) && isOpen) {
          isOpen = false;
          if (dropdown) dropdown.style.display = 'none';
          container.classList.remove('open');
        }
      });
    });
  }
''';
}
