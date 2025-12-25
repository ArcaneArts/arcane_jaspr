/// Timeline component interactivity scripts.
class TimelineScripts {
  TimelineScripts._();

  static const String code = r'''
  function bindTimelines() {
    document.querySelectorAll('.arcane-timeline').forEach(function(timeline) {
      if (timeline.dataset.arcaneInteractive === 'true') return;
      timeline.dataset.arcaneInteractive = 'true';

      var items = timeline.querySelectorAll('.arcane-timeline-item');

      items.forEach(function(item) {
        item.addEventListener('mouseenter', function() {
          var content = item.querySelector('.arcane-timeline-content');
          if (content) {
            content.style.transform = 'translateX(4px)';
            content.style.transition = 'transform 0.15s ease';
          }
        });

        item.addEventListener('mouseleave', function() {
          var content = item.querySelector('.arcane-timeline-content');
          if (content) {
            content.style.transform = 'translateX(0)';
          }
        });
      });
    });
  }
''';
}
