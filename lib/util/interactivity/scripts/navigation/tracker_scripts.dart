/// Tracker component interactivity scripts.
class TrackerScripts {
  TrackerScripts._();

  static const String code = r'''
  function bindTrackers() {
    // Grid tracker cells
    document.querySelectorAll('.arcane-tracker').forEach(function(tracker) {
      if (tracker.dataset.arcaneInteractive === 'true') return;
      tracker.dataset.arcaneInteractive = 'true';

      var cells = tracker.querySelectorAll('.arcane-tracker-cell');

      cells.forEach(function(cell) {
        // Show tooltip on hover
        cell.addEventListener('mouseenter', function() {
          cell.style.transform = 'scale(1.2)';
          cell.style.zIndex = '1';
        });

        cell.addEventListener('mouseleave', function() {
          cell.style.transform = 'scale(1)';
          cell.style.zIndex = '';
        });

        // Click handler
        cell.addEventListener('click', function() {
          if (cell.style.cursor !== 'pointer') return;

          var index = parseInt(cell.dataset.index || '0');
          var level = cell.dataset.level || 'unknown';

          tracker.dispatchEvent(new CustomEvent('celltap', {
            detail: { index: index, level: level }
          }));
        });
      });
    });

    // Uptime tracker bars
    document.querySelectorAll('.arcane-uptime-tracker').forEach(function(tracker) {
      if (tracker.dataset.arcaneInteractive === 'true') return;
      tracker.dataset.arcaneInteractive = 'true';

      var bars = tracker.querySelectorAll('.arcane-uptime-bar');

      bars.forEach(function(bar) {
        bar.addEventListener('mouseenter', function() {
          bar.style.opacity = '0.8';
        });

        bar.addEventListener('mouseleave', function() {
          bar.style.opacity = '1';
        });
      });
    });
  }
''';
}
