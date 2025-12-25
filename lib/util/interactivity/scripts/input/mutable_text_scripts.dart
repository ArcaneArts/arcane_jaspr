/// Mutable text (inline editable) interactivity scripts.
class MutableTextScripts {
  MutableTextScripts._();

  static const String code = r'''
  function bindMutableText() {
    document.querySelectorAll('.arcane-mutable-text').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var display = container.querySelector('.arcane-mutable-display');
      var editContainer = container.querySelector('.arcane-mutable-edit');
      var input = container.querySelector('.arcane-mutable-input');
      var saveBtn = container.querySelector('.arcane-mutable-save');
      var cancelBtn = container.querySelector('.arcane-mutable-cancel');
      var charCounter = container.querySelector('.arcane-mutable-counter');

      if (!display || !editContainer || !input) return;

      var trigger = container.dataset.trigger || 'click';
      var originalValue = '';

      function showEdit() {
        originalValue = display.textContent.trim();
        input.value = originalValue;
        display.style.display = 'none';
        editContainer.style.display = 'flex';
        input.focus();
        input.select();
        updateCharCounter();
      }

      function hideEdit(save) {
        if (save) {
          var newValue = input.value.trim();
          var minLength = parseInt(container.dataset.minLength) || 0;
          var maxLength = parseInt(container.dataset.maxLength) || Infinity;

          if (newValue.length < minLength || newValue.length > maxLength) {
            input.style.borderColor = 'var(--arcane-error)';
            return;
          }

          display.textContent = newValue || originalValue;
          container.dataset.value = newValue;
        }
        display.style.display = '';
        editContainer.style.display = 'none';
        input.style.borderColor = '';
      }

      function updateCharCounter() {
        if (!charCounter) return;
        var maxLength = parseInt(container.dataset.maxLength) || 0;
        if (maxLength > 0) {
          charCounter.textContent = input.value.length + '/' + maxLength;
          charCounter.style.color = input.value.length > maxLength ? 'var(--arcane-error)' : 'var(--arcane-muted)';
        }
      }

      if (trigger === 'click' || trigger === 'doubleClick') {
        var eventType = trigger === 'doubleClick' ? 'dblclick' : 'click';
        display.addEventListener(eventType, function(e) {
          e.preventDefault();
          showEdit();
        });
      } else if (trigger === 'hover') {
        var hoverTimer = null;
        display.addEventListener('mouseenter', function() {
          hoverTimer = setTimeout(showEdit, 500);
        });
        display.addEventListener('mouseleave', function() {
          if (hoverTimer) clearTimeout(hoverTimer);
        });
      }

      var editIcon = container.querySelector('.arcane-mutable-edit-icon');
      if (editIcon) {
        editIcon.addEventListener('click', function(e) {
          e.stopPropagation();
          showEdit();
        });
      }

      input.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
          e.preventDefault();
          hideEdit(true);
        } else if (e.key === 'Escape') {
          e.preventDefault();
          hideEdit(false);
        }
      });

      input.addEventListener('input', updateCharCounter);

      if (saveBtn) {
        saveBtn.addEventListener('click', function(e) {
          e.preventDefault();
          hideEdit(true);
        });
      }

      if (cancelBtn) {
        cancelBtn.addEventListener('click', function(e) {
          e.preventDefault();
          hideEdit(false);
        });
      }

      document.addEventListener('click', function(e) {
        if (editContainer.style.display !== 'none' && !container.contains(e.target)) {
          hideEdit(false);
        }
      });
    });
  }
''';
}
