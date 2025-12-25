/// Cycle button interactivity scripts.
class CycleButtonScripts {
  CycleButtonScripts._();

  static const String code = r'''
  function bindCycleButtons() {
    document.querySelectorAll('.arcane-cycle-button').forEach(function(btn) {
      if (btn.dataset.arcaneInteractive === 'true') return;
      if (btn.disabled) return;
      btn.dataset.arcaneInteractive = 'true';

      btn.addEventListener('click', function(e) {
        e.preventDefault();

        var optionsStr = btn.dataset.options || '';
        var options = optionsStr.split('|').filter(function(o) { return o.length > 0; });
        var currentIndex = parseInt(btn.dataset.index) || 0;

        if (options.length > 0) {
          var nextIndex = (currentIndex + 1) % options.length;
          btn.dataset.index = nextIndex.toString();

          var labelSpan = btn.querySelector('.arcane-cycle-button-label');
          if (labelSpan) {
            labelSpan.textContent = options[nextIndex];
          }
        }

        btn.style.transform = 'scale(0.95)';
        setTimeout(function() {
          btn.style.transform = 'scale(1)';
        }, 100);

        var indicator = btn.querySelector('.arcane-cycle-button-indicator');
        if (indicator) {
          indicator.style.transition = 'transform 0.3s ease';
          indicator.style.transform = 'rotate(360deg)';
          setTimeout(function() {
            indicator.style.transition = 'none';
            indicator.style.transform = 'rotate(0deg)';
          }, 300);
        }
      });
    });
  }
''';
}
