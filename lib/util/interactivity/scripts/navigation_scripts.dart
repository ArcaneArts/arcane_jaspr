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
''';
}
