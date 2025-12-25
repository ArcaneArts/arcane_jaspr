/// Navigation component interactivity scripts for static sites.
class NavigationScripts {
  NavigationScripts._();

  static const String code = r'''
  // ===== TABS =====
  function bindTabs() {
    document.querySelectorAll('[style*="border-bottom: 2px"]').forEach(function(tab) {
      var container = tab.closest('[style*="display: flex"][style*="gap"]');
      if (!container || container.dataset.arcaneTabsInteractive) return;
      container.dataset.arcaneTabsInteractive = 'true';

      var tabs = container.querySelectorAll('[style*="border-bottom"], [style*="cursor: pointer"][style*="padding"]');
      tabs.forEach(function(t) {
        t.addEventListener('click', function() {
          tabs.forEach(function(other) {
            other.style.borderBottom = '2px solid transparent';
            other.style.color = 'var(--arcane-on-surface-variant)';
          });
          t.style.borderBottom = '2px solid var(--arcane-accent)';
          t.style.color = 'var(--arcane-on-surface)';
        });
      });
    });
  }

  // ===== EXPANDERS/ACCORDIONS =====
  function bindExpandersAccordions() {
    document.querySelectorAll('.arcane-expander-header, .arcane-accordion-header, button[aria-expanded]').forEach(function(header) {
      if (header.dataset.arcaneInteractive) return;
      header.dataset.arcaneInteractive = 'true';

      header.addEventListener('click', function() {
        var isExpanded = header.getAttribute('aria-expanded') === 'true';
        header.setAttribute('aria-expanded', (!isExpanded).toString());

        var container = header.closest('.arcane-expander, .arcane-accordion, [style*="border-radius"]');
        var content = header.nextElementSibling;
        if (content) {
          content.style.display = isExpanded ? 'none' : 'block';
        }

        var icon = header.querySelector('[style*="transform"], svg');
        if (icon) {
          icon.style.transform = isExpanded ? 'rotate(0deg)' : 'rotate(180deg)';
        }
      });
    });
  }

  // ===== DROPDOWNS =====
  function bindDropdowns() {
    document.querySelectorAll('.arcane-dropdown').forEach(function(dropdown) {
      var trigger = dropdown.querySelector('.arcane-dropdown-trigger');
      var menu = dropdown.querySelector('.arcane-dropdown-menu');
      if (!trigger || dropdown.dataset.arcaneInteractive) return;
      dropdown.dataset.arcaneInteractive = 'true';

      trigger.addEventListener('click', function(e) {
        e.stopPropagation();
        var isOpen = dropdown.classList.contains('open');

        document.querySelectorAll('.arcane-dropdown.open').forEach(function(d) {
          d.classList.remove('open');
          var m = d.querySelector('.arcane-dropdown-menu');
          if (m) m.style.display = 'none';
        });

        if (!isOpen && menu) {
          dropdown.classList.add('open');
          menu.style.display = 'block';
        }
      });

      document.addEventListener('click', function() {
        dropdown.classList.remove('open');
        if (menu) menu.style.display = 'none';
      });
    });
  }

  // ===== SELECTORS (dropdown select) =====
  function bindSelectors() {
    document.querySelectorAll('.arcane-selector').forEach(function(selector) {
      if (selector.dataset.arcaneInteractive) return;
      selector.dataset.arcaneInteractive = 'true';

      var wrapper = selector.closest('.arcane-selector-wrapper');
      if (!wrapper) return;

      selector.addEventListener('click', function(e) {
        e.stopPropagation();
        var dropdown = wrapper.querySelector('.arcane-selector-dropdown');
        var arrow = selector.querySelector('[style*="transform"]');

        if (dropdown) {
          var isOpen = dropdown.style.display !== 'none';
          dropdown.style.display = isOpen ? 'none' : 'block';
          if (arrow) arrow.style.transform = isOpen ? 'rotate(0)' : 'rotate(180deg)';
        } else {
          // Create dropdown if it doesn't exist (for static rendering)
          if (arrow) {
            var isRotated = arrow.style.transform.includes('180');
            arrow.style.transform = isRotated ? 'rotate(0)' : 'rotate(180deg)';
          }
        }
      });

      // Close on outside click
      document.addEventListener('click', function(e) {
        if (!wrapper.contains(e.target)) {
          var dropdown = wrapper.querySelector('.arcane-selector-dropdown');
          var arrow = selector.querySelector('[style*="transform"]');
          if (dropdown) dropdown.style.display = 'none';
          if (arrow) arrow.style.transform = 'rotate(0)';
        }
      });
    });

    // Handle option clicks
    document.querySelectorAll('.arcane-selector-option').forEach(function(option) {
      if (option.dataset.arcaneOptionInteractive) return;
      option.dataset.arcaneOptionInteractive = 'true';

      option.addEventListener('click', function() {
        var wrapper = option.closest('.arcane-selector-wrapper');
        var selector = wrapper?.querySelector('.arcane-selector');
        var dropdown = wrapper?.querySelector('.arcane-selector-dropdown');
        var label = option.querySelector('span');

        if (selector && label) {
          var valueSpan = selector.querySelector('span');
          if (valueSpan) {
            valueSpan.textContent = label.textContent;
            valueSpan.style.color = 'var(--arcane-on-surface)';
          }
        }

        // Update selected state
        wrapper?.querySelectorAll('.arcane-selector-option').forEach(function(opt) {
          opt.style.backgroundColor = 'transparent';
          opt.style.color = 'var(--arcane-on-surface)';
          var check = opt.querySelector('span:last-child');
          if (check && check.textContent === '✓') check.remove();
        });

        option.style.backgroundColor = 'var(--arcane-accent-container)';
        option.style.color = 'var(--arcane-accent)';

        if (dropdown) dropdown.style.display = 'none';
        var arrow = selector?.querySelector('[style*="transform"]');
        if (arrow) arrow.style.transform = 'rotate(0)';
      });
    });
  }

  // ===== TREE VIEW =====
  function bindTreeViews() {
    document.querySelectorAll('[role="tree"]').forEach(function(tree) {
      if (tree.dataset.arcaneInteractive) return;
      tree.dataset.arcaneInteractive = 'true';

      tree.querySelectorAll('[role="treeitem"]').forEach(function(item) {
        item.addEventListener('click', function(e) {
          e.stopPropagation();

          var hasChildren = item.getAttribute('aria-expanded') !== null;
          var isExpanded = item.getAttribute('aria-expanded') === 'true';
          var isSelected = item.getAttribute('aria-selected') === 'true';

          // Toggle expansion
          if (hasChildren) {
            item.setAttribute('aria-expanded', (!isExpanded).toString());
            var group = item.nextElementSibling;
            if (group && group.getAttribute('role') === 'group') {
              group.style.display = isExpanded ? 'none' : 'block';
            }
            var icon = item.querySelector('[style*="transform"]');
            if (icon) {
              icon.style.transform = isExpanded ? 'rotate(0deg)' : 'rotate(90deg)';
            }
          }

          // Toggle selection
          tree.querySelectorAll('[role="treeitem"]').forEach(function(other) {
            other.setAttribute('aria-selected', 'false');
            other.style.background = 'transparent';
            var label = other.querySelector('span:last-child');
            if (label) {
              label.style.color = 'var(--arcane-on-surface)';
              label.style.fontWeight = 'normal';
            }
          });

          item.setAttribute('aria-selected', 'true');
          item.style.background = 'var(--arcane-surface-variant)';
          var label = item.querySelector('span:last-child');
          if (label) {
            label.style.color = 'var(--arcane-accent)';
            label.style.fontWeight = '500';
          }
        });
      });
    });
  }

  // ===== PAGINATION =====
  function bindPagination() {
    document.querySelectorAll('nav[aria-label="Pagination"]').forEach(function(nav) {
      if (nav.dataset.arcaneInteractive) return;
      nav.dataset.arcaneInteractive = 'true';

      nav.querySelectorAll('button').forEach(function(btn) {
        btn.addEventListener('click', function() {
          if (btn.disabled) return;

          // Update active state
          nav.querySelectorAll('button').forEach(function(b) {
            if (b.getAttribute('aria-current') === 'page') {
              b.removeAttribute('aria-current');
              // Reset styles based on variant
              if (b.style.background?.includes('accent')) {
                b.style.background = 'transparent';
                b.style.border = '1px solid var(--arcane-border)';
              } else {
                b.style.background = 'var(--arcane-surface-variant)';
              }
              b.style.fontWeight = 'normal';
            }
          });

          // Set new active (only for number buttons)
          var pageNum = parseInt(btn.textContent);
          if (!isNaN(pageNum)) {
            btn.setAttribute('aria-current', 'page');
            btn.style.background = 'var(--arcane-accent)';
            btn.style.border = '1px solid var(--arcane-accent)';
            btn.style.fontWeight = '500';
          }
        });
      });
    });
  }

  // ===== CHIPS =====
  function bindChips() {
    document.querySelectorAll('.arcane-chip').forEach(function(chip) {
      if (chip.dataset.arcaneInteractive) return;
      chip.dataset.arcaneInteractive = 'true';

      // Clickable chips
      if (chip.classList.contains('clickable')) {
        chip.addEventListener('click', function() {
          chip.style.opacity = chip.style.opacity === '0.7' ? '1' : '0.7';
        });
      }

      // Removable chips
      var removeBtn = chip.querySelector('.arcane-chip-remove');
      if (removeBtn) {
        removeBtn.addEventListener('click', function(e) {
          e.stopPropagation();
          chip.style.transform = 'scale(0.9)';
          chip.style.opacity = '0';
          setTimeout(function() { chip.remove(); }, 150);
        });
      }
    });
  }

  // ===== BACK TO TOP =====
  function bindBackToTop() {
    document.querySelectorAll('[title="Back to top"], button[style*="position: fixed"][style*="bottom"]').forEach(function(btn) {
      if (btn.dataset.arcaneInteractive) return;
      btn.dataset.arcaneInteractive = 'true';

      btn.addEventListener('click', function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });

      // Show/hide based on scroll position
      window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
          btn.style.opacity = '1';
          btn.style.pointerEvents = 'auto';
        } else {
          btn.style.opacity = '0';
          btn.style.pointerEvents = 'none';
        }
      });
    });
  }

  // ===== CONTEXT MENUS =====
  function bindContextMenus() {
    document.querySelectorAll('.arcane-context-menu-trigger').forEach(function(trigger) {
      if (trigger.dataset.arcaneInteractive === 'true') return;
      trigger.dataset.arcaneInteractive = 'true';

      var menu = trigger.querySelector('.arcane-context-menu');
      if (!menu) return;

      trigger.addEventListener('contextmenu', function(e) {
        e.preventDefault();

        // Close any open context menus
        document.querySelectorAll('.arcane-context-menu').forEach(function(m) {
          m.style.display = 'none';
        });

        // Position and show menu
        menu.style.display = 'block';
        menu.style.left = e.clientX + 'px';
        menu.style.top = e.clientY + 'px';

        // Keep menu in viewport
        var rect = menu.getBoundingClientRect();
        if (rect.right > window.innerWidth) {
          menu.style.left = (e.clientX - rect.width) + 'px';
        }
        if (rect.bottom > window.innerHeight) {
          menu.style.top = (e.clientY - rect.height) + 'px';
        }
      });

      // Menu item clicks
      menu.querySelectorAll('.arcane-context-menu-item:not(.disabled)').forEach(function(item) {
        item.addEventListener('click', function() {
          menu.style.display = 'none';
        });
      });
    });

    // Close on outside click
    document.addEventListener('click', function() {
      document.querySelectorAll('.arcane-context-menu').forEach(function(m) {
        m.style.display = 'none';
      });
    });

    // Close on escape
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        document.querySelectorAll('.arcane-context-menu').forEach(function(m) {
          m.style.display = 'none';
        });
      }
    });
  }

  // ===== MENUBARS =====
  function bindMenubars() {
    document.querySelectorAll('.arcane-menubar').forEach(function(menubar) {
      if (menubar.dataset.arcaneInteractive === 'true') return;
      menubar.dataset.arcaneInteractive = 'true';

      var items = menubar.querySelectorAll('.arcane-menubar-item');
      var activeItem = null;

      items.forEach(function(item) {
        var trigger = item.querySelector('.arcane-menubar-trigger');
        var dropdown = item.querySelector('.arcane-menubar-dropdown');

        if (!trigger || !dropdown) return;

        trigger.addEventListener('click', function(e) {
          e.stopPropagation();

          if (activeItem === item) {
            dropdown.style.display = 'none';
            activeItem = null;
          } else {
            // Close others
            items.forEach(function(other) {
              var d = other.querySelector('.arcane-menubar-dropdown');
              if (d) d.style.display = 'none';
            });

            dropdown.style.display = 'block';
            activeItem = item;
          }
        });

        // Hover to switch when one is open
        item.addEventListener('mouseenter', function() {
          if (activeItem && activeItem !== item) {
            var oldDropdown = activeItem.querySelector('.arcane-menubar-dropdown');
            if (oldDropdown) oldDropdown.style.display = 'none';

            dropdown.style.display = 'block';
            activeItem = item;
          }
        });

        // Menu item clicks
        dropdown.querySelectorAll('.arcane-menubar-menu-item:not(.disabled)').forEach(function(menuItem) {
          menuItem.addEventListener('click', function() {
            dropdown.style.display = 'none';
            activeItem = null;
          });
        });
      });

      // Close on outside click
      document.addEventListener('click', function(e) {
        if (!menubar.contains(e.target)) {
          items.forEach(function(item) {
            var d = item.querySelector('.arcane-menubar-dropdown');
            if (d) d.style.display = 'none';
          });
          activeItem = null;
        }
      });
    });
  }

  // ===== RESIZABLE PANELS =====
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

          // Store current sizes
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

            // Get min/max constraints
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

        // Keyboard support
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

  // ===== COMMAND PALETTES =====
  function bindCommandPalettes() {
    document.querySelectorAll('.arcane-command-overlay').forEach(function(overlay) {
      if (overlay.dataset.arcaneInteractive === 'true') return;
      overlay.dataset.arcaneInteractive = 'true';

      var dialog = overlay.querySelector('.arcane-command-dialog');
      var input = overlay.querySelector('.arcane-command-input');
      var items = overlay.querySelectorAll('.arcane-command-item');
      var selectedIndex = -1;

      function updateSelection() {
        items.forEach(function(item, i) {
          item.classList.toggle('selected', i === selectedIndex);
        });
        if (selectedIndex >= 0 && items[selectedIndex]) {
          items[selectedIndex].scrollIntoView({ block: 'nearest' });
        }
      }

      // Keyboard navigation
      overlay.addEventListener('keydown', function(e) {
        if (e.key === 'ArrowDown') {
          e.preventDefault();
          selectedIndex = Math.min(selectedIndex + 1, items.length - 1);
          updateSelection();
        } else if (e.key === 'ArrowUp') {
          e.preventDefault();
          selectedIndex = Math.max(selectedIndex - 1, 0);
          updateSelection();
        } else if (e.key === 'Enter' && selectedIndex >= 0) {
          e.preventDefault();
          items[selectedIndex].click();
        } else if (e.key === 'Escape') {
          overlay.style.display = 'none';
        }
      });

      // Search filtering
      if (input) {
        input.addEventListener('input', function() {
          var query = input.value.toLowerCase();
          items.forEach(function(item) {
            var label = item.textContent.toLowerCase();
            item.style.display = label.includes(query) ? '' : 'none';
          });
          selectedIndex = -1;
          updateSelection();
        });
      }

      // Click outside to close
      overlay.addEventListener('click', function(e) {
        if (!dialog.contains(e.target)) {
          overlay.style.display = 'none';
        }
      });

      // Item clicks
      items.forEach(function(item) {
        item.addEventListener('click', function() {
          if (!item.classList.contains('disabled')) {
            overlay.style.display = 'none';
          }
        });
      });
    });
  }
''';
}
