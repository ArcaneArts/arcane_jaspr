/// Number input interactivity scripts.
class NumberInputScripts {
  NumberInputScripts._();

  static const String code = r'''
  function bindNumberInputs() {
    document.querySelectorAll('.arcane-number-input').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      if (container.dataset.disabled === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var decrementBtn = container.querySelector('.arcane-number-input-decrement');
      var incrementBtn = container.querySelector('.arcane-number-input-increment');
      var display = container.querySelector('.arcane-number-input-display');

      function getValue() {
        return parseFloat(container.dataset.value) || 0;
      }

      function getMin() {
        return parseFloat(container.dataset.min) || 0;
      }

      function getMax() {
        return parseFloat(container.dataset.max) || 100;
      }

      function getStep() {
        return parseFloat(container.dataset.step) || 1;
      }

      function getDecimals() {
        return parseInt(container.dataset.decimals) || 0;
      }

      function updateValue(newValue) {
        var min = getMin();
        var max = getMax();
        var decimals = getDecimals();

        newValue = Math.max(min, Math.min(max, newValue));
        container.dataset.value = newValue.toString();

        if (display) {
          display.textContent = decimals > 0 ? newValue.toFixed(decimals) : Math.round(newValue).toString();
        }

        if (decrementBtn) {
          decrementBtn.disabled = newValue <= min;
          decrementBtn.style.cursor = newValue <= min ? 'not-allowed' : 'pointer';
          decrementBtn.style.color = newValue <= min ? 'var(--arcane-muted)' : 'var(--arcane-on-surface)';
        }
        if (incrementBtn) {
          incrementBtn.disabled = newValue >= max;
          incrementBtn.style.cursor = newValue >= max ? 'not-allowed' : 'pointer';
          incrementBtn.style.color = newValue >= max ? 'var(--arcane-muted)' : 'var(--arcane-on-surface)';
        }
      }

      if (decrementBtn) {
        decrementBtn.addEventListener('click', function(e) {
          e.preventDefault();
          if (!decrementBtn.disabled) {
            updateValue(getValue() - getStep());
          }
        });
      }

      if (incrementBtn) {
        incrementBtn.addEventListener('click', function(e) {
          e.preventDefault();
          if (!incrementBtn.disabled) {
            updateValue(getValue() + getStep());
          }
        });
      }
    });
  }
''';
}
