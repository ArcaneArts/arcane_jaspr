/// Button click feedback interactivity scripts.
class ButtonFeedbackScripts {
  ButtonFeedbackScripts._();

  static const String code = r'''
  function bindButtons() {
    document.querySelectorAll('.arcane-button').forEach(function(btn) {
      if (btn.dataset.arcaneButtonInteractive === 'true') return;
      btn.dataset.arcaneButtonInteractive = 'true';

      btn.addEventListener('mousedown', function() { btn.style.transform = 'scale(0.98)'; });
      btn.addEventListener('mouseup', function() { btn.style.transform = 'scale(1)'; });
      btn.addEventListener('mouseleave', function() { btn.style.transform = 'scale(1)'; });
    });
  }
''';
}
