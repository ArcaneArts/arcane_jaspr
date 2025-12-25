/// Steps component interactivity scripts.
class StepsScripts {
  StepsScripts._();

  static const String code = r'''
  function bindSteps() {
    document.querySelectorAll('.arcane-steps').forEach(function(steps) {
      if (steps.dataset.arcaneInteractive === 'true') return;
      steps.dataset.arcaneInteractive = 'true';

      var indicators = steps.querySelectorAll('.arcane-steps-indicator:not([disabled])');

      indicators.forEach(function(indicator) {
        indicator.addEventListener('click', function() {
          var stepIndex = indicator.dataset.stepIndex;
          if (stepIndex === undefined) return;

          var event = new CustomEvent('arcane-step-click', {
            bubbles: true,
            detail: { stepIndex: parseInt(stepIndex) }
          });
          steps.dispatchEvent(event);
        });

        indicator.addEventListener('mouseenter', function() {
          if (!indicator.disabled) {
            indicator.style.transform = 'scale(1.1)';
          }
        });

        indicator.addEventListener('mouseleave', function() {
          indicator.style.transform = 'scale(1)';
        });
      });
    });
  }
''';
}
