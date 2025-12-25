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

  // ===== RADIO BUTTONS/GROUPS =====
  function bindRadioButtons() {
    document.querySelectorAll('.arcane-radio-group').forEach(function(group) {
      if (group.dataset.arcaneInteractive === 'true') return;
      group.dataset.arcaneInteractive = 'true';

      // Support all variants: standard (.arcane-radio-item), cards (.arcane-radio-card),
      // buttons (.arcane-radio-button), chips (.arcane-radio-chip)
      var radios = group.querySelectorAll('.arcane-radio-item, .arcane-radio-card, .arcane-radio-button, .arcane-radio-chip, .arcane-radio');

      radios.forEach(function(radio) {
        var input = radio.querySelector('input[type="radio"]');
        if (!input || input.disabled) return;

        radio.addEventListener('click', function(e) {
          if (e.target === input) return; // Let native input handle it
          e.preventDefault();

          // Trigger the hidden input
          input.checked = true;
          input.dispatchEvent(new Event('change', { bubbles: true }));

          // Update visual states for all variants
          radios.forEach(function(r) {
            var rInput = r.querySelector('input[type="radio"]');
            var isChecked = rInput && rInput.checked;

            // Standard radio circle
            var circle = r.querySelector('.arcane-radio-circle');
            if (circle) {
              circle.style.borderColor = isChecked ? 'var(--arcane-accent)' : 'var(--arcane-border)';
              var dot = circle.querySelector('div');
              if (isChecked && !dot) {
                dot = document.createElement('div');
                dot.style.cssText = 'width: 10px; height: 10px; border-radius: 50%; background: var(--arcane-accent);';
                circle.appendChild(dot);
              } else if (!isChecked && dot) {
                dot.remove();
              }
            }

            // Card variant styling
            if (r.classList.contains('arcane-radio-card')) {
              r.style.borderColor = isChecked ? 'var(--arcane-accent)' : 'var(--arcane-border)';
              r.style.borderWidth = isChecked ? '2px' : '1px';
              r.style.background = isChecked ? 'var(--arcane-accent-container)' : 'var(--arcane-surface)';
            }

            // Button variant styling
            if (r.classList.contains('arcane-radio-button')) {
              r.style.background = isChecked ? 'var(--arcane-accent)' : 'var(--arcane-surface)';
              r.style.color = isChecked ? 'var(--arcane-accent-foreground)' : 'var(--arcane-on-surface)';
              r.style.borderColor = isChecked ? 'var(--arcane-accent)' : 'var(--arcane-border)';
            }

            // Chip variant styling
            if (r.classList.contains('arcane-radio-chip')) {
              r.style.background = isChecked ? 'var(--arcane-accent-container)' : 'var(--arcane-surface)';
              r.style.color = isChecked ? 'var(--arcane-accent)' : 'var(--arcane-on-surface)';
              r.style.borderColor = isChecked ? 'var(--arcane-accent)' : 'var(--arcane-border)';
            }

            // Legacy indicator support
            var indicator = r.querySelector('.arcane-radio-indicator');
            if (indicator) {
              indicator.style.borderColor = isChecked ? 'var(--arcane-accent)' : 'var(--arcane-border)';
              if (isChecked) {
                indicator.innerHTML = '<div style="width: 10px; height: 10px; border-radius: 9999px; background: var(--arcane-accent);"></div>';
              } else {
                indicator.innerHTML = '';
              }
            }
          });
        });
      });
    });
  }

  // ===== MUTABLE TEXT (Inline Editable) =====
  function bindMutableText() {
    document.querySelectorAll('.arcane-mutable-text').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var display = container.querySelector('.arcane-mutable-display');
      var editContainer = container.querySelector('.arcane-mutable-edit');
      var input = container.querySelector('.arcane-mutable-input');
      var saveBtn = container.querySelector('.arcane-mutable-save');
      var cancelBtn = container.querySelector('.arcane-mutable-cancel');
      var charCounter = container.querySelector('.arcane-mutable-counter');

      if (!display || !editContainer || !input) return;

      var trigger = container.dataset.trigger || 'click';
      var originalValue = '';

      function showEdit() {
        originalValue = display.textContent.trim();
        input.value = originalValue;
        display.style.display = 'none';
        editContainer.style.display = 'flex';
        input.focus();
        input.select();
        updateCharCounter();
      }

      function hideEdit(save) {
        if (save) {
          var newValue = input.value.trim();
          var minLength = parseInt(container.dataset.minLength) || 0;
          var maxLength = parseInt(container.dataset.maxLength) || Infinity;

          if (newValue.length < minLength || newValue.length > maxLength) {
            input.style.borderColor = 'var(--arcane-error)';
            return;
          }

          display.textContent = newValue || originalValue;
          container.dataset.value = newValue;
        }
        display.style.display = '';
        editContainer.style.display = 'none';
        input.style.borderColor = '';
      }

      function updateCharCounter() {
        if (!charCounter) return;
        var maxLength = parseInt(container.dataset.maxLength) || 0;
        if (maxLength > 0) {
          charCounter.textContent = input.value.length + '/' + maxLength;
          charCounter.style.color = input.value.length > maxLength ? 'var(--arcane-error)' : 'var(--arcane-muted)';
        }
      }

      // Trigger handlers
      if (trigger === 'click' || trigger === 'doubleClick') {
        var eventType = trigger === 'doubleClick' ? 'dblclick' : 'click';
        display.addEventListener(eventType, function(e) {
          e.preventDefault();
          showEdit();
        });
      } else if (trigger === 'hover') {
        var hoverTimer = null;
        display.addEventListener('mouseenter', function() {
          hoverTimer = setTimeout(showEdit, 500);
        });
        display.addEventListener('mouseleave', function() {
          if (hoverTimer) clearTimeout(hoverTimer);
        });
      }
      // 'always' trigger means it's already in edit mode

      // Edit icon click
      var editIcon = container.querySelector('.arcane-mutable-edit-icon');
      if (editIcon) {
        editIcon.addEventListener('click', function(e) {
          e.stopPropagation();
          showEdit();
        });
      }

      // Keyboard handling
      input.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
          e.preventDefault();
          hideEdit(true);
        } else if (e.key === 'Escape') {
          e.preventDefault();
          hideEdit(false);
        }
      });

      input.addEventListener('input', updateCharCounter);

      // Button handlers
      if (saveBtn) {
        saveBtn.addEventListener('click', function(e) {
          e.preventDefault();
          hideEdit(true);
        });
      }

      if (cancelBtn) {
        cancelBtn.addEventListener('click', function(e) {
          e.preventDefault();
          hideEdit(false);
        });
      }

      // Click outside to cancel
      document.addEventListener('click', function(e) {
        if (editContainer.style.display !== 'none' && !container.contains(e.target)) {
          hideEdit(false);
        }
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

  // ===== OTP INPUTS =====
  function bindOtpInputs() {
    document.querySelectorAll('.arcane-otp-input').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var inputs = container.querySelectorAll('.arcane-otp-digit');
      if (!inputs.length) return;

      inputs.forEach(function(input, index) {
        // Handle input
        input.addEventListener('input', function(e) {
          var value = input.value;

          // Handle paste (multiple characters)
          if (value.length > 1) {
            var digits = value.replace(/[^0-9]/g, '').split('');
            inputs.forEach(function(inp, i) {
              if (digits[i]) inp.value = digits[i];
            });
            var lastIndex = Math.min(digits.length, inputs.length) - 1;
            if (lastIndex >= 0) inputs[lastIndex].focus();
            return;
          }

          // Single digit - auto advance
          if (value && index < inputs.length - 1) {
            inputs[index + 1].focus();
          }
        });

        // Handle backspace
        input.addEventListener('keydown', function(e) {
          if (e.key === 'Backspace' && !input.value && index > 0) {
            inputs[index - 1].focus();
          } else if (e.key === 'ArrowLeft' && index > 0) {
            inputs[index - 1].focus();
          } else if (e.key === 'ArrowRight' && index < inputs.length - 1) {
            inputs[index + 1].focus();
          }
        });

        // Select all on focus
        input.addEventListener('focus', function() {
          input.select();
        });
      });
    });
  }

  // ===== COMBOBOXES =====
  function bindComboboxes() {
    document.querySelectorAll('.arcane-combobox').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var trigger = container.querySelector('.arcane-combobox-trigger');
      var dropdown = container.querySelector('.arcane-combobox-dropdown');
      var searchInput = container.querySelector('.arcane-combobox-search');
      var options = container.querySelectorAll('.arcane-combobox-option');

      if (!trigger) return;

      var isOpen = false;
      var selectedIndex = -1;

      function openDropdown() {
        if (dropdown) {
          dropdown.style.display = 'block';
          isOpen = true;
          container.classList.add('open');
          if (searchInput) searchInput.focus();
        }
      }

      function closeDropdown() {
        if (dropdown) {
          dropdown.style.display = 'none';
          isOpen = false;
          container.classList.remove('open');
          selectedIndex = -1;
        }
      }

      function updateHighlight() {
        options.forEach(function(opt, i) {
          opt.style.backgroundColor = i === selectedIndex ? 'var(--arcane-surface-variant)' : '';
        });
      }

      trigger.addEventListener('click', function(e) {
        e.stopPropagation();
        if (isOpen) closeDropdown();
        else openDropdown();
      });

      // Search filtering
      if (searchInput) {
        searchInput.addEventListener('input', function() {
          var query = searchInput.value.toLowerCase();
          options.forEach(function(opt) {
            var label = opt.textContent.toLowerCase();
            opt.style.display = label.includes(query) ? '' : 'none';
          });
        });
      }

      // Keyboard navigation
      container.addEventListener('keydown', function(e) {
        if (!isOpen) return;

        if (e.key === 'ArrowDown') {
          e.preventDefault();
          selectedIndex = Math.min(selectedIndex + 1, options.length - 1);
          updateHighlight();
        } else if (e.key === 'ArrowUp') {
          e.preventDefault();
          selectedIndex = Math.max(selectedIndex - 1, 0);
          updateHighlight();
        } else if (e.key === 'Enter' && selectedIndex >= 0) {
          e.preventDefault();
          options[selectedIndex].click();
        } else if (e.key === 'Escape') {
          closeDropdown();
        }
      });

      // Option selection
      options.forEach(function(opt) {
        opt.addEventListener('click', function() {
          var label = opt.querySelector('div > div')?.textContent || opt.textContent;
          var valueSpan = trigger.querySelector('span');
          if (valueSpan) {
            valueSpan.textContent = label;
            valueSpan.style.color = 'var(--arcane-on-surface)';
          }
          closeDropdown();
        });
      });

      // Close on outside click
      document.addEventListener('click', function(e) {
        if (!container.contains(e.target)) closeDropdown();
      });
    });
  }

  // ===== CALENDARS =====
  function bindCalendars() {
    document.querySelectorAll('.arcane-calendar').forEach(function(calendar) {
      if (calendar.dataset.arcaneInteractive === 'true') return;
      calendar.dataset.arcaneInteractive = 'true';

      var days = calendar.querySelectorAll('.arcane-calendar-day:not(.disabled):not(.outside)');
      days.forEach(function(day) {
        day.addEventListener('click', function() {
          // Remove previous selection
          calendar.querySelectorAll('.arcane-calendar-day.selected').forEach(function(d) {
            d.classList.remove('selected');
            d.style.background = 'transparent';
            d.style.color = 'var(--arcane-on-surface)';
          });

          // Select this day
          day.classList.add('selected');
          day.style.background = 'var(--arcane-accent)';
          day.style.color = 'var(--arcane-on-accent)';
        });
      });
    });
  }

  // ===== DATE PICKERS =====
  function bindDatePickers() {
    document.querySelectorAll('.arcane-date-picker').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var trigger = container.querySelector('.arcane-date-picker-trigger');
      var dropdown = container.querySelector('.arcane-date-picker-dropdown');
      var clearBtn = container.querySelector('.arcane-date-picker-clear');

      if (!trigger) return;

      var isOpen = false;

      function toggleDropdown() {
        isOpen = !isOpen;
        if (dropdown) dropdown.style.display = isOpen ? 'block' : 'none';
        container.classList.toggle('open', isOpen);
      }

      trigger.addEventListener('click', function(e) {
        if (e.target.closest('.arcane-date-picker-clear')) return;
        e.stopPropagation();
        toggleDropdown();
      });

      if (clearBtn) {
        clearBtn.addEventListener('click', function(e) {
          e.stopPropagation();
          var valueSpan = trigger.querySelector('span:nth-child(2)');
          if (valueSpan) {
            valueSpan.textContent = container.dataset.placeholder || 'Select date...';
            valueSpan.style.color = 'var(--arcane-muted)';
          }
        });
      }

      // Close on outside click
      document.addEventListener('click', function(e) {
        if (!container.contains(e.target) && isOpen) {
          isOpen = false;
          if (dropdown) dropdown.style.display = 'none';
          container.classList.remove('open');
        }
      });
    });
  }
''';
}
