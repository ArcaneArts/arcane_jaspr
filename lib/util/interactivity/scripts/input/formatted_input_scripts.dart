/// FormattedInput interactivity scripts.
class FormattedInputScripts {
  FormattedInputScripts._();

  static const String code = r'''
  function bindFormattedInputs() {
    document.querySelectorAll('.arcane-formatted-input').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      if (container.classList.contains('disabled')) return;
      container.dataset.arcaneInteractive = 'true';

      var segments = container.querySelectorAll('.arcane-formatted-input-segment input');

      segments.forEach(function(input, index) {
        // Auto-advance to next field when max length reached
        input.addEventListener('input', function(e) {
          var maxLen = parseInt(input.getAttribute('maxlength') || '0');
          if (maxLen > 0 && input.value.length >= maxLen) {
            // Move to next input
            if (index < segments.length - 1) {
              segments[index + 1].focus();
              segments[index + 1].select();
            }
          }

          // Dispatch change event on container
          container.dispatchEvent(new CustomEvent('formattedchange', {
            detail: { values: getFormattedValues() }
          }));
        });

        // Handle backspace to go to previous field
        input.addEventListener('keydown', function(e) {
          if (e.key === 'Backspace' && input.value === '' && index > 0) {
            segments[index - 1].focus();
          }
          // Allow arrow key navigation
          if (e.key === 'ArrowLeft' && input.selectionStart === 0 && index > 0) {
            segments[index - 1].focus();
          }
          if (e.key === 'ArrowRight' && input.selectionStart === input.value.length && index < segments.length - 1) {
            segments[index + 1].focus();
          }
        });
      });

      function getFormattedValues() {
        var values = [];
        segments.forEach(function(seg) {
          values.push(seg.value);
        });
        return values;
      }
    });
  }
''';
}
