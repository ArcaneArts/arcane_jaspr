/// Toggle button group interactivity scripts.
class ToggleButtonGroupScripts {
  ToggleButtonGroupScripts._();

  static const String code = r'''
  function bindToggleButtonGroups() {
    document.querySelectorAll('.arcane-toggle-button-group').forEach(function(group) {
      if (group.dataset.arcaneInteractive === 'true') return;
      group.dataset.arcaneInteractive = 'true';

      var buttons = group.querySelectorAll('button');
      buttons.forEach(function(btn) {
        btn.addEventListener('click', function(e) {
          e.preventDefault();

          buttons.forEach(function(b) {
            b.style.backgroundColor = 'transparent';
            b.style.color = 'var(--arcane-on-surface-variant)';
            b.style.boxShadow = 'none';
          });

          btn.style.backgroundColor = 'var(--arcane-surface)';
          btn.style.color = 'var(--arcane-on-surface)';
          btn.style.boxShadow = 'var(--arcane-shadow-sm)';
        });
      });
    });
  }
''';
}
