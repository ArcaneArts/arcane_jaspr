/// TimeDialog interactivity scripts.
class TimeDialogScripts {
  TimeDialogScripts._();

  static const String code = r'''
  function bindTimeDialogs() {
    document.querySelectorAll('.arcane-time-dialog').forEach(function(dialog) {
      if (dialog.dataset.arcaneInteractive === 'true') return;
      dialog.dataset.arcaneInteractive = 'true';

      var hourCol = dialog.querySelector('.arcane-time-dialog-hour');
      var minuteCol = dialog.querySelector('.arcane-time-dialog-minute');
      var periodCol = dialog.querySelector('.arcane-time-dialog-period');

      var selectedHour = parseInt(dialog.dataset.hour || '12');
      var selectedMinute = parseInt(dialog.dataset.minute || '0');
      var selectedPeriod = dialog.dataset.period || 'AM';

      // Bind column selections
      bindTimeColumn(hourCol, 'hour', function(val) {
        selectedHour = parseInt(val);
        dialog.dataset.hour = val;
        updateDisplay();
      });

      bindTimeColumn(minuteCol, 'minute', function(val) {
        selectedMinute = parseInt(val);
        dialog.dataset.minute = val;
        updateDisplay();
      });

      bindTimeColumn(periodCol, 'period', function(val) {
        selectedPeriod = val;
        dialog.dataset.period = val;
        updateDisplay();
      });

      function updateDisplay() {
        var displayEl = dialog.querySelector('.arcane-time-dialog-display');
        if (displayEl) {
          var minStr = selectedMinute.toString().padStart(2, '0');
          displayEl.textContent = selectedHour + ':' + minStr + ' ' + selectedPeriod;
        }

        dialog.dispatchEvent(new CustomEvent('timechange', {
          detail: {
            hour: selectedHour,
            minute: selectedMinute,
            period: selectedPeriod
          }
        }));
      }

      function bindTimeColumn(col, type, onChange) {
        if (!col) return;
        var items = col.querySelectorAll('.arcane-time-dialog-item');
        items.forEach(function(item) {
          item.addEventListener('click', function() {
            items.forEach(function(i) {
              i.classList.remove('selected');
              i.style.background = 'transparent';
              i.style.color = 'var(--arcane-on-surface)';
            });
            item.classList.add('selected');
            item.style.background = 'var(--arcane-accent)';
            item.style.color = 'var(--arcane-accent-foreground)';
            onChange(item.dataset.value);
          });
        });
      }
    });
  }
''';
}
