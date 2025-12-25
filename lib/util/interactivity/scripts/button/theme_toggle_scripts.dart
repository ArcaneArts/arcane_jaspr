/// Theme toggle interactivity scripts.
class ThemeToggleScripts {
  ThemeToggleScripts._();

  static const String code = r'''
  function bindThemeToggles() {
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

        toggle.style.background = newTheme === 'dark'
          ? 'var(--arcane-surface-variant)'
          : 'rgba(234, 179, 8, 0.3)';

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

        if (sunIcon) sunIcon.style.opacity = newTheme === 'dark' ? '0.3' : '1';
        if (moonIcon) moonIcon.style.opacity = newTheme === 'dark' ? '1' : '0.3';
      });
    });

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

        if (track) {
          track.style.background = newTheme === 'dark'
            ? 'var(--arcane-accent)'
            : 'var(--arcane-warning)';
        }

        if (thumb) {
          thumb.style.left = newTheme === 'dark' ? '20px' : '2px';
        }

        if (sunIcon) sunIcon.style.opacity = newTheme === 'dark' ? '0.4' : '1';
        if (moonIcon) moonIcon.style.opacity = newTheme === 'dark' ? '1' : '0.4';
      });
    });
  }
''';
}
