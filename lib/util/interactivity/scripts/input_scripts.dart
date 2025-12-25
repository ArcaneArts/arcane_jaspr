/// Input component interactivity scripts for static sites.
class InputScripts {
  InputScripts._();

  static const String code = r'''
  // ===== COLOR INPUTS =====
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

        // Update swatch background
        if (swatch) {
          swatch.style.background = color;
        }

        // Update native input
        if (nativeInput) {
          nativeInput.value = color;
        }

        // Update hex input
        if (hexInput) {
          hexInput.value = color;
        }

        // Update preset borders
        presets.forEach(function(preset) {
          if (preset.dataset.color === color) {
            preset.style.borderColor = 'var(--arcane-accent)';
          } else {
            preset.style.borderColor = 'var(--arcane-border)';
          }
        });
      }

      // Native color picker change
      if (nativeInput) {
        nativeInput.addEventListener('input', function() {
          updateColor(nativeInput.value);
        });
      }

      // Hex input change
      if (hexInput) {
        hexInput.addEventListener('input', function() {
          var val = hexInput.value.trim().toUpperCase();
          if (!val.startsWith('#')) val = '#' + val;
          if (/^#[0-9A-F]{6}$/.test(val)) {
            updateColor(val);
          }
        });
      }

      // Preset swatches
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

  // ===== NUMBER INPUTS =====
  function bindNumberInputs() {
    document.querySelectorAll('.arcane-number-input').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      if (container.dataset.disabled === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var decrementBtn = container.querySelector('.arcane-number-input-decrement');
      var incrementBtn = container.querySelector('.arcane-number-input-increment');
      var display = container.querySelector('.arcane-number-input-display');

      function getValue() {
        return parseFloat(container.dataset.value) || 0;
      }

      function getMin() {
        return parseFloat(container.dataset.min) || 0;
      }

      function getMax() {
        return parseFloat(container.dataset.max) || 100;
      }

      function getStep() {
        return parseFloat(container.dataset.step) || 1;
      }

      function getDecimals() {
        return parseInt(container.dataset.decimals) || 0;
      }

      function updateValue(newValue) {
        var min = getMin();
        var max = getMax();
        var decimals = getDecimals();

        newValue = Math.max(min, Math.min(max, newValue));
        container.dataset.value = newValue.toString();

        // Update display
        if (display) {
          display.textContent = decimals > 0 ? newValue.toFixed(decimals) : Math.round(newValue).toString();
        }

        // Update button states
        if (decrementBtn) {
          decrementBtn.disabled = newValue <= min;
          decrementBtn.style.cursor = newValue <= min ? 'not-allowed' : 'pointer';
          decrementBtn.style.color = newValue <= min ? 'var(--arcane-muted)' : 'var(--arcane-on-surface)';
        }
        if (incrementBtn) {
          incrementBtn.disabled = newValue >= max;
          incrementBtn.style.cursor = newValue >= max ? 'not-allowed' : 'pointer';
          incrementBtn.style.color = newValue >= max ? 'var(--arcane-muted)' : 'var(--arcane-on-surface)';
        }
      }

      if (decrementBtn) {
        decrementBtn.addEventListener('click', function(e) {
          e.preventDefault();
          if (!decrementBtn.disabled) {
            updateValue(getValue() - getStep());
          }
        });
      }

      if (incrementBtn) {
        incrementBtn.addEventListener('click', function(e) {
          e.preventDefault();
          if (!incrementBtn.disabled) {
            updateValue(getValue() + getStep());
          }
        });
      }
    });
  }

  // ===== CHECKBOXES =====
  function bindCheckboxes() {
    document.querySelectorAll('.arcane-checkbox').forEach(function(checkbox) {
      if (checkbox.dataset.arcaneInteractive === 'true') return;
      if (checkbox.dataset.disabled === 'true') return;
      checkbox.dataset.arcaneInteractive = 'true';

      var box = checkbox.querySelector('.arcane-checkbox-box');
      if (!box) return;

      checkbox.addEventListener('click', function(e) {
        e.preventDefault();
        var isChecked = checkbox.dataset.checked === 'true';
        var newState = !isChecked;
        checkbox.dataset.checked = newState.toString();

        if (newState) {
          box.style.background = 'var(--arcane-success)';
          box.style.borderColor = 'var(--arcane-success)';
          box.innerHTML = '<span style="color: var(--arcane-success-foreground); font-size: 12px; font-weight: bold;">✓</span>';
        } else {
          box.style.background = 'transparent';
          box.style.borderColor = 'var(--arcane-border)';
          box.innerHTML = '';
        }
      });
    });
  }

  // ===== TOGGLE SWITCHES =====
  function bindToggleSwitches() {
    document.querySelectorAll('.arcane-toggle-switch').forEach(function(toggle) {
      if (toggle.dataset.arcaneInteractive === 'true') return;
      if (toggle.dataset.disabled === 'true') return;
      toggle.dataset.arcaneInteractive = 'true';

      var track = toggle.querySelector('.arcane-toggle-switch-track');
      var thumb = toggle.querySelector('.arcane-toggle-switch-thumb');
      if (!track || !thumb) return;

      toggle.addEventListener('click', function(e) {
        e.preventDefault();
        var isOn = toggle.dataset.checked === 'true';
        var newState = !isOn;
        toggle.dataset.checked = newState.toString();

        if (newState) {
          track.style.background = 'var(--arcane-success)';
          thumb.style.transform = 'translateX(20px)';
        } else {
          track.style.background = 'var(--arcane-surface-variant)';
          thumb.style.transform = 'translateX(0)';
        }
      });
    });
  }

  // ===== RADIO BUTTONS =====
  function bindRadioButtons() {
    document.querySelectorAll('.arcane-radio-group').forEach(function(group) {
      if (group.dataset.arcaneInteractive === 'true') return;
      group.dataset.arcaneInteractive = 'true';

      var radios = group.querySelectorAll('.arcane-radio');
      radios.forEach(function(radio) {
        if (radio.dataset.disabled === 'true') return;

        radio.addEventListener('click', function(e) {
          e.preventDefault();

          // Deselect all
          radios.forEach(function(r) {
            r.dataset.checked = 'false';
            var indicator = r.querySelector('.arcane-radio-indicator');
            if (indicator) {
              indicator.style.borderColor = 'var(--arcane-border)';
              indicator.innerHTML = '';
            }
          });

          // Select this one
          radio.dataset.checked = 'true';
          var indicator = radio.querySelector('.arcane-radio-indicator');
          if (indicator) {
            indicator.style.borderColor = 'var(--arcane-success)';
            indicator.innerHTML = '<div style="width: 10px; height: 10px; border-radius: 9999px; background: var(--arcane-success);"></div>';
          }
        });
      });
    });
  }

  // ===== TAG INPUTS =====
  function bindTagInputs() {
    document.querySelectorAll('.arcane-tag-input').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var input = container.querySelector('.arcane-tag-input-field');
      var tagsContainer = container.querySelector('.arcane-tag-input-tags');
      if (!input || !tagsContainer) return;

      // Remove tag buttons
      container.querySelectorAll('.arcane-tag-remove').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
          e.preventDefault();
          var tag = btn.closest('.arcane-tag');
          if (tag) tag.remove();
        });
      });

      // Add new tags
      input.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' || e.key === ',') {
          e.preventDefault();
          var value = input.value.trim();
          if (!value) return;

          var tag = document.createElement('span');
          tag.className = 'arcane-tag';
          tag.style.cssText = 'display: inline-flex; align-items: center; gap: 4px; padding: 4px 8px; background: var(--arcane-accent); color: var(--arcane-accent-foreground); border-radius: 9999px; font-size: 0.75rem;';
          tag.innerHTML = value + '<button type="button" class="arcane-tag-remove" style="display: flex; width: 14px; height: 14px; padding: 0; border: none; background: rgba(255,255,255,0.2); border-radius: 9999px; color: inherit; cursor: pointer; align-items: center; justify-content: center;">×</button>';

          tag.querySelector('.arcane-tag-remove').addEventListener('click', function() { tag.remove(); });
          tagsContainer.appendChild(tag);
          input.value = '';
        }
      });
    });
  }

  // ===== FILE UPLOADS =====
  function bindFileUploads() {
    document.querySelectorAll('.arcane-file-upload').forEach(function(dropzone) {
      if (dropzone.dataset.arcaneInteractive === 'true') return;
      dropzone.dataset.arcaneInteractive = 'true';

      var fileInput = dropzone.querySelector('.arcane-file-input');
      if (!fileInput) return;

      dropzone.addEventListener('click', function(e) {
        if (e.target !== fileInput) {
          fileInput.click();
        }
      });

      fileInput.addEventListener('change', function() {
        var files = fileInput.files;
        if (!files || files.length === 0) return;

        var fileList = dropzone.querySelector('.arcane-file-list');
        if (fileList) {
          fileList.innerHTML = '';
          for (var i = 0; i < files.length; i++) {
            var file = files[i];
            var size = file.size < 1024 ? file.size + ' B' :
                       file.size < 1024 * 1024 ? (file.size / 1024).toFixed(1) + ' KB' :
                       (file.size / (1024 * 1024)).toFixed(1) + ' MB';

            var item = document.createElement('div');
            item.style.cssText = 'display: flex; align-items: center; justify-content: space-between; padding: 8px; background: var(--arcane-surface-variant); border-radius: 4px; font-size: 0.875rem;';
            item.innerHTML = '<span>' + file.name + '</span><span style="color: var(--arcane-muted);">' + size + '</span>';
            fileList.appendChild(item);
          }
        }
      });

      dropzone.addEventListener('dragover', function(e) {
        e.preventDefault();
        dropzone.style.borderColor = 'var(--arcane-accent)';
      });

      dropzone.addEventListener('dragleave', function() {
        dropzone.style.borderColor = 'var(--arcane-border)';
      });

      dropzone.addEventListener('drop', function(e) {
        e.preventDefault();
        dropzone.style.borderColor = 'var(--arcane-border)';
        if (e.dataTransfer?.files?.length > 0) {
          fileInput.files = e.dataTransfer.files;
          fileInput.dispatchEvent(new Event('change'));
        }
      });
    });
  }
''';
}
