/// Toggle button (aria-pressed) interactivity scripts.
class ToggleButtonScripts {
  ToggleButtonScripts._();

  static const String code = r'''
  function bindToggleButtons() {
    document.querySelectorAll('.arcane-toggle-button').forEach(function(btn) {
      if (btn.dataset.arcaneInteractive === 'true') return;
      if (btn.disabled) return;
      if (btn.closest('.arcane-toggle-button-group')) return;
      btn.dataset.arcaneInteractive = 'true';

      btn.addEventListener('click', function(e) {
        e.preventDefault();
        var isPressed = btn.getAttribute('aria-pressed') === 'true';
        var newState = !isPressed;

        btn.setAttribute('aria-pressed', newState.toString());
        btn.classList.toggle('active', newState);

        if (newState) {
          btn.style.backgroundColor = 'var(--arcane-accent)';
          btn.style.color = 'var(--arcane-accent-foreground)';
          btn.style.border = 'none';
        } else {
          btn.style.backgroundColor = 'transparent';
          btn.style.color = 'var(--arcane-on-surface)';
          btn.style.border = '1px solid var(--arcane-border)';
        }
      });
    });
  }
''';
}
