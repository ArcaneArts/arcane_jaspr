/// TimePicker interactivity scripts.
class TimePickerScripts {
  TimePickerScripts._();

  static const String code = r'''
  function bindTimePickers() {
    document.querySelectorAll('.arcane-time-picker').forEach(function(picker) {
      if (picker.dataset.arcaneInteractive === 'true') return;
      picker.dataset.arcaneInteractive = 'true';

      var hourCol = picker.querySelector('.arcane-time-hour-column');
      var minuteCol = picker.querySelector('.arcane-time-minute-column');
      var periodCol = picker.querySelector('.arcane-time-period-column');

      // Bind hour selection
      if (hourCol) {
        hourCol.querySelectorAll('.arcane-time-option').forEach(function(option) {
          option.addEventListener('click', function() {
            hourCol.querySelectorAll('.arcane-time-option').forEach(function(opt) {
              opt.classList.remove('selected');
              opt.style.background = 'transparent';
              opt.style.color = 'var(--arcane-on-surface)';
            });
            option.classList.add('selected');
            option.style.background = 'var(--arcane-accent)';
            option.style.color = 'var(--arcane-accent-foreground)';
            picker.dataset.hour = option.dataset.value;
          });
        });
      }

      // Bind minute selection
      if (minuteCol) {
        minuteCol.querySelectorAll('.arcane-time-option').forEach(function(option) {
          option.addEventListener('click', function() {
            minuteCol.querySelectorAll('.arcane-time-option').forEach(function(opt) {
              opt.classList.remove('selected');
              opt.style.background = 'transparent';
              opt.style.color = 'var(--arcane-on-surface)';
            });
            option.classList.add('selected');
            option.style.background = 'var(--arcane-accent)';
            option.style.color = 'var(--arcane-accent-foreground)';
            picker.dataset.minute = option.dataset.value;
          });
        });
      }

      // Bind AM/PM selection
      if (periodCol) {
        periodCol.querySelectorAll('.arcane-time-period-btn').forEach(function(btn) {
          btn.addEventListener('click', function() {
            periodCol.querySelectorAll('.arcane-time-period-btn').forEach(function(b) {
              b.classList.remove('selected');
              b.style.background = 'transparent';
              b.style.color = 'var(--arcane-muted)';
            });
            btn.classList.add('selected');
            btn.style.background = 'var(--arcane-accent)';
            btn.style.color = 'var(--arcane-accent-foreground)';
            picker.dataset.period = btn.dataset.value;
          });
        });
      }
    });
  }
''';
}
