/// Button interactivity scripts for static sites.
class ButtonScripts {
  ButtonScripts._();

  static const String code = r'''
  // ===== THEME TOGGLE =====
  function bindThemeToggles() {
    // Main theme toggle
    document.querySelectorAll('.arcane-theme-toggle').forEach(function(toggle) {
      if (toggle.dataset.arcaneInteractive === 'true') return;
      toggle.dataset.arcaneInteractive = 'true';

      var thumb = toggle.querySelector('.arcane-theme-toggle-thumb');
      var sunIcon = toggle.querySelector('.arcane-theme-toggle-sun');
      var moonIcon = toggle.querySelector('.arcane-theme-toggle-moon');

      toggle.addEventListener('click', function(e) {
        e.preventDefault();
        var isDark = toggle.dataset.theme === 'dark';
        var newTheme = isDark ? 'light' : 'dark';
        toggle.dataset.theme = newTheme;
        toggle.setAttribute('aria-checked', (!isDark).toString());

        // Update background
        toggle.style.background = newTheme === 'dark'
          ? 'var(--arcane-surface-variant)'
          : 'rgba(234, 179, 8, 0.3)';

        // Update thumb
        if (thumb) {
          var width = parseInt(toggle.style.width) || 56;
          var thumbWidth = parseInt(thumb.style.width) || 24;
          thumb.style.transform = newTheme === 'dark'
            ? 'translateX(' + (width - thumbWidth - 6) + 'px)'
            : 'translateX(0)';
          thumb.style.background = newTheme === 'dark'
            ? 'var(--arcane-on-surface)'
            : 'var(--arcane-warning)';
        }

        // Update icon opacity
        if (sunIcon) sunIcon.style.opacity = newTheme === 'dark' ? '0.3' : '1';
        if (moonIcon) moonIcon.style.opacity = newTheme === 'dark' ? '1' : '0.3';
      });
    });

    // Simple theme toggle
    document.querySelectorAll('.arcane-theme-toggle-simple').forEach(function(toggle) {
      if (toggle.dataset.arcaneInteractive === 'true') return;
      toggle.dataset.arcaneInteractive = 'true';

      var track = toggle.querySelector('.arcane-theme-toggle-simple-track');
      var thumb = toggle.querySelector('.arcane-theme-toggle-simple-thumb');
      var sunIcon = toggle.querySelector('.arcane-theme-toggle-simple-sun');
      var moonIcon = toggle.querySelector('.arcane-theme-toggle-simple-moon');

      toggle.addEventListener('click', function(e) {
        e.preventDefault();
        var isDark = toggle.dataset.theme === 'dark';
        var newTheme = isDark ? 'light' : 'dark';
        toggle.dataset.theme = newTheme;
        toggle.setAttribute('aria-checked', (!isDark).toString());

        // Update track
        if (track) {
          track.style.background = newTheme === 'dark'
            ? 'var(--arcane-accent)'
            : 'var(--arcane-warning)';
        }

        // Update thumb
        if (thumb) {
          thumb.style.left = newTheme === 'dark' ? '20px' : '2px';
        }

        // Update icon opacity
        if (sunIcon) sunIcon.style.opacity = newTheme === 'dark' ? '0.4' : '1';
        if (moonIcon) moonIcon.style.opacity = newTheme === 'dark' ? '1' : '0.4';
      });
    });
  }

  // ===== TOGGLE BUTTON GROUPS =====
  function bindToggleButtonGroups() {
    document.querySelectorAll('.arcane-toggle-button-group').forEach(function(group) {
      if (group.dataset.arcaneInteractive === 'true') return;
      group.dataset.arcaneInteractive = 'true';

      var buttons = group.querySelectorAll('button');
      buttons.forEach(function(btn) {
        btn.addEventListener('click', function(e) {
          e.preventDefault();

          // Deselect all
          buttons.forEach(function(b) {
            b.style.backgroundColor = 'transparent';
            b.style.color = 'var(--arcane-on-surface-variant)';
            b.style.boxShadow = 'none';
          });

          // Select clicked
          btn.style.backgroundColor = 'var(--arcane-surface)';
          btn.style.color = 'var(--arcane-on-surface)';
          btn.style.boxShadow = 'var(--arcane-shadow-sm)';
        });
      });
    });
  }

  // ===== CYCLE BUTTONS =====
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

          // Find the label span (not the cycle indicator)
          var labelSpan = btn.querySelector('.arcane-cycle-button-label');
          if (labelSpan) {
            labelSpan.textContent = options[nextIndex];
          }
        }

        // Visual feedback
        btn.style.transform = 'scale(0.95)';
        setTimeout(function() {
          btn.style.transform = 'scale(1)';
        }, 100);

        // Spin indicator
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

  // ===== TOGGLE BUTTONS (aria-pressed) =====
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

  // ===== BUTTONS (click feedback) =====
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
