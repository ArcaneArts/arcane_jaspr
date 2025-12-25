/// Popover and hovercard interactivity scripts.
class PopoverScripts {
  PopoverScripts._();

  static const String code = r'''
  function bindPopovers() {
    document.querySelectorAll('[style*="position: relative"]').forEach(function(container) {
      var trigger = container.firstElementChild;
      var popup = container.querySelector('[style*="position: absolute"][style*="z-index"]');
      if (!trigger || !popup || container.dataset.arcanePopoverInteractive) return;
      container.dataset.arcanePopoverInteractive = 'true';

      var isClick = !popup.closest('.arcane-hovercard');

      if (isClick) {
        trigger.addEventListener('click', function(e) {
          e.stopPropagation();
          var isVisible = popup.style.opacity === '1';
          popup.style.opacity = isVisible ? '0' : '1';
          popup.style.visibility = isVisible ? 'hidden' : 'visible';
          popup.style.pointerEvents = isVisible ? 'none' : 'auto';
        });

        document.addEventListener('click', function(e) {
          if (!container.contains(e.target)) {
            popup.style.opacity = '0';
            popup.style.visibility = 'hidden';
            popup.style.pointerEvents = 'none';
          }
        });
      } else {
        container.addEventListener('mouseenter', function() {
          popup.style.opacity = '1';
          popup.style.visibility = 'visible';
        });
        container.addEventListener('mouseleave', function() {
          popup.style.opacity = '0';
          popup.style.visibility = 'hidden';
        });
      }
    });
  }
''';
}
