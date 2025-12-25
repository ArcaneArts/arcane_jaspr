/// Calendar interactivity scripts.
class CalendarScripts {
  CalendarScripts._();

  static const String code = r'''
  function bindCalendars() {
    document.querySelectorAll('.arcane-calendar').forEach(function(calendar) {
      if (calendar.dataset.arcaneInteractive === 'true') return;
      calendar.dataset.arcaneInteractive = 'true';

      var days = calendar.querySelectorAll('.arcane-calendar-day:not(.disabled):not(.outside)');
      days.forEach(function(day) {
        day.addEventListener('click', function() {
          calendar.querySelectorAll('.arcane-calendar-day.selected').forEach(function(d) {
            d.classList.remove('selected');
            d.style.background = 'transparent';
            d.style.color = 'var(--arcane-on-surface)';
          });

          day.classList.add('selected');
          day.style.background = 'var(--arcane-accent)';
          day.style.color = 'var(--arcane-on-accent)';
        });
      });
    });
  }
''';
}
