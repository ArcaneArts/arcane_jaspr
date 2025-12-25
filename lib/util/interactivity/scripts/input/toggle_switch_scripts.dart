/// Toggle switch interactivity scripts.
class ToggleSwitchScripts {
  ToggleSwitchScripts._();

  static const String code = r'''
  function bindToggleSwitches() {
    document.querySelectorAll('.arcane-toggle-switch').forEach(function(toggle) {
      if (toggle.dataset.arcaneInteractive === 'true') return;
      if (toggle.dataset.disabled === 'true') return;
      toggle.dataset.arcaneInteractive = 'true';

      var track = toggle.querySelector('.arcane-toggle-switch-track');
      var thumb = toggle.querySelector('.arcane-toggle-switch-thumb');
      if (!track || !thumb) return;

      toggle.addEventListener('click', function(e) {
        e.preventDefault();
        var isOn = toggle.dataset.checked === 'true';
        var newState = !isOn;
        toggle.dataset.checked = newState.toString();

        if (newState) {
          track.style.background = 'var(--arcane-success)';
          thumb.style.transform = 'translateX(20px)';
        } else {
          track.style.background = 'var(--arcane-surface-variant)';
          thumb.style.transform = 'translateX(0)';
        }
      });
    });
  }
''';
}
