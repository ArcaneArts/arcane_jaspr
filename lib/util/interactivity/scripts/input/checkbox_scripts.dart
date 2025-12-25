/// Checkbox interactivity scripts.
class CheckboxScripts {
  CheckboxScripts._();

  static const String code = r'''
  function bindCheckboxes() {
    document.querySelectorAll('.arcane-checkbox').forEach(function(checkbox) {
      if (checkbox.dataset.arcaneInteractive === 'true') return;
      if (checkbox.dataset.disabled === 'true') return;
      checkbox.dataset.arcaneInteractive = 'true';

      var box = checkbox.querySelector('.arcane-checkbox-box');
      if (!box) return;

      checkbox.addEventListener('click', function(e) {
        e.preventDefault();
        var isChecked = checkbox.dataset.checked === 'true';
        var newState = !isChecked;
        checkbox.dataset.checked = newState.toString();

        if (newState) {
          box.style.background = 'var(--arcane-success)';
          box.style.borderColor = 'var(--arcane-success)';
          box.innerHTML = '<span style="color: var(--arcane-success-foreground); font-size: 12px; font-weight: bold;">✓</span>';
        } else {
          box.style.background = 'transparent';
          box.style.borderColor = 'var(--arcane-border)';
          box.innerHTML = '';
        }
      });
    });
  }
''';
}
