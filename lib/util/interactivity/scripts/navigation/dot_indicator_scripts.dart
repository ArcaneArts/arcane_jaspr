/// DotIndicator and StepIndicator interactivity scripts.
class DotIndicatorScripts {
  DotIndicatorScripts._();

  static const String code = r'''
  function bindDotIndicators() {
    // Dot indicators
    document.querySelectorAll('.arcane-dot-indicator').forEach(function(indicator) {
      if (indicator.dataset.arcaneInteractive === 'true') return;
      indicator.dataset.arcaneInteractive = 'true';

      var dots = indicator.querySelectorAll('.arcane-dot');
      var currentIndex = parseInt(indicator.dataset.currentIndex || '0');

      dots.forEach(function(dot, i) {
        dot.addEventListener('click', function() {
          if (indicator.dataset.interactive !== 'true') return;

          // Update visual state
          dots.forEach(function(d, j) {
            var isActive = j === i;
            d.style.background = isActive ? 'var(--arcane-accent)' : 'var(--arcane-muted)';
            d.style.transform = isActive ? 'scale(1.2)' : 'scale(1)';
          });

          indicator.dataset.currentIndex = i.toString();
          indicator.dispatchEvent(new CustomEvent('dotchange', { detail: { index: i } }));
        });
      });
    });

    // Step indicators
    document.querySelectorAll('.arcane-step-indicator').forEach(function(indicator) {
      if (indicator.dataset.arcaneInteractive === 'true') return;
      indicator.dataset.arcaneInteractive = 'true';

      var steps = indicator.querySelectorAll('.arcane-step');
      var circles = indicator.querySelectorAll('.arcane-step-circle');
      var allowNav = indicator.dataset.allowNavigation === 'true';

      circles.forEach(function(circle, i) {
        if (!allowNav) return;
        if (circle.disabled) return;

        circle.addEventListener('click', function() {
          var currentStep = parseInt(indicator.dataset.currentStep || '0');
          if (i > currentStep) return; // Can't skip ahead

          // Update step visuals
          circles.forEach(function(c, j) {
            var isCompleted = j < i;
            var isActive = j === i;
            c.style.background = isCompleted || isActive ? 'var(--arcane-accent)' : 'var(--arcane-surface-variant)';
            c.style.color = isCompleted || isActive ? 'var(--arcane-accent-foreground)' : 'var(--arcane-muted)';
            c.innerHTML = isCompleted ? '✓' : (j + 1).toString();
          });

          indicator.dataset.currentStep = i.toString();
          indicator.dispatchEvent(new CustomEvent('stepchange', { detail: { step: i } }));
        });
      });
    });
  }
''';
}
