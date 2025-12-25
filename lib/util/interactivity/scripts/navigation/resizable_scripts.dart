/// Resizable panels interactivity scripts.
class ResizableScripts {
  ResizableScripts._();

  static const String code = r'''
  function bindResizables() {
    document.querySelectorAll('.arcane-resizable').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var isHorizontal = container.dataset.direction === 'horizontal';
      var handles = container.querySelectorAll('.arcane-resizable-handle');
      var panels = container.querySelectorAll('.arcane-resizable-panel');

      handles.forEach(function(handle, handleIndex) {
        var isDragging = false;
        var startPos = 0;
        var startSizes = [];

        handle.addEventListener('mousedown', function(e) {
          e.preventDefault();
          isDragging = true;
          startPos = isHorizontal ? e.clientX : e.clientY;

          startSizes = [];
          panels.forEach(function(p) {
            var rect = p.getBoundingClientRect();
            startSizes.push(isHorizontal ? rect.width : rect.height);
          });

          container.classList.add('dragging');
          document.body.style.cursor = isHorizontal ? 'col-resize' : 'row-resize';
          document.body.style.userSelect = 'none';
        });

        document.addEventListener('mousemove', function(e) {
          if (!isDragging) return;

          var currentPos = isHorizontal ? e.clientX : e.clientY;
          var delta = currentPos - startPos;

          var panel1 = panels[handleIndex];
          var panel2 = panels[handleIndex + 1];

          if (panel1 && panel2) {
            var newSize1 = startSizes[handleIndex] + delta;
            var newSize2 = startSizes[handleIndex + 1] - delta;

            var min1 = parseFloat(panel1.dataset.minSize) || 10;
            var max1 = parseFloat(panel1.dataset.maxSize) || 90;
            var min2 = parseFloat(panel2.dataset.minSize) || 10;
            var max2 = parseFloat(panel2.dataset.maxSize) || 90;

            var containerSize = isHorizontal ? container.clientWidth : container.clientHeight;
            var minPx1 = containerSize * min1 / 100;
            var maxPx1 = containerSize * max1 / 100;
            var minPx2 = containerSize * min2 / 100;
            var maxPx2 = containerSize * max2 / 100;

            if (newSize1 >= minPx1 && newSize1 <= maxPx1 && newSize2 >= minPx2 && newSize2 <= maxPx2) {
              panel1.style.flex = '0 0 ' + newSize1 + 'px';
              panel2.style.flex = '0 0 ' + newSize2 + 'px';
            }
          }
        });

        document.addEventListener('mouseup', function() {
          if (isDragging) {
            isDragging = false;
            container.classList.remove('dragging');
            document.body.style.cursor = '';
            document.body.style.userSelect = '';
          }
        });

        handle.addEventListener('keydown', function(e) {
          var step = e.shiftKey ? 50 : 10;
          var delta = 0;

          if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {
            delta = -step;
          } else if (e.key === 'ArrowRight' || e.key === 'ArrowDown') {
            delta = step;
          }

          if (delta !== 0) {
            e.preventDefault();
            var panel1 = panels[handleIndex];
            var panel2 = panels[handleIndex + 1];

            if (panel1 && panel2) {
              var rect1 = panel1.getBoundingClientRect();
              var rect2 = panel2.getBoundingClientRect();
              var size1 = isHorizontal ? rect1.width : rect1.height;
              var size2 = isHorizontal ? rect2.width : rect2.height;

              panel1.style.flex = '0 0 ' + (size1 + delta) + 'px';
              panel2.style.flex = '0 0 ' + (size2 - delta) + 'px';
            }
          }
        });
      });
    });
  }
''';
}
