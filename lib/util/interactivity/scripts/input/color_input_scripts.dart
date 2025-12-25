/// Color input interactivity scripts.
class ColorInputScripts {
  ColorInputScripts._();

  static const String code = r'''
  function bindColorInputs() {
    document.querySelectorAll('.arcane-color-input').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      if (container.dataset.disabled === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var nativeInput = container.querySelector('.arcane-color-input-native');
      var hexInput = container.querySelector('.arcane-color-input-hex');
      var swatch = container.querySelector('.arcane-color-input-swatch');
      var presets = container.querySelectorAll('.arcane-color-input-preset');

      function updateColor(color) {
        color = color.toUpperCase();
        container.dataset.value = color;

        if (swatch) {
          swatch.style.background = color;
        }

        if (nativeInput) {
          nativeInput.value = color;
        }

        if (hexInput) {
          hexInput.value = color;
        }

        presets.forEach(function(preset) {
          if (preset.dataset.color === color) {
            preset.style.borderColor = 'var(--arcane-accent)';
          } else {
            preset.style.borderColor = 'var(--arcane-border)';
          }
        });
      }

      if (nativeInput) {
        nativeInput.addEventListener('input', function() {
          updateColor(nativeInput.value);
        });
      }

      if (hexInput) {
        hexInput.addEventListener('input', function() {
          var val = hexInput.value.trim().toUpperCase();
          if (!val.startsWith('#')) val = '#' + val;
          if (/^#[0-9A-F]{6}$/.test(val)) {
            updateColor(val);
          }
        });
      }

      presets.forEach(function(preset) {
        preset.addEventListener('click', function(e) {
          e.preventDefault();
          var color = preset.dataset.color;
          if (color) {
            updateColor(color);
          }
        });
      });
    });
  }
''';
}
