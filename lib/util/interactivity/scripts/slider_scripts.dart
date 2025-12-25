/// Slider interactivity scripts for static sites.
class SliderScripts {
  SliderScripts._();

  static const String code = r'''
  // ===== SLIDERS =====
  function bindSliders() {
    // Regular sliders
    document.querySelectorAll('.arcane-slider').forEach(function(slider) {
      if (slider.dataset.arcaneInteractive) return;
      slider.dataset.arcaneInteractive = 'true';

      var input = slider.querySelector('.arcane-slider-input');
      var track = slider.querySelector('.arcane-slider-track-fill');
      var thumb = slider.querySelector('.arcane-slider-thumb');
      var valueDisplay = slider.querySelector('.arcane-slider-value');

      if (!input) return;

      input.addEventListener('input', function() {
        var min = parseFloat(input.min) || 0;
        var max = parseFloat(input.max) || 100;
        var value = parseFloat(input.value);
        var percent = ((value - min) / (max - min)) * 100;

        // Update track fill
        if (track) track.style.width = percent + '%';

        // Update thumb position
        if (thumb) {
          var thumbSize = parseInt(thumb.style.width) || 18;
          thumb.style.left = 'calc(' + percent + '% - ' + (thumbSize / 2) + 'px)';
        }

        // Update value display
        if (valueDisplay) {
          var text = valueDisplay.textContent;
          var prefix = text.match(/^[^\d-]*/)?.[0] || '';
          var suffix = text.match(/[^\d]*$/)?.[0] || '';
          valueDisplay.textContent = prefix + Math.round(value) + suffix;
        }
      });
    });

    // Range sliders
    document.querySelectorAll('.arcane-range-slider').forEach(function(slider) {
      if (slider.dataset.arcaneInteractive) return;
      slider.dataset.arcaneInteractive = 'true';

      var minInput = slider.querySelector('.arcane-range-slider-input-min');
      var maxInput = slider.querySelector('.arcane-range-slider-input-max');
      var track = slider.querySelector('.arcane-range-slider-track-fill');
      var minThumb = slider.querySelector('.arcane-range-slider-thumb-min');
      var maxThumb = slider.querySelector('.arcane-range-slider-thumb-max');
      var valuesDisplay = slider.querySelector('.arcane-range-slider-values');

      if (!minInput || !maxInput) return;

      function updateRange() {
        var min = parseFloat(minInput.min) || 0;
        var max = parseFloat(minInput.max) || 100;
        var minVal = parseFloat(minInput.value);
        var maxVal = parseFloat(maxInput.value);
        var minPercent = ((minVal - min) / (max - min)) * 100;
        var maxPercent = ((maxVal - min) / (max - min)) * 100;

        // Update track
        if (track) {
          track.style.left = minPercent + '%';
          track.style.width = (maxPercent - minPercent) + '%';
        }

        // Update thumbs
        var thumbSize = minThumb ? parseInt(minThumb.style.width) || 18 : 18;
        if (minThumb) minThumb.style.left = 'calc(' + minPercent + '% - ' + (thumbSize / 2) + 'px)';
        if (maxThumb) maxThumb.style.left = 'calc(' + maxPercent + '% - ' + (thumbSize / 2) + 'px)';

        // Update display
        if (valuesDisplay) {
          valuesDisplay.textContent = Math.round(minVal) + ' – ' + Math.round(maxVal);
        }
      }

      minInput.addEventListener('input', function() {
        var maxVal = parseFloat(maxInput.value);
        if (parseFloat(minInput.value) >= maxVal) {
          minInput.value = maxVal - 1;
        }
        updateRange();
      });

      maxInput.addEventListener('input', function() {
        var minVal = parseFloat(minInput.value);
        if (parseFloat(maxInput.value) <= minVal) {
          maxInput.value = minVal + 1;
        }
        updateRange();
      });
    });

    // Legacy slider support (fallback for old class names)
    document.querySelectorAll('input[type="range"]:not(.arcane-slider-input):not(.arcane-range-slider-input)').forEach(function(input) {
      if (input.dataset.arcaneInteractive) return;
      input.dataset.arcaneInteractive = 'true';

      var container = input.closest('div');
      if (!container) return;

      input.addEventListener('input', function() {
        var min = parseFloat(input.min) || 0;
        var max = parseFloat(input.max) || 100;
        var value = parseFloat(input.value);
        var percent = ((value - min) / (max - min)) * 100;

        // Update any track fill
        container.querySelectorAll('[style*="position: absolute"]').forEach(function(el) {
          if (el.style.width && el.style.width.includes('%') && el !== input) {
            el.style.width = percent + '%';
          }
        });

        // Update any thumb
        container.querySelectorAll('[style*="border-radius: 9999px"]').forEach(function(thumb) {
          if (thumb.style.position === 'absolute' && thumb.style.width) {
            var thumbSize = parseInt(thumb.style.width) || 18;
            thumb.style.left = 'calc(' + percent + '% - ' + (thumbSize / 2) + 'px)';
          }
        });
      });
    });
  }
''';
}
